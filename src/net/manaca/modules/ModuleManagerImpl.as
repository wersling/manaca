/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import flash.system.ApplicationDomain;
import flash.utils.getQualifiedClassName;

/**
 * @private
 * @author Sean Zou
 * 
 */
final public class ModuleManagerImpl
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>ModuleManagerImpl</code>实例.
     * 
     */
    public function ModuleManagerImpl()
    {
        super();
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    /**
     * @private
     * 保存所有已经实例化的模块对象
     */
    private var moduleList:Object = {};
    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * @private
     * 查看引用的对象是否与已知 IModuleFactory 
     * 实现关联（或者在该实现的受管 ApplicationDomain 中）。
     * @param object  ModuleManager 尝试创建的对象。
     * @return 会返回 IModuleFactory 实现，
     * 或者如果无法从 factory 创建对象类型，则会返回 null。
     */
    internal function getAssociatedFactory(object:Object):IModuleFactory
    {
        var className:String = getQualifiedClassName(object);
        
        for each (var info:ModuleInfo in moduleList)
        {
            if (!info.ready)
            {
                continue;
            }
            
            var domain:ApplicationDomain = info.applicationDomain;
            try
            {
                var cls:Class = Class(domain.getDefinition(className));
                if (object is cls)
                {
                    return info.factory;
                }
            }
            catch(error:Error)
            {
            }
        }
        
        return null;
    }
    
    /**
     * @private
     * 获取与特定 URL 关联的 IModuleInfo 接口。
     */
    internal function getModule(moduleName:String):IModuleInfo
    {
        var info:ModuleInfo = moduleList[moduleName] as ModuleInfo;
        
        if (!info)
        {
            info = new ModuleInfo(moduleName);
            moduleList[moduleName] = info;
        }
        
        return info;
    }
}
}
