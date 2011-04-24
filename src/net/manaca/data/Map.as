package net.manaca.data
{
import flash.utils.Dictionary;

/**
 * An object that maps keys to values. A map cannot contain duplicate keys; 
 * each key can map to at most one value.
 * @author Sean Zou
 *
 */
public class Map
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Map</code> instance.
     * @param weakKeys if parameter is set to true, weak keys will be used
     *
     */
    public function Map(weakKeys:Boolean = false)
    {
        this.weakKeys = weakKeys;
        clear();
    }
    
    //==========================================================================
    //  Variables
    //==========================================================================
    private var weakKeys:Boolean;
    private var content:Dictionary;
    private var length:int;
    
    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * Removes all of the mappings from this map (optional operation).
     *
     */
    public function clear():void
    {
        content = new Dictionary(weakKeys);
        length = 0;
    }

    /**
     * Returns true if this map contains a mapping for the specified key.
     * @param key key whose presence in this map is to be tested
     * @return if this map contains a mapping for the specified key
     */
    public function containsKey(key:*):Boolean
    {
        return (content[key] != null) ? true : false;
    }

    /**
     * Returns true if this map maps one or more keys to the specified value.
     * @param value value whose presence in this map is to be tested
     * @return if this map maps one or more keys to the specified value
     */
    public function containsValue(value:*):Boolean
    {
        for each (var v:* in content)
        {
            if (v == value) return true;
        }
        return false;
    }

    /**
     * Returns the value to which the specified key is mapped, or null if this 
     * map contains no mapping for the key.
     * @param key the key whose associated value is to be returned.
     * @return the value to which the specified key is mapped, or null if this 
     * map contains no mapping for the key
     */
    public function getValue(key:*):*
    {
        return content[key];
    }

    /**
     * Associates the specified value with the specified key in this map.
     * @param key key with which the specified value is to be associated
     * @param value value to be associated with the specified key
     * @return if the map has the key return false, else return true.
     * @throws net.manaca.errors.IllegalArgumentError if the specified key or 
     * value is null.
     */
    public function put(key:*, value:*):Boolean
    {
        if (value == null)
        {
            return remove(key);
        }
        var oldValue:* = content[key];
        if (oldValue == null) length++;
        content[key] = value;
        return true;
    }

    /**
     * Removes the mapping for a key from this map if it is present.
     * @param key key whose mapping is to be removed from the map.
     * @return if has value removed return false, else return true.
     * @throws net.manaca.errors.IllegalArgumentError if the specified key 
     * is null.
     */
    public function remove(key:*):Boolean
    {
        if (content[key] == null)
        {
            return false;
        }
        delete content[key];
        length--;
        return true;
    }

    /**
     * Copies all of the mappings from the specified map to this map.
     * @param map mappings to be stored in this map.
     *
     */
    public function putAll(map:Map):void
    {
        if(map == null) return;

        var _keys:Array = map.keys();
        var len:uint = _keys.length;
        for(var i:uint = 0 ;i < len; i++ )
        {
            put(_keys[i], map.getValue(_keys[i]));
        }
    }

    /**
     * Returns the number of key-value mappings in this map.
     * @return number of key-value mappings in this map.
     *
     */
    public function size():uint
    {
        return length;
    }

    /**
     * Returns true if this map contains no key-value mappings.
     * @return if this map contains no key-value mappings
     *
     */
    public function isEmpty():Boolean
    {
        return length == 0 ? true : false;
    }

    /**
     * Get all keys which associate with the value.
     * @param obj    The value associated with the specified key.
     * @return    <code>Array</code> for all keys which associate with 
     * the value.
     */
    public function getKeys(obj:*):Array
    {
        var tmpArr:Array = new Array();
        for (var key:String in content)
        {
            if (content[key] == obj) tmpArr.push(key);
        }
        return tmpArr;
    }

    /**
     * Returns a Array of the keys contained in this map.
     * @return a Array of the keys contained in this map
     *
     */
    public function keys():Array
    {
        var tmpArr:Array = new Array();
        var index:int = 0;
        for (var key:* in content)
        {
            tmpArr[index++] = key;
        }
        return tmpArr;
    }

    /**
     * Returns a Array of the values contained in this map.
     * @return a Array of the values contained in this map
     *
     */
    public function values():Array
    {
        var tmpArr:Array = new Array();
        var index:int = 0;
        for each (var v:* in content)
        {
            tmpArr[index++] = v;
        }
        return tmpArr;
    }
}
}