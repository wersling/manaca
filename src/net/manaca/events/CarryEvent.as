package net.manaca.events
{
import flash.events.Event;

/**
 * The CarryEvent can catch a data in the event instance.
 * @author v-seanzo
 *
 */
public class CarryEvent extends FrameworkEvent
{
    /**
     * Constructs a new <code>CarryEvent</code> instance.
     * @param type
     * @param data
     * @param bubbles
     * @param cancelable
     *
     */
    public function CarryEvent(type:String, data:*, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
        this.data = data;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    //----------------------------------
    //  data
    //----------------------------------
    /**
     * catch of data.
     */
    public var data:*;

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * @inheritDoc
     */
    override public function clone():Event
    {
        return new CarryEvent(this.type, this.data, this.bubbles, this.cancelable);
    }
}
}