package site
{
import com.yahoo.astra.layout.LayoutContainer;
import com.yahoo.astra.layout.modes.ILayoutMode;

import net.manaca.events.TransitionEvent;

import site.module.ModuleBase;

public class Content extends LayoutContainer
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Content</code> instance.
     * 
     */
    public function Content(mode:ILayoutMode=null)
    {
        super(mode);
        autoMask = false;
        initDisplay();
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var currentModule:ModuleBase;
    private var newModule:ModuleBase;
    //==========================================================================
    //  Methods
    //==========================================================================
    private function initDisplay():void
    {
    }
    
    public function show(module:ModuleBase):void
    {
        this.newModule = module;
        if(currentModule)
        {
            currentModule.addEventListener(TransitionEvent.TRANSITION_OUT_COMPLETE,
                currentModule_tranOutHandler);
            currentModule.transitionOut();
        }
        else
        {
            showNewModule();
        }
    }
    
    private function showNewModule():void
    {
        if(currentModule)
        {
            currentModule.dispose();
            removeChild(currentModule);
            currentModule = null;
        }
        currentModule = newModule;
        currentModule.addEventListener(TransitionEvent.TRANSITION_IN_COMPLETE,
            currentModule_tranInHandler);
        currentModule.display();
        addChild(currentModule);
        currentModule.transitionIn();
    }
    
    
    override protected function layout():void
    {
        if(currentModule)
        {
            currentModule.width = width;
            currentModule.height = height;
        }
    }
    
    protected function currentModule_tranInHandler(event:TransitionEvent):void
    {
        // TODO Auto-generated method stub
    }
    
    protected function currentModule_tranOutHandler(event:TransitionEvent):void
    {
        showNewModule();
    }
    
}
}