package net.manaca.data
{
import net.manaca.utils.ArrayUtil;

/**
 * An iterator for arrays that allows the programmer to traverse the array in 
 * either direction, modify the array during iteration, 
 * and obtain the iterator's current position in the array. 
 * @author wersling
 * 
 */
public class ArrayIterator
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>ArrayIterator</code> instance.
     * 
     */
    public function ArrayIterator(source:* = null)
    {
        content = ArrayUtil.toArray(source);
        total = content.length;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var content:Array;
    private var total:int;
    private var index:int = -1;
    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Returns true if this list iterator has more elements when traversing the 
     * list in the reverse direction.
     * @return true if the list iterator has more elements when traversing the 
     * list in the reverse direction.
     * 
     */    
    public function hasPrevious():Boolean
    {
        return index > 0;
    }
    
    /**
     * Returns true if this list iterator has more elements when traversing 
     * the list in the forward direction.
     * @return true if the list iterator has more elements when traversing the 
     * list in the forward direction.
     * 
     */    
    public function hasNext():Boolean
    {
        return index < total - 1;
    }
    
    /**
     * Returns the index of the element that would be returned by a subsequent 
     * call to previous.
     * @return the index of the element that would be returned by a subsequent 
     * call to previous, or -1 if list iterator is at beginning of list.
     * 
     */ 
    public function previousIndex():int
    {
        if(hasPrevious())
        {
            return index - 1;
        }
        return -1; 
    }
    
    /**
     * Returns the index of the element that would be returned by a subsequent 
     * call to next.
     * @return the index of the element that would be returned by a subsequent 
     * call to next, or list size if list iterator is at end of list.
     * 
     */    
    public function nextIndex():int
    {
        if(hasNext())
        {
            return index + 1;
        }
        return total; 
    }
    
    /**
     * Returns the previous element in the list. This method may be called 
     * repeatedly to iterate through the list backwards, or intermixed with 
     * calls to next to go back and forth.
     * @return the previous element in the list. 
     * 
     */    
    public function previous():Object
    {
        if(hasPrevious())
        {
            index--;
            return content[index];
        }
        return null;
    }
    
    /**
     * Returns the next element in the list. This method may be called 
     * repeatedly to iterate through the list, or intermixed with calls to 
     * previous to go back and forth. 
     * @return the next element in the list.
     * 
     */    
    public function next():Object
    {
        if(hasNext())
        {
            index++;
            return content[index];
        }
        return null; 
    }
    
    /**
     * Returns the number of elements in this list.
     * @return the number of elements in this list
     * 
     */    
    public function size():int
    {
        return total;
    }
    
    /**
     * Removes all of the elements from this list.
     */    
    public function clear():void
    {
        content = [];
        total = 0;
        index = -1;
    }
}
}