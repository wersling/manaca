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
        if (!obj)
        {
            return [];
        }
        else if (obj is Array)
        {
            return obj as Array;
        }
        else if (obj is XMLList)
        {
            var result:Array = new Array();
            var len:uint = XMLList(obj).length();
            for (var i:uint = 0; i < len; i++)
            {
                result.push(XMLList(obj)[i]);
            }
            return result;
        }
        else
        {
            return [obj];
        }
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
}
}