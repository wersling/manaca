package net.manaca.application.config
{
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;

import net.manaca.application.Bootstrap;
import net.manaca.application.IApplicationSetup;
import net.manaca.core.manaca_internal;
import net.manaca.errors.FrameworkError;
import net.manaca.loaderqueue.LoaderQueue;
import net.manaca.modules.ModuleManager;
import net.manaca.modules.ModuleVO;

public class ApplicationSetup extends EventDispatcher implements IApplicationSetup
{
    static public var AA:String = "11";
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>ApplicationSetup</code> instance.
     * 
     */
    public function ApplicationSetup(stage:Stage, config:*)
    {
        super();
        this.stage = stage;
        this.config = config;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var stage:Stage;
    private var config:*;
    private var configXML:XML;
    private var filePreloading:FilePreloadingHelper;
    private const loaderQueueIns:LoaderQueue = new LoaderQueue(8, 100);
    //==========================================================================
    //  Properties
    //==========================================================================
    
    //==========================================================================
    //  Methods
    //==========================================================================
    public function start():void
    {
        var configFile:ConfigFileHelper = new ConfigFileHelper();
        configFile.addEventListener(Event.COMPLETE,
            configFile_completeHandler);
        configFile.init(config);
    }
    
    private function initApp():void
    {
        Bootstrap.getInstance().manaca_internal::init(configXML);
        
        //init stage,logging
        new ApplicationInitHelper().init(stage, configXML);
        
        //set server name
        var href:String = Bootstrap.getInstance().href;
        if (!href || href.indexOf("http") == -1 || 
            href.indexOf("localhost") != -1)
        {
            Bootstrap.getInstance().
                manaca_internal::setServerByName("flashDev");
        }
        else
        {
            Bootstrap.getInstance().
                manaca_internal::setServerByName("release");
        }
        
        //init modules
        var modules:Vector.<ModuleVO> = new Vector.<ModuleVO>();
        for each(var moduleNode:XML in configXML.Modules.Module)
        {
            var moduleVO:ModuleVO = new ModuleVO(moduleNode);
            moduleVO.url = Bootstrap.getInstance().getSwfPath(moduleVO.url);
            modules.push(moduleVO);
        }
        
        ModuleManager.init(modules, Bootstrap.getInstance().loaderQueue);
        
        //start loading files
        filePreloading = 
            new FilePreloadingHelper(configXML.PreloadFiles.File, modules);
        filePreloading.addEventListener(Event.COMPLETE, loadCompletedHandler);
        filePreloading.addEventListener(Event.CHANGE, progressHandler);
        filePreloading.start();
    }
    
    /**
     * The updateConfiguration function will call by configuration update.
     * You can override the function.
     * @param percent
     *
     */
    protected function updateProgress(percent:uint):void
    {
        var progressEvent:ProgressEvent = 
            new ProgressEvent(ProgressEvent.PROGRESS, false, false,
                percent, 100);
        dispatchEvent(progressEvent);
    }
    
    //==========================================================================
    //  Event handlers
    //==========================================================================
    /**
     * The updateConfiguration function will call by 
     * configuration catched a error.
     * You can override the function.
     * @param error the catched error.
     *
     */
    protected function errorHandler(error:Error):void
    {
        throw new FrameworkError(error.toString());
    }
    
    /**
     * Handler then the config file loaded.
     * @param event
     * 
     */    
    private function configFile_completeHandler(event:Event):void
    {
        ConfigFileHelper(event.target).addEventListener(Event.COMPLETE,
            configFile_completeHandler);
        
        configXML = ConfigFileHelper(event.target).configXML;
        if(configXML)
        {
            initApp();
        }
    }
    
    /**
     * Handler the external files loading progressHanlder
     * @param event
     * 
     */    
    private function progressHandler(event:Event):void
    {
        updateProgress(filePreloading.percentage);
    }
    
    /**
     * Handler then the external files.
     * @param event
     * 
     */    
    private function loadCompletedHandler(event:Event):void
    {
        Bootstrap.getInstance().
            manaca_internal::setPreloadFiles(filePreloading.preloadFiles);
        
        filePreloading.removeEventListener(Event.COMPLETE, 
            loadCompletedHandler);
        filePreloading.removeEventListener(Event.CHANGE, progressHandler);
        filePreloading.dispose();
        filePreloading = null;
        
        updateProgress(100);
        
        dispatchEvent(new Event(Event.INIT));
    }
}
}