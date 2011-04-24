package net.manaca.logging
{

/**
 * The ILogPublisher interface is used to actually log messages. 
 * you need different handlers for different output targets. 
 * Output targets can be everything, any type of file, a database, 
 * a custom, trace, output console and so on.
 * @author Sean Zou
 * 
 */    
public interface ILogPublisher
{
    //==========================================================================
    //  Properties
    //==========================================================================
    /**
     * The Publisher publish log level.
     */
    function get level():LogLevel;

    function set level(value:LogLevel):void;

    //==========================================================================
    //  Methods
    //==========================================================================
            
    /**
     * Publish a LogRecord. 
     * @param logRecord a LogRecord
     * 
     */
    function publish(logRecord:LogRecord):void;

    /**
     * Check if a given log record should be published.
     * @param logRecord a LogRecord.
     * @return true if the log record should be published.
     * 
     */
    function isLoggable(logRecord:LogRecord):Boolean;

    /**
     * @see Object#toString() 
     */
    function toString():String;
}
}