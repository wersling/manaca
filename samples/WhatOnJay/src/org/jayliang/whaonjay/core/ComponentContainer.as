package org.jayliang.whaonjay.core
{
import com.gskinner.motion.GTween;

import fl.motion.easing.Elastic;

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;

public class ComponentContainer extends Sprite
{
    //==========================================================================
    //  Constructor
    //==========================================================================
	public function ComponentContainer(w:Number, h:Number)
	{
	    bgMask = new Shape();
        bgMask.graphics.beginFill(0x000000, 0.4);
        bgMask.graphics.drawRect(0, 0, w, h);
        bgMask.graphics.endFill();
        bgMask.alpha = 0;
        bgMask.visible = false;
        this.addChildAt(bgMask, 0);
	}
	//==========================================================================
    //  Variables
    //==========================================================================
    private var bgMask:Shape;
    private var current:DisplayObject;
	//==========================================================================
    //  Public methods
    //==========================================================================
    public function show(target:DisplayObject):void
    {
        bgMask.visible = true;
        doAlphaAnimation(target, 0.5, 0, 1);
        doAlphaAnimation(bgMask, 0.5, 0, 1);
        
        target.x = (this.width - target.width) / 2;
        target.y = (this.height - target.height) / 2;
        this.addChild(target);
        current = target;
    }
    
    public function close():void
    {
        doAlphaAnimation(bgMask, 0.5, 1, 0);
        doAlphaAnimation(current, 0.5, 1, 0, hideCompletedHandler);
    }
    //==========================================================================
    //  Private methods
    //==========================================================================
    private function doAlphaAnimation(target:DisplayObject, duration:Number, 
                                      from:Number, end:Number, 
                                      callBack:Function = null):void
    {
        target.alpha = from;
        var gtween:GTween = new GTween(target, duration, null, Elastic.easeIn);
        if (callBack != null) gtween.addEventListener(Event.COMPLETE, callBack);
        gtween.setProperties({alpha:end});
    }
    
    private function hideCompletedHandler(event:Event):void
    {
        event.target.removeEventListener(Event.COMPLETE, hideCompletedHandler);
        if (current && this.contains(current))
        {
            this.removeChild(current);
        }
        current = null;
        bgMask.visible = false;
    }
}
}