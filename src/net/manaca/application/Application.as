package net.manaca.application
{
import flash.display.Sprite;
import flash.events.Event;

import net.manaca.application.config.ApplicationInitHelper;
import net.manaca.application.config.ConfigFileHelper;
import net.manaca.application.config.FilePreloadingHelper;
import net.manaca.core.AbstractHandler;
import net.manaca.core.manaca_internal;
import net.manaca.errors.FrameworkError;
import net.manaca.errors.IllegalArgumentError;
import net.manaca.errors.SingletonError;
import net.manaca.loaderqueue.LoaderQueue;
import net.manaca.modules.ModuleManager;
import net.manaca.modules.ModuleVO;

/**
 * <code>Application</code> is the default access point for flash applications.
 *
 * <p>You can use a Frame tag define a <code>Preloader</code> object.</p>
 *
 * <p>You must simply init your application something like this:</p>
 * <listing version = "3.0" >
 * package {
import net.manaca.application.Application;
[Frame(factoryClass="net.manaca.preloaders.SimplePreloader")]
public class ApplicationExample extends Application
{
[Embed(source="./application.xml", mimeType="application/octet-stream")]
private var configClz:Class;

public function ApplicationExample()
{
super(configClz);
}

override protected function startup():void
{
}
}
}
 * </listing>
 *
 * @author Sean Zou
 */
public class Application extends Sprite implements IApplication
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * Singleton for this application
     */    
    static private var instance:Application;
    //==========================================================================
    //  Variables
    //==========================================================================
    private var config:*;
    private var configXML:XML;
    private var filePreloading:FilePreloadingHelper;
    private const loaderQueueIns:LoaderQueue = new LoaderQueue(8, 100);
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Application</code> instance.
     * @param config the config xml class.
     * you can writing something like this:
     * <listing version = "3.0" >
     * [Embed(source="./application.xml", mimeType="application/octet-stream")]
     * private var configClz:Class;
     * </listing>
     */
    public function Application(config:*)
    {
        AbstractHandler.handlerClass(this, Application);

        if(config != null)
        {
            this.config = config;
        }
        else
        {
            throw new IllegalArgumentError(
                                    "invalid config argument:" + config);
        }

        if(instance != null)
        {
            throw new SingletonError(this);
        }
        else
        {
            instance = this;
        }
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * @inheritDoc
     */
    final public function initialize():void
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
        filePreloading.addEventListener(Event.COMPLETE, 
            loadCompletedHandler);
        filePreloading.addEventListener(Event.CHANGE, progressHandler);
        filePreloading.start();
    }
    
    /**
     * The startup function will call by application initialized.
     * You need override the function.
     * <p>for example:</p>
     * @example
     * <pre>
     * final override public function startup(...rest):void
     * {
     *         trace("The application started!")
     * }
     * </pre>
     * @throws net.manaca.errors.AbstractOperationError thrown the error 
     * indicate that an operation marked by the developer has not override 
     * the abstract function.
     */
    protected function startup():void
    {
        AbstractHandler.handlerFunction("Application.startup");
    }

    /**
     * The updateConfiguration function will call by configuration update.
     * You can override the function.
     * @param percent
     *
     */
    protected function updateProgress(percent:uint):void
    {
    }

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

    //==========================================================================
    //  Event handlers
    //==========================================================================
    /**
     * Handler then the config file loaded.
     * @param event
     * 
     */    
    private function configFile_completeHandler(event:Event):void
    {
        ConfigFileHelper(event.target).addEventListener(Event.COMPLETE,
            configFile_completeHandler);
        
        configXML = ConfigFileHelper(event.target).config;
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
        
        startup();
    }
}
}