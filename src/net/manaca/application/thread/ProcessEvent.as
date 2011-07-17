package net.manaca.application.thread
{
import flash.events.Event;

/**
 * The <code>ProcessEvent</code> provides a single Process event.
 * @author Sean Zou
 * 
 */
public class ProcessEvent extends Event
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     *  The <code>ProcessEvent.PROCESS_FINISH</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>finish</code> event.
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
     */    
    static public const PROCESS_FINISH:String = "processFinish";

    /**
     *  The <code>ProcessEvent.PROCESS_ERROR</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>error</code> event.
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
     */ 
    static public const PROCESS_ERROR:String = "processError";

    /**
     *  The <code>ProcessEvent.PROCESS_FINISH</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>pause</code> event.
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
     */
    static public const PROCESS_PAUSE:String = "processPause";

    /**
     *  The <code>ProcessEvent.PROCESS_RESUME</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>resume</code> event.
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
     */
    static public const PROCESS_RESUME:String = "processResume";

    /**
     *  The <code>ProcessEvent.PROCESS_START</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>start</code> event.
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
     */
    static public const PROCESS_START:String = "processStart";
    /**
     *  The <code>ProcessEvent.PROCESS_UPDATE</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>update</code> event.
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
     */
    static public const PROCESS_UPDATE:String = "processUpdate";

    
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * <code>ProcessEvent</code> Constructor. 
     * @param type The event type; indicates the action that caused the event.
     * @param error A error of batch.
     * @param bubbles Specifies whether the event can bubble up the display list hierarchy.
     * @param cancelable Specifies whether the behavior associated with the event can be prevented.
     * 
     */    
    public function ProcessEvent(type:String, error:Error = null, 
                        bubbles:Boolean = false, cancelable:Boolean = false)
    {
        super(type, bubbles, cancelable);
        this.error = error;
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
     * The loading percent.
     */
    public var percent:Number;

    //==========================================================================
    //  Methods
    //==========================================================================
    override public function clone():Event
    {
        var result:ProcessEvent = 
                        new ProcessEvent(type, error, bubbles, cancelable);
        result.percent = percent;
        return result;
    }
}
}