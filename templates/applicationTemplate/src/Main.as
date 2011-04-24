package
{

import flash.net.URLLoader;

import net.manaca.application.Application;
import net.manaca.logging.Tracer;
//--------------------------------------
//  Application Metadata
//--------------------------------------
/* Define the application preloader class. */
[Frame(factoryClass="net.manaca.preloaders.SimplePreloader")]
/* Define the application size , background color and frame rate. */
[SWF(width="800", height="600", frameRate="30", backgroundColor="#FFFFFF")]
/**
 * Main
 * 
 * @author Sean Zou
 */
public class Main extends Application
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /* Embed config file. */
    [Embed(source="./application.xml", mimeType="application/octet-stream")]
    private var configClz:Class;
    
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Main</code> instance.
     */
    public function Main()
    {
        super(configClz);
    }
    
    //==========================================================================
    //  Methods
    //==========================================================================
    override protected function updateConfiguration(percent:uint):void
    {
    }
    /**
     * overrided. start the application.
     * 
     */        
    override protected function startup():void
    {
        Tracer.info("application startup, version : " + 
            config.AppSettings.version);
        ExternalVars.initialize(stage.loaderInfo);
        //TODO start coding
    }
}
}