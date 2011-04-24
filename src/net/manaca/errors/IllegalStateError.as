package net.manaca.errors
{

/**
 * The IllegalStateError signals that a method has been invoked at an 
 * illegal or inappropriate time.
 * @author Sean Zou
 * 
 */    
public class IllegalStateError extends FrameworkError
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>IllegalStateError</code> instance.
     * @param message A string associated with the Error object; this parameter is optional.
     */
    public function IllegalStateError(message:String = "")
    {
        //TODO
        super(message, 0);
    }
}
}