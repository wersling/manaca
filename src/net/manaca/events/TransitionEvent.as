package net.manaca.events
{
import flash.events.Event;

/**
 * The TransitionEvent signals that the object transition change for ITransitionObject.
 * @see net.manaca.display.ITransitionObject;
 * @author SeanZou
 * 
 */    
public class TransitionEvent extends Event
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * Dispatched when the transition out.
     * @eventType transitionOut
     */    
    static public const TRANSITION_OUT:String = "transitionOut";
    /**
     * Dispatched when the transition in.
     * @eventType transitionIn
     */    
    static public const TRANSITION_IN:String = "transitionIn";
    /**
     * Dispatched when the transition out completed.
     * @eventType transitionOutComplete
     */    
    static public const TRANSITION_OUT_COMPLETE:String = "transitionOutComplete";
    /**
     * Dispatched when the transition in completed.
     * @eventType transitionInComplete
     */    
    static public const TRANSITION_IN_COMPLETE:String = "transitionInComplete";

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a new <code>PreloaderEvent</code> instance.
     * @param type
     * @param bubbles
     * @param cancelable
     * 
     */
    public function TransitionEvent(type:String, 
                                    bubbles:Boolean = false, 
                                    cancelable:Boolean = false)
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
        return new TransitionEvent(type, bubbles, cancelable);
    }
}
}