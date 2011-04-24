package net.manaca.logging.publishers
{
import net.manaca.logging.ILogPublisher;
import net.manaca.logging.LogLevel;
import net.manaca.logging.LogRecord;

/**
 * Provides a logger publisher that uses the global <code>trace()</code> method to output log messages.
 * <p>To view <code>trace()</code> method output, you must be running the 
 * debugger version of Flash Player or AIR Debug Launcher.</p>
 * 
 * 
 *  <p>The debugger version of Flash Player and AIR Debug Launcher send output from the <code>trace()</code> method 
 *  to the flashlog.txt file. The default location of this file is the same directory as 
 *  the mm.cfg file. You can customize the location of this file by using the <code>TraceOutputFileName</code> 
 *  property in the mm.cfg file. You must also set <code>TraceOutputFileEnable</code> to 1 in your mm.cfg file.</p>
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
 * 
 */    
public class TracePublisher extends AbstractLogPublisher implements ILogPublisher
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a new <code>TracePublisher</code> instance.
     * 
     */
    public function TracePublisher()
    {
        super();
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * This method outputs the specified message directly to 
     *  <code>trace()</code>.
     * All output will be directed to flashlog.txt by default.
     * @param logRecord a LogRecord
     * 
     */
    override public function publish(logRecord:LogRecord):void
    {
        if (this.isLoggable(logRecord)) 
        {
            trace(this.format(logRecord));
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
    private function format(logRecord:LogRecord):String
    {
        var formatted:String;
        formatted = "[" + logRecord.getLevel().name + "]\t" + logRecord.getDate().toTimeString().slice(0, 8) + " " + logRecord.getMessage();
        return formatted;
    }
}
}