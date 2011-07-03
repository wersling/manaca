/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
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
     * @return 模块实例.
     * 
     */    
    function create():IModule;
}
}
