package net.manaca.utils
{
import flexunit.framework.TestCase;

public class CookieTest extends TestCase
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var cookie:Cookie;

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * 
     * @param testMethod
     * 
     */        
    public function CookieTest(testMethod:String = null)
    {
        super(testMethod);
    }

    
    override public function setUp():void
    {
        cookie = new Cookie("CookieTest");
    }

    override public function tearDown():void
    {
        cookie.clear();
        cookie = null;
    }

    public function testSetAndGet():void
    {
        cookie.value1 = "1";
        cookie.value2 = 2;
        cookie.value3 = new Date();
        cookie.value4 = new XML();
        
        assertEquals(cookie.value1, "1");
        assertEquals(cookie.value2, 2);
        assertTrue(cookie.value3 is Date);
    }

    public function testClear():void
    {
        cookie.value1 = "1";
        cookie.value2 = 2;
        cookie.clear();
        
        assertTrue(cookie.value1 == null);
        assertFalse(cookie.isExist("value2"));
        assertFalse(cookie.isExist("_name"));
    }

    public function testRemove():void
    {
        cookie.value1 = "1";
        cookie.remove("value1");
        assertTrue(cookie.value1 == null);
    }

    public function testSize():void
    {
        assertEquals(cookie.getSize(), 0);
    }
}
}