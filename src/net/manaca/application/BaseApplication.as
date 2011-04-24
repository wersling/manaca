package net.manaca.application
{
import flash.display.Sprite;

import net.manaca.core.AbstractHandler;

/**
 * <code>BaseApplication</code> is the base access point for flash applications.
 *
 * <p>You can use a Frame tag define a <code>Preloader</code> object.</p>
 *
 * <p>You must simply init your application something like this:</p>
 * <listing version = "3.0" >
[Frame(factoryClass="net.manaca.preloaders.Preloader")]
public class AppStartupDemo extends Application
{
public function AppStartupDemo()
{
}

final override protected function startup():void
{
trace("The application started!")
}
}
 * </listing>
 *
 * @author Sean Zou
 *
 */
public class BaseApplication extends Sprite implements IApplication
{
    //==========================================================================
    //  Class variables
    //==========================================================================

    //==========================================================================
    //  Class methods
    //==========================================================================

    //==========================================================================
    //  Variables
    //==========================================================================

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Application Constructor.
     * This class is abstract and must be implemented by subclasses.
     * @throws net.manaca.errors.AbstractOperationError thrown to 
     * indicate that an operation marked by the developer as 
     * abstract has not been overwritten.
     */
    public function BaseApplication()
    {
        AbstractHandler.handlerClass(this, BaseApplication);
    }

    //==========================================================================
    //  Properties
    //==========================================================================

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * @inheritDoc
     */
    final public function initialize():void
    {
        startup();
    }

    /**
     * The startup function will call by application initialized.
     * You need override the function.
     * <p>for example:</p>
     * @example
     * <pre>
     * final override public function startup(...rest):void
     * {
     *         trace("The application started!")
     * }
     * </pre>
     * @throws net.manaca.errors.AbstractOperationError thrown the error 
     * indicate that an operation marked by the developer has not override 
     * the abstract function.
     */
    protected function startup():void
    {
        AbstractHandler.handlerFunction("Application.startup");
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
}
}