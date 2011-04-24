package net.manaca.loading.queue
{
import flash.events.Event;

import net.manaca.events.FrameworkEvent;

/**
 * The LoadingEvent object is dispatched into the event flow whenever LoadingQueue events occur. 
 * @author Sean Zou
 */    
public class LoadingEvent extends FrameworkEvent
{
    //==========================================================================
    //  Class methods
    //==========================================================================
    
    /**
     * The LoadingEvent.COMPLETE constant defines the value of the type property of a loading complete event object. 
     */        
    static public const COMPLETE:String = "complete";
    /**
     * The LoadingEvent.ERROR constant defines the value of the type property of a loading has a error event object. 
     */        
    static public const ERROR:String = "error";
    /**
     * The LoadingEvent.PROGRESS constant defines the value of the type property of a loading update event object. 
     */        
    static public const PROGRESS:String = "progress";

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * LoadingEvent Constructor.
     * @param type
     * @param bubbles
     * @param cancelable
     * 
     */
    public function LoadingEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    /**
     * The loading percent.
     */
    public var percent:Number;

    /**
     * The loading error object.
     */
    public var error:Object;

    //==========================================================================
    //  Methods
    //==========================================================================

    override public function clone():Event
    {
        var result:LoadingEvent = new LoadingEvent(type);
        result.percent = percent;
        result.error = error;
        return result;
    }
}
}