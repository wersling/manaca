package net.manaca.utils
{
import flexunit.framework.TestCase;

import net.manaca.utils.NumberUtil;

public class NumberUtilTest extends TestCase
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>NumberUtilTest</code> instance.
     *
     */
    public function NumberUtilTest(methodName:String=null)
    {
        super(methodName);
    }
    
    public function testDigit():void
    {
        assertEquals( NumberUtil.digit( 1, 3 ), "001" );
        assertEquals( NumberUtil.digit( 10, 3 ), "010" );
        assertEquals( NumberUtil.digit( 100, 3 ), "100" );
        assertEquals( NumberUtil.digit( 1000, 3 ), "000" );
        assertEquals( NumberUtil.digit( 10000, 3 ), "000" );
    }
    
    public function testFormat():void
    {
        assertEquals( NumberUtil.format( 1 ), "1" );
        assertEquals( NumberUtil.format( 10 ), "10" );
        assertEquals( NumberUtil.format( 100 ), "100" );
        assertEquals( NumberUtil.format( 1000 ), "1,000" );
        assertEquals( NumberUtil.format( 10000 ), "10,000" );
        assertEquals( NumberUtil.format( 100000 ), "100,000" );
        assertEquals( NumberUtil.format( 1000000 ), "1,000,000" );
        assertEquals( NumberUtil.format( 10000000 ), "10,000,000" );
    }
}
}