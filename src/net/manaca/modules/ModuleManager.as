/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import net.manaca.data.Map;
import net.manaca.loaderqueue.LoaderQueue;

/**
 * ModuleManager 类会集中管理动态加载模块。并会维持 moduleName 到模块的映射。
 * 模块可以处于已加载（并且可使用）状态，也可以处于尚未加载状态。
 * ModuleManager 会分派显示模块状态的事件。
 * 客户可以注册事件处理函数，然后调用 load() 方法，
 * 该方法可在 factory 就绪时（或者，在已加载时可立即）分派事件。
 * @author Sean Zou
 * 
 */
public class ModuleManager
{
    /**
     * @private
     */    
    static private const moduleMap:Map = new Map();
    
    /**
     * @praivte
     */ 
    static private var managerSingleton:ModuleManagerImpl;
    
    /**
     * @private
     */    
    static internal var loaderQueueIns:LoaderQueue;
    
    /**
     * 查看引用的对象是否与已知 IModuleFactory 
     * 实现关联（或者在该实现的受管 ApplicationDomain 中）。
     * @param object  ModuleManager 尝试创建的对象。
     * @return 会返回 IModuleFactory 实现，
     * 或者如果无法从 factory 创建对象类型，则会返回 null。
     */
    static public function getAssociatedFactory(object:Object):IModuleFactory
    {
        return getSingleton().getAssociatedFactory(object);
    }
    
    /**
     * 获取与特定 moduleName 关联的 IModuleInfo 接口。
     * @param moduleName 指定的模块名称
     * @return 特定 moduleName 关联的 IModuleInfo 接口。
     * 
     */    
    static public function getModule(moduleName:String):IModuleInfo
    {
        return getSingleton().getModule(moduleName);
    }
    
    /**
     * 初始化模块
     * @param moudles 模块文件列表
     * @param loaderQueue 加载队列
     */    
    static public function init(moudles:Vector.<ModuleVO>, 
                                loaderQueue:LoaderQueue):void
    {
        var vo:ModuleVO;
        for each(vo in moudles)
        {
            moduleMap.put(vo.name, vo);
        }
        loaderQueueIns = loaderQueue;
    }
    
    /**
     * 获得指定模块名称的模块VO
     * @param moduleName 指定模块名称
     * @return 指定模块名称的模块VO
     * 
     */    
    static public function getModuleVOByName(moduleName:String):ModuleVO
    {
        return moduleMap.getValue(moduleName);
    }
    
    /**
     * @praivte
     */ 
    static private function getSingleton():ModuleManagerImpl
    {
        if (!managerSingleton)
        {
            managerSingleton = new ModuleManagerImpl();
        }

        return managerSingleton;
    }
}
}
