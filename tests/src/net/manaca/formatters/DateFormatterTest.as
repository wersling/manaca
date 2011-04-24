package net.manaca.formatters
{
import flexunit.framework.TestCase;

public class DateFormatterTest extends TestCase
{
    //private var formatter:DateFormatter;
    public function DateFormatterTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        //formatter = new DateFormatter();
    }
    
    public function testFormatAll():void
    {
        /*var tmp:String = 'G EEE MM/DD/YYYY Ah:mm:ss.SSSS Z';
        formatter.template = tmp;
        var date:Date = new Date(2007,1,12,5,45,2,55);
        assertEquals('template '+tmp+' is interpreted wrongly','AD Mon 02/12/2007 am5:45:02.0055 GMT-0800',formatter.format(date));
    */}
    /* 
    public function testFormatYear():void
    {
        var tmp:String = 'Y YY YYY YYYY YYYYY YYYYYY';
        formatter.template = tmp;
        assertEquals('template '+tmp+' is interpreted wrongly','07 07 2007 2007 02007 002007',formatter.format(new Date(2007,1)));
        assertEquals('template '+tmp+' is interpreted wrongly','52 52 1952 1952 01952 001952',formatter.format(new Date(1952,1)));
    }
    
    public function testFormatMonth():void
    {
        var tmp:String = 'M MM MMM MMMM MMMMM MMMMMM';
        formatter.template = tmp;
        
        assertEquals('template '+tmp+' is interpreted wrongly','12 12 Dec December December December',formatter.format(new Date(2007,11)));
        assertEquals('template '+tmp+' is interpreted wrongly','2 02 Feb February February February',formatter.format(new Date(2007,1)));
    }
    
    public function testFormatDate():void
    {
        var tmp:String = 'D DD DDD';
        formatter.template = tmp;
        
        assertEquals('template '+tmp+' is interpreted wrongly','1 01 01',formatter.format(new Date(2007,11,1)));
        assertEquals('template '+tmp+' is interpreted wrongly','12 12 12',formatter.format(new Date(2007,11,12)));
        assertEquals('template '+tmp+' is interpreted wrongly','3 03 03',formatter.format(new Date(2007,1,31)));
    }
    
    public function testFormatDay():void
    {
        var tmp:String = 'E EE EEE EEEE';
        formatter.template = tmp;
        
        assertEquals('template '+tmp+' is interpreted wrongly','6 06 Sat Saturday',formatter.format(new Date(2007,11,1)));
        assertEquals('template '+tmp+' is interpreted wrongly','3 03 Wed Wednesday',formatter.format(new Date(2007,11,12)));
    } */
}
}