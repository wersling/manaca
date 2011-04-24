package net.manaca.manager
{
import flash.display.Sprite;

import flexunit.framework.TestCase;

import net.manaca.managers.DepthManager;

public class DepthManagerTest extends TestCase
{

    public function DepthManagerTest(methodName:String = null)
    {
        super(methodName);
    }

    private var container:Sprite;
    private var mc1:Sprite;
    private var mc2:Sprite;
    private var mc3:Sprite;

    override public function setUp():void
    {
        container = new Sprite();
    
        mc1 = new Sprite();
        mc1.name = "mc1";
    
        mc2 = new Sprite();
        mc2.name = "mc2";
    
        mc3 = new Sprite();
        mc3.name = "mc3";
        container.addChild(mc1);
        container.addChild(mc2);
        container.addChild(mc3);
    }

    override public function tearDown():void
    {
        container = null;
    }

    public function testBringToBottom():void
    {
        assertEquals(container.getChildAt(0).name, mc1.name);
        assertEquals(container.getChildAt(1).name, mc2.name);
        assertEquals(container.getChildAt(2).name, mc3.name);
        DepthManager.bringToBottom(mc3);
        assertEquals(container.getChildAt(0).name, mc3.name);
        assertEquals(container.getChildAt(1).name, mc1.name);
        assertEquals(container.getChildAt(2).name, mc2.name);
    
        DepthManager.bringToBottom(mc1);
        assertEquals(container.getChildAt(0).name, mc1.name);
        assertEquals(container.getChildAt(1).name, mc3.name);
        assertEquals(container.getChildAt(2).name, mc2.name);
    }

    public function testBringToTop():void
    {
        assertEquals(container.getChildAt(0).name, mc1.name);
        assertEquals(container.getChildAt(1).name, mc2.name);
        assertEquals(container.getChildAt(2).name, mc3.name);
    
        DepthManager.bringToTop(mc1);
        assertEquals(container.getChildAt(0).name, mc2.name);
        assertEquals(container.getChildAt(1).name, mc3.name);
        assertEquals(container.getChildAt(2).name, mc1.name);
    
        DepthManager.bringToTop(mc2);
        assertEquals(container.getChildAt(0).name, mc3.name);
        assertEquals(container.getChildAt(1).name, mc1.name);
        assertEquals(container.getChildAt(2).name, mc2.name);
    
        DepthManager.bringToTop(mc1);
        assertEquals(container.getChildAt(0).name, mc3.name);
        assertEquals(container.getChildAt(1).name, mc2.name);
        assertEquals(container.getChildAt(2).name, mc1.name);
    }

    public function testIsTop():void
    {
        assertEquals(container.getChildAt(0).name, mc1.name);
        assertEquals(container.getChildAt(1).name, mc2.name);
        assertEquals(container.getChildAt(2).name, mc3.name);
    
        assertTrue(DepthManager.isTop(mc3));
        DepthManager.bringToTop(mc1);
        assertTrue(DepthManager.isTop(mc1));
        DepthManager.bringToTop(mc2);
        assertTrue(DepthManager.isTop(mc2));
    
        container.removeChild(mc1);
        assertTrue(DepthManager.isTop(mc2));
    }

    public function testIsBottom():void
    {
        assertEquals(container.getChildAt(0).name, mc1.name);
        assertEquals(container.getChildAt(1).name, mc2.name);
        assertEquals(container.getChildAt(2).name, mc3.name);
    
        assertTrue(DepthManager.isBottom(mc1));
        DepthManager.bringToBottom(mc2);
        assertTrue(DepthManager.isBottom(mc2));
    }

    public function testIsJustBelow():void
    {
        assertEquals(container.getChildAt(0).name, mc1.name);
        assertEquals(container.getChildAt(1).name, mc2.name);
        assertEquals(container.getChildAt(2).name, mc3.name);
    
        assertTrue(DepthManager.isJustBelow(mc1, mc2));
        assertTrue(DepthManager.isJustBelow(mc2, mc3));
    }

    public function testIsJustAbove():void
    {
        assertEquals(container.getChildAt(0).name, mc1.name);
        assertEquals(container.getChildAt(1).name, mc2.name);
        assertEquals(container.getChildAt(2).name, mc3.name);
    
        assertTrue(DepthManager.isJustAbove(mc2, mc1));
        assertTrue(DepthManager.isJustAbove(mc3, mc2));
    }
}
}