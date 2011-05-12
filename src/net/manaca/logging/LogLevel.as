package net.manaca.logging
{

/**
 * The Level class defines a set of standard logging levels that can be 
 * used to control logging output. 
 * 
 * The logging Level objects are ordered and are specified by ordered integers. 
 * Enabling logging at a given level also enables logging at all higher levels. 
 * 
 * <p>In addition there is a level OFF that can be used to turn off logging, 
 * and a level ALL that can be used to enable logging of all messages. </p>
 * 
 * The levels in descending order are:
 *  <ul>
 *    <li><code>LogLevel.FATAL</code> designates events that are very
 *    harmful and will eventually lead to application failure</li>
 *
 *    <li><code>LogLevel.ERROR</code> designates error events
 *    that might still allow the application to continue running.</li>
 *
 *    <li><code>LogLevel.WARN</code> designates events that could be
 *    harmful to the application operation</li>
 *
 *    <li><code>LogLevel.INFO</code> designates informational messages
 *    that highlight the progress of the application at
 *    coarse-grained level.</li>
 *
 *    <li><code>LogLevel.DEBUG</code> designates informational
 *    level messages that are fine grained and most helpful when
 *    debugging an application.</li>
 *
 *    <li><code>LogLevel.ALL</code> intended to force a target to
 *    process all messages.</li>
 *  </ul>
 * @author Sean Zou
 * 
 */    
public class LogLevel
{

    //==========================================================================
    //  Class variables
    //==========================================================================
    
    /**
     * Designates events off is a special level that can be 
     * used to turn off logging.
     */
    static public const OFF:LogLevel = new LogLevel("OFF", 1024);

    /**
     *  Designates events that are very
     *  harmful and will eventually lead to application failure.
     */
    static public const FATAL:LogLevel = new LogLevel("FATAL", 32);

    /**
     *  Designates error events that might
     *  still allow the application to continue running.
     */
    static public const ERROR:LogLevel = new LogLevel("ERROR", 16);

    /**
     *  Designates events that could be
     *  harmful to the application operation.
     */
    static public const WARN:LogLevel = new LogLevel("WARN", 8);

    /**
     *  Designates informational messages that
     *  highlight the progress of the application at coarse-grained level.
     */
    static public const INFO:LogLevel = new LogLevel("INFO", 4);

    /**
     *  Designates informational level
     *  messages that are fine grained and most helpful when debugging an
     *  application.
     */
    static public const DEBUG:LogLevel = new LogLevel("DEBUG", 2);

    /**
     *  Tells a target to process all messages.
     */
    static public const ALL:LogLevel = new LogLevel("ALL", 0);

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a new <code>LogLevel</code> instance.
     * @param name a level name.
     * @param value a number
     * 
     */  
    public function LogLevel(name:String, value:int)
    {
        this.name = name;
        this.value = value;
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    
    /**
     * The non-localized string name of the Level.
     */        
    public var name:String;
    /**
     * The integer value for this level.
     */        
    public var value:int;

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Return value of the LogLevel.
     * @return 
     * @see Object#valueOf()
     */
    public function valueOf():Number
    {
        return this.value;
    }

    /**
     * Return a string of the LogLevel.
     * @see Object#toString() 
     */    
    public function toString():String 
    { 
        return "[object net.manaca.LogLevel" + [ name,value ] + "]"; 
    }
}
}