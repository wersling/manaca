package net.manaca.formatters
{
import flexunit.framework.TestCase;

public class StringFormatterTest extends TestCase
{
    //private var fm:StringFormatter;
    public function StringFormatterTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        //fm = new StringFormatter();
    }

    public function testNormal():void
    {
        /* assertEquals("Using null", fm.format(null), null);
        assertEquals("Using undefined", fm.format(undefined), null);
        
        fm.template = "I'm is Sean Zou!";
        assertEquals("No special values", fm.format(null), "I'm is Sean Zou!");
        
        fm.template = "{0}";
        assertEquals("Using placeholder without argument", fm.format(null), "");
        fm.template = "{0}";
        assertEquals("Using placeholder with special argument", fm.format(["{"]), "{");
        fm.template = "{0}";
        assertEquals("Using placeholder with special argument", fm.format(["}"]), "}");
        fm.template = "{0}";
        assertEquals("Using placeholder with special argument", fm.format(["{0}"]), "{0}");
        fm.template = "";
        assertEquals("Using no placeholder with argument", fm.format(["Sean"]), "");
        
        fm.template = "{0}";
        assertEquals("Using placeholder with integer argument", fm.format([1]), "1");
        assertEquals("Using placeholder with floating point argument", fm.format([3.141592]), "3.141592");
        assertEquals("Using placeholder with string argument", fm.format(["Sean"]), "Sean");
        assertEquals("Using placeholder with string argument", fm.format([true]), "true");
        assertEquals("Using placeholder with string argument", fm.format([1,2,3]), "1");
        
        fm.template = "Hello {0}"
        assertEquals("Using placehodler with in front text", fm.format(["Sean"]), "Hello Sean");
        fm.template = "{0} is smiling"
        assertEquals("Using placehodler with in back text", fm.format(["Sean"]), "Sean is smiling");
        fm.template = "Hello - I am {0}, pleased to meet you"
        assertEquals("Using placehodler with text", fm.format(["Sean"]), "Hello - I am Sean, pleased to meet you");
        
        fm.template = "{0}{1}"
        assertEquals("Using 2 placeholders without arguments", fm.format(null), "");
        fm.template = "Hello {0}, do you know {1}?"
        assertEquals("Using 2 placeholders without arguments with some text", fm.format(null), "Hello , do you know ?");
        assertEquals("Using 2 placeholders with one last argument with some text", fm.format(["Sean"]), "Hello Sean, do you know ?");
        assertEquals("Using 2 placeholders with two arguments with some text", fm.format(["J枚rg","Sean"]), "Hello J枚rg, do you know Sean?");
        
        fm.template = "{0}{0}"
        assertEquals("Using 2 same placeholders without arguments", fm.format(null), "");
        assertEquals("Using 2 same placeholders with argument", fm.format(["Sean"]), "SeanSean");
        fm.template = "{1}{1}"
        assertEquals("Using 2 same placeholders with argument", fm.format(["Sean"]), "");
         */
        /* fm.template = "'{0}'"
        assertEquals("one single quote", fm.format(["zero"]), "{0}");
        fm.template = "'''{0}'''"
        assertEquals("multiple single quotes", fm.format(null), "'{0}'"); */
    }
}
}