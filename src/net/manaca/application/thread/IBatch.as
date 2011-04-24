package net.manaca.application.thread
{

/**
 * The <code>IBatch</code> interface manages the execution of multiple 
 * processes (most batches start processes after each other).
 *
 * <p>Use the <code>addProcess</code> method to add a new child-process 
 * to this batch. 
 * Most implementations start processes in the order they are added to them.</p>
 * 
 * <p>This interface extends the <code>IProcess</code> interface. 
 * This means that this batch is a composite, so you can add one batch with 
 * the <code>addProcess</code> method as child-process to another batch.</p>
 * 
 * <p>Because the <code>IBatch</code> extends the <code>IProcess</code>, 
 * you need handler process and batch error event for synchronous. 
 * for example:</p>
 * <listing version = "3.0" >
import net.manaca.application.thread.BatchEvent;
import net.manaca.application.thread.IBatch;
import net.manaca.application.thread.ProcessEvent;
import net.manaca.application.thread.SimpleBatch;
    
var myBatch:IBatch = new SimpleBatch();
myBatch.addEventListener(BatchEvent.BATCH_FINISH, batchFinishHandler);
myBatch.addEventListener(BatchEvent.BATCH_ERROR, batchErrorHandler);
myBatch.addEventListener(ProcessEvent.PROCESS_ERROR, processErrorHandler);
 * </listing>
 * 
 * @example
 * <p>you can using the batch for following:</p>
 * <listing version = "3.0" >
 * import net.manaca.application.thread.BatchEvent;
 * import net.manaca.application.thread.IBatch;
 * import net.manaca.application.thread.SimpleBatch;
 * 
 * var batch:IBatch = new SimpleBatch();
 * batch.addEventListener(BatchEvent.BATCH_FINISH,onFinish);
 * batch.addProcess(new MyStartUpProcess());
 * batch.addProcess(new MyXMLParsingProcess());
 * batch.start();
 * </listing>
 */    
public interface IBatch extends IProcess
{
    //==========================================================================
    //  Properties
    //==========================================================================
    
    /**
     * Returns the currently running process.
     */
    function get currentProcess():IProcess;

    /**
     * Returns the number of processes added to this batch.
     *
     * @return the total number of processes
     */
    function get processCount():uint;

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Adds the given process to be executed by this batch.
     *
     * @param process the process to add
     */
    function addProcess(process:IProcess):void;

    /**
     * Adds all given processes.
     *
     * @param processes the processes to add
     */
    function addAllProcesses(processes:Array):void;

    /**
     * Removes the given process.
     *
     * @param process the process to remove
     */
    function removeProcess(process:IProcess):void;

    /**
     * Removes all processes.
     */
    function removeAllProcesses():void;

    /**
     * Returns all added processes.
     *
     * @return all added processes
     */
    function getAllProcesses():Array;
}
}