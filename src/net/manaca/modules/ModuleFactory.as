/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import flash.system.ApplicationDomain;

import net.manaca.logging.Tracer;

import org.robotlegs.core.IMediatorMap;

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
     * 实例化模块.
     * @param mediatorMap IMediatorMap实例，如果为null，则不map任何Mediator.
     * @param moduleMediator 自定义的Module Mediator类，如果为null，则map默认的Mediator.
     * 你可以自定义一个Mediator并继承ModuleMediator.
     * @return 模块实例.
     * 
     */    
    public function create(mediatorMap:IMediatorMap = null, 
                           moduleMediator:Class = null,
                           autoCreate:Boolean = true, 
                           autoRemove:Boolean = true):IModuleDisplay
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
        
        var module:IModuleDisplay = new moduleClz();

        if (mediatorMap)
        {
            if (mediatorMap.hasMapping(module))
            {
                mediatorMap.unmapView(module);
            }
            moduleMediator = (moduleMediator == null) ? 
                ModuleMediator : moduleMediator;
            //Note:一个module只能map一个Mediator.
            mediatorMap.mapView(module, moduleMediator, 
                IModuleDisplay, autoCreate, autoRemove);
        }
        
        return module;
    }
    
    public function dispose():void
    {
        applicationDomain = null;
        moduleVO = null;
    }
}
}
