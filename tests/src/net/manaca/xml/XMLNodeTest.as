package net.manaca.xml
{
import flexunit.framework.TestCase;

public class XMLNodeTest extends TestCase
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var node:XMLNode;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 
     * @param testMethod
     * 
     */        
    override public function XMLNodeTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        var xml:XML = <root xmlns:ns="www.example.com/ns" name="root">
            <node1 name="node11">1</node1>
            <node1 name="node12">2</node1>
            <node2 name="node2">3</node2>
        </root>
        
        node = new XMLNode(xml);
    }

    override public function tearDown():void
    {
        if(node)
        {
            node = null;
        }
    }

    public function testCount():void
    {
        assertEquals(node.getChildCount(XMLNode.ELEMENT, "", "node1"), 2);
        assertEquals(node.getChildCount(XMLNode.ELEMENT, "", "node2"), 1);
        node.addChild(XMLNode.ELEMENT, "", "", new XML("<node1>1</node1>"));
        assertEquals(node.getChildCount(XMLNode.ELEMENT, "", "node1"), 3);
    }

    public function testAddNode():void
    {
        node.addChild(XMLNode.ELEMENT, "", "", new XML("<node1>1</node1>"));
        node.addChild(XMLNode.ELEMENT, "", "", new XML("<node1>1</node1>"));
        node.addChild(XMLNode.ELEMENT, "", "", new XML("<node2>2</node2>"));
        
        assertEquals(node.getChildCount(XMLNode.ELEMENT, "", "node1"), 4);
        assertEquals(node.getChildCount(XMLNode.ELEMENT, "", "node2"), 2);
    }

    public function testRemoveNode():void
    {
        node.removeChild(XMLNode.ELEMENT, "", "node1", 1);
        node.removeChild(XMLNode.ELEMENT, "", "node2", 0);
        
        node.removeChild(XMLNode.ATTRIBUTE, "", "name", 0);
        
        assertEquals(node.getChildCount(XMLNode.ELEMENT, "", "node1"), 1);
        assertEquals(node.getChildCount(XMLNode.ELEMENT, "", "node2"), 0);
        assertEquals(node.getChildAt(XMLNode.ELEMENT, "", "node1", 0), 1);
        assertEquals(node.getChildAt(XMLNode.ATTRIBUTE, "", "name", 0), null);
    }

    public function testSetNode():void
    {
        node.setChildAt(XMLNode.ELEMENT, "", "node1", 0, new XML("<nodez>2</nodez>"));
        node.setChildAt(XMLNode.ELEMENT, "", "node1", 1, 3);
        node.setChildAt(XMLNode.ATTRIBUTE, "", "name", 0, "abc");
        
        assertEquals(node.getChildAt(XMLNode.ELEMENT, "", "node1", 0).nodez, 2);
        assertEquals(node.getChildAt(XMLNode.ELEMENT, "", "node1", 1), 3);
        assertEquals(node.getChildAt(XMLNode.ATTRIBUTE, "", "name", 0), "abc");
    }
}
}