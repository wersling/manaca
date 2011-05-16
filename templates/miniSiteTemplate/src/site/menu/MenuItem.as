package site.menu
{
import com.asual.swfaddress.SWFAddress;

import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import net.manaca.controls.listClass.ListItemRenderer;
import net.manaca.utils.DeepVO;

import site.model.SectionVO;

public class MenuItem extends ListItemRenderer
{
    /**
     * 是否显示子级菜单
     */    
    static private const SHOW_CHILD_MENU:Boolean = true;
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>MenuItem</code> instance.
     * 
     */
    public function MenuItem()
    {
        super();
        
        initDisplay();
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var textFiled:TextField;
    private var currentDeepVO:DeepVO;
    private var menus:Array = [];
    //==========================================================================
    //  Properties
    //==========================================================================
    public var rootDeep:String;
    
    override public function set data(value:Object):void
    {
        super.data = value;
        
        textFiled.text = SectionVO(value).name;
        textFiled.setTextFormat(ExternalVars.defaultTextFormat);
    }
    
    override public function set selected(value:Boolean):void
    {
        super.selected = value;
        textFiled.backgroundColor = value ? 0xFF : 0x000000;
        if(SHOW_CHILD_MENU && data.menuChildren.length) 
        {
            if(selected)
            {
                openSubMenu();
            }
            else
            {
                closeSubMenu();
            }
        }
    }
    //==========================================================================
    //  Methods
    //==========================================================================
    private function initDisplay():void
    {
        buttonMode = true;
        
        textFiled = new TextField();
        textFiled.autoSize = TextFieldAutoSize.LEFT;
        textFiled.background = true;
        textFiled.backgroundColor = 0x000000;
        textFiled.textColor = 0xFFFFFF;
        textFiled.selectable = false;
        textFiled.mouseEnabled = false;
        addChild(textFiled);
        
        addEventListener(MouseEvent.CLICK, mouse_clickHandler);
    }
    
    public function changeDeep(deepVO:DeepVO):void
    {
        currentDeepVO = deepVO;
        for each(var menu:MenuItem in menus)
        {
            menu.changeDeep(deepVO);
        }
        //判断是否需要显示
        //&&后面的判断是为了修复首页采用空地址导致的错误
        if(deepVO.path.indexOf(rootDeep + data.deep) == 0 &&
        (data.deep != "" || deepVO.path == "/"))
        {
            if(!selected)
            {
                selected = true;
            }
        }
        else
        {
            selected = false;
        }
    }
    
    private function openSubMenu():void
    {
        var list:Array = data.menuChildren;
        for(var i:int = 0; i < list.length; i++)
        {
            var menu:MenuItem = new MenuItem();
            menu.data = list[i];
            menu.rootDeep = rootDeep + data.deep + "/";
            menu.y = i * 20 + 20;
            if(currentDeepVO)
            {
                menu.changeDeep(currentDeepVO);
            }
            addChild(menu);
            menus.push(menu);
        }
    }
    
    private function closeSubMenu():void
    {
        for(var i:int = 0; i < menus.length; i++)
        {
            var menu:MenuItem = menus[i];
            removeChild(menu);
        }
        menus = [];
    }
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    private function mouse_clickHandler(event:MouseEvent):void
    {
        if(event.currentTarget != event.target)
        {
            return;
        }
        SWFAddress.setValue(rootDeep + data.deep);
    }
}
}