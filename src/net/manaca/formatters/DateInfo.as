package net.manaca.formatters
{

/**
 * The data formatter info.
 * @author Sean
 */
public class DateInfo
{
    /**
     * Long weeks name.
     * @default ["Sunday", "Monday", "Tuesday", "Wednesday","Thursday", "Friday", "Saturday"]
     */
    public var dayNamesLong:Array =
        ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
         "Saturday"];

    /**
     * Short weeks name.
     * @default  ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
     */
    public var dayNamesShort:Array =
        ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

    /**
     * Long months name.
     * @default ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
     */
    public var monthNamesLong:Array =
        ["January", "February", "March", "April", "May", "June", "July",
         "August", "September", "October", "November", "December"];

    /**
     * Short months name.
     * @default ["Jan", "Feb", "Mar", "Apr", "May", "Jun","Jul", "Aug", "Sep", "Oct","Nov", "Dec"]
     */
    public var monthNamesShort:Array =
        ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct",
         "Nov", "Dec"];

    /**
     * Time of a day.
     * @default ["AM", "PM"]
     */
    public var timeOfDay:Array = ["AM", "PM"];

    /**
     * Date of month name
     * @default [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
     */
    public var todayNames:Array =
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
         20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31];

    /**
     * Time format string.
     */
    public var time:String = "h:mm:ss A";

    /**
     * Long date format string.
     */
    public var dateLong:String = "EEEE, MMMM dd, YYYY";

    /**
     * Short date format string.
     */
    public var dateShort:String = "M/d/YYYY";
}
}