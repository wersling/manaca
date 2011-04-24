package net.manaca.utils
{
import flexunit.framework.TestCase;

public class CookieClearTest extends TestCase
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var cookie:Cookie;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>CookieClearTest</code> instance.
     * @param testMethod
     * 
     */        
    override public function CookieClearTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        cookie = new Cookie("CookieTest", 1);
        cookie.value1 = 1;
        cookie.value2 = 2;
    }

    override public function tearDown():void
    {
        cookie.clear();
        cookie = null;
    }

    public function testClearTimeOut():void
    {
        this.addAsync(function():void
        {
        }, 1000, null, assertClearTimeOut);
    }

    private function assertClearTimeOut(arg:Object):void
    {
        assertEquals(cookie.value1, 1);
        assertEquals(cookie.value2, 2);
        
        assertTrue(cookie.isExist("value1"));
        assertTrue(cookie.isExist("value2"));
        
        cookie.clearTimeOut();
        
        assertFalse(cookie.isExist("value1"));
        assertFalse(cookie.isExist("value2"));
    }
}
}