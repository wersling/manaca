package net.manaca.core
{

/**
 * The IDataRenderer interface defines the interface for components that have a 
 * data property.
 * @author Sean Zou
 *
 */
public interface IDataRenderer
{
    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  data
    //----------------------------------
    /**
     * The data to render or edit.
     */
    function get data():Object;
    /**
     * @priavte
     * @param value
     * 
     */    
    function set data(value:Object):void;
}
}
