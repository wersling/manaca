package net.manaca.managers
{
import flash.display.DisplayObject;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageDisplayState;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.system.Capabilities;
import flash.utils.Dictionary;

import net.manaca.errors.IllegalArgumentError;
import net.manaca.errors.UnsupportedOperationError;

/**
 * The <code>StageManager</code> provides the global stage manager and fullScreen control.
 * @author Sean Zou
 *
 */
final public class StageManager
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    static private const targetMap:Dictionary = new Dictionary();
    //==========================================================================
    //  Class variables
    //==========================================================================

    //----------------------------------
    //  stage
    //----------------------------------
    /**
     * @private
     */
    static private var _stage:Stage;

    /**
     * Get the main stage if we"re initialized the stage manager.
     * @return the main stage object.
     * @throws net.manaca.errors.UnsupportedOperationError thrown the error indicate that the
     * manager not initialize.
     */
    static public function get stage():Stage
    {
        if(!available)
        {
            throw new UnsupportedOperationError("The stage must be initialized in the class!");
        }
        return _stage;
    }

    //----------------------------------
    //  available
    //----------------------------------
    /**
     * Checks if the stage is available.
     * @return Boolean
     */
    static public function get available():Boolean
    {
        return ( _stage != null );
    }

    //----------------------------------
    //  fullScreenAvailable
    //----------------------------------
    static private var _fullScreenAvailable:Boolean = false;

    /**
     * Checks if full screen mode is available.
     * @return Boolean
     */
    static public function get fullScreenAvailable():Boolean
    {
        return _fullScreenAvailable;
    }

    //----------------------------------
    //  stageWidth
    //----------------------------------
    /**
     * Returns the width current width.
     * @return the stage width.
     * @throws net.manaca.errors.UnsupportedOperationError thrown the error indicate that the
     * manager not initialize.
     */
    static public function get stageWidth():uint
    {
        if(!available)
        {
            throw new UnsupportedOperationError("The stage must be initialized in the class!");
        }
        return stage.stageWidth;
    }

    //----------------------------------
    //  stageHeight
    //----------------------------------
    /**
     * Returns the width current height.
     * @return the width height.
     * @throws net.stage.errors.UnsupportedOperationError thrown the error indicate that the
     * manager not initialize.
     */
    static public function get stageHeight():uint
    {
        if(!available)
        {
            throw new UnsupportedOperationError("The stage must be initialized in the class!");
        }
        return stage.stageHeight;
    }

    //==========================================================================
    //  Class methods
    //==========================================================================

    /**
     * Initialize the state manager.
     * @param stage the main stage object.
     * @throws net.manaca.errors.IllegalArgumentError thrown the error indicate that a
     * the stage argument is invalid.
     */
    static public function initialize(stage:Stage):void
    {
        if(stage != null && stage is Stage)
        {
            _stage = stage;
            // initialize the stage default setting.
            _stage.scaleMode = StageScaleMode.NO_SCALE;
            _stage.align = StageAlign.TOP_LEFT;

            const versionStr:String = Capabilities.version;
            var version:String = versionStr.split(" ")[1];
            // For compatibility with version 9,0,16,0 or earlier
            // Must be version 9,0,28,0 or later for Fullscreen support
            if ( Number(version.split(",")[0]) >= 9 && Number(version.split(",")[2]) >= 28 )
            {
                _fullScreenAvailable = true;
            }
            else
            {
                _fullScreenAvailable = false;
                trace("Your version of Flash Player (" + versionStr + ") does not support full screen mode.");
            }

            _stage.addEventListener(Event.RESIZE, reSizeHandler);
        }
        else
        {
            throw new IllegalArgumentError("invalid argument stage:" + stage);
        }
    }

    /**
     * Switch to full screen mode if available.
     * This method has no affect if full screen mode is not available or if already in full screen mode
     * @throws net.manaca.errors.UnsupportedOperationError thrown the error indicate that a
     * the application is not available fullScreen.
     */
    static public function turnOnFullScreen():void
    {
        if(fullScreenAvailable)
        {
            stage.displayState = StageDisplayState.FULL_SCREEN;
        }
        else
        {
            throw new UnsupportedOperationError("The application is not available fullScreen.");
        }
    }

    /**
     * Switch to normal mode.
     * This method has no affect if already in normal mode.
     * @throws net.manaca.errors.UnsupportedOperationError thrown the error indicate that a
     * the application is not available fullScreen.
     */
    static public function turnOffFullScreen():void
    {
        if(fullScreenAvailable)
        {
            stage.displayState = StageDisplayState.NORMAL;
        }
        else
        {
            throw new UnsupportedOperationError("The application is not available fullScreen.");
        }
    }

    /**
     * Toggles full screen mode.
     * This method has no affect if full screen mode is not available
     * @throws net.manaca.errors.UnsupportedOperationError thrown the error indicate that a
     * the application is not available fullScreen.
     */
    static public function toggleFullScreen():void
    {
        if (fullScreenAvailable)
        {
            switch (stage.displayState)
            {
                case StageDisplayState.FULL_SCREEN:
                    turnOffFullScreen();
                    break;
                case StageDisplayState.NORMAL:
                    turnOnFullScreen();
                    break;
            }
        }
        else
        {
            throw new UnsupportedOperationError("The application is not available fullScreen.");
        }
    }

    /**
     *
     * @param target
     * @param fun
     * @param dispatchNow
     *
     */
    static public function registerResizeHandler(target:DisplayObject, fun:Function, dispatchNow:Boolean = false):void
    {
        if(fun != null && target != null)
        {
            targetMap[fun] = target;

            if(dispatchNow)
            {
                fun.apply(target, [ stageWidth, stageHeight ]);
            }
        }
    }

    /**
     *
     * @param target
     * @param fun
     *
     */
    static public function removeResizeHandler(target:DisplayObject, fun:Function):void
    {
        if(fun != null && target != null)
        {
            delete targetMap[fun];
        }
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    static private function reSizeHandler(event:Event):void
    {
        for(var fun:* in targetMap)
        {
            var target:DisplayObject = targetMap[fun];
            var func:Function = fun;
            func.apply(target, [ stageWidth, stageHeight ]);
        }
    }
}
}