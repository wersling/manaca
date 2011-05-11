/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import org.robotlegs.core.IMediatorMap;

/**
 * 
 * @author sean
 * 
 */
public interface IModuleFactory
{
    /**
     * 实例化模块.
     * @param mediatorMap IMediatorMap实例，如果为null，则不map任何Mediator.
     * @param moduleMediator 自定义的Module Mediator类，如果为null，则map默认的Mediator.
     * 你可以自定义一个Mediator并继承ModuleMediator.
     * @return 模块实例.
     * 
     */    
    function create(mediatorMap:IMediatorMap = null, 
                           moduleMediator:Class = null,
                           autoCreate:Boolean = true, 
                           autoRemove:Boolean = true):IModuleDisplay;
}
}
