/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import flash.system.ApplicationDomain;

import org.robotlegs.utilities.modular.core.IModule;

/**
 * @private
 * @author Sean Zou
 * 
 */
public class ModuleFactory implements IModuleFactory
{
    public function ModuleFactory(
        applicationDomain:ApplicationDomain,
        moduleVO:ModuleVO)
    {
        this.applicationDomain = applicationDomain;
        this.moduleVO = moduleVO;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var applicationDomain:ApplicationDomain;
    private var moduleVO:ModuleVO;
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * @inheritDoc 
     */
    public function create():IModule
    {
        var moduleClz:Class = 
            applicationDomain.getDefinition(moduleVO.clz) as Class;
        
        var module:IModule = new moduleClz();
        return module;
    }
}
}
