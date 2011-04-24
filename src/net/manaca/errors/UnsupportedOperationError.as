package net.manaca.errors
{

/**
 * The UnsupportedOperationError is thrown to indicate that an operation is 
 * not supported by the throwing class.
 * @author Sean Zou
 * 
 */    
public class UnsupportedOperationError extends FrameworkError
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>UnsupportedOperationError</code> instance.
     * @param message A string associated with the Error object; this parameter is optional.
     */
    public function UnsupportedOperationError(message:String = "")
    {
        //TODO
        super(message, 0);
    }
}
}