package net.manaca.logging
{

/**
 * The Tracer defines a shortcut publish a message.
 * 
 * <p>It just publish message to a global logger.</p>
 * 
 * @example
 * <p>The basic workflow of using Tracer is as follows:</p>
 * <listing version = "3.0" >
 * Tracer.logger.addPublisher(new TracePublisher());
 * Tracer.info("This is an information message.");
 * </listing>
 * 
 * @author Sean Zou
 * 
 */    
public class Tracer
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    
    /**
     * The ILogger is a global logger.
     */        
    static public const logger:Logger = Logger.getLogger("global");

    //==========================================================================
    //  Class methods
    //==========================================================================
    
    /**
     *  Logs the specified data using the <code>LogLevel.DEBUG</code>
     *  level.
     *  <code>LogLevel.DEBUG</code> designates informational level
     *  messages that are fine grained and most helpful when debugging
     *  an application.
     *  
     *  <p>The string specified for logging can contain braces with an index
     *  indicating which additional parameter should be inserted
     *  into the string before it is logged.
     *  For example "the first additional parameter was {0} the second was {1}"
     *  will be translated into "the first additional parameter was 10 the
     *  second was 15" when called with 10 and 15 as parameters.</p>
     *
     *  @param message The information to log.
     *  This string can contain special marker characters of the form {x},
     *  where x is a zero based index that will be replaced with
     *  the additional parameters found at that index if specified.
     *
     *  @param rest Additional parameters that can be subsituted in the str
     *  parameter at each "{<code>x</code>}" location, where <code>x</code>
     *  is an integer (zero based) index value into the Array of values
     *  specified.
     *
     *  @example
     *  <listing version = "3.0" >
     *  var logger:ILogger = Logger.getLogger("myLog");
     *  logger.debug("here is some channel info {0} and {1}", 15.4, true);
     *
     *  // This will log the following String:
     *  // "here is some channel info 15.4 and true"
     *  </listing>
     */
    static public  function debug(message:*, ...rest):void
    {
        log(LogLevel.DEBUG, message, rest);
    }

    /**
     *  Logs the specified data using the <code>LogLevel.ERROR</code>
     *  level.
     *  <code>LogLevel.ERROR</code> designates error events
     *  that might still allow the application to continue running.
     *  
     *  <p>The string specified for logging can contain braces with an index
     *  indicating which additional parameter should be inserted
     *  into the string before it is logged.
     *  For example "the first additional parameter was {0} the second was {1}"
     *  will be translated into "the first additional parameter was 10 the
     *  second was 15" when called with 10 and 15 as parameters.</p>
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
     *  <listing version = "3.0" >
     *  var logger:ILogger = Logger.getLogger("myLog");
     *  logger.error("here is some channel info {0} and {1}", 15.4, true);
     *
     *  // This will log the following String:
     *  // "here is some channel info 15.4 and true"
     *  </listing>
     */
    static public function error(message:*, ...rest):void
    {
        log(LogLevel.ERROR, message, rest);
    }

    /**
     *  Logs the specified data using the <code>LogLevel.FATAL</code> 
     *  level.
     *  <p>
     *  <code>LogLevel.FATAL</code> designates events that are very 
     *  harmful and will eventually lead to application failure.</p>
     *
     *  <p>The string specified for logging can contain braces with an index
     *  indicating which additional parameter should be inserted
     *  into the string before it is logged.
     *  For example "the first additional parameter was {0} the second was {1}"
     *  will be translated into "the first additional parameter was 10 the
     *  second was 15" when called with 10 and 15 as parameters.</p>
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
     *  <listing version = "3.0" >
     *  var logger:ILogger = Logger.getLogger("myLog");
     *  logger.fatal("here is some channel info {0} and {1}", 15.4, true);
     *
     *  // This will log the following String:
     *  // "here is some channel info 15.4 and true"
     *  </listing>
     */
    static public function fatal(message:*, ...rest):void
    {
        log(LogLevel.FATAL, message, rest);
    }

    /**
     *  Logs the specified data using the <code>LogEvent.INFO</code> level.
     *  <code>LogLevel.INFO</code> designates informational messages that 
     *  highlight the progress of the application at coarse-grained level.
     *  
     *  <p>The string specified for logging can contain braces with an index
     *  indicating which additional parameter should be inserted
     *  into the string before it is logged.
     *  For example "the first additional parameter was {0} the second was {1}"
     *  will be translated into "the first additional parameter was 10 the
     *  second was 15" when called with 10 and 15 as parameters.</p>
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
     *  <listing version = "3.0" >
     *  var logger:ILogger = Logger.getLogger("myLog");
     *  logger.info("here is some channel info {0} and {1}", 15.4, true);
     *
     *  // This will log the following String:
     *  // "here is some channel info 15.4 and true"
     *  </listing>
     */
    static public function info(message:*, ...rest):void
    {
        log(LogLevel.INFO, message, rest);
    }

    /**
     *  Logs the specified data using the <code>LogLevel.WARN</code> level.
     *  <code>LogLevel.WARN</code> designates events that could be harmful 
     *  to the application operation.
     *      
     *  <p>The string specified for logging can contain braces with an index
     *  indicating which additional parameter should be inserted
     *  into the string before it is logged.
     *  For example "the first additional parameter was {0} the second was {1}"
     *  will be translated into "the first additional parameter was 10 the
     *  second was 15" when called with 10 and 15 as parameters.</p>
     *  
     *  @param message The information to log.
     *  This String can contain special marker characters of the form {x},
     *  where x is a zero based index that will be replaced with
     *  the additional parameters found at that index if specified.
     *
     *  @param rest Aadditional parameters that can be subsituted in the str
     *  parameter at each "{<code>x</code>}" location, where <code>x</code>
     *  is an integer (zero based) index value into the Array of values
     *  specified.
     *
     *  @example
     *  <listing version = "3.0" >
     *  var logger:ILogger = Logger.getLogger("myLog");
     *  logger.warn("here is some channel info {0} and {1}", 15.4, true);
     *
     *  // This will log the following String:
     *  // "here is some channel info 15.4 and true"
     *  </listing>
     */
    static public function warn(message:*, ...rest):void
    {
        log(LogLevel.WARN, message, rest);
    }

    /**
     * @private 
     * @param level
     * @param message
     * @param rest
     * 
     */
    static private function log(level:LogLevel, message:*, rest:Array):void
    {
        logger.log(level, message, rest);
    }
}
}