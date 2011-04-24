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
     * @return 模块实例.
     * 
     */    
    function create():IModuleDisplay;
}
}