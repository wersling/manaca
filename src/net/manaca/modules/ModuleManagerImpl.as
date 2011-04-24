package net.manaca.modules
{
import flash.system.ApplicationDomain;
import flash.utils.getQualifiedClassName;
/**
 * @private
 * @author sean
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
     *  @private
     */
    private var moduleList:Object = {};
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     *  @private
     */
    public function getAssociatedFactory(object:Object):IModuleFactory
    {
        var className:String = getQualifiedClassName(object);
        
        for each (var m:Object in moduleList)
        {
            var info:ModuleInfo = m as ModuleInfo;
            
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
     *  @private
     */
    public function getModule(moduleName:String):IModuleInfo
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