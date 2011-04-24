package net.manaca.events
{
import flash.events.Event;

/**
 * The FrameworkEvent provide base event for manaca framework.
 * @author v-seanzo
 * 
 */    
public class FrameworkEvent extends Event
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a new <code>FrameworkEvent</code> instance.
     * @param type event type.
     * @param bubbles
     * @param cancelable
     * 
     */
    public function FrameworkEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * @inheritDoc 
     */       
    override public function clone():Event
    {
        return new FrameworkEvent(type, bubbles, cancelable);
    }
}
}