package site.module
{
import com.yahoo.astra.layout.LayoutContainer;
import com.yahoo.astra.layout.modes.ILayoutMode;

import net.manaca.display.ITransitionObject;
import net.manaca.events.TransitionEvent;
import net.manaca.utils.DeepVO;

import site.model.SectionVO;

public class ModuleBase extends LayoutContainer implements ITransitionObject
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>ModuleBase</code> instance.
     * 
     */
    public function ModuleBase(mode:ILayoutMode=null)
    {
        super(mode);
        autoMask = false;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    protected var deepVO:DeepVO;
    protected var sectionVO:SectionVO;
    protected var files:Object;
    //==========================================================================
    //  Properties
    //==========================================================================
    
    //==========================================================================
    //  Methods
    //==========================================================================
    public function init(deepVO:DeepVO, sectionVO:SectionVO, files:Object):void
    {
        this.deepVO = deepVO;
        this.sectionVO = sectionVO;
        this.files = files;
    }
    
    public function changeDeep(deepVO:DeepVO):void
    {
        this.deepVO = deepVO;
    }
    
    public function display():void
    {
        
    }
    
    public function dispose():void
    {
        
    }
    
    public function transitionIn():void
    {
        dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN));
    }
    
    public function transitionOut():void
    {
        dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT));
    }
    
    public function transitionInComplete():void
    {
        dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_IN_COMPLETE));
    }
    
    public function transitionOutComplete():void
    {
        dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_OUT_COMPLETE));
    }
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    
}
}