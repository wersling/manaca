/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import flash.events.Event;

import org.robotlegs.mvcs.Mediator;

/**
 * @private
 * @author sean
 *
 */
public class ModuleMediator extends Mediator
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>ModuleMediator</code>实例.
     *
     */
    public function ModuleMediator()
    {
        super();
    }

    /**
     * 监听该模块的指定事件类型，获得事件后，直接clone该事件并抛出.
     * @param type 需要添加的事件类型。
     *
     */
    protected function addCloneEventType(type:String):void
    {
        if (viewComponent is IModuleDisplay)
        {
            IModuleDisplay(viewComponent).addContextListener(type,
                                                             cloneEventHandler);
        }
    }

    /**
     * 删除由addCloneEventType方法添加的事件类型。
     * @param type 需要删除的事件类型。
     * 
     */
    protected function removeCloneEventType(type:String):void
    {
        if (viewComponent is IModuleDisplay)
        {
            IModuleDisplay(viewComponent).removeContextListener(type,
                                                             cloneEventHandler);
        }
    }
    
    /**
     * 处理获取的需要clone的事件。
     * @param event
     * 
     */    
    private function cloneEventHandler(event:Event):void
    {
        dispatch(event.clone());
    }
}
}
