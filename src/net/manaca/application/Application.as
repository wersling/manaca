package net.manaca.application
{
import flash.display.Sprite;

import net.manaca.application.config.ApplicationSetup;
import net.manaca.core.AbstractHandler;
import net.manaca.errors.SingletonError;

/**
 * <code>Application</code> is the default access point for flash applications.
 *
 * <p>You can use a Frame tag define a <code>Preloader</code> object.</p>
 *
 * <p>You must simply init your application something like this:</p>
 * <listing version = "3.0" >
 * package {
import net.manaca.application.Application;
[Frame(factoryClass="net.manaca.preloaders.SimplePreloader")]
public class ApplicationExample extends Application
{
[Embed(source="./application.xml", mimeType="application/octet-stream")]
private var configClz:Class;

public function ApplicationExample()
{
super(configClz);
}

override protected function startup():void
{
}
}
}
 * </listing>
 *
 * @author Sean Zou
 */
public class Application extends Sprite implements IApplication
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * Singleton for this application
     */    
    static private var instance:Application;
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Application</code> instance.
     * @param config the config xml class.
     * you can writing something like this:
     * <listing version = "3.0" >
     * [Embed(source="./application.xml", mimeType="application/octet-stream")]
     * private var configClz:Class;
     * </listing>
     */
    public function Application()
    {
        AbstractHandler.handlerClass(this, Application);
        ApplicationSetup;

        if(instance != null)
        {
            throw new SingletonError(this);
        }
        else
        {
            instance = this;
        }
    }   

    //==========================================================================
    //  Methods
    //==========================================================================
    public function initialize():void
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
}
}