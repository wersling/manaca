package net.manaca.errors
{
import flash.utils.getQualifiedClassName;

/**
 * The SingletonError signals when user created multi-singleton class.
 * 
 * @example
 * <p>The following example uses the SingletonError class to show how a 
 * singleton error can be generated.</p>
 * 
 * <listing version = "3.0" >
import net.manaca.errors.SingletonError;
    
public class MySingleton
{
static private var instance:MySingleton;
public function MySingleton()
{
if(instance != null)
{
throw new SingletonError(this);
}
else
{
instance = this;
}
}
}
 * </listing>
 * @author Sean Zou
 * 
 */    
public class SingletonError extends FrameworkError
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>SingletonError</code> instance.
     * @param message A string associated with the Error object; this parameter is optional.
     */
    public function SingletonError(instance:Object)
    {
        var message:String = "Only one " + 
            getQualifiedClassName(instance) + " instance can be instantiated.";
        super(message, 0);
    }
}
}