package net.manaca.logging
{
import net.manaca.data.Set;
import net.manaca.logging.publishers.TracePublisher;
import net.manaca.utils.StringUtil;

/**
 * <code>Logger</code> implements <code>ILogger</code> all methods.
 *
 * <p>The basic methods to log messages are <code>debug</code>, <code>info</code>,
 * <code>error</code>,<code>warning</code> and <code>fatal</code>.</p>
 *
 * <p>Logger objects may be obtained by calls on one of the getLogger factory methods.
 * These will either create a new Logger or return a suitable existing Logger.</p>
 *
 * <p>Each Logger keeps track of a "parent" Logger, which is its nearest existing
 * ancestor in the Logger namespace.</p>
 *
 * <p>Logging messages will be forwarded to registered publisher objects,
 * which can forward the messages to a variety of destinations, including consoles,
 * files, OS logs, etc.</p>
 *
 * <p>The basic workflow of using loggers is as follows:</p>
 * @example
 * <pre>
 * //Constructs a new Logger instance.
 * var logger:ILogger = Logger.getLogger("mylog");
 * //add a TracePublisher
 * logger.addPublisher(new TracePublisher());
 * logger.info("This is an information message.");
 * </pre>
 *
 * @author Sean Zou
 * @see net.manaca.logging.LogLevel
 * @see net.manaca.logging.ILogPublisher
 */
public class Logger
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * @private
     * the all loggers map.
     */
    static private const loggerMap:Object = new Object();

    //==========================================================================
    //  Class methods
    //==========================================================================

    /**
     * Returns the logger associated with the specified category.
     * @param logName The logName of the logger that should be returned.
     * @return An instance of a logger object for the specified name.
     * If the name doesn"t exist, a new instance with the specified
     * name is returned.
     */
    static public function getLogger(logName:String = null):Logger
    {
        if (logName == null || logName == "")
        {
            return new Logger("global");
        }
        if (loggerMap[logName] == null)
        {
            loggerMap[logName] = new Logger(logName);
        }
        return loggerMap[logName];
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    private const default_publisher:ILogPublisher = new TracePublisher();
    /**
     * @private
     * the all publisher set.
     */
    private var publishers:Set;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Constructs a new <code>Logger</code> instance.
     * @param logName the logger name.
     *
     */
    public function Logger(logName:String)
    {
        super();

        this._name = logName;

        loggerMap[_name] = this;

        publishers = new Set();
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  name
    //----------------------------------
    private var _name:String;

    /**
     * The name for this logger.
     */
    public function get name():String
    {
        return _name;
    }

    //----------------------------------
    //  level
    //----------------------------------
    /**
     * @private
     * Storage for the level property.
     */
    private var _level:LogLevel = LogLevel.ALL;

    /**
     * The log Level that has been specified for this Logger.
     */
    public function get level():LogLevel
    {
        return _level;
    }

    public function set level(value:LogLevel):void
    {
        _level = value;
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * @private
     * Get the effective log level for this Logger.
     * @return the effective log level.
     */
    internal function getEffectiveLevel():LogLevel
    {
        if (level != null)
        {
            return level;
        }

        return LogLevel.ALL;
    }

    /**
     * Add a publicsher to the Logger.
     * @param publishera publicsher.
     * @see com.msn.logging.ILogPublisher
     */
    public function addPublisher(publisher:ILogPublisher):void
    {
        publishers.add(publisher);
    }

    /**
     * Remove a publicsher from the Logger.
     * @param publisher a publicsher.
     * @see com.msn.logging.ILogPublisher
     */
    public function removePublisher(publisher:ILogPublisher):void
    {
        if(hasPublisher(publisher))
        {
            publishers.remove(publisher);
        }
    }

    /**
     * Check a publicsher in the Logger.
     * @param publisher a publicsher.
     * @return true if the publisher existent.
     * @see com.msn.logging.ILogPublisher
     */
    public function hasPublisher(publisher:ILogPublisher):Boolean
    {
        return publishers.contains(publisher);
    }

    /**
     * Get the publishers associated with this logger.
     * @return all publicshers.
     */
    public function getPublishers():Array
    {
        return publishers.toArray();
    }

    /**
     *  Logs the specified data at the given level.
     *
     *  <p>The String specified for logging can contain braces with an index
     *  indicating which additional parameter should be inserted
     *  into the String before it is logged.
     *  For example "the first additional parameter was {0} the second was {1}"
     *  is translated into "the first additional parameter was 10 the
     *  second was 15" when called with 10 and 15 as parameters.</p>
     *
     *  @param level The level this information should be logged at.
     *  Valid values are:
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
     *
     *  @param message The information to log.
     *  This String can contain special marker characters of the form {x},
     *  where x is a zero based index that will be replaced with
     *  the additional parameters found at that index if specified.
     *
     *  @param rest Additional parameters that can be subsituted in the str
     *  parameter at each "{<code>x</code>}" location, where <code>x</code>
     *  is an integer (zero based) index value into the Array of values
     *  specified.
     *
     *  @example
     *  <pre>
     *  var logger:ILogger = Logger.getLogger("myLog");
     *  logger.log(LogLevel.DEBUG, "here is some channel info {0} and {1}", LogLevel.DEBUG, 15.4, true);
     *
     *  // This will log the following String as a DEBUG log message:
     *  //   "here is some channel info 15.4 and true"
     *  </pre>
     *
     */
    public function log(level:LogLevel, message:*, rest:Array):void
    {
        if (this.getEffectiveLevel() <= level && message)
        {
            //format massage.
            message = formatMassage(message.toString(), rest);
            var logRecord:LogRecord = 
                new LogRecord(new Date(), name, level, message);
            var aps:Array = getPublishers();
            var len:uint = aps.length;
            if(len > 0)
            {
                for (var i:int = 0;i < len; i++)
                {
                    ILogPublisher(aps[i]).publish(logRecord);
                }
            }
            else
            {
                default_publisher.publish(logRecord);
            }
        }
    }

    /**
     * @inheritDoc
     */
    public function debug(message:*, ...rest):void
    {
        log(LogLevel.DEBUG, message, rest);
    }

    /**
     * @inheritDoc
     */
    public function error(message:*, ...rest):void
    {
        log(LogLevel.ERROR, message, rest);
    }

    /**
     * @inheritDoc
     */
    public function fatal(message:*, ...rest):void
    {
        log(LogLevel.FATAL, message, rest);
    }

    /**
     * @inheritDoc
     */
    public function info(message:*, ...rest):void
    {
        log(LogLevel.INFO, message, rest);
    }

    /**
     * @inheritDoc
     */
    public function warn(message:*, ...rest):void
    {
        log(LogLevel.WARN, message, rest);
    }

    /**
     * @private
     * format a massage.
     * @param message
     * @param rest
     * @return
     *
     */
    private function formatMassage(message:String, rest:Array):String
    {
        var result:String = message;
        if(rest.length > 0 && message != null)
        {
            result = StringUtil.substitute(message, rest);
        }

        return result;
    }
}
}