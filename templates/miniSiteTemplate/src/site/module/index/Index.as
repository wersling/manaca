package site.module.index
{
import com.greensock.TweenLite;
import com.yahoo.astra.layout.modes.ILayoutMode;

import flash.text.TextField;

import site.module.ModuleBase;

public class Index extends ModuleBase
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Index</code> instance.
     * 
     */
    public function Index(mode:ILayoutMode=null)
    {
        super(mode);
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
    override public function display():void
    {
        graphics.beginFill(0xFFFFFF * Math.random());
        graphics.drawRect(0, 20, 100, 100);
        alpha = 0;
        
        var tf:TextField = new TextField();
        tf.y = 20;
        tf.text = sectionVO.name;
        addChild(tf);
    }
    
    override public function transitionIn():void
    {
        super.transitionIn();
        TweenLite.to(this, 1, {alpha:1, onComplete:transitionInComplete});
    }
    
    override public function transitionOut():void
    {
        super.transitionOut();
        TweenLite.to(this, 1, {alpha:0, onComplete:transitionOutComplete});
    }
    
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    
}
}