package net.manaca.logging
{

/**
 * LogRecord declares methods to access data containing all the information 
 * about the message to log.
 * 
 * <p>LogRecord objects are used to pass logging requests between the 
 * logging framework and individual log publisher.</p>
 * 
 * 
 * @author Sean Zou
 * 
 */
public class LogRecord
{
    //==========================================================================
    //  Variables
    //==========================================================================
    /**
     * @private
     * the date of logger.
     */        
    private var date:Date;
    /**
     * @private
     * the loggerName of logger.
     */
    private var loggerName:String;
    /**
     * @private
     * the level of logger.
     */
    private var level:LogLevel;
    /**
     * @private
     * the message of logger.
     */
    private var message:*;

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a new <code>LogRecord</code> instance.
     * @param date the date of logger.
     * @param loggerName the name of the logging logger
     * @param level the level of the message.
     * @param message the message object to log.
     * @return 
     * 
     */
    public function LogRecord(date:Date, loggerName:String, level:LogLevel, message:*)
    {
        this.date = date;
        this.loggerName = loggerName;
        this.level = level;
        this.message = message;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Returns the date of logger.
     * @return the date of logger.
     * 
     */
    public function getDate():Date
    {
        return date;
    }

    /**
     * Returns the name of the logger that logs the message.
     * @return the name of the logger that logs the message.
     * 
     */
    public function getLoggerName():String
    {
        return loggerName;
    }

    /**
     * Returns the level of the message.
     * @return the level of the message.
     * 
     */
    public function getLevel():LogLevel
    {
        return level;
    }

    /**
     * Returns the message object to log.
     * @return the message object to log.
     * 
     */
    public function getMessage():*
    {
        return message;
    }

    /**
     * Return a LogRecord clone.
     * @return a LogRecord clone.
     * 
     */
    public function clone():LogRecord
    {
        return new LogRecord(this.date, this.loggerName, this.level, this.message);
    }
}
}