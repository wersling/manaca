package net.manaca.core.patterns.command
{
import flash.events.Event;

/**
 * The CommandEvent class is used to differentiate Command events
 * from events raised by the underlying Flash framework (or
 * similar). It is mandatory for Command event dispatching.
 *
 * <p>For more information on how event dispatching works in Model-View-Presenter,
 * please check with ForntPresenter.</p>
 *
 * <p>Events are typically broadcast as the result of a user gesture occuring
 * in the application, such as a button click, a menu selection, a double
 * click, a drag and drop operation, etc.  </p>
 * @author Sean Zou
 *
 */
public class CommandEvent extends Event
{

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Constructs a new <code>CommandEvent</code> instance.
     *
     * <p>Takes the event name (type) and data object (defaults to null)
     * and also defaults the standard Command event properties bubbles and cancelable
     * to true and false respectively.</p>
     *
     */
    public function CommandEvent(type:String, data:* = null, bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);

        this.data = data;
    }

    //==========================================================================
    //  Properties
    //==========================================================================

    /**
     * The data property can be used to hold information to be passed with the event
     * in cases where the developer does not want to extend the CommandEvent class.
     * However, it is recommended that specific classes are created for each type
     * of event to be dispatched.
     */
    public var data:*;
}
}