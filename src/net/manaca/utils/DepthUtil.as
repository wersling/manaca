package net.manaca.utils
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

/**
 * DepthManager to manage the depth of display objects.
 */
public class DepthUtil
{

    /**
     * Bring the display to all brother display's bottom.
     * @param display the display to be set to bottom
     */
    static public function bringToBottom(display:DisplayObject):void
    {
        var parent:DisplayObjectContainer = display.parent;
        if(parent == null)
        {
            return;
        }
        if(parent.getChildIndex(display) != 0)
        {
            parent.setChildIndex(display, 0);
        }
    }

    /**
     * Bring the display to all brother displays' top.
     */
    static public function bringToTop(display:DisplayObject):void
    {
        var parent:DisplayObjectContainer = display.parent;
        if(parent == null)
        {
            return;
        }
        var maxIndex:int = parent.numChildren - 1;
        //var index:int = parent.getChildIndex(display);
        for(var i:int = 0;i <= maxIndex; i++)
        {
            //var mi:DisplayObject = parent.getChildAt(i);
        }
        if(parent.getChildIndex(display) != maxIndex)
        {
            parent.setChildIndex(display, maxIndex);
        }
    }

    /**
     * Returns is the display is on the top depths in DepthManager's valid depths.
     * Valid depths is that depths from MIN_DEPTH to MAX_DEPTH.
     */
    static public function isTop(display:DisplayObject):Boolean
    {
        var parent:DisplayObjectContainer = display.parent;
        if(parent == null)
        {
            return true;
        }
        return (parent.numChildren - 1) == parent.getChildIndex(display);
    }

    /**
     * Returns if the display is at bottom depth.
     * @param display the display to be set to bottom
     * @return is the display is at the bottom
     */
    static public function isBottom(display:DisplayObject):Boolean
    {
        var parent:DisplayObjectContainer = display.parent;
        if(parent == null)
        {
            return true;
        }
        var depth:int = parent.getChildIndex(display);
        if(depth == 0)
        {
            return true;
        }
        return false;
    }

    /**
     * Return if display is just first bebow the aboveDisplay.
     * if them don't have the same parent, whatever depth they has just return false.
     */
    static public function isJustBelow(display:DisplayObject, aboveDisplay:DisplayObject):Boolean
    {
        var parent:DisplayObjectContainer = display.parent;
        if(parent == null)
        {
            return false;
        }
        if(aboveDisplay.parent != parent)
        {
            return false;
        }

        return parent.getChildIndex(display) == parent.getChildIndex(aboveDisplay) - 1;
    }

    /**
     * Returns if display is just first above the aboveDisplay.
     * if them don't have the same parent, whatever depth they has just return false.
     */
    static public function isJustAbove(display:DisplayObject, aboveDisplay:DisplayObject):Boolean
    {
        return isJustBelow(aboveDisplay, display);
    }
}
}