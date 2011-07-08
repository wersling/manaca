package
{

import com.pixelbreaker.ui.osx.MacMouseWheel;

import flash.external.ExternalInterface;
import flash.system.Capabilities;

import net.manaca.application.Application;
import net.manaca.application.Bootstrap;
import net.manaca.logging.Tracer;

import site.MainContainer;

//--------------------------------------
//  Application Metadata
//--------------------------------------
/* Define the application preloader class. */
[Frame(factoryClass="SimplePreloader")]
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
    /**
     * Define the config file path.
     */    
    static public const APP_CONFIG:String = "application.xml";
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Main</code> instance.
     */
    public function Main()
    {
        super();
    }
    
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * overrided. start the application.
     * 
     */        
    override protected function startup():void
    {
        Tracer.info("application startup, version : " + 
            Bootstrap.getInstance().clientVersion);
        Tracer.info(
            [
                "FPVersion:" + Capabilities.version,
                "isDebuger:" + Capabilities.isDebugger,
                "playerType:" + Capabilities.playerType,
                "ExternalInterface.available:" + ExternalInterface.available,
                "href:" + Bootstrap.getInstance().href
            ]
        );
        MacMouseWheel.setup(stage);
        ExternalVars.initialize(stage.loaderInfo);
        addChild(new MainContainer());
    }
}
}