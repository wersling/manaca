package net.manaca.data
{
import flexunit.framework.TestCase;

public class HashMapTest extends TestCase
{
    private var _map:Map = new Map();

    public function HashMapTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        _map = new Map();
    }

    public function testHash():void
    {
        assertEquals(_map.isEmpty(), true);
        for (var i:uint = 1;i <= 100;i++)
        {
            _map.put(i, "object" + i.toString());
        }
        assertEquals(_map.size(), 100);
        var result:Object = _map.put(1, "object2");
        assertEquals(_map.getValue(1), "object2");
        assertEquals(_map.size(), 100);
        //assertEquals(_map.getValue(1),"object2");
        assertEquals(_map.containsKey(1), true);
        assertEquals(_map.containsValue("object0"), false);
        /* assertEquals(_map.find(1),"object2");
        assertEquals(_map.findKey("object100"),100);
        assertEquals(_map.toString(),"[HashMap, size = 100]"); */

        var myKeys:Array = _map.keys();
        var myVals:Array = _map.values();
        //myKeys retrieve values while myVals retrieve keys
        for (var j:uint = 2;j <= 100; j++)
        {
            assertEquals(myVals[j - 1], "object" + j.toString());
        }

        _map.remove(1);
        assertEquals(_map.size(), 99);
        assertEquals(_map.containsKey(1), false);
        /* for (var k:uint = 2;k<=100;k++)
        {
            trace(_map.find(k) + ":" + _map.findKey("object" + k.toString()));
        } */
        //assertEquals(_map.containsValue("object1"),false);
    }
}
}