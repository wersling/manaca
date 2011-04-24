package net.manaca.display
{
import flash.events.IEventDispatcher;

/**
 * The <code>ITransitionObject</code> interface provides a display object transition functions.
 *
 * @author v-seanzo
 *
 */
public interface ITransitionObject extends IEventDispatcher
{
    /**
     * Do the display transition in.
     */
    function transitionIn():void;

    /**
     * Do the display transition out.
     *
     */
    function transitionOut():void;

    /**
     * Apply the function when the transition in comapleted.
     *
     */
    function transitionInComplete():void;

    /**
     * Apply the function when the transition out comapleted
     *
     */
    function transitionOutComplete():void;
}
}