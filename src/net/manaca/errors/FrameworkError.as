package net.manaca.errors
{
import flash.utils.getQualifiedClassName;

/**
 * The FrameworkError class is a base error for flash framework.
 *
 *
 * @author Sean Zou
 *
 */
public class FrameworkError extends Error
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>FrameworkError</code> instance.
     * @param message A string associated with the Error object; this parameter is optional.
     * @param id A reference number to associate with the specific error message.
     *
     */
    public function FrameworkError(message:String = "", id:int = 0)
    {
        super(message, id);
    }

    /**
     * Returns the string "FrameworkError" by default or the value contained in
     * Error.message property, if defined.
     *
     * @return The error message.
     * @example
     * The following example creates a new Error object err and then,
     * using the Error() constructor, assigns the string "New Error Message" to err.
     * Finally, the message property is set to "Another New Error Message", which overwrites "New Error Message".
     * <listing version = "3.0" >
     * var err:FrameworkError = new FrameworkError();
     * trace(err.toString());    // FrameworkError
     * err = new FrameworkError("New Error Message");
     * trace(err.toString());    // FrameworkError: New Error Message
     * </listing>
     */
    public function toString():String
    {
        if(message)
        {
            return getQualifiedClassName(this) + ":" + message;
        }
        else
        {
            return getQualifiedClassName(this);
        }
    }
}
}