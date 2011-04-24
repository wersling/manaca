package net.manaca.xml.type
{
import flexunit.framework.TestCase;

import net.manaca.xml.types.SchemaBoolean;

public class SchmeaBooleanTest extends TestCase
{
    private var node:SchemaBoolean;

    override public function SchmeaBooleanTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        node = new SchemaBoolean(null);
    }

    public function testGetSet():void
    {
        node.setValue(false);
        assertEquals(node.getValue(), false);
        
        node.setValue(true);
        assertEquals(node.getValue(), true);
        
        node.setValue(undefined);
        assertEquals(node.getValue(), false);
    }

    public function testConstructs():void
    {
        node = new SchemaBoolean(new XML(<xml>true</xml>));
        assertEquals(node.getValue(), true);
        
        node = new SchemaBoolean(new XML(<xml></xml>));
        assertEquals(node.getValue(), false);
        
        node = new SchemaBoolean(new XML(<xml>null</xml>));
        assertEquals(node.getValue(), false);
    }
}
}