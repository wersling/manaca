package net.manaca.formatters
{

/**
 * The DateFormatter class uses a format String to return a formatted date and 
 * time String from an input String or a Date object.
 * You can create many variations easily, including international formats.
 * <p>The following table describes the valid pattern letters：</p>
 *  <p>You compose a pattern String using specific uppercase letters,
 *  for example: YYYY/MM.</p>
 *
 *  <p>The DateFormatter pattern String can contain other text
 *  in addition to pattern letters.
 *  To form a valid pattern String, you only need one pattern letter.</p>
 *
 *  <p>The following table describes the valid pattern letters:</p>
 *
 *  <table class="innertable">
 *    <tr><th>Pattern letter</th><th>Description</th></tr>
 *    <tr>
 *      <td>Y</td>
 *      <td> Year. If the number of pattern letters is two, the year is
 *        truncated to two digits; otherwise, it appears as four digits.
 *        The year can be zero-padded, as the third example shows in the
 *        following set of examples:
 *        <ul>
 *          <li>YY = 05</li>
 *          <li>YYYY = 2005</li>
 *          <li>YYYYY = 02005</li>
 *        </ul></td>
 *    </tr>
 *    <tr>
 *      <td>M</td>
 *      <td> Month in year. The format depends on the following criteria:
 *        <ul>
 *          <li>If the number of pattern letters is one, the format is
 *            interpreted as numeric in one or two digits. </li>
 *          <li>If the number of pattern letters is two, the format
 *            is interpreted as numeric in two digits.</li>
 *          <li>If the number of pattern letters is three,
 *            the format is interpreted as short text.</li>
 *          <li>If the number of pattern letters is four, the format
 *           is interpreted as full text. </li>
 *        </ul>
 *          Examples:
 *        <ul>
 *          <li>M = 7</li>
 *          <li>MM= 07</li>
 *          <li>MMM=Jul</li>
 *          <li>MMMM= July</li>
 *        </ul></td>
 *    </tr>
 *    <tr>
 *      <td>d</td>
 *      <td>Day in month. While a single-letter pattern string for day is valid,
 *        you typically use a two-letter pattern string.
 *
 *        <p>Examples:</p>
 *        <ul>
 *          <li>d=4</li>
 *          <li>dd=04</li>
 *          <li>ddd=十月 or 04</li>
 *        </ul></td>
 *    </tr>
 *    <tr>
 *      <td>E</td>
 *      <td>Day in week. The format depends on the following criteria:
 *        <ul>
 *          <li>If the number of pattern letters is one, the format is
 *            interpreted as numeric in one or two digits.</li>
 *          <li>If the number of pattern letters is two, the format is interpreted
 *           as numeric in two digits.</li>
 *          <li>If the number of pattern letters is three, the format is interpreted
 *            as short text. </li>
 *          <li>If the number of pattern letters is four, the format is interpreted
 *           as full text. </li>
 *        </ul>
 *          Examples:
 *        <ul>
 *          <li>E = 1</li>
 *          <li>EE = 01</li>
 *          <li>EEE = Mon</li>
 *          <li>EEEE = Monday</li>
 *        </ul></td>
 *    </tr>
 *    <tr>
 *      <td>A</td>
 *      <td> am/pm indicator.</td>
 *    </tr>
 *    <tr>
 *      <td>K</td>
 *      <td>Hour in day (0-23).</td>
 *    </tr>
 *    <tr>
 *      <td>H</td>
 *      <td>Hour in day (1-24).</td>
 *    </tr>
 *    <tr>
 *      <td>k</td>
 *      <td>Hour in am/pm (0-11).</td>
 *    </tr>
 *    <tr>
 *      <td>h</td>
 *      <td>Hour in am/pm (1-12).</td>
 *    </tr>
 *    <tr>
 *      <td>m</td>
 *      <td>Minute in hour.
 *
 *        <p>Examples:</p>
 *        <ul>
 *          <li>m = 3</li>
 *          <li>mm = 03</li>
 *        </ul></td>
 *    </tr>
 *    <tr>
 *      <td>s</td>
 *      <td>Second in minute.
 *
 *        <p>Example:</p>
 *        <ul>
 *          <li>ss = 30</li>
 *        </ul></td>
 *    </tr>
 *    <tr>
 *      <td>Other text</td>
 *      <td>You can add other text into the pattern string to further
 *        format the string. You can use punctuation, numbers,
 *        and all lowercase letters. You should avoid uppercase letters
 *        because they may be interpreted as pattern letters.
 *
 *        <p>Example:</p>
 *        <ul>
 *          <li>EEEE, MMM. D, YYYY at H:NN A = Tuesday, Sept. 8, 2005 at 1:26 PM</li>
 *        </ul></td>
 *    </tr>
 *  </table>
 *
 * @author Sean
 *
 */
public class DateFormatter
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * all support char.
     */
    static private const VALID_PATTERN_CHARS:String = "Y,M,d,E,t,H,h,K,k,m,s,S";
    /** */
    static private const YEAR:String = "Y"; //年  Year  1996; 96
    /** */
    static private const MONTH:String = "M"; //年中的月份  Month  July; Jul; 07
    /** */
    static private const DATE_IN_MONTH:String = "d"; //月份中的天数  Number  10
    /** */
    static private const DATE_OF_WEEK:String = "E"; //星期中的天数  Text  Tuesday; Tue
    /** */
    static private const TIME_OF_DAY:String = "t"; //Am/pm 标记  Text  PM
    /** */
    static private const HOUR_OF_DAY0:String = "K"; //一天中的小时数（0-23）  Number  0
    /** */
    static private const HOUR_OF_DAY1:String = "H"; //一天中的小时数（1-24）  Number  24
    /** */
    static private const HOUR0:String = "k"; //am/pm 中的小时数（0-11）  Number  0
    /** */
    static private const HOUR1:String = "h"; //am/pm 中的小时数（1-12）  Number  12
    /** */
    static private const MINUTE:String = "m"; //小时中的分钟数  Number  30
    /** */
    static private const SECOND:String = "s"; //分钟中的秒数  Number  55
    /** */
    static private const MILLISECOND:String = "S"; //毫秒数  Number  978
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>DateFormatter</code> instance.
     * @param template The mask pattern.
     * @param dateInfo date info.
     * @return
     *
     */
    public function DateFormatter(template:String = "MM/DD/YYYY",
                                  dateInfo:DateInfo = null)
    {
        this.template = template;

        this.dateInfo = dateInfo != null ? dateInfo : new DateInfo();
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    /**
     * The mask pattern.
     * The DateFormatter pattern String can contain other text in addition to pattern letters.
     * To form a valid pattern String, you only need one pattern letter.
     * @default "MM/DD/YYYY"
     */
    public var template:String;
    /**
     * date info.
     */
    private var dateInfo:DateInfo;

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * Generates a date-formatted String from either a date-formatted String or a Date object.
     * @param template The mask pattern.
     * @param date Date to format. This can be a Date object.
     * @param dateInfo date info.
     * @return Formatted String. Empty if an error occurs. A description of the 
     * error condition is written to the error property
     *
     */
    static public function formatSingle(template:String, date:Date = null,
                                        dateInfo:DateInfo = null):String
    {
        if (date == null)
        {
            date = new Date();
        }
        return new DateFormatter(template, dateInfo).format(date);
    }

    /**
     * Generates a time-formatted String from either a date-formatted String or 
     * a Date object.
     * @param date Date to format. This can be a Date object.
     * @param dateInfo
     * @return Formatted String.
     *
     */
    static public function getTime(date:Date = null, dateInfo:DateInfo =
        null):String
    {
        if (date == null)
        {
            date = new Date();
        }

        if (dateInfo == null)
        {
            dateInfo = new DateInfo();
        }
        var df:DateFormatter = new DateFormatter(dateInfo.time, dateInfo);
        return df.format(date);
    }

    /**
     * Generates a short date-formatted String from either 
     * a date-formatted String or a Date object.
     * @param date Date to format. This can be a Date object.
     * @param dateInfo
     * @return Formatted String.
     *
     */
    static public function getDateShort(date:Date = null, dateInfo:DateInfo =
        null):String
    {
        if (date == null)
        {
            date = new Date();
        }

        if (dateInfo == null)
        {
            dateInfo = new DateInfo();
        }
        var df:DateFormatter = new DateFormatter(dateInfo.dateShort, dateInfo);
        return df.format(date);
    }

    /**
     * Generates a long date-formatted String from either 
     * a date-formatted String or a Date object.
     * @param date Date to format. This can be a Date object.
     * @param dateInfo
     * @return Formatted String.
     *
     */
    static public function getDateLong(date:Date = null, dateInfo:DateInfo =
        null):String
    {
        if (date == null)
        {
            date = new Date();
        }

        if (dateInfo == null)
        {
            dateInfo = new DateInfo();
        }
        var df:DateFormatter = new DateFormatter(dateInfo.dateLong, dateInfo);
        return df.format(date);
    }

    /**
     * Generates a date-formatted String from either 
     * a date-formatted String or a Date object.
     * @param date Date to format. This can be a Date object.
     * @return Formatted String. Empty if an error occurs. 
     * A description of the error condition is written to the error property
     *
     */
    public function format(date:Date = null):String
    {
        if (date == null)
            date = new Date();
        //所有字符
        var tmp:String = template;
        //字符长度
        var tmp_index:int = tmp.length;
        //待处理的字符
        //var character:String = "";
        //当前索引的字符
        var letter:String = "";
        //字符编码
        var code:Number;
        var result:String = "";

        //查看所有的模板字符
        while (tmp_index > 0)
        {
            tmp_index--;
            letter = tmp.charAt(tmp_index);
            code = letter.charCodeAt(0);

            if (VALID_PATTERN_CHARS.indexOf(letter) != -1 && letter != ",")
            {
                var tempIndex:int = tmp_index;

                while (tmp.charCodeAt(--tmp_index) == code)
                {
                }
                ;
                result =
                    extractTokenDate(date, letter,
                                     tempIndex - tmp_index++) + result;
            }
            else
            {
                //如果不是支持的字符，则直接加在后面d
                result = letter + result;
            }
        }
        return result;
    }

    /**
     * extract the string to date  string.
     * @param date Date to format.
     * @param token
     * @param key
     * @return
     *
     */
    private function extractTokenDate(date:Date, token:String, key:uint):String
    {
        var result:String = "";
        var day:int;
        var hours:int;

        switch (token)
        {
            case YEAR:
            {
                var year:String = date.getFullYear().toString();

                if (key < 3)
                {
                    return year.substr(2);
                }
                else if (key > 4)
                {
                    return setValue(Number(year), key);
                }
                else
                {
                    return year;
                }
            }
            case MONTH:
            {
                // month in year
                var month:int = int(date.getMonth());

                if (key < 3)
                {
                    month++; // zero based
                    result += setValue(month, key);
                    return result;
                }
                else if (key == 3)
                {
                    return dateInfo.monthNamesShort[month];
                }
                else
                {
                    return dateInfo.monthNamesLong[month];
                }
            }
            case DATE_IN_MONTH:
            {
                // day in month
                day = int(date.getDate());

                if (key < 3)
                {
                    return setValue(day, key);
                }
                else
                {
                    return dateInfo.todayNames[day];
                }

                return result;
            }
            case DATE_OF_WEEK:
            {
                // day in the week
                day = int(date.getDay());

                if (key < 3)
                {
                    result += setValue(day, key);
                    return result;
                }
                else if (key == 3)
                {
                    return dateInfo.dayNamesShort[day];
                }
                else
                {
                    return dateInfo.dayNamesLong[day];
                }
            }
            case TIME_OF_DAY:
            {
                // am/pm marker
                hours = int(date.getHours());

                if (hours < 12)
                {
                    return dateInfo.timeOfDay[0];
                }
                else
                {
                    return dateInfo.timeOfDay[1];
                }
            }
            case HOUR_OF_DAY1:
            {
                // hour in day (1-24)
                hours = int(date.getHours()) + 1;
                result += setValue(hours, key);
                return result;
            }
            case HOUR_OF_DAY0:
            {
                // hour in day (0-23)
                hours = int(date.getHours());
                result += setValue(hours, key);
                return result;
            }
            case HOUR0:
            {
                // hour in am/pm (0-11)
                hours = int(date.getHours());

                if (hours >= 12)
                    hours = hours - 12;
                result += setValue(hours, key);
                return result;
            }
            case HOUR1:
            {
                // hour in am/pm (1-12)
                hours = int(date.getHours());

                if (hours == 0)
                    hours = 12;
                else if (hours > 12)
                    hours = hours - 12;
                result += setValue(hours, key);
                return result;
            }
            case MINUTE:
            {
                // minutes in hour
                var mins:int = int(date.getMinutes());
                result += setValue(mins, key);
                return result;
            }
            case SECOND:
            {
                // seconds in minute
                var sec:int = int(date.getSeconds());
                result += setValue(sec, key);
                return result;
            }
            case MILLISECOND:
            {
                // seconds in minute
                var mil:int = int(date.getMilliseconds());
                result += setValue(mil, key);
                return result;
            }
        }
        return result;
    }

    /**
     * add 0 to string end if the string length == 1.
     * @param value
     * @param key
     * @return
     *
     */
    static private function setValue(value:Object, key:int):String
    {
        var result:String = "";
        var vLen:int = value.toString().length;

        if (vLen < key)
        {
            var n:int = key - vLen;

            for (var i:int = 0; i < n; i++)
            {
                result += "0";
            }
        }
        result += value.toString();
        return result;
    }
}
}