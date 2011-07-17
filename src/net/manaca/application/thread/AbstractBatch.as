package net.manaca.application.thread
{
import flash.utils.getTimer;

import net.manaca.core.AbstractHandler;
import net.manaca.data.Set;

/**
 * Dispatched when the batch finish.
 *
 *    <p>The properties of the event object have the following values:</p>
 *  <table class="innertable">
 *     <tr><th>Property</th><th>Value</th></tr>
 *     <tr><td><code>bubbles</code></td><td>false</td></tr>
 *     <tr><td><code>cancelable</code></td><td>false</td></tr>
 *     <tr><td><code>error</code></td><td>null</td></tr>
 *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
 *       event listener that handles the event. For example, if you use
 *       <code>simpleBatch.addEventListener()</code> to register an event listener,
 *       simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
 *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
 *       it is not always the Object listening for the event.
 *       Use the <code>currentTarget</code> property to always access the
 *       Object listening for the event.</td></tr>
 *  </table>
 *
 * @eventType net.manaca.application.thread.BatchEvent.BATCH_FINISH
 */
[Event(name = "batchFinish", type = "net.manaca.application.thread.BatchEvent")]

/**
 * Dispatched when the batch bring a error.
 *
 *    <p>The properties of the event object have the following values:</p>
 *  <table class="innertable">
 *     <tr><th>Property</th><th>Value</th></tr>
 *     <tr><td><code>bubbles</code></td><td>false</td></tr>
 *     <tr><td><code>cancelable</code></td><td>false</td></tr>
 *     <tr><td><code>error</code></td><td>A error of batch.</td></tr>
 *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
 *       event listener that handles the event. For example, if you use
 *       <code>simpleBatch.addEventListener()</code> to register an event listener,
 *       simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
 *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
 *       it is not always the Object listening for the event.
 *       Use the <code>currentTarget</code> property to always access the
 *       Object listening for the event.</td></tr>
 *  </table>
 * @eventType net.manaca.application.thread.BatchEvent.BATCH_ERROR
 */
[Event(name = "batchError", type = "net.manaca.application.thread.BatchEvent")]

/**
 * Dispatched when the batch next process.
 *
 *    <p>The properties of the event object have the following values:</p>
 *  <table class="innertable">
 *     <tr><th>Property</th><th>Value</th></tr>
 *     <tr><td><code>bubbles</code></td><td>false</td></tr>
 *     <tr><td><code>cancelable</code></td><td>false</td></tr>
 *     <tr><td><code>error</code></td><td>null</td></tr>
 *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
 *       event listener that handles the event. For example, if you use
 *       <code>simpleBatch.addEventListener()</code> to register an event listener,
 *       simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
 *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
 *       it is not always the Object listening for the event.
 *       Use the <code>currentTarget</code> property to always access the
 *       Object listening for the event.</td></tr>
 *  </table>
 *
 * @eventType net.manaca.application.thread.BatchEvent.BATCH_NEXT_PROCESS
 */
[Event(name = "batchNextProcess", 
                            type = "net.manaca.application.thread.BatchEvent")]

/**
 * Dispatched when the batch started.
 *
 *    <p>The properties of the event object have the following values:</p>
 *  <table class="innertable">
 *     <tr><th>Property</th><th>Value</th></tr>
 *     <tr><td><code>bubbles</code></td><td>false</td></tr>
 *     <tr><td><code>cancelable</code></td><td>false</td></tr>
 *     <tr><td><code>error</code></td><td>null</td></tr>
 *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
 *       event listener that handles the event. For example, if you use
 *       <code>simpleBatch.addEventListener()</code> to register an event listener,
 *       simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
 *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
 *       it is not always the Object listening for the event.
 *       Use the <code>currentTarget</code> property to always access the
 *       Object listening for the event.</td></tr>
 *  </table>
 *
 * @eventType net.manaca.application.thread.BatchEvent.BATCH_START
 */
[Event(name = "batchStart", type = "net.manaca.application.thread.BatchEvent")]

/**
 * Dispatched when the batch updated.
 *
 *    <p>The properties of the event object have the following values:</p>
 *  <table class="innertable">
 *     <tr><th>Property</th><th>Value</th></tr>
 *     <tr><td><code>bubbles</code></td><td>false</td></tr>
 *     <tr><td><code>cancelable</code></td><td>false</td></tr>
 *     <tr><td><code>error</code></td><td>null</td></tr>
 *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
 *       event listener that handles the event. For example, if you use
 *       <code>simpleBatch.addEventListener()</code> to register an event listener,
 *       simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
 *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
 *       it is not always the Object listening for the event.
 *       Use the <code>currentTarget</code> property to always access the
 *       Object listening for the event.</td></tr>
 *  </table>
 *
 * @eventType net.manaca.application.thread.BatchEvent.BATCH_UPDATE
 */
[Event(name = "batchUpdate", type = "net.manaca.application.thread.BatchEvent")]

/**
 * The <code>AbstractBatch</code> provides a 
 * abstract <code>IBatch</code> implement.
 * @author Sean Zou
 *
 */
public class AbstractBatch extends AbstractProcess implements IBatch
{
    //==========================================================================
    //  Variables
    //==========================================================================

    /** All added processes. */
    protected var processes:Set;

    /** The index of the process that is currently running. */
    protected var currentProcessIndex:Number;

    /** Loading progress in percent. */
    protected var _percentage:uint;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * <code>AbstractBatch</code> Constructor.
     * You can"t creat the <code>AbstractBatch</code> object.
     * @param self
     */
    public function AbstractBatch()
    {
        AbstractHandler.handlerClass(this, AbstractBatch);

        processes = new Set();
        _percentage = 0;
    }

    //==========================================================================
    //  Properties
    //==========================================================================

    /**
     * @inheritDoc
     */
    override public function get name():String
    {
        var result:String = super.name;
        if (result == null && currentProcess)
        {
            result = currentProcess.name;
        }
        return result;
    }

    /**
     * @inheritDoc
     */
    override public function get percentage():uint
    {
        return _percentage;
    }

    /**
     * @inheritDoc
     */
    public function get currentProcess():IProcess
    {
        return processes.getItemAt(currentProcessIndex) as IProcess;
    }

    /**
     * @inheritDoc
     */
    public function get processCount():uint
    {
        return processes.size();
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * @inheritDoc
     */
    override public function start():void
    {
        if (this.state == ProcessState.UNSTARTED)
        {
            currentProcessIndex = -1;
            _percentage = 0;
            endTime = NaN;
            startTime = getTimer();
            this.state = ProcessState.RUNNING;
            if (processes.size() == 0)
            {
                this.dispatchStartEvent();
            }
            nextProcess();
        }
    }

    private function removeCurrentProcessEvents():void
    {
        if(currentProcess != null)
        {
            currentProcess.setParentProcess(null);
            currentProcess.removeEventListener(ProcessEvent.PROCESS_ERROR, 
                                                            onProcessError);
            currentProcess.removeEventListener(ProcessEvent.PROCESS_FINISH, 
                                                            onProcessFinish);
            currentProcess.removeEventListener(ProcessEvent.PROCESS_PAUSE, 
                                                            onProcessPause);
            currentProcess.removeEventListener(ProcessEvent.PROCESS_RESUME, 
                                                            onProcessResume);
            currentProcess.removeEventListener(ProcessEvent.PROCESS_START, 
                                                            onProcessStart);
            currentProcess.removeEventListener(ProcessEvent.PROCESS_UPDATE, 
                                                            onProcessUpdate);
        }
    }
    /**
     * @inheritDoc
     */
    private function nextProcess():void
    {
        removeCurrentProcessEvents();

        if (currentProcessIndex < processes.size() - 1)
        {
            updatePercentage(100);
            currentProcessIndex++;
            var process:AbstractProcess = 
                    AbstractProcess(processes.getItemAt(currentProcessIndex));
            process.setParentProcess(this);

            process.addEventListener(ProcessEvent.PROCESS_ERROR, 
                                                            onProcessError);
            process.addEventListener(ProcessEvent.PROCESS_FINISH, 
                                                            onProcessFinish);
            process.addEventListener(ProcessEvent.PROCESS_PAUSE, 
                                                            onProcessPause);
            process.addEventListener(ProcessEvent.PROCESS_RESUME, 
                                                            onProcessResume);
            process.addEventListener(ProcessEvent.PROCESS_START, 
                                                            onProcessStart);
            process.addEventListener(ProcessEvent.PROCESS_UPDATE, 
                                                            onProcessUpdate);
            process.start();
        }
        else
        {
            updatePercentage(100);
            finish();
        }
    }

    /**
     * Updates the loading progress percentage.
     *
     * @param percentage the progress percentage of the current process
     */
    private function updatePercentage(percentage:Number):void
    {
        this._percentage = 100 / processCount * 
                            (currentProcessIndex + (1 / 100 * percentage));
    }

    /**
     * @inheritDoc
     */
    override public function getParentProcess():IProcess
    {
        return parent;
    }

    /**
     * Sets the parent of this process.
     *
     * @throws IllegalArgumentException if this process is itself a parent of the
     * given process (to prevent infinite recursion)
     * @param parentProcess the new parent process of this process
     */
    override public function setParentProcess(parentProcess:IProcess):void
    {
        this.parent = parentProcess;
        do
        {
            if (parentProcess == this)
            {
                /* throw new IllegalArgumentException(
                            "A process may not be the parent of its " +
                            "parent process.", this, arguments); */
            }
            parentProcess = parentProcess.getParentProcess();
        }
        while (parentProcess != null);
    }



    /**
     * @inheritDoc
     */
    public function getAllProcesses():Array
    {
        return processes.toArray().concat();
    }

    /**
     * Adds the given process to execute to this batch.
     *
     * <p>It is possible to add the same process more than once. 
     * It will be executed as often as you add it.</p>
     *
     * <p>Note that the given process will not be added if it is 
     * this batch itself or if it is <code>null</code></p>
     *
     * @param process the process to add
     */
    public function addProcess(process:IProcess):void
    {
        if (process != null && process != this)
        {
            processes.add(process);
            updatePercentage(100);
        }
    }

    /**
     * Adds all given processes which implement 
     * the <code>Process</code> interface.
     *
     * @param processes the processes to add
     * @see #addProcess
     */
    public function addAllProcesses(processes:Array):void
    {
        for (var i:Number = 0;i < processes.length; i++)
        {
            addProcess(AbstractProcess(processes[i]));
        }
    }

    /**
     * Removes all occurrences of the given process.
     *
     * @param process the process to remove
     */
    public function removeProcess(process:IProcess):void
    {
        var index:int = processes.remove(process);
        if (index == currentProcessIndex)
        {
            /*TODO  throw new IllegalArgumentException(
                    "Process [" + process + "] is " +
                    "currently running and can thus not be removed.", this, arguments); */
        }
        if (index < currentProcessIndex)
        {
            currentProcessIndex--;
        }
    }

    /**
     * @inheritDoc
     */
    public function removeAllProcesses():void
    {
        if (state == ProcessState.RUNNING) {
            /* throw new IllegalStateException(
                    "All processes cannot be removed when batch is " +
                    "running.", this, arguments); */
        }
        processes = new Set();
    }

    /**
     * Gives the given process highest priority: 
     * the given process will be started as soon as the currently 
     * running process finishes.
     *
     * @param process the process to run next.
     */
    public function moveProcess(process:IProcess):void
    {
        if (process != null)
        {
            var _processes:Array = processes.toArray();
            var i:Number = _processes.length;
            while(--i - (-1))
            {
                if (_processes[i] == process)
                {
                    if (i != currentProcessIndex)
                    {
                        if (i < currentProcessIndex)
                        {
                            currentProcessIndex--;
                        }
                        _processes.slice(i, i);
                        _processes.splice(currentProcessIndex + 1, 0, process);
                    }
                }
            }
        }
    }
    
    override public function dispose():void
    {
        removeCurrentProcessEvents();
        if(currentProcess)
        {
            currentProcess.dispose();
        }
        if(processes)
        {
            processes.clear();
            processes = null;
        }
        super.dispose();
    }
    //==========================================================================
    //  Event handlers
    //==========================================================================

    /**
     * @private
     * Distributes a start event if the started process is the first process; 
     * also distributes a next process and an update event.
     *
     * @param process the process that was started
     */
    private function onProcessStart(event:ProcessEvent):void
    {
        if (currentProcessIndex == 0)
        {
            this.dispatchStartEvent();
        }
        distributeNextProcessEvent();
        this.dispatchUpdateEvent();
    }

    /**
     * @private
     * Updates the percentage and distributes an update event.
     *
     * @param process the process that was updated
     */
    private function onProcessUpdate(event:ProcessEvent):void
    {
        var process:IProcess = event.target as IProcess;
        var percentage:Number = process.percentage;
        if (!isNaN(percentage))
        {
            updatePercentage(percentage);
        }
        this.dispatchUpdateEvent();
    }

    /**
     * @private
     * Distributes a process pause event for the given process.
     *
     * @param process the process that has paused its execution
     */
    private function onProcessPause(event:ProcessEvent):void
    {
        this.dispatchPauseEvent();
    }

    /**
     * @private
     * Distributes a process resume event for the given process.
     *
     * @param process the process that has resumed its execution
     */
    private function onProcessResume(event:ProcessEvent):void
    {
        this.dispatchResumeEvent();
    }

    /**
     * @private
     * Updates the current process and distributes a next-process event.
     *
     * @param batch the batch that started the next process
     */
    /* public function onNextProcess(batch:IBatch):void
    {
    currentProcess = batch.currentProcess;
    distributeNextProcessEvent();
    } */

    /**
     * @private
     * Executes the next process if the current process has finished.
     *
     * @param process the finished process
     * @see #nextProcess
     */
    private function onProcessFinish(event:ProcessEvent):void
    {
        if (currentProcess.state == ProcessState.FINISHED)
        {
            nextProcess();
        }
    }

    /**
     * @private
     * Distributes an error event with the given error.
     *
     * @param process the process that raised the error
     * @param error the raised error
     */
    private function onProcessError(event:ProcessEvent):void
    {
        this.dispatchErrorEvent(event.error);
    }

    /**
     * @private
     * Distributes a next-process event.
     *
     * <p>Note that this implementation is empty. 
     * But you may override it in subclasses
     * to distribute a next-process event.</p>
     */
    protected function distributeNextProcessEvent():void
    {
    }
}
}