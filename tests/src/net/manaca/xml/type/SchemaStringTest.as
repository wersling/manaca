package net.manaca.xml.type
{
import flexunit.framework.TestCase;

import net.manaca.xml.types.SchemaString;

public class SchemaStringTest extends TestCase
{
    private var node:SchemaString;

    /**
     * 
     * @param testMethod
     * 
     */        
    override public function SchemaStringTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        node = new SchemaString(null);
    }

    override public function tearDown():void
    {
        if(node)
        {
            node = null;
        }
    }

    public function testNull():void
    {
        assertEquals(node.getValue(), null);
    }

    public function testGetSet():void
    {
        node.setValue("");
        assertEquals(node.getValue(), "");
        
        node.setValue("abc");
        assertEquals(node.getValue(), "abc");
        
        node.setValue(null);
        assertEquals(node.getValue(), null);
        
        node.setValue(undefined);
        assertEquals(node.getValue(), undefined);
        
        node.setValue("<xml>abc</xml>");
        assertEquals(node.getValue(), "<xml>abc</xml>");
    }

    public function testConstructs():void
    {
        node = new SchemaString(new XML(<xml>abc</xml>));
        assertEquals(node.getValue(), "abc");
        node = new SchemaString(new XML(<xml></xml>));
        assertEquals(node.getValue(), "");
        node = new SchemaString(new XML(<xml>null</xml>));
        assertEquals(node.getValue(), "null");
    }

    
    public function testClone():void
    {
        node.setValue("clone");
        
        var str1:SchemaString = node.clone();
        assertEquals(str1.getValue(), "clone");
    }
}
}