package 
{
import net.manaca.preloaders.DownloadProgressBar;
import net.manaca.preloaders.PreloaderBase;


/**
 * The SimplePreloader provide a had loading bar preloader.
 * @author v-seanzo
 * 
 */    
public class SimplePreloader extends PreloaderBase
{
    //==========================================================================
    //  Variables
    //==========================================================================
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a new <code>SimplePreloader</code> instance.
     * 
     */
    public function SimplePreloader()
    {
        super(new DownloadProgressBar());
        swfRatio = 100;
    }
}
}