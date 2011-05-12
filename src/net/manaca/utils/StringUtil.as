package net.manaca.utils
{
import flash.utils.ByteArray;

/**
 *  The StringUtil utility class is an all-static class with methods for
 *  working with String objects.
 */
public class StringUtil
{
    //==========================================================================
    //  Class methods
    //==========================================================================
    
    /**
     *    Removes whitespace from the front and the end of the specified
     *    string.
     *    @param input The String whose beginning and ending whitespace will
     *    will be removed.
     *    @returns A String with whitespace removed from the begining and end    
     */            
    static public function trim(input:String):String
    {
        return StringUtil.ltrim(StringUtil.rtrim(input));
    }

    /**
     *    Removes whitespace from the front of the specified string.
     *    @param input The String whose beginning whitespace will will be removed.
     *    @returns A String with whitespace removed from the begining    
     */    
    static public function ltrim(input:String):String
    {
        var size:Number = input.length;
        for(var i:Number = 0;i < size; i++)
        {
            if(input.charCodeAt(i) > 32)
            {
                return input.substring(i);
            }
        }
        return "";
    }

    /**
     *    Removes whitespace from the end of the specified string.
     *    @param input The String whose ending whitespace will will be removed.
     *    @returns A String with whitespace removed from the end    
     */    
    static public function rtrim(input:String):String
    {
        var size:Number = input.length;
        for(var i:Number = size;i > 0; i--)
        {
            if(input.charCodeAt(i - 1) > 32)
            {
                return input.substring(0, i);
            }
        }
        return "";
    }

    /**
     *  Substitutes "{n}" tokens within the specified string
     *  with the respective arguments passed in.
     *
     *  @param str The string to make substitutions in.
     *  This string can contain special tokens of the form
     *  <code>{n}</code>, where <code>n</code> is a zero based index,
     *  that will be replaced with the additional parameters
     *  found at that index if specified.
     *
     *  @param rest Additional parameters that can be substituted
     *  in the <code>str</code> parameter at each <code>{n}</code>
     *  location, where <code>n</code> is an integer (zero based)
     *  index value into the array of values specified.
     *  If the first parameter is an array this array will be used as
     *  a parameter list.
     *  This allows reuse of this routine in other methods that want to
     *  use the ... rest signature.
     *  For example <pre>
     *     public function myTracer(str:String, ... rest):void
     *     { 
     *         label.text += StringUtil.substitute(str, rest) + "\n";
     *     } </pre>
     *
     *  @return New string with all of the <code>{n}</code> tokens
     *  replaced with the respective arguments specified.
     *
     *  @example
     *
     *  var str:String = "here is some info "{0}" and {1}";
     *  Tracer.info(StringUtil.substitute(str, 15.4, true));
     *
     *  // this will output the following string:
     *  // "here is some info "15.4" and true"
     */
    static public function substitute(input:String, ... rest):String
    {
        // Replace all of the parameters in the msg string.
        var len:uint = rest.length;
        var args:Array;
        if (len == 1 && rest[0] is Array)
        {
            args = rest[0] as Array;
            len = args.length;
        }
        else 
        {
            args = rest;
        }
        
        for (var i:int = 0;i < len; i++) 
        {
            input = input.replace(new RegExp("\\{" + i + "\\}", "g"), args[i]);
        }
        return input;
    }

    /**
     *  Substitutes "{$id}" tokens within the specified string
     *  with the respective object arguments passed in.
     */
    static public function substituteByID(input:String, containObj:Object):String
    {
        // Replace all of the paramenters in the passed string.
        for ( var i:String in containObj) 
        {
            input = input.replace(new RegExp("\\{\\$" + i + "\\}", "g"), containObj[i]);
        }
        return input;
    }

    /**
     *    Replaces all instances of the replace string in the input string
     *    with the replaceWith string.
     *    @param input The string that instances of replace string will be 
     *    replaces with removeWith string.
     *    @param replace The string that will be replaced by instances of 
     *    the replaceWith string.
     *    @param replaceWith The string that will replace instances of replace
     *    string.
     *    @returns A new String with the replace string replaced with the 
     *    replaceWith string.
     */
    static public function replace(input:String, replace:String, replaceWith:String):String
    {
        return input.split(replace).join(replaceWith);
    }

    /**
     * intercept and return part of the specified String
     * @param input
     * @param limited
     * @param addedChars
     * @return 
     */    
    static public function intercept(input:String,limited:uint,addedChars:String):String
    {
        if(input == null) return "";
        if(input.length > limited && limited > 0) 
        {
            input = input.slice(0, limited);
            input += addedChars;
        }
        return input;
    }

    /**
     * HTML encode
     */
    static public function htmlEncode(input:String):String
    {
        input = replace(input, "&", "&amp;");
        input = replace(input, "\"", "&quot;");
        input = replace(input, "\"", "&apos;");
        input = replace(input, "<", "&lt;");
        input = replace(input, ">", "&gt;");
        return input;
    }

    /**
     * Make a string CDATA
     */
    static public function cdata(theURL:String):XML
    {
        var x:XML = new XML("<![CDATA[" + theURL + "]]>");
        return x;
    }

    /**
     * Strip out &lt;, &gt;
     */
    static public function stripGtAndLt(input:String):String
    {
        input = replace(input, "<", "&lt;");
        input = replace(input, ">", "&gt;");        
        return input;     
    }

    /**
     * validate Email address
     */
    static public function validateEmail(input:String):Boolean
    {
        var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
        var result:Object = pattern.exec(input);
        if(result == null) 
        {
            return false;
        }
        return true;
    }

    /**
     * Encoding for String
     * Change GB2312 to UTF8
     */
    static public function GB2312toUTF8(input:*):String
    {
        var byte:ByteArray = new ByteArray();
        byte.writeMultiByte(input, "gb2312");
        byte.position = 0;
        return byte.readMultiByte(byte.bytesAvailable, "utf-8"); 
    }

    static public function UTF8toGB2312(input:*):String
    {
        var byte:ByteArray = new ByteArray();
        byte.writeMultiByte(input, "utf-8");
        byte.position = 0;
        return byte.readMultiByte(byte.bytesAvailable, "gb2312"); 
    }

    /**
     * add zero padding
     */
    static public function zeroPad(num:uint):String
    {
        var output:String;
        if (num < 10)
        {
            output = "0" + num;
        }
        else
        {
            output = String(num);
        }
        return output;
    }

    /**
     * Make %uef124 to string.
     * @param str
     * @return 
     * 
     */
    static public function toUNString(str:String):String
    {
        var myPattern:RegExp = /%u(....)/g;
        var reslut:String = str.replace(myPattern, replStr);
        
        function replStr():String 
        {
            var a:String = (arguments[1]);
            var n:Number = parseInt("0x" + a);
            
            return String.fromCharCode(n);
        }
        
        try
        {
            reslut = unescape(reslut);
        }
        catch(e:Error)
        {
        }
        
        return reslut;
    }
    
    /**
     * <p>Convert the specified string to the proper object type and returns.</p>
     * 
     * @param str
     * <p>The string to convert.</p>
     * @param priority <p>Whether it gives priority to expressing numerically 
     * or not?</p>
     * @return <p>The converted object.</p>
     * 
     * @example <listing version="3.0" >
     * trace( StringUtil.toProperType( "true" ) == true ); // true
     * trace( StringUtil.toProperType( "false" ) == false ); // true
     * trace( StringUtil.toProperType( "null" ) == null ); // true
     * trace( StringUtil.toProperType( "ABCDE" ) == "ABCDE" ); // true
     * trace( StringUtil.toProperType( "100" ) == 100 ); // true
     * trace( StringUtil.toProperType( "010" ) == 10 ); // true
     * trace( StringUtil.toProperType( "010", false ) == "010" ); // true
     * trace( StringUtil.toProperType( "10.0", false ) == "10.0" ); // true
     * </listing>
     */
    static public function toProperType( str:String, priority:Boolean = true ):* 
    {
        // Number type change
        var num:Number = parseFloat(str);
        
        // if priority true
        if(priority) 
        {
            if(!isNaN( num )) 
            { 
                return num; 
            }
        }
        else 
        {
            if(num.toString() == str) 
            { 
                return num; 
            }
        }
        
        switch ( str ) 
        {
            case "true"	: 
            { 
                return true; 
            }
            case "false" : 
            { 
                return false; 
            }
            case ""	:
            case "null"	: 
            { 
                return null; 
            }
            case "undefined": 
            { 
                return undefined; 
            }
            case "Infinity"	: 
            { 
                return Infinity; 
            }
            case "-Infinity" : 
            { 
                return -Infinity; 
            }
            case "NaN" : 
            { 
                return NaN; 
            }
        }
        
        return str;
    }
}
}