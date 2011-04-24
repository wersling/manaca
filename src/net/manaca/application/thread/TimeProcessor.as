package net.manaca.application.thread
{
import flash.events.EventDispatcher;
import flash.utils.getTimer;

import net.manaca.core.AbstractHandler;

/**
 * <code>TimeProcessor</code> provides methods to measure execution time.
 *
 * <p>The concrete implementation needs to take care of <code>startTime</code>,
 * <code>endTime</code>, <code>percentage</code>.</p>
 */    
public class TimeProcessor extends EventDispatcher 
{
    //==========================================================================
    //  Variables
    //==========================================================================
   
    /** The time stamp at which execution started. */
    protected var startTime:uint;

    /** The time stamp at which execution finished. */
    protected var endTime:uint;

    /** The current duration time. */
    protected var durationTime:uint;

    /** The total execution time. */
    protected var totalTime:uint;

    /** The time still needed for the execution. */
    protected var restTime:uint;

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * <code>TimeProcessor</code> Constructor. 
     * You can"t creat the <code>TimeProcessor</code> object.
     */
    public function TimeProcessor()
    {
        AbstractHandler.handlerClass(this, TimeProcessor);
        
        durationTime = NaN;
        totalTime = NaN;
        restTime = NaN;
        endTime = NaN;
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    
    /**
     * Returns the execution progress in percent.
     *
     * <p>Note that this implementation just returns <code>NaN</code>; 
     * override this method in subclasses to reutrn an actual value.</p>
     *
     * @return the current execution progress in percent
     */
    public function get percentage():uint 
    {
        return NaN;
    }

    /**
     * Returns the time needed for the execution (until now).
     *
     * <p>If execution has already finished, the totally needed execution time 
     * will be returned. </p>
     * Otherwise the time needed from the start of the execution until this 
     * point in the execution will be returned.
     *
     * @return the time needed for executing this process (until now)
     */
    public function get duration():uint 
    {
        if ( isNaN(endTime) && !isNaN(startTime) ) 
        {
            durationTime = getTimer() - startTime;
        }
        else if( !isNaN(startTime) )
        {
            durationTime = endTime - startTime;
        }
        
        return durationTime;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Estimates the time needed for the total execution.
     *
     * @return the estimated total time needed for the execution
     */
    public function getEstimatedTotalTime():uint 
    {
        if ( !isNaN(duration) && !isNaN(percentage) ) 
        {
            totalTime = duration / percentage * 100;
            return totalTime;
        }
        return null;
    }

    /**
     * Estimates the rest time needed until the execution finishes.
     *
     * @return the estimated rest time needed for the execution
     */
    public function getEstimatedRestTime():uint 
    {
        var totalTime:uint = getEstimatedTotalTime();
        if ( isNaN(totalTime) ) 
        {
            restTime = getEstimatedTotalTime() - duration;
            return restTime;
        }
        return null;
    }
}
}