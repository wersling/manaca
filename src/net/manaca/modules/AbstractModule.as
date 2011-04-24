package net.manaca.modules
{
import com.yahoo.astra.layout.LayoutContainer;
import com.yahoo.astra.layout.modes.BorderLayout;
import com.yahoo.astra.layout.modes.ILayoutMode;

public class AbstractModule extends LayoutContainer
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>AbstractModule</code>实例.
     * @param autoRemove 是(true)否(false)自动删除这个模块，
     * 在这个模块移除舞台的时候.
     * 
     */    
    public function AbstractModule(mode:ILayoutMode = null)
    {
        if(!mode)
        {
            mode = new BorderLayout();
        }
        super(mode);
        autoMask = false;
    }
}
}