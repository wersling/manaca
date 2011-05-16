package site
{
import com.yahoo.astra.layout.LayoutContainer;
import com.yahoo.astra.layout.modes.ILayoutMode;

public class Footer extends LayoutContainer
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Footer</code> instance.
     * 
     */
    public function Footer(mode:ILayoutMode=null)
    {
        super(mode);
        autoMask = false;
        
        initDisplay();
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    //==========================================================================
    //  Properties
    //==========================================================================
    
    //==========================================================================
    //  Methods
    //==========================================================================
    private function initDisplay():void
    {
    }
}
}