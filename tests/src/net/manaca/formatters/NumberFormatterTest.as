package net.manaca.formatters
{
import flexunit.framework.TestCase;

public class NumberFormatterTest extends TestCase
{
    //public var fm:NumberFormatter;
    public function NumberFormatterTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        //fm = new NumberFormatter();
    }
    
    public function testNumFormat():void
    {
        /*fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 3;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = "*";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 0;
        assertEquals("numberforamtter error",fm.format(12.25687),"12.25");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 3;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = "*";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 3;
        assertEquals("numberforamtter error",fm.format(12.25687),"12.26");
        
        fm.numberDecimalDigits = 0;
        fm.numberGroupSizes = 3;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = "*";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 1;
        assertEquals("numberforamtter error",fm.format(12.25687),"12");
        
        fm.numberDecimalDigits = 1;
        fm.numberGroupSizes = 3;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = "*";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 1;
        assertEquals("numberforamtter error",fm.format(12.25687),"12.2");
        
        fm.numberDecimalDigits = 3;
        fm.numberGroupSizes = 3;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = "*";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 1;
        assertEquals("numberforamtter error",fm.format(12.25687),"12.256");
        
        fm.numberDecimalDigits = 3;
        fm.numberGroupSizes = 3;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = "*";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 2;
        assertEquals("numberforamtter error",fm.format(12.25687),"12.257");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 4;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = "*";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 3;
        assertEquals("numberforamtter error",fm.format(456412.25687),"45*6412.26");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 5;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 3;
        assertEquals("numberforamtter error",fm.format(456412.25687),"4 56412.26");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 5;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 0;
        fm.numberRoundingPattern = 3;
        assertEquals("numberforamtter error",fm.format(-456412.25687),"(4 56412.25)");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 5;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 1;
        fm.numberRoundingPattern = 3;
        assertEquals("numberforamtter error",fm.format(-456412.25687),"-4 56412.26");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 5;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 1;
        fm.numberRoundingPattern = 2;
        assertEquals("numberforamtter error",fm.format(-456412.25687),"-4 56412.25");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 5;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 1;
        fm.numberRoundingPattern = 1;
        assertEquals("numberforamtter error",fm.format(-456412.25687),"-4 56412.26");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 5;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 2;
        fm.numberRoundingPattern = 3;
        assertEquals("numberforamtter error",fm.format(-456412.12),"- 4 56412.12");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 5;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 3;
        fm.numberRoundingPattern = 3;
        assertEquals("numberforamtter error",fm.format(-456412.12),"4 56412.12-");
        
        fm.numberDecimalDigits = 2;
        fm.numberGroupSizes = 5;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 4;
        fm.numberRoundingPattern = 3;
        assertEquals("numberforamtter error",fm.format(-456412.12),"4 56412.12 -");
        
        fm.numberDecimalDigits = 0;
        fm.numberGroupSizes = 3;
        fm.numberDecimalSeparator = ".";
        fm.numberGroupSeparator = " ";
        fm.numberNegativePattern = 2;
        fm.numberRoundingPattern = 0;
        assertEquals("numberforamtter error",fm.format(-456412),"- 456 412");*/
    }
}
}