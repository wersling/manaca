package net.manaca.logging.publishers
{

import net.manaca.logging.ILogPublisher;
import net.manaca.logging.LogLevel;
import net.manaca.logging.LogRecord;

/**
 * Provides a interface send logs to alcon.
 * @author Sean Zou
 *
 */
public class AlconPublisher extends AbstractLogPublisher implements ILogPublisher
{
    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Constructs a new <code>AlconPublisher</code> instance.
     *
     */
    public function AlconPublisher()
    {
        super();
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * This method outputs the specified message directly to
     * send log to Alcon.
     * @param logRecord a LogRecord
     *
     */
    override public function publish(logRecord:LogRecord):void
    {
        if (this.isLoggable(logRecord))
        {
            var level:uint = 0;
            switch (logRecord.getLevel().value)
            {
                case LogLevel.DEBUG.value :
                    level = 0;
                    break;
                case LogLevel.INFO.value :
                    level = 1;
                    break;
                case LogLevel.WARN.value :
                    level = 2;
                    break;
                case LogLevel.ERROR.value :
                    level = 3;
                    break;
                case LogLevel.FATAL.value :
                    level = 4;
                    break;
            }

            //Debug.trace(this.format(logRecord), level);
        }
    }

    /**
     * Format the provide logRecord to string.
     *
     * <p>the string format:</p>
     * <p>[LevelName]    Time message</p>
     * <p>[DEBUG]    12:02:22 this is debug message</p>
     * @param logRecord a logRecord.
     * @return a formated string.
     */
//    private function format(logRecord:LogRecord):String
//    {
//        var formatted:String;
//        formatted = logRecord.getDate().toTimeString().slice(0, 8) + " " + logRecord.getMessage();
//        return formatted;
//    }
}
}