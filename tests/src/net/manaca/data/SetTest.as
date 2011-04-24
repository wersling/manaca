package net.manaca.data
{
import flexunit.framework.TestCase;

public class SetTest extends TestCase
{
    private var _set:Set = new Set();

    public function SetTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        _set = new Set();
    }

    public function testAdd():void
    {
        _set.add(1);
        _set.add(1);
        _set.add(1);
        _set.add(1);
        assertEquals(_set.size(), 1);
    }

    public function testRemove():void
    {
        _set.add(1);
        _set.add(2);
        _set.remove(1);
        _set.add(1);
        assertEquals(_set.size(), 2);
    }

    public function testContains():void
    {
        _set.add(1);
        _set.add(2);
        assertTrue(_set.contains(1));
    }
}
}