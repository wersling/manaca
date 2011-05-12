package net.manaca.utils
{

/**
 * <p>The NumberUtil class is an utility class for numeric operation.
 * NumbertUtil class can not instanciate directly.
 * When call the new NumberUtil() constructor,
 * the ArgumentError exception will be thrown.</p>
 */
public class NumberUtil
{

    /**
     * <p>Returns the numerical value applying the comma every 1000 digits.</p>
     *
     * @param number <p>The numerical value to convert.</p>
     * @return <p>The converted numerical value.</p>
     *
     * @example <listing version="3.0" >
     * trace( NumberUtil.format( 100 ) ); // 100
     * trace( NumberUtil.format( 10000 ) ); // 10,000
     * trace( NumberUtil.format( 1000000 ) ); // 1,000,000
     * </listing>
     */
    static public function format(number:Number):String
    {
        var words:Array = String(number).split("").reverse();
        var l:int = words.length;
        for (var i:int = 3; i < l; i += 3)
        {
            if (words[i])
            {
                words.splice(i, 0, ",");
                i++;
                l++;
            }
        }
        return words.reverse().join("");
    }

    /**
     * <p>Arrange the digit of numerical value by 0.</p>
     *
     * @param number <p>The numerical value to convert.</p>
     * @param figure <p>The number of digit to arrange.</p>
     * @return <p>The converted numerical value.</p>
     *
     * @example <listing version="3.0" >
     * trace( NumberUtil.digit( 1, 3 ) ); // 001
     * trace( NumberUtil.digit( 100, 3 ) ); // 100
     * trace( NumberUtil.digit( 10000, 3 ) ); // 000
     * </listing>
     */
    static public function digit(number:Number, figure:int):String
    {
        var str:String = String(number);
        for (var i:int = 0; i < figure; i++)
        {
            str = "0" + str;
        }
        return str.substr(str.length - figure, str.length);
    }
}
}
