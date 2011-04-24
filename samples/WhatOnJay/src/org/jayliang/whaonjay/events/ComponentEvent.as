package org.jayliang.whaonjay.events
{
import flash.display.DisplayObject;
import flash.events.Event;

public class ComponentEvent extends Event
{
    //==========================================================================
    //  Class constants
    //==========================================================================
    public static const SHOW:String = "showComponent";
    public static const CLOSE:String = "closeComponent";
    //==========================================================================
    //  Constructor
    //==========================================================================
	public function ComponentEvent(type:String, component:DisplayObject=null,
	                               bubbles:Boolean=false, 
	                               cancelable:Boolean=false)
	{
	    super(type, bubbles, cancelable);
	    this._component = component;
	}
	//==========================================================================
    //  Properties
    //==========================================================================
    private var _component:DisplayObject;

    public function get component():DisplayObject
    {
        return _component;
    }

}
}