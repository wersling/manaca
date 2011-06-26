/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import flash.system.ApplicationDomain;

import net.manaca.logging.Tracer;

import org.robotlegs.core.IMediatorMap;
import org.robotlegs.core.IViewMap;
import org.robotlegs.utilities.modular.core.IModule;

/**
 * @private
 * @author sean
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
    public function create(viewMap:IViewMap = null):IModule
    {
        try
        {
            var moduleClz:Class = 
                applicationDomain.getDefinition(moduleVO.clz) as Class;
        }
        catch(error:Error)
        {
            Tracer.error("Can't find class : " + moduleVO.clz);
            Tracer.error(error);
        }
        
        var module:IModule = new moduleClz();
        if(viewMap)
        {
            viewMap.mapType(moduleClz);
        }
        return module;
    }
}
}
