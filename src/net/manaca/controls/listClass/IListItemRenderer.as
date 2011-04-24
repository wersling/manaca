package net.manaca.controls.listClass
{
import flash.events.IEventDispatcher;

import net.manaca.core.IDataRenderer;

/**
 * Item renderers and item editors for list components must implement the 
 * IListItemRenderer interface. 
 * The IListItemRenderer interface is a set of several other interfaces. 
 * @author sean
 * 
 */    
public interface IListItemRenderer extends IDataRenderer, IEventDispatcher
{
    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  index
    //----------------------------------
    /**
     * The itm index.
     */
    function set index(value:uint):void;

    function get index():uint;

    //----------------------------------
    //  selected
    //----------------------------------
    /**
     * The item is be selected.
     * @return if selected return true, else false.
     * 
     */
    function get selected():Boolean;

    function set selected(value:Boolean):void;

    //==========================================================================
    //  Methods
    //==========================================================================

    function dispose():void;
}
}