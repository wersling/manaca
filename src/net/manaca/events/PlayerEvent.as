package net.manaca.events
{
import flash.events.Event;

public class PlayerEvent extends FrameworkEvent
{
    /**
     * Dispatched when the play state chenged.
     * @eventType playStateChange
     */
    static public const PLAY_STATE_CHANGE:String = "playStateChange";

    /**
     * Dispatched when the play progress chenged.
     * @eventType playStateChange
     */
    static public const PROGRESS_CHANGE:String = "progressChange";

    /**
     * 
     * @param type
     * @param bubbles
     * @param cancelable
     * 
     */
    public function PlayerEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
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
        return new PlayerEvent(type, bubbles, cancelable);
    }
}
}