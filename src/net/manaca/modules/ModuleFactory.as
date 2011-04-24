package net.manaca.modules
{
import flash.system.ApplicationDomain;
/**
 * @private
 * @author sean
 * 
 */
public class ModuleFactory implements IModuleFactory
{
    public function ModuleFactory(
        applicationDomain:ApplicationDomain,
        moduleClz:Class)
    {
        this.applicationDomain = applicationDomain;
        this.moduleClz = moduleClz;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var applicationDomain:ApplicationDomain;
    private var moduleClz:Class;
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
    public function create():IModuleDisplay
    {
        return IModuleDisplay(new moduleClz());
    }
    
    public function dispose():void
    {
        applicationDomain = null;
        moduleVO = null;
    }
}
}