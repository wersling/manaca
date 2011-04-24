package net.manaca.core
{
import net.manaca.errors.AbstractOperationError;

import flash.utils.getQualifiedClassName;

/**
 * The <code>AbstractHandler</code> static class which provides an API for 
 * enforcing an pseudo abstract class is never to have an instance instantiated.
 *
 * @example The following example demonstrates how to utilize
 * <code>AbstractHandler</code> to ensure a pseudo-abstract
 * class is never instantiated.
 *
 * <listing version="3.0">
 *
 * package
 * {
 *   import net.manaca.core.AbstractHandler;
 *
 *   public class Abstract
 *   {
 *       public function Abstract()
 *       {
 *            AbstractHandler.handlerClass(this, Abstract);
 *       }
 *    }
 * }
 * </listing>
 * @author Sean Zou
 *
 */
public class AbstractHandler
{
    /**
     * Provides a mechanism for handling a pseudo-abstract class
     * is never instantiated.
     *
     * <p>
     * When an attempt to instantiate an instance of an Abstract
     * class an exception will be thrown as the instance and Class
     * object are of the same qualified class name. When a sub class
     * of the Abstract class is instantiated the instance will not
     * be of the same type as that of the Abstract class, thus making
     * it possible to enforce the Abstract class is not instantiated.
     * </p>
     *
     * @param instance the class instance.
     * @param type the class type.
     * @throws net.manaca.errors.AbstractOperationError thrown to indicate 
     * that an operation marked by the developer as abstract has not been 
     * overwritten.
     */
    public static function handlerClass(instance:Object, type:Class):void
    {
        if ( getQualifiedClassName(instance) == getQualifiedClassName(type) )
        {
            var message:String = getQualifiedClassName(type) + 
                                        " class cannot be instantiated.";
            throw new AbstractOperationError(message);
        }
    }

    /**
     * Provides a mechanism for handling a pseudo-abstract function
     * is must be implemented by subclasses.
     *
     * @param methodName the function name.
     * @throws net.manaca.errors.AbstractOperationError thrown to indicate that 
     * an operation marked by the developer as abstract has not 
     * been overwritten.
     */
    public static function handlerFunction(methodName:String):void
    {
        var message:String = methodName + 
                " method is abstract and must be implemented by subclasses.";
        throw new AbstractOperationError(message);
    }
}
}