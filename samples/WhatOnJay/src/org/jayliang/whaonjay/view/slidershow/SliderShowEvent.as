package org.jayliang.whaonjay.view.slidershow
{
import flash.events.Event;

public class SliderShowEvent extends Event
{
    //==========================================================================
    //  Class constants
    //==========================================================================
    public static const CLOSE:String = "closeSliderShow";
    //==========================================================================
    //  Constructor
    //==========================================================================
	public function SliderShowEvent(type:String, 
	                                bubbles:Boolean=false, 
	                                cancelable:Boolean=false)
	{
	    super(type, bubbles, cancelable);
	}
}
}