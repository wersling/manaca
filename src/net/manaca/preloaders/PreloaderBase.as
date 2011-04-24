package net.manaca.preloaders
{
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.system.Capabilities;
import flash.utils.getDefinitionByName;

import net.manaca.application.IApplication;

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
    //  Variables
    //==========================================================================

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Application Constructor.
     */
    public function PreloaderBase()
    {
        //stop at the first frame
        stop();
        
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        
        if(root && root.loaderInfo)
        {
            root.loaderInfo.addEventListener(Event.INIT, initHanlder);
        }
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * Create a PreloaderDisplay.
     * the default create a DownloadProgressBar.
     * @return
     *
     */
    protected function initDisplay():void
    {
    }

    /**
     * Create a application.
     * @param params
     * @return
     *
     */
    protected function createApplication():Object
    {
        var mainClassName:String;

        if (mainClassName == null)
        {
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
        }
        var mainClass:Class = Class(getDefinitionByName(mainClassName));
        return mainClass ? new mainClass() : null;
    }

    /**
     * @private
     * initialize the application.
     */
    protected function initialize():void
    {
        nextFrame();

        var app:Object = createApplication();
        addChild(app as Sprite);

        if(app is IApplication)
        {
            IApplication(app).initialize();
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
        initDisplay();

        addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }

    /**
     * Use frame based loading
     */
    protected function enterFrameHandler(event:Event):void
    {
        if (loaderInfo.bytesLoaded == loaderInfo.bytesTotal)
        {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            initialize();
        }
    }
}
}