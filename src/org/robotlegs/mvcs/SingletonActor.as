package org.robotlegs.mvcs
{
import flash.events.Event;
import flash.events.IEventDispatcher;

import org.robotlegs.base.EventMap;
import org.robotlegs.core.IEventMap;

public class SingletonActor
{
    /**
     * @private
     */
    protected const eventDispatchers:Array /* of IEventDispatcher*/= [];
    
    /**
     * @private
     */
    protected var _eventDispatcher:IEventDispatcher;

    /**
     * @private
     */
    protected var _eventMap:IEventMap;

    //---------------------------------------------------------------------
    //  Constructor
    //---------------------------------------------------------------------

    public function SingletonActor()
    {
    }

    //---------------------------------------------------------------------
    //  API
    //---------------------------------------------------------------------

    /**
     * @inheritDoc
     */
    public function get eventDispatcher():IEventDispatcher
    {
        return _eventDispatcher;
    }

    [Inject]
    /**
     * @private
     */
    public function set eventDispatcher(value:IEventDispatcher):void
    {
        _eventDispatcher = value;
        if(value && eventDispatchers.indexOf(value) == -1)
        {
            eventDispatchers.push(value);
        }
    }
    
    public function removeEventDispatcher(value:IEventDispatcher):void
    {
        var index:int = eventDispatchers.indexOf(value);
        
        if (index >= 0)
        {
            eventDispatchers.splice(index, 1);
        }
    }
    //---------------------------------------------------------------------
    //  Internal
    //---------------------------------------------------------------------

    /**
     * Local EventMap
     *
     * @return The EventMap for this Actor
     */
    protected function get eventMap():IEventMap
    {
        return _eventMap || (_eventMap = new EventMap(eventDispatcher));
    }

    /**
     * Dispatch helper method
     *
     * @param event The <code>Event</code> to dispatch on the <code>IContext</code>'s <code>IEventDispatcher</code>
     */
    protected function dispatch(event:Event):Boolean
    {
        var result:Boolean = false;
        for each(var dispatcher:IEventDispatcher in eventDispatchers)
        {
            if(dispatcher.hasEventListener(event.type))
            {
                result = dispatcher.dispatchEvent(event);
            }
        }
        return result;
    }
}
}
