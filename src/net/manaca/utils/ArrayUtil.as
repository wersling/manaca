package net.manaca.utils
{

/**
 * The ArrayUtil utility class is an all-static class with methods for working with Array objects.
 * @author v-seanzo
 *
 */
public class ArrayUtil
{
    /**
     * Switch a objcet to array.
     * @param obj
     * @return
     *
     */
    static public function toArray(obj:Object):Array
    {
        var result:Array = [];
        if (!obj)
        {
        }
        else if (obj is Array)
        {
            result = obj as Array;
        }
        else if (obj is XMLList)
        {
            var len:uint = XMLList(obj).length();
            for (var i:uint = 0; i < len; i++)
            {
                result.push(XMLList(obj)[i]);
            }
        }
        else
        {
            result = [obj];
        }
        return result;
    }

    /**
     * Remove all instances of the specified value from the array,
     * @param arr The array from which the value will be removed
     * @param value The object that will be removed from the array.
     */
    static public function removeValueFromArray(arr:Array, value:Object):void
    {
        var len:uint = arr.length;

        for (var i:Number = len; i > -1; i--)
        {
            if (arr[i] === value)
            {
                arr.splice(i, 1);
            }
        }
    }
    
    /**
     * Creates new Array composed of only the non-identical elements of passed Array.
     * 
     * @param inArray: Array to remove equivalent items.
     * @return A new Array composed of only unique elements.
     * @example
     * <code>
     * var numberArray:Array = new Array(1, 2, 3, 4, 4, 4, 4, 5);
     * trace(ArrayUtil.removeDuplicates(numberArray)); // Traces 1,2,3,4,5
     * </code>
     */
    public static function removeDuplicates(inArray:Array):Array
    {
        return inArray.filter(ArrayUtil._removeDuplicatesFilter);
    }
    
    protected static function _removeDuplicatesFilter(e:*, i:int,
                                                      inArray:Array):Boolean
    {
        return (i == 0) ? true : inArray.lastIndexOf(e, i - 1) == -1;
    }
}
}