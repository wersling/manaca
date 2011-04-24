package net.manaca.application.thread
{
import flash.events.Event;

/**
 * The <code>BatchEvent</code> provides a single Batch event.
 * @author v-seanzo
 * 
 */    
public class BatchEvent extends Event
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * The <code>BatchEvent.BATCH_FINISH</code> constant defines the value of 
     * the <code>type</code> property of the event object for a 
     * <code>finish</code> event.
     *
     * <p>The properties of the event object have the following values:</p>
     * <table class="innertable">
     *    <tr><th>Property</th><th>Value</th></tr>
     *    <tr><td><code>bubbles</code></td><td>false</td></tr>
     *    <tr><td><code>cancelable</code></td><td>false</td></tr>
     *    <tr><td><code>error</code></td><td>null</td></tr>
     *    <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *      event listener that handles the event. For example, if you use
     *      <code>simpleBatch.addEventListener()</code> to register 
     *          an event listener, simpleBatch is the value of the 
 *          <code>currentTarget</code>. </td></tr>
     *    <tr><td><code>target</code></td>
     *       <td>The Object that dispatched the event;
     *      it is not always the Object listening for the event.
     *      Use the <code>currentTarget</code> property to always access the
     *      Object listening for the event.</td></tr>
     * </table>
     */    
    static public const BATCH_FINISH:String = "batchFinish";
    /**
     * The <code>BatchEvent.BATCH_ERROR</code> constant defines the value of the
     * <code>type</code> property of the event object for a <code>error</code> event.
     *
     *   <p>The properties of the event object have the following values:</p>
     * <table class="innertable">
     *    <tr><th>Property</th><th>Value</th></tr>
     *    <tr><td><code>bubbles</code></td><td>false</td></tr>
     *    <tr><td><code>cancelable</code></td><td>false</td></tr>
     *    <tr><td><code>error</code></td><td>A error of batch.</td></tr>
     *    <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *      event listener that handles the event. For example, if you use
     *      <code>simpleBatch.addEventListener()</code> to register an event listener,
     *      simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
     *    <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *      it is not always the Object listening for the event.
     *      Use the <code>currentTarget</code> property to always access the
     *      Object listening for the event.</td></tr>
     * </table>
     */  
    static public const BATCH_ERROR:String = "batchError";
    /**
     * The <code>BatchEvent.BATCH_NEXT_PROCESS</code> constant defines the value of the
     * <code>type</code> property of the event object for a next process event.
     *
     *   <p>The properties of the event object have the following values:</p>
     * <table class="innertable">
     *    <tr><th>Property</th><th>Value</th></tr>
     *    <tr><td><code>bubbles</code></td><td>false</td></tr>
     *    <tr><td><code>cancelable</code></td><td>false</td></tr>
     *    <tr><td><code>error</code></td><td>null</td></tr>
     *    <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *      event listener that handles the event. For example, if you use
     *      <code>simpleBatch.addEventListener()</code> to register an event listener,
     *      simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
     *    <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *      it is not always the Object listening for the event.
     *      Use the <code>currentTarget</code> property to always access the
     *      Object listening for the event.</td></tr>
     * </table>
     */ 
    static public const BATCH_NEXT_PROCESS:String = "batchNextProcess";
    /**
     * The <code>BatchEvent.BATCH_NEXT_PROCESS</code> constant defines the 
     * value of the <code>type</code> property of the event object for 
     * a start event.
     *
     * <p>The properties of the event object have the following values:</p>
     * <table class="innertable">
     *    <tr><th>Property</th><th>Value</th></tr>
     *    <tr><td><code>bubbles</code></td><td>false</td></tr>
     *    <tr><td><code>cancelable</code></td><td>false</td></tr>
     *    <tr><td><code>error</code></td><td>null</td></tr>
     *    <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *      event listener that handles the event. For example, if you use
     *      <code>simpleBatch.addEventListener()</code> to register an event listener,
     *      simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
     *    <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *      it is not always the Object listening for the event.
     *      Use the <code>currentTarget</code> property to always access the
     *      Object listening for the event.</td></tr>
     * </table>
     */
    static public const BATCH_START:String = "batchStart";
    /**
     * The <code>BatchEvent.BATCH_NEXT_PROCESS</code> constant defines the value of the
     * <code>type</code> property of the event object for a update event.
     *
     *   <p>The properties of the event object have the following values:</p>
     * <table class="innertable">
     *    <tr><th>Property</th><th>Value</th></tr>
     *    <tr><td><code>bubbles</code></td><td>false</td></tr>
     *    <tr><td><code>cancelable</code></td><td>false</td></tr>
     *    <tr><td><code>error</code></td><td>null</td></tr>
     *    <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *      event listener that handles the event. For example, if you use
     *      <code>simpleBatch.addEventListener()</code> to register an event listener,
     *      simpleBatch is the value of the <code>currentTarget</code>. </td></tr>
     *    <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *      it is not always the Object listening for the event.
     *      Use the <code>currentTarget</code> property to always access the
     *      Object listening for the event.</td></tr>
     * </table>
     */
    static public const BATCH_UPDATE:String = "batchUpdate";

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * <code>BatchEvent</code> Constructor. 
     * @param type The event type; indicates the action that caused the event.
     * @param error A error of batch.
     * @param bubbles Specifies whether the event can bubble up the display 
     * list hierarchy.
     * @param cancelable Specifies whether the behavior associated with the 
     * event can be prevented.
     * 
     */
    public function BatchEvent(type:String,
                    bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  error
    //----------------------------------
    /**
     * A error of batch.
     */        
    public var error:Error;

    /**
     * The loading percentage.
     */
    public var percentage:uint;

    //==========================================================================
    //  Methods
    //==========================================================================
    override public function clone():Event
    {
        var result:BatchEvent = 
                            new BatchEvent(type, bubbles, cancelable);
        result.error = error;
        result.percentage = percentage;
        return result;
    }
}
}