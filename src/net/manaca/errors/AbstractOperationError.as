package net.manaca.errors
{

/**
 * The AbstractOperationError is thrown to indicate that an operation 
 * marked by the developer as abstract has not been overwritten.
 * 
 * @example
 * <p>The following example uses the AbstractOperationError class to show how a 
 * abstract operation error can be generated.</p>
 * 
 * <listing version = "3.0" >
import net.manaca.core.AbstractHandler;
    
public class MyAbstractClass
{
public function MyAbstractClass()
{
AbstractHandler.handlerClass(this,MyAbstractClass);
}

}
 * </listing>
 * @author Sean Zou
 * 
 */    
public class AbstractOperationError extends FrameworkError
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>AbstractOperationError</code> instance.
     * @param message A string associated with the Error object; this parameter is optional.
     */
    public function AbstractOperationError(message:String = "")
    {
        //TODO
        super(message, 0);
    }
}
}