package net.manaca.preloaders
{
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.IEventDispatcher;
import flash.events.ProgressEvent;
import flash.external.ExternalInterface;
import flash.system.Capabilities;
import flash.utils.getDefinitionByName;
import flash.utils.setTimeout;

import net.manaca.application.IApplication;
import net.manaca.application.IApplicationSetup;

/**
 * The Preloader class is used by the application to monitor
 * the download and initialization status of a flash application.
 * It is also responsible for downloading the runtime shared libraries (RSLs).
 * @author Sean Zou
 *
 */
public class PreloaderBase extends MovieClip
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * PreloaderBase Constructor.
     * @param progressBar The display progress bar.
     * 
     */    
    public function PreloaderBase(progressBar:IPreloaderDisplay = null)
    {
        //stop at the first frame
        stop();
        
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.quality = StageQuality.HIGH;
        
        if(root && root.loaderInfo)
        {
            root.loaderInfo.addEventListener(Event.INIT, initHanlder);
        }
        
        this.progressBar = progressBar;
    }
    
    //==========================================================================
    //  Properties
    //==========================================================================
    protected var progressBar:IPreloaderDisplay;
    
    /**
     * The main swf size ratio.
     */    
    protected var swfRatio:int = 50;
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * Create a application.
     * @param params
     * @return
     *
     */
    protected function getApplicationClass():Class
    {
        var mainClassName:String;

        var url:String = loaderInfo.loaderURL;

        var dot:int = url.lastIndexOf(".");
        var slash:int = url.lastIndexOf("/");
        mainClassName = url.substring(slash + 1, dot);

        /* modify at flex 2 debuging error. */
        if(Capabilities.isDebugger && mainClassName.indexOf("_debug") != -1)
        {
            mainClassName = mainClassName.slice(0, -6);
        }
        
        mainClassName = decodeURIComponent(mainClassName);
        
        var mainClass:Class = Class(getDefinitionByName(mainClassName));
        return mainClass;
    }
    
    protected function getSWFPath():String
    {
        var result:String = loaderInfo.loaderURL;
        result = result.split("\\").join("/");
        var lastIndex:int = result.lastIndexOf("/");
        result = result.slice(0, lastIndex + 1);
        return result;
    }
    
    /**
     * @private
     * check js is inited.
     */    
    private function checkJSInit():void
    {
        try
        {
            ExternalInterface.call(
                "function getHref(){return document.location.href;}");
        }
        catch(error:Error)
        {
            trace(error);
            setTimeout(checkJSInit, 100);
            return;
        }
        
        preInit();
    }
    
    private function preInit():void
    {
        nextFrame();
        
        var appClz:Class = getApplicationClass();
        
        var configPath:String = appClz.APP_CONFIG;
        if(configPath.indexOf("http") == -1)
        {
            configPath = getSWFPath() + configPath;
        }
        
        var setupClz:Class = Class(getDefinitionByName(
            "net.manaca.application.config.ApplicationSetup"));
        var setup:IApplicationSetup = new setupClz(stage, configPath);
        setup.addEventListener(ProgressEvent.PROGRESS,
            preInit_progressHandler);
        setup.addEventListener(Event.INIT, preInit_initHandler);
        setup.start();
    }
    
    /**
     * @private
     * initialize the application.
     */
    protected function initialize():void
    {
        if(progressBar)
        {
            stage.removeChild(progressBar as Sprite);
        }
        
        var appClz:Class = getApplicationClass();
        var app:Object = new appClz();
        addChild(app as Sprite);

        if(app is IApplication)
        {
            IApplication(app).initialize();
        }
    }
    
    protected function updateProgress(percent:uint):void
    {
        if(progressBar)
        {
            progressBar.updateProgress(percent);
        }
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    /**
     * Handler the init event.
     * @param e
     *
     */
    protected function initHanlder(event:Event):void
    {
        if(progressBar)
        {
            stage.addChild(progressBar as Sprite);
        }
        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }

    /**
     * Use frame based loading
     */
    protected function enterFrameHandler(event:Event):void
    {
        var loaded:uint = loaderInfo.bytesLoaded;
        var total:uint = loaderInfo.bytesTotal;
        
        updateProgress(loaded / total * swfRatio);
        
        if((loaded >= total && total > 0) || (total == 0 && loaded > 0) 
            || (root is MovieClip && (MovieClip(root).totalFrames > 2) && 
                (MovieClip(root).framesLoaded >= 2)))
        {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            
            var playerType:String = Capabilities.playerType;
            if ((playerType == "PlugIn" || playerType == "ActiveX"))
            {
                checkJSInit();
            }
            else
            {
                preInit();
            }
        }
    }
    
    private function preInit_initHandler(event:Event):void
    {
        var setup:IApplicationSetup = event.currentTarget as IApplicationSetup;
        setup.removeEventListener(ProgressEvent.PROGRESS,
            preInit_progressHandler);
        setup.removeEventListener(Event.INIT, preInit_initHandler);
        
        updateProgress(100);
        setTimeout(initialize, 25);
    }
    
    private function preInit_progressHandler(event:ProgressEvent):void
    {
        if(!isNaN(event.bytesLoaded / event.bytesTotal))
        {
            updateProgress(
                event.bytesLoaded / event.bytesTotal * 
                (100 - swfRatio) + swfRatio);
        }
        else
        {
            updateProgress(swfRatio);
        }
    }
}
}