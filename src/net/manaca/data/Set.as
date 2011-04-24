package net.manaca.data
{
import flash.utils.Dictionary;

/**
 * Set is like an Array that contains no duplicate elements.
 */    
public class Set
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Set</code> instance.
     */
    public function Set()
    {
        clear();
    }
    
    //==========================================================================
    //  Variables
    //==========================================================================
    private var content:Array;
    private var map:Dictionary;
    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Add an element to this Set.
     * @param o    The element to add.
     * @return    <code>false</code> is the element is already in this Set.
     */
    public function add(o:*):Boolean
    {
        if (this.contains(o)) return false;
        content.push(o);
        map[o] = true;
        return true;
    }

    /**
     * Check if an object is in this Set. 
     * @param o    The object to check.
     * @return    <code>true</code> if the element is in this Set.
     */
    public function contains(o:*):Boolean
    {
        return map[o];
    }

    /**
     * Get an element by an index. 
     * @param index    The index to get by.
     * @return        The element got by the index.
     */
    public function getItemAt(index:int):*
    {
        return content[index];
    }

    /**
     * Remove an element from this Set. 
     * @param o    The element to remove.
     * @return    The index of the element. 
     */
    public function remove(o:Object):int 
    {
        var index:int = content.indexOf(o);
        
        if (index >= 0)
        {
            content.splice(index, 1);
        }
        map[o] = null;
        return index;
    }

    /**
     * Get the size of this Set.
     * @return The size of this set.
     */
    public function size():int
    {
        return content.length;
    }

    /**
     * Check if this Set is empty.
     * @return <code>true</code> if the Set is empty.
     */
    public function isEmpty():Boolean
    {
        return content.length > 0;
    }

    /**
     * Clear the Set so that it contains no elements.
     */
    public function clear():void
    {
        content = new Array();
        map = new Dictionary();
    }

    /**
     * Get the elements as an Array.
     * @return The elements as an Array.
     */
    public function toArray():Array
    {
        return content.slice();
    }
}
}