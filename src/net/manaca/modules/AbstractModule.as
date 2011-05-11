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
import org.robotlegs.core.IContext;
/**
 * 动态可加载模块的基类。
 * @author sean
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
    protected var context:IContext;
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * 添加该模块的Context事件。
     * @param type 事件类型。
     * @param listener 处理事件的侦听器函数。
     * @param useCapture 确定侦听器是运行于捕获阶段、目标阶段还是冒泡阶段。
     * @param priority 事件侦听器的优先级。
     * @param useWeakReference 确定对侦听器的引用是强引用，还是弱引用。
     * 
     */    
    public function addContextListener(type:String, 
                                listener:Function, 
                                useCapture:Boolean=false, 
                                priority:int=0, 
                                useWeakReference:Boolean=false) : void
    {
        context.eventDispatcher.addEventListener(type, listener, 
            useCapture, priority, useWeakReference);
    }
    
    /**
     * 删除已经侦听的该模块的Context事件。
     * @param type 事件的类型。
     * @param listener 要删除的侦听器对象。
     * @param useCapture 指出是否为捕获阶段或目标阶段和冒泡阶段注册了侦听器。
     * 
     */    
    public function removeContextListener(type:String, 
                                   listener:Function, 
                                   useCapture:Boolean=false) : void
    {
        context.eventDispatcher.removeEventListener(type, listener, useCapture);
    }
    
    /**
     * 检查Context对象是否为特定事件类型注册了任何侦听器。
     * @param type 事件的类型。
     * @return 如果指定类型的侦听器已注册，则值为 true；否则，值为 false。
     * 
     */    
    public function hasContextListener(type:String) : Boolean
    {
        return context.eventDispatcher.hasEventListener(type);
    }
    
    /**
     * 删除此模块 
     * 
     */    
    public function shutdown():void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
        var contextEvent:ContextEvent = new ContextEvent(ContextEvent.SHUTDOWN);
        context.eventDispatcher.dispatchEvent(contextEvent);
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
        shutdown();
    }
}
}
