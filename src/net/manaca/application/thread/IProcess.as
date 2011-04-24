package net.manaca.application.thread
{
import flash.events.IEventDispatcher;

/**
 * The <code>IProcess</code> interface provides a common interface for the 
 * execution of synchronous or asynchronous tasks. It is mostly used for 
 * asynchronous tasks.
 *
 * <p>Synchronous tasks are directly done in the <code>start</code> method 
 * and are finished when the <code>start</code> method returns.</p>
 * 
 * <p>Asynchronous tasks are only started in the <code>start</code> method and 
 * are finished some time after the <code>start</code> method returns. 
 * An asynchronous task is for example loading a file or getting data from a 
 * web service (which cannot be done synchronously in ActionScript). 
 * You may also use asynchronous processes to do a huge computation 
 * step-by-step which would crash the flash player or would prevent user
 * interaction if done synchronously.</p>
 * 
 * @author v-seanzo
 */    
public interface IProcess extends IEventDispatcher
{
    //==========================================================================
    //  Properties
    //==========================================================================
    
    /**
     * Returns the execution progress in percent.
     *
     * <p>If this process has not started execution yet, 
     * <code>0</code> will be returned.</p>
     *
     * <p>If this process has already started exeuction and the progress 
     * is evaluable, a value between <code>0</code> and <code>100</code> 
     * will be returned, depending on the current execution state.</p>
     *
     * <p>If this process has already finished execution, 
     * <code>100</code> will be returned.</p>
     *
     * @return the current execution progress in percent
     */
    function get percentage():uint;

    /**
     * Get the Process state.
     * @return 
     * @see ProcessState
     */
    function get state():uint;

    /**
     * Returns the time needed for executing this process (until now).
     *
     * <p>If this process has already finished execution, 
     * the totally needed execution time will be returned. 
     * Otherwise the time needed from the start of the execution until this 
     * point in the execution will be returned.</p>
     *
     * @return the time needed for executing this process (until now)
     */
    function get duration():uint;

    /**
     * Returns the name of this process intended for display to users, 
     * but it is also helpful for debugging.
     *
     * <p>Note that batch processes may choose to return not their name but 
     * rather the name of the process currently running.</p>
     *
     * @return the name of this process
     */
    function get name():String;

    /**
     * Sets the name of this process.
     *
     * @param name the name of this process
     * @see #getName
     */
    function set name(value:String):void;

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Starts the execution of this process.
     */
    function start():void;

    /**
     * Suspend the execution of this process.
     * 
     */
    function suspend():void;

    /**
     * Resume the execution of this process.
     * 
     */    
    function resume():void;
    
    /**
     * dispose 
     * 
     */    
    function dispose():void;
    
    /**
     * Estimates the total execution time.
     *
     * <p>If this process has already finished execution, 
     * the exact execution time will be returned.</p>
     *
     * <p>If this process has not started execution yet <code>0</code> 
     * will be returned.</p>
     *
     * @return the estimated total execution time
     * @see #getDuration
     */
    function getEstimatedTotalTime():uint;

    /**
     * Estimates the rest time needed until the execution finishes.
     *
     * <p>If this process has already finished execution <code>0</code> will be 
     * returned. If it has not started execution yet <code>null</code> 
     * will be returned.</p>
     *
     * @return the estimated rest time needed for the execution of this process.
     */
    function getEstimatedRestTime():uint;

    /**
     * Returns the parent of this process. This process may be a child process 
     * of a batch or the subprocess of another process. In the former case the 
     * returned parent is a batch, in the latter case another process.
     *
     * @return the parent process or <code>null</code>
     */
    function getParentProcess():IProcess;

    /**
     * Sets the parent of this process. The parent process may be a batch of 
     * which this process is a child, or another process of which this process 
     * is a subprocess.
     *
     * @param parentProcess the parent process that manages this process
     * @throws ArgumentError if the given parent process is itself a child
     * or subprocess of this process or if it is this process itself
     */
    function setParentProcess(parentProcess:IProcess):void;
}
}