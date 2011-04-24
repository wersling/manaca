package net.manaca.xml.type
{
import flexunit.framework.TestCase;

import net.manaca.xml.types.SchemaNumber;

public class SchemaNumberTest extends TestCase
{
    private var node:SchemaNumber;

    override public function SchemaNumberTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        node = new SchemaNumber(null);
    }

    public function testGetSet():void
    {
        node.setValue(Math.PI);
        assertEquals(node.getValue(), Math.PI);

        node.setValue(-Math.PI);
        assertEquals(node.getValue(), -Math.PI);

        node.setValue(Infinity);
        assertEquals(node.getValue(), Infinity);

        node.setValue(-Infinity);
        assertEquals(node.getValue(), -Infinity);

        node.setValue(undefined);
        assertTrue(isNaN(node.getValue()));

        node.setValue(NaN);
        assertTrue(isNaN(node.getValue()));
    }

    public function testConstructs():void
    {
        node = new SchemaNumber(new XML(<xml>3.1415926</xml>));
        assertEquals(node.getValue(), 3.1415926);

        node = new SchemaNumber(new XML(<xml>-3.1415926</xml>));
        assertEquals(node.getValue(), -3.1415926);

        node = new SchemaNumber(new XML(<xml>null</xml>));
        assertTrue(isNaN(node.getValue()));

        node = new SchemaNumber(new XML(<xml>Infinity</xml>));
        assertEquals(node.getValue(), Infinity);

        node = new SchemaNumber(new XML(<xml></xml>));
        assertEquals(node.getValue(), 0);
    }
}
}