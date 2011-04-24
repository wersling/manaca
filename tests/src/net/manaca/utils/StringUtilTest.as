package net.manaca.utils
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.setTimeout;

import flexunit.framework.TestCase;

public class StringUtilTest extends TestCase
{
    public function StringUtilTest(testMethod:String = null)
    {
        super(testMethod);
    }

    public function testLtrim():void
    {
        var tmp:String = '  vivian';
        assertEquals('Ltrim wrong', 'vivian', StringUtil.ltrim(tmp));
        tmp = 'vivian';
        assertEquals('Ltrim wrong', 'vivian', StringUtil.ltrim(tmp));
        tmp = '';
        assertEquals('Ltrim wrong', '', StringUtil.ltrim(tmp));
        tmp = ' ';
        assertEquals('Ltrim wrong', '', StringUtil.ltrim(tmp));
        tmp = '                                                       ';
        assertEquals('Ltrim wrong', '', StringUtil.ltrim(tmp));
    }

    public function testRtrim():void
    {
        var tmp:String = 'vivian ';
        assertEquals('Rtrim wrong', 'vivian', StringUtil.rtrim(tmp));
        tmp = 'vivian';
        assertEquals('Rtrim wrong', 'vivian', StringUtil.rtrim(tmp));
        tmp = '';
        assertEquals('Rtrim wrong', '', StringUtil.rtrim(tmp));
        tmp = ' ';
        assertEquals('Rtrim wrong', '', StringUtil.rtrim(tmp));
        tmp = '                                             ';
        assertEquals('Rtrim wrong', '', StringUtil.rtrim(tmp));
    }

    public function testTrim():void
    {
        var tmp:String = 'vivian ';
        assertEquals('Trim wrong', 'vivian', StringUtil.trim(tmp));
        tmp = ' vivian';
        assertEquals('Trim wrong', 'vivian', StringUtil.trim(tmp));
        tmp = ' vivian ';
        assertEquals('Trim wrong', 'vivian', StringUtil.trim(tmp));
        tmp = '';
        assertEquals('Trim wrong', '', StringUtil.trim(tmp));
        tmp = ' ';
        assertEquals('Trim wrong', '', StringUtil.trim(tmp));
        tmp = '                               ';
        assertEquals('Trim wrong', '', StringUtil.trim(tmp));
        tmp = ' viv ian ';
        assertEquals('Trim wrong', 'viv ian', StringUtil.trim(tmp));
    }

    public function testSubstitute():void
    {
        assertEquals('Substitute wrong', 'abcdefg', StringUtil.substitute('abc{0}{1}fg', 'd', 'e'));
        assertEquals('Substitute wrong', 'abcd{1}fg', StringUtil.substitute('abc{0}{1}fg', 'd'));
        assertEquals('Substitute wrong', 'abcddfg', StringUtil.substitute('abc{0}{0}fg', 'd'));
        assertEquals('Substitute wrong', 'abcddfg', StringUtil.substitute('abc{0}{0}fg', 'd', 'e'));
        assertEquals('Substitute wrong', 'abcd{2}fg', StringUtil.substitute('abc{0}{2}fg', 'd', 'e'));
        assertEquals('Substitute wrong', 'abc{}dfg', StringUtil.substitute('abc{}{0}fg', 'd', 'e'));
    }

    public function testReplace():void
    {
        assertEquals('Replace error', 'vivi n', StringUtil.replace('vivian', 'a', ' '));
        assertEquals('Replace error', 'vivian', StringUtil.replace('vivian', 'b', 'a'));
        assertEquals('Replace error', 'vivian', StringUtil.replace('vivian ', ' ', ''));
        assertEquals('Replace error', 'vivian', StringUtil.replace('vivian', 'b', 'a'));
        assertEquals('Replace error', 'aaaaaa', StringUtil.replace('bbbbbb', 'b', 'a'));
    }

