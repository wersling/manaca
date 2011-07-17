/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import com.yahoo.astra.layout.LayoutContainer;
import com.yahoo.astra.layout.modes.BorderLayout;
import com.yahoo.astra.layout.modes.ILayoutMode;

import flash.events.Event;
import flash.system.Security;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.utilities.modular.core.IModuleContext;

/**
 * 动态可加载模块的基类。
 * @author Sean Zou
 * 
 */
public class AbstractModule extends LayoutContainer
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>AbstractModule</code>实例.
     * @param autoRemove 是(true)否(false)自动删除这个模块，
     * 在这个模块移除舞台的时候.
     * @param mode Layout 模式
     */    
    public function AbstractModule(autoRemove:Boolean = false, 
                                   mode:ILayoutMode = null)
    {
        if(!mode)
        {
            mode = new BorderLayout();
        }
        super(mode);
        autoMask = false;
        
        if(autoRemove)
        {
            addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
        }
        
        Security.allowDomain("*");
        Security.allowInsecureDomain("*");
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    /**
     * Robotlegs Context
     */    
    protected var context:IModuleContext;
    //==========================================================================
    //  Methods
    //==========================================================================
    public function dispose():void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
        var contextEvent:ContextEvent = new ContextEvent(ContextEvent.SHUTDOWN);
        context.eventDispatcher.dispatchEvent(contextEvent);
        context.dispose();
        context = null;
    }
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    /**
     * 当该模块从舞台上移除时触发的事件处理.
     * @param event
     * 
     */    
    private function removedFromStageHandler(event:Event):void
    {
        dispose();
    }
}
}
