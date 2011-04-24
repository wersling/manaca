package net.manaca.core.patterns.command
{
import net.manaca.core.patterns.command.ICommand;

/**
 * <code>Call</code> enables another object to call a method in another scope without
 * having to know the scope or the method.
 *
 * <p>This enables you to pass a call to another object and let the object execute
 * the call without losing its scope. The call can be executed with the <code>execute</code>
 * method.</p>
 *
 * <p>A call is similar to a Delegate.</p>
 */
public class Call implements ICommand
{
    //==========================================================================
    //  Variables
    //==========================================================================

    /** The object to execute the method on. */
    private var object:Object;
    /** The method to execute on the object. */
    private var method:Function;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Constructs a new <code>Call</code> instance.
     *
     * @param object the object to execute the method on.
     * @param method the method to execute.
     * @throws ArgumentError if either <code>object</code> or <code>method</code> is
     * <code>null</code> or <code>undefined</code>
     */
    public function Call(object:Object, method:Function)
    {
        var message:String;
        if(object == null)
        {
            message = "Required parameter \"object\" is \"null\" or \"undefined\".";
        }

        if (method == null)
        {
            message = "Required parameter \"method\" is \"null\" or \"undefined\".";
        }

        if(message)
        {
            throw new ArgumentError(message);
        }
        this.object = object;
        this.method = method;
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * @inheritDoc
     */
    public function execute(event:CommandEvent = null):void
    {
        method.apply(object, [ event ]);
    }
}
}