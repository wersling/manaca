package {
import net.manaca.application.Application;

/* Define the application preloader class. */
[Frame(factoryClass="net.manaca.preloaders.SimplePreloader")]
/* Define the application size , background color and frame rate. */
[SWF(width="1000", height="500", frameRate="26", backgroundColor="#FFFFFF")]
/**
 * The application entry.
 * @author Sean
 * 
 */    
public class MyApplication extends Application
{
    //==========================================================================
    //  Variables
    //==========================================================================
    /* Embed config file. */
    [Embed(source="./application.xml", mimeType="application/octet-stream")]
    private var configClz:Class;
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs.
     * 
     */        
    public function MyApplication()
    {
        super(configClz);
    }
    
    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * override. start the application.
     * 
     */        
    override protected function startup():void
    {
        
    }
}
}
