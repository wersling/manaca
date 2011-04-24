package net.manaca.errors
{

/**
 * The IllegalArgumentError is thrown to indicate that a method has been 
 * passed an illegal or inappropriate argument.
 * @author Sean Zou
 * 
 */    
public class IllegalArgumentError extends FrameworkError
{

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>IllegalArgumentError</code> instance.
     * @param message A string associated with the Error object; this parameter is optional.
     */
    public function IllegalArgumentError(message:String = "")
    {
        //TODO
        super(message, 0);
    }
}
}