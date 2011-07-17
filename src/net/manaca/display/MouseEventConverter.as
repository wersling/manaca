package net.manaca.display
{
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import net.manaca.errors.IllegalArgumentError;

/**
 *
 * @author Sean Zou
 *
 */
public class MouseEventConverter
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var triggerTimer:Timer;
    private var intervalTimer:Timer;

    private var autoRemove:Boolean;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>MusicListPage</code> instance.
     *
     */
    public function MouseEventConverter(target:InteractiveObject, 
                                        autoRemove:Boolean = false)
    {
        if(target == null)
        {
            throw new IllegalArgumentError("invalid target:" + target);
        }
        this._target = target;
        this.autoRemove = autoRemove;

        target.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);

        if(autoRemove)
        {
            target.addEventListener(Event.REMOVED, removeHandler);
            target.addEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
        }
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  target
    //----------------------------------
    private var _target:InteractiveObject;

    public function get target():InteractiveObject
    {
        return _target;
    }

    //----------------------------------
    //  triggerTime
    //----------------------------------
    private var _triggerTime:uint = 250;

    public function set triggerTime(value:uint):void
    {
        _triggerTime = value;
    }

    public function get triggerTime():uint
    {
        return _triggerTime;
    }

    //----------------------------------
    //  interval
    //----------------------------------
    private var _interval:uint = 50;

    public function set interval(value:uint):void
    {
        _interval = value;
    }

    public function get interval():uint
    {
        return _interval;
    }

    //----------------------------------
    //  continualPressEvent
    //----------------------------------
    private var _continualPressEvent:Boolean = false;

    public function set continualPressEvent(value:Boolean):void
    {
        _continualPressEvent = value;
        if(_continualPressEvent)
        {
            catateTimers();
        }
    }

    public function get continualPressEvent():Boolean
    {
        return _continualPressEvent;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    private function catateTimers():void
    {
        triggerTimer = new Timer(triggerTime, 1);
        triggerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, 
            triggerHanlder);

        intervalTimer = new Timer(interval);
        intervalTimer.addEventListener(TimerEvent.TIMER, intervalHandler);
    }

    public function dispose():void
    {
        if(target)
        {
            target.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
            target.removeEventListener(Event.REMOVED, removeHandler);
            target.removeEventListener(Event.REMOVED_FROM_STAGE, removeHandler);
            if(target.stage)
            {
                target.stage.removeEventListener(MouseEvent.MOUSE_UP, 
                    stageMouseUpHandler);
                target.stage.removeEventListener(Event.MOUSE_LEAVE, 
                    stageMouseUpHandler);
            }
            _target = null;
        }

        if(triggerTimer)
        {
            triggerTimer.stop();
            triggerTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, 
                triggerHanlder);
            triggerTimer = null;
        }

        if(intervalTimer)
        {
            intervalTimer.stop();
            intervalTimer.removeEventListener(TimerEvent.TIMER, 
                intervalHandler);
            intervalTimer = null;
        }
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function triggerHanlder(event:TimerEvent):void
    {
        intervalTimer.reset();
        intervalTimer.start();
    }

    private function intervalHandler(event:TimerEvent):void
    {
        target.dispatchEvent(new MouseEvent(
            MouseEvent.CLICK, true, false, target.mouseX, target.mouseY));
    }

    private function mouseDownHandler(event:MouseEvent):void
    {
        if(continualPressEvent)
        {
            triggerTimer.stop();
            triggerTimer.reset();
            triggerTimer.start();
        }

        if(target.stage)
        {
            target.stage.addEventListener(MouseEvent.MOUSE_UP, 
                stageMouseUpHandler);
            target.stage.addEventListener(Event.MOUSE_LEAVE, 
                stageMouseUpHandler);
        }
    }

    private function stageMouseUpHandler(event:MouseEvent):void
    {
        if(triggerTimer)
        {
            intervalTimer.stop();
            triggerTimer.stop();
        }

        if (target.stage)
        {
            target.stage.removeEventListener(MouseEvent.MOUSE_UP,
                                             stageMouseUpHandler);
            target.stage.removeEventListener(Event.MOUSE_LEAVE,
                                             stageMouseUpHandler);
        }
        target.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true, false,
                                            target.mouseX, target.mouseY));
    }

    private function removeHandler(event:Event):void
    {
        if(event.currentTarget == target)
        {
            this.dispose();
        }
    }
}
}