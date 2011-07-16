package net.manaca.utils
{
import flash.display.DisplayObject;

/**
 * Simple class that handles stretching of displayelements.
 **/
public class Stretcher
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /** 
     * Stretches the clip nonuniform to fit the container. 
     */
    static public var EXACTFIT:String = "exactfit";
    /** 
     * Stretches the clip uniform to fill the container,
     * with parts being cut off.
     */
    static public var FILL:String = "fill";
    /**
     * No stretching, but the clip is placed in the center of the container.
     */    
    static public var NONE:String = "none";
    /**
     * Stretches the clip uniform to fit the container, with bars added.
     */    
    static public var UNIFORM:String = "uniform";
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * Resize a displayobject to the display, depending on the stretching.
     *
     * @param display   The display element to resize.
     * @param width	    The target width.
     * @param height	The target height.
     * @param type	    The stretching type.
     */
    static public function stretch(display:DisplayObject, width:Number,
                                   height:Number, type:String = "uniform"):void
    {
        var xsc:Number = width / display.width;
        var ysc:Number = height / display.height;

        switch (type.toLowerCase())
        {
            case "exactfit":
            {
                display.width = width;
                display.height = height;
                break;
            }
            case "fill":
            {
                if (xsc > ysc)
                {
                    display.width *= xsc;
                    display.height *= xsc;
                }
                else
                {
                    display.width *= ysc;
                    display.height *= ysc;
                }
                break;
            }
            case "none":
            {
                display.scaleX = 1;
                display.scaleY = 1;
                break;
            }
            case "uniform":
            {
                if (xsc > ysc)
                {
                    display.width *= ysc;
                    display.height *= ysc;
                }
                else
                {
                    display.width *= xsc;
                    display.height *= xsc;
                }
                break;
            }
            default:
            {
                //do nothing
            }
        }
        display.x = Math.round(width / 2 - display.width / 2);
        display.y = Math.round(height / 2 - display.height / 2);
        display.width = Math.ceil(display.width);
        display.height = Math.ceil(display.height);
    }
}
}