package net.manaca.application.config
{
import flash.display.Stage;

import net.manaca.application.config.model.LogLevelInfo;
import net.manaca.application.config.model.LoggingSettingsInfo;
import net.manaca.application.thread.AbstractProcess;
import net.manaca.errors.IllegalArgumentError;
import net.manaca.logging.LogLevel;
import net.manaca.logging.Tracer;
import net.manaca.logging.publishers.Output;
import net.manaca.logging.publishers.TracePublisher;

/**
 * The LoggingConfiguration provide a log initialize by config file.
 * @author v-seanzo
 *
 */
public class LoggingConfiguration extends AbstractProcess
{
    //==========================================================================
    //  Variables
    //==========================================================================

    private var info:LoggingSettingsInfo;
    private var stage:Stage;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>LoggingConfiguration</code> instance.
     * @param stage stage object.
     * @param info the log setting info.
     *
     */
    public function LoggingConfiguration(stage:Stage, info:LoggingSettingsInfo)
    {
        super();
        if(stage != null)
        {
            this.stage = stage;
        }
        else
        {
            throw new IllegalArgumentError("invalid stage argument:" + stage);
        }

        if(info != null)
        {
            this.info = info;
        }
        else
        {
            throw new IllegalArgumentError("invalid info argument:" + info);
        }
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * Start initialize the logging.
     * <ul>
     *     <li>
     *         initialize the Output and other publishers.
     *     </li>
     *     <li>
     *         set the log level.
     *     </li>
     * </ul>
     */
    override protected function run():void
    {
        if(info.enabled)
        {
            setPublishers();
            setLogLevel();
        }
        this.finish();
    }

    private function setPublishers():void
    {
        if(info.Output != null && !Output.instance)
        {
            var output:Output = new Output(info.Output.outputHeight, 
                                                            info.Output.strong);
            output.level = getLogLevel(info.Output.LogLevel);
            this.stage.addChild(output);
            this.stage.removeChild(output);

            Tracer.info("Added  Output. log level:" + output.level.name);
        }

        if(info.TracePublisher != null)
        {
            var tracePublisher:TracePublisher = new TracePublisher();
            Tracer.logger.addPublisher(tracePublisher);
            tracePublisher.level = getLogLevel(info.TracePublisher.LogLevel);

            Tracer.info("Added  TracePublisher. log level:" + 
                                                tracePublisher.level.name);
        }
    }

    private function setLogLevel():void
    {
        Tracer.logger.level = getLogLevel(info.LogLevel);
        Tracer.info("Set Tracer log level:" + Tracer.logger.level.name);
    }

    private function getLogLevel(level:LogLevelInfo):LogLevel
    {
        var result:LogLevel = LogLevel.ALL;
        switch(level.valueOf())
        {
            case LogLevelInfo.ALL:
            {
                result = LogLevel.ALL;
                break;
            }
            case LogLevelInfo.DEBUG:
            {
                result = LogLevel.DEBUG;
                break;
            }
            case LogLevelInfo.INFO:
            {
                result = LogLevel.INFO;
                break;
            }
            case LogLevelInfo.WARN:
            {
                result = LogLevel.WARN;
                break;
            }
            case LogLevelInfo.ERROR:
                result = LogLevel.ERROR;
                break;
            case LogLevelInfo.FATAL:
            {
                result = LogLevel.FATAL;
                break;
            }
            case LogLevelInfo.OFF:
            {
                result = LogLevel.OFF;
                break;
            }
        }
        return result;
    }
}
}