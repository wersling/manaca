package net.manaca.application.thread
{

/**
 * SimpleBatch is a simple implementation of the IBatch interface.
 *
 * <p>This batch executes its child-processes after each other. This means that the
 * first child-process will be executed at the beginning, the second after the first
 * finished execution and so on.</p>
 * 
 * <p>You can seamlessly add batch processes as child-processes to this batch. If the
 * added child-batch acts like a simple process (as does <code>BatchProcess</code>) this
 * batch will treat the child-batch like a simple process. If the added child-batch
 * acts like a real batch (as does this batch) it is treated as if it were not there,
 * this means as if the child-processes of the child-batch were directly added to this
 * batch.</p>
 *
 * <p>If you want multiple processes to be treated as one process, use the
 * <code>BatchProcess</code>. If you want to group multiple processes, but still want them
 * to be independent and you want to be notified when the next process is executed use
 * this batch. If you simply do not care use this batch: it is more convenient to use
 * because of the properly typed batch events.</p>
 * 
 */
public class SimpleBatch extends AbstractBatch
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a new SimpleBatch instance.
     */
    public function SimpleBatch()
    {
        super();
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    
    /**
     * Distributes batch and process finish events.
     * 
     */
    override protected function dispatchFinishEvent():void
    {
        super.dispatchFinishEvent();
        this.dispatchEvent(
            new BatchEvent(BatchEvent.BATCH_FINISH, false, false));
    }

    /**
     * Distributes batch and process start events.
     * 
     */
    override protected function dispatchStartEvent():void
    {
        super.dispatchStartEvent();
        this.dispatchEvent(
            new BatchEvent(BatchEvent.BATCH_START, false, false));
    }

    /**
     * Distributes batch and process update events.
     * 
     */
    override protected function dispatchUpdateEvent():void
    {
        super.dispatchUpdateEvent();
        var batchEvent:BatchEvent = 
                new BatchEvent(BatchEvent.BATCH_UPDATE, false, false);
        batchEvent.percentage = this.percentage;
        this.dispatchEvent(batchEvent);
    }

    /**
     * Distributes batch and process Resume events.
     * 
     */
    override protected function dispatchResumeEvent():void
    {
        this.dispatchUpdateEvent();
    }

    /**
     * Distributes batch and process pause events.
     * 
     */    
    override protected function dispatchPauseEvent():void
    {
        this.dispatchUpdateEvent();
    }

    /**
     * Distributes batch and process error events.
     * 
     */    
    override protected function dispatchErrorEvent(error:*):void
    {
        super.dispatchErrorEvent(error);
        if(this.willTrigger(BatchEvent.BATCH_ERROR))
        {
            var batchEvent:BatchEvent = 
                    new BatchEvent(BatchEvent.BATCH_ERROR, false, false);
            batchEvent.error = error;
            this.dispatchEvent(batchEvent);
        }
        else
        {
            throw new Error("Unhandled BatchEvent:" + error.toString(), 2044);
        }
    }

    /**
     * Distributes a next-process event.
     *
     * <p>Note that this implementation is empty. But you may override it in 
     * subclasses to distribute a next-process event.</p>
     */
    override protected function distributeNextProcessEvent():void 
    {
        if (currentProcessIndex > 0 || getParentProcess() == null) 
        {
            this.dispatchEvent(new BatchEvent(
                        BatchEvent.BATCH_NEXT_PROCESS, false, false));
        }
    }
}
}