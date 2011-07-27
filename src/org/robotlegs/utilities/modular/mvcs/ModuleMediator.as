/*
 * Copyright (c) 2009 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.utilities.modular.mvcs
{
    import flash.events.Event;
    
    import org.robotlegs.mvcs.Mediator;
    import org.robotlegs.utilities.modular.base.IModuleEvent;
    import org.robotlegs.utilities.modular.core.IModuleCommandMap;
    import org.robotlegs.utilities.modular.core.IModuleEventDispatcher;
    
    public class ModuleMediator extends Mediator
    {
        [Inject]
        public var moduleDispatcher:IModuleEventDispatcher;
               
        [Inject]
        public var moduleCommandMap:IModuleCommandMap;

        /**
         * Map an event type to globally redispatch to all modules within an application.
         * <p/>
         * <listing version="3.0">
         * mapRedispatchToModules(MyEvent.SOME_EVENT);
         * </listing>
         * 
         * @param event
         * 
         */
        protected function addModuleListener(type:String, listener:Function, eventClass:Class = null, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true):void
        {
            eventMap.mapListener(moduleDispatcher, type, listener, eventClass, useCapture, priority, useWeakReference);
        }
        
        /**
         * Globally redispatch an event to all modules within an application.
         * <p/>
         * <listing version="3.0">
         * eventMap.mapEvent(view, MyEvent.SOME_EVENT, redispatchToModule);
         * </listing>
         * 
         * @param event
         * 
         */
        protected function dispatchToModules(event:IModuleEvent):Boolean
        {
            if(moduleDispatcher.hasEventListener(Event(event).type))
                return moduleDispatcher.dispatchEvent(Event(event));
            return false;
        }
    }
}