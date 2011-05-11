/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{

import org.robotlegs.core.IContext;

public interface IModuleDisplay
{
    /**
     * 监听Context事件
     */    
    function addContextListener(type:String, 
                                listener:Function, 
                                useCapture:Boolean=false, 
                                priority:int=0, 
                                useWeakReference:Boolean=false) : void;
    /**
     * 删除监听Context事件
     */    
    function removeContextListener(type:String, 
                                   listener:Function, 
                                   useCapture:Boolean=false) : void;
    
    /**
     * 是否存在Context事件
     * @param type
     * @return 
     * 
     */    
    function hasContextListener(type:String) : Boolean;
    
    /**
     * 设置模块大小
     * @param width 宽度
     * @param height 高度
     * 
     */
    //function setSize(width:Number, height:Number):void;
    
    /**
     * 删除此模块
     * 
     */    
    function shutdown():void;
}
}