    public function testIntercept():void
    {
        assertEquals('Intercept error', 'viv...', StringUtil.intercept('vivian', 3, '...'));
        assertEquals('Intercept error', 'vivian', StringUtil.intercept('vivian', 6, '...'));
        assertEquals('Intercept error', 'vivian', StringUtil.intercept('vivian', 7, '...'));
        assertEquals('Intercept error', 'vivia...', StringUtil.intercept('vivian', 5, '...'));
        assertEquals('Intercept error', 'v...', StringUtil.intercept('vivian', 1, '...'));
        assertEquals('Intercept error', 'vivian', StringUtil.intercept('vivian', 0, '...'));
        assertEquals('Intercept error', 'viv\'', StringUtil.intercept('vivian', 3, '\''));
        assertEquals('Intercept error', 'viv"', StringUtil.intercept('vivian', 3, '"'));
        assertEquals('Intercept error', 'viv ', StringUtil.intercept('vivian', 3, ' '));
        assertEquals('Intercept error', 'viv', StringUtil.intercept('vivian', 3, ''));
        assertEquals('Intercept error', '......', StringUtil.intercept('......', 3, '...'));
        assertEquals('Intercept error', '   ...', StringUtil.intercept('    ', 3, '...'));
        assertEquals('Intercept error', '', StringUtil.intercept('', 1, '...'));
    }

    public function testEncode():void
    {
        assertEquals('Intercept error', "&amp;&amp;&amp;&quot;&quot;\\'''&gt;&lt;\&gt;\&lt;", StringUtil.htmlEncode("&&&\"\"\\'''><\>\<"));
    }

    public function testCData():void
    {
        var x:XML = new XML();
        assertEquals('CData error', "<![CDATA[http://www.online.sh.cn]]>", StringUtil.cdata("http://www.online.sh.cn").toXMLString());
    }

    public function testEmail():void
    {
        assertEquals('ValidEmail error', false, StringUtil.validateEmail("@"));
        assertEquals('ValidEmail error', false, StringUtil.validateEmail("@."));
        assertEquals('ValidEmail error', false, StringUtil.validateEmail("@.com"));
        assertEquals('ValidEmail error', false, StringUtil.validateEmail("v@.com"));
        assertEquals('ValidEmail error', false, StringUtil.validateEmail("@c.com"));
        assertEquals('ValidEmail error', true, StringUtil.validateEmail("v@c.com"));
        assertEquals('ValidEmail error', true, StringUtil.validateEmail("v@ccc.cn"));
        assertEquals('ValidEmail error', false, StringUtil.validateEmail("v@ccc.a"));
        assertEquals('ValidEmail error', true, StringUtil.validateEmail("v@ccc.aaaaa"));
    }

    public function testZeroPad():void
    {
        assertEquals('ZeroPad error', '03', StringUtil.zeroPad(3));
        assertEquals('ZeroPad error', '10', StringUtil.zeroPad(10));
        assertEquals('ZeroPad error', '00', StringUtil.zeroPad(0));
    }

    // This is an asynchronous test method
    public function testAsyncFeature():void 
    {
        // create a new object that dispatches events...
        var dispatcher:IEventDispatcher = new EventDispatcher();
        // get a TestCase async event handler reference
        // the 2nd arg is an optional timeout in ms. (default=1000ms )
        var handler:Function = addAsync(changeHandler, 2000);
        // subscribe to your event dispatcher using the returned handler
        dispatcher.addEventListener(Event.CHANGE, handler);
        // cause the event to be dispatched.
        // either immediately:
        //dispatcher.dispatchEvent(new Event(Event.CHANGE));
        // or in the future < your assigned timeout
        setTimeout(dispatcher.dispatchEvent, 200, new Event(Event.CHANGE));
    }
    
    public function testToProperType():void
    {
        assertTrue( StringUtil.toProperType( "true" ) == true ); 
        assertTrue( StringUtil.toProperType( "false" ) == false ); 
        assertTrue( StringUtil.toProperType( "null" ) == null ); 
        assertTrue( StringUtil.toProperType( "ABCDE" ) == "ABCDE" ); 
        assertTrue( StringUtil.toProperType( "100" ) == 100 ); 
        assertTrue( StringUtil.toProperType( "010" ) == 10 ); 
        assertTrue( StringUtil.toProperType( "010", false ) == "010" ); 
        assertTrue( StringUtil.toProperType( "10.0", false ) == "10.0" ); 
    }

    protected function changeHandler(event:Event):void 
    {
        // perform assertions in your handler
        assertEquals(Event.CHANGE, event.type);
    }
}
}