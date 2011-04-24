package net.manaca.core.patterns.command
{

/**
 * The SequenceCommand is provided as a "psuedo-abstract" (since ActionScript
 * has no real concept of abstract classes) base-class that can be extended when
 * you wish to chain commands together for a single user-gesture, or establish
 * some simple form of decision-based workflow
 * @author Sean Zou
 *
 */
public class SequenceCommand implements ICommand
{
    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Constructor, with optional nextEvent.
     * @param nextEvent
     *
     */
    public function SequenceCommand(nextCommand:ICommand = null)
    {
        super();

        this.nextCommand = nextCommand;
    }

    //==========================================================================
    //  Properties
    //==========================================================================

    /**
     * The next event in the sequence.
     */
    public var nextCommand:ICommand;

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * Abstract implementation of the execute() method.
     * <p>ActionScript does not explicity support abstract methods and abstract classes, so this concrete
     * implementation of the interface method must be overridden by the developer.</p>
     * @param event
     *
     */
    public function execute(event:CommandEvent = null):void
    {
    }

    /**
     * Call to execute the next command in the sequence.
     *
     * <p>Called explicitly by the developer within a concrete SequenceCommand implementation, this method causes the
     * event registered with nextEvent to be broadcast, for the next command in the sequence to be called
     * without further user-gesture.</p>
     *
     */
    public function executeNextCommand():void
    {
        if(nextCommand != null)
        {
            nextCommand.execute();
        }
    }
}
}