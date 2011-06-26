/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import org.robotlegs.core.IMediatorMap;
import org.robotlegs.core.IViewMap;
import org.robotlegs.utilities.modular.core.IModule;

/**
 * 
 * @author sean
 * 
 */
public interface IModuleFactory
{
    /**
     * 实例化模块.
     * @param viewMap IViewMap实例，
     * 当构造的是一个基于Robotlegs modular插件的模块时，设置该参数将自动mapView，
     * 如果为null，则需要手动mapView。
     * 非modular插件模块不需要设置该参数。
     * @return 模块实例.
     * 
     */    
    function create(viewMap:IViewMap = null):IModule;
}
}
