package net.manaca.managers
{

/**
 * Define ToolTipDisplay interface.
 * Every ToolTipDisplay must is DisplayDobject.
 * @author Sean Zou
 * 
 */    
public interface IToolTipDisplay
{
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * Display the specify value.
     * @param value the specify value.
     * 
     */
    function display(value:*):void
}
}