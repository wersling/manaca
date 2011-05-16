package site.menu
{
import com.yahoo.astra.layout.LayoutContainer;
import com.yahoo.astra.layout.modes.BoxLayout;

import net.manaca.utils.DeepVO;

import site.model.SectionModel;

public class Menu extends LayoutContainer
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Menu</code> instance.
     * 
     */
    public function Menu()
    {
        var box:BoxLayout = new BoxLayout();
        box.horizontalGap = 5;
        super(box);
        autoMask = false;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var selectedMenu:MenuItem;
    private var currentDeepVO:DeepVO;
    private var menus:Array = [];
    //==========================================================================
    //  Properties
    //==========================================================================
    
    //==========================================================================
    //  Methods
    //==========================================================================
    public function initMenu():void
    {
        var list:Array = SectionModel.getInstance().sectionList;
        for(var i:int = 0; i < list.length; i++)
        {
            var menu:MenuItem = new MenuItem();
            menu.rootDeep = "/";
            menu.data = list[i];
            addChild(menu);
            
            menus.push(menu);
        }
    }
    
    public function changeDeep(deepVO:DeepVO):void
    {
        for each(var menu:MenuItem in menus)
        {
            menu.changeDeep(deepVO);
        }
    }
}
}