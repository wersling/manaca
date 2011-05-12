package net.manaca.logging.publishers
{
import flash.events.StatusEvent;
import flash.net.LocalConnection;
import flash.utils.getQualifiedClassName;

import net.manaca.logging.ILogPublisher;
import net.manaca.logging.LogRecord;
import net.manaca.logging.Tracer;

/**
 * Provides a logger publisher that uses Longing display the log.
 * The LongingPublisher send log to Longing application.
 * @author v-seanzo
 *
 */
public class LongingPublisher extends AbstractLogPublisher implements ILogPublisher
{
    //==========================================================================
    //  Variables
    //==========================================================================
    /**
     * connecation name.
     */
    static public const CONN_NAME:String = "_manaca_log_console";

    /**
     * connecation function Name.
     */
    static public const CONN_FUN:String = "log";

    /**
     * the lacal connection
     */
    private var conn:LocalConnection;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>LongingPublisher</code> instance.
     *
     */
    public function LongingPublisher()
    {
        super();

        conn = new LocalConnection();
        conn.addEventListener(StatusEvent.STATUS, onStatus);
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * send logRecord to Longing.
     * @param logRecord
     *
     */
    override public function publish(logRecord:LogRecord):void
    {
        if (this.isLoggable(logRecord))
        {
            conn.send(CONN_NAME, CONN_FUN, toObject(logRecord));
        }
    }

    /**
     * logRecord to Object.
     * @param logRecord
     * @return
     *
     */
    private function toObject(logRecord:LogRecord):Object
    {
        var result:Object =
        {
			date : logRecord.getDate(),
			level :
			{
				name : logRecord.getLevel().name,
				value : logRecord.getLevel().value
			},
			loggerName : logRecord.getLoggerName(),
			message : logRecord.getMessage()
        };
        return result;
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function onStatus(event:StatusEvent):void
    {
        switch (event.level)
        {
            case "status":
                break;
            case "error":
                Tracer.logger.removePublisher(this);
                Tracer.warn(getQualifiedClassName(this) + " publish failed!");
                break;
        }
    }
}
}