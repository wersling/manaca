/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{

import org.robotlegs.core.IContext;
/**
 * 定义模块显示对象的基础接口
 * @author wersling
 * 
 */
public interface IModuleDisplay
{
    /**
     * 添加该模块的Context事件。
     * @param type 事件类型。
     * @param listener 处理事件的侦听器函数。
     * @param useCapture 确定侦听器是运行于捕获阶段、目标阶段还是冒泡阶段。
     * @param priority 事件侦听器的优先级。
     * @param useWeakReference 确定对侦听器的引用是强引用，还是弱引用。
     * 
     */     
    function addContextListener(type:String, 
                                listener:Function, 
                                useCapture:Boolean=false, 
                                priority:int=0, 
                                useWeakReference:Boolean=false) : void;
    /**
     * 删除已经侦听的该模块的Context事件。
     * @param type 事件的类型。
     * @param listener 要删除的侦听器对象。
     * @param useCapture 指出是否为捕获阶段或目标阶段和冒泡阶段注册了侦听器。
     * 
     */    
    function removeContextListener(type:String, 
                                   listener:Function, 
                                   useCapture:Boolean=false) : void;
    
    /**
     * 检查Context对象是否为特定事件类型注册了任何侦听器。
     * @param type 事件的类型。
     * @return 如果指定类型的侦听器已注册，则值为 true；否则，值为 false。
     * 
     */    
    function hasContextListener(type:String) : Boolean;
    
    /**
     * 删除此模块
     * 
     */    
    function shutdown():void;
}
}
