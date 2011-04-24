package net.manaca.application.thread
{
import flash.utils.getTimer;

import net.manaca.core.AbstractHandler;
import net.manaca.core.patterns.command.ICommand;
import net.manaca.data.Map;

// Getting localizable text from "process"

/**
 * Dispatched when the process finished.
 * @copy net.manaca.application.thread.ProcessEvent#PROCESS_FINISH
 * @eventType net.manaca.application.thread.ProcessEvent.PROCESS_FINISH
 */
[Event(name = "processFinish", 
            type = "net.manaca.application.thread.ProcessEvent")]

/**
 * Dispatched when the process bring a error.
 * @copy net.manaca.application.thread.ProcessEvent#PROCESS_ERROR
 * @eventType net.manaca.application.thread.ProcessEvent.PROCESS_ERROR
 */
[Event(name = "processError", 
            type = "net.manaca.application.thread.ProcessEvent")]

/**
 * Dispatched when the process paused.
 * @copy net.manaca.application.thread.ProcessEvent#PROCESS_PAUSE
 * @eventType net.manaca.application.thread.ProcessEvent.PROCESS_PAUSE
 */
[Event(name = "processPause", 
            type = "net.manaca.application.thread.ProcessEvent")]

/**
 * Dispatched when the process resumed.
 * @copy net.manaca.application.thread.ProcessEvent#PROCESS_RESUME
 * @eventType net.manaca.application.thread.ProcessEvent.PROCESS_RESUME
 */
[Event(name = "processResume", 
            type = "net.manaca.application.thread.ProcessEvent")]

/**
 * Dispatched when the process started.
 * @copy net.manaca.application.thread.ProcessEvent#PROCESS_START
 * @eventType net.manaca.application.thread.ProcessEvent.PROCESS_START
 */
[Event(name = "processStart", 
            type = "net.manaca.application.thread.ProcessEvent")]

/**
 * Dispatched when the process updated.
 * @copy net.manaca.application.thread.ProcessEvent#PROCESS_UPDATE
 * @eventType net.manaca.application.thread.ProcessEvent.PROCESS_UPDATE
 */
[Event(name = "processUpdate", 
            type = "net.manaca.application.thread.ProcessEvent")]

/**
 * The <code>AbstractProcess</code> provides 
 * a abstract <code>IProcess</code> implement.
 * 
 * <p>It handles all process states, distributes events and provides
 * means for starting subprocesses. Subclasses must implement the run
 * template method, which is responsible for doing the actual processing. The
 * run method can either do its job synchronously or asynchronously.</p>
 * 
 * <p>Synchronously means that all computations have been done as soon as the
 * <code>run</code> method returns; 
 * the finish event will be distributed directly
 * after the invocation of the <code>run</code> method.</p>
 *
 * <listing version = "3.0" >
 * class MySynchronousProcess extends AbstractProcess 
 * {
 *
 *         private var collaborator:MyCollaborator;
 *
 *         public function MySynchronousProcess(
 *                                        collaborator:MyCollaborator):void
 *         {
 *             this.collaborator = collaborator;
 *         }
 *
 *         override protected function run():void 
 *         {
 *             var number:Number = collaborator.getNumber();
 *             collaborator.setNumber(number * 2);
 *      }
 *
 * }
 * </listing>
 *
 * <p>Asynchronously means that the run method needs more than one frame
 * to do its job (for example when files are loaded) and that processing is thus
 * not finished when the run method returns. In this case the run
 * method must designate that it has not finished processing when it returns by
 * setting the <code>ProcessState.RUNNING</code> flag to <code>true</code> 
 * and finish the process as soon as the asynchrnous subprocess finishes.</p>
 *
 * <listing version = "3.0" >
 * class MyAsynchronousProcess extends AbstractProcess {
 *
 *         private var loader:URLLoader;
 *
 *         public function MyAsynchronousProcess(loader:URLLoader):void
 *         {
 *             this.loader = loader;
 *         }
 *
 *         override protected function run():void 
 *         {
 *             loader.addEventListener(ProcessEvent.PROCESS_FINISH,finish);
 *             state = ProcessState.RUNNING;
 *             xml.load("test.xml");
 *     }
 * }
 * </listing>
 * 
 * @author v-seanzo
 * 
 */    
public class AbstractProcess extends TimeProcessor implements IProcess
{
    //==========================================================================
    //  Variables
    //==========================================================================
   
    /** All subprocesses as keys and their callbacks as values. */
    protected var subProcesses:Map;

    /** The parent of this process. */
    protected var parent:IProcess;

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * <code>AbstractProcess</code> Constructor. 
     * You can"t creat the <code>AbstractProcess</code> object.
     */
    public function AbstractProcess()
    {
        AbstractHandler.handlerClass(this, AbstractProcess);
        
        subProcesses = new Map();
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    /** The state of this process. */
    private var _state:uint;

    /**
     * @inheritDoc 
     */    
    public function get state():uint
    {
        return _state;
    }

    public function set state(value:uint):void
    {
        this._state = value;
    }

    /** The name of this process. */
    private var _name:String;

    /**
     * @inheritDoc 
     */    
    public function get name():String
    {
        return this._name;
    }

    public function set name(name:String):void
    {
        this._name = name;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    public function dispose():void
    {
        parent = null;
        if(subProcesses)
        {
            subProcesses.clear();
            subProcesses = null;
        }
        
    }
    /**
     * Does the actual computations.
     *
     * <p>This method is abstract and must be implemented by subclasses.</p>
     *
     * @throws ArgumentError if this method was not implemented by
     * subclasses
     */
    protected function run():void
    {
        AbstractHandler.handlerFunction("AbstractProcess.run");
    }

    /**
     * Prepares the start of this process by setting all flags and 
     * distributing a start event.
     *
     * @see #distributeStartEvent
     */
    protected function prepare():void 
    {
        durationTime = NaN;
        totalTime = NaN;
        restTime = NaN;
        endTime = NaN;
        this._state = ProcessState.UNSTARTED;
        dispatchStartEvent();
        this._state = ProcessState.RUNNING;
    }

    /**
     * @inheritDoc 
     */    
    public function start():void
    {
        prepare();
        try
        {
            startTime = getTimer();
            
            run();
        }
        catch (exception:Error)
        {
            dispatchErrorEvent(exception);
        }
        if (state != ProcessState.SUSPENDED
            && state != ProcessState.FINISHED
            && state != ProcessState.RUNNING)
        {
            finish();
        }
    }

    /**
     * Pauses this process and distributes a pause event.
     *
     * @see #distributePauseEvent
     */
    public function suspend():void 
    {
        this._state = ProcessState.SUSPENDED;
        this.dispatchPauseEvent();
    }

    /**
     * Resumes this process and distributes a resume event.
     *
     * @see #distributeResumeEvent
     */
    public function resume():void 
    {
        this._state = ProcessState.RUNNING;
        this.dispatchResumeEvent();
        if (subProcesses.isEmpty()/* && !(this instanceof StepByStepProcess)*/) 
        {
            finish();
        }
    }

    /**
     * Interrupts the execution of this process with the given error.
     *
     * <p>Stores the given error, distributes an error event 
     * and finishes this process.</p>
     *
     * <p>If no error is specified is will be set to <code>-1</code>.</p>
     *
     * @param error the error that caused this interrupt.
     * 
     * @see #distributeErrorEvent
     * @see #finish
     */
    protected function interrupt(error:Error):void 
    {
        this.state = ProcessState.ABORTED;
        this.dispatchErrorEvent(error);
        finish();
    }

    /**
     * Finishes this process if it is currently running and has no more 
     * subprocesses to wait for. It sets all flags, stores the end time and 
     * distributes a finish event.
     */
    protected function finish():void
    {
        if (subProcesses.isEmpty() && this.state == ProcessState.RUNNING) 
        {
            this._state = ProcessState.FINISHED;
            endTime = getTimer();
            this.dispatchFinishEvent();
        }
    }

    /**
     * @inheritDoc 
     */    
    public function getParentProcess():IProcess
    {
        return parent;
    }

    /**
     * @inheritDoc 
     */    
    public function setParentProcess(parentProcess:IProcess):void
    {
        this.parent = parentProcess;
        if(parentProcess != null)
        {
            do 
            {
                if (parentProcess == this) 
                {
                    //TODO setParentProcessException
                    throw new ArgumentError("setParentProcessException");
                }
            } 
            while (parentProcess = parentProcess.getParentProcess());
        }
    }

    /**
     * Starts the given subprocess.
     *
     * <p>Registers this process as parent of the given subprocess and starts 
     * the subprocess immediately if necessary. This means that if you start 
     * multiple subprocesses they will be executed synchronously and not one 
     * after the other.</p>
     *
     * <p>This process does not finish execution until all subprocesses 
     * have finished.</p>
     *
     * <p>If the given subprocess finishes its corresponding callback will 
     * be invoked. </p>
     * 
     * @param process the subprocess to start
     * @param callback the callback to execute if the subprocess finishes
     */
    public function startSubProcess(process:IProcess, callback:ICommand):void 
    {
        // Don"t do anything if the the process is already 
        // registered as sub-process.
        if (!subProcesses.containsKey(process)) 
        {
            process.addEventListener(ProcessEvent.PROCESS_ERROR, 
                                            onProcessError, false, 0, true);
            process.addEventListener(ProcessEvent.PROCESS_FINISH, 
                                            onProcessFinish, false, 0, true);
            process.setParentProcess(this);
            subProcesses.put(process, callback);
            
            if (this.state == ProcessState.SUSPENDED) 
            {
                resume();
            }
            // Start if not started.
            // Re-start if finished.
            // Do nothing if started but not finished.
            if (process.state == ProcessState.UNSTARTED || 
                                    process.state == ProcessState.FINISHED) 
            {
                process.start();
            }
        }
    }

    /**
     * Invoked when a subprocess finishes; removes itself as listener from the
     * subprocess, executes the callback corresponding of the subprocess and 
     * resumes the execution of this process.
     *
     * @param process the subprocess that finished execution
     * @see #resume
     */
    private function onProcessFinish(event:ProcessEvent):void 
    {
        var process:IProcess = event.target as IProcess;
        if (subProcesses.containsKey(process)) 
        {
            // removes current as listener
            process.removeEventListener(ProcessEvent.PROCESS_ERROR, 
                                                        onProcessError);
            process.removeEventListener(ProcessEvent.PROCESS_FINISH, 
                                                        onProcessFinish);
            // Remove the process and executes the registered callback.
            ICommand(subProcesses.remove(process)).execute();
            // Resume exeuction
            resume();
        }
    }

    /**
     * Invoked when a subprocess has an error; distributes an error event with 
     * the given error.
     *
     * @param process the subprocess where the error occurred
     * @param error the error that occurred
     * @return true if the error was consumed else false.
     * @see #distributeErrorEvent
     */
    private function onProcessError(event:ProcessEvent):void 
    {
        var process:IProcess = event.target as IProcess;
        if (subProcesses.containsKey(process)) 
        {
            // removes current as listener
            process.removeEventListener(ProcessEvent.PROCESS_ERROR, 
                                                        onProcessError);
            process.removeEventListener(ProcessEvent.PROCESS_FINISH, 
                                                        onProcessFinish);
            // Remove the process
            subProcesses.remove(process);
            // Resume exeuction
            resume();
        }
        
        this.dispatchErrorEvent(event.error);
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    
    /**
     * Distributes process finish events.
     * @see net.manaca.application.thread.ProcessEvent#PROCESS_FINISH
     */
    protected function dispatchFinishEvent():void
    {
        this.dispatchEvent(new ProcessEvent(
                            ProcessEvent.PROCESS_FINISH, null, false, false));
    }

    
    /**
     * Distributes process start events.
     * 
     */
    protected function dispatchStartEvent():void
    {
        this.dispatchEvent(new ProcessEvent(
                            ProcessEvent.PROCESS_START, null, false, false));
    }

    /**
     * Distributes process update events.
     * 
     */
    protected function dispatchUpdateEvent():void
    {
        var event:ProcessEvent = new ProcessEvent(
                            ProcessEvent.PROCESS_UPDATE, null, false, false);
        event.percent = this.percentage;
        this.dispatchEvent(event);
    }

    /**
     * Distributes process resume events.
     * 
     */
    protected function dispatchResumeEvent():void
    {
        this.dispatchEvent(new ProcessEvent(
                            ProcessEvent.PROCESS_RESUME, null, false, false));
    }

    /**
     * Distributes process pause events.
     * 
     */
    protected function dispatchPauseEvent():void
    {
        this.dispatchEvent(new ProcessEvent(
                            ProcessEvent.PROCESS_PAUSE, null, false, false));
    }

    /**
     * Distributes process error events.
     * @param error
     * 
     */
    protected function dispatchErrorEvent(error:*):void
    {
        if(this.willTrigger(ProcessEvent.PROCESS_ERROR))
        {
            this.dispatchEvent(new ProcessEvent(
                            ProcessEvent.PROCESS_ERROR, error, false, false));
        }
        else
        {
            throw new Error("Unhandled ProcessEvent:" + error.toString(), 2044);
        }
    }
}
}