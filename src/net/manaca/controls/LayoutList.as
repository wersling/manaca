package net.manaca.controls
{
import com.yahoo.astra.layout.LayoutContainer;
import com.yahoo.astra.layout.modes.IAdvancedLayoutMode;
import com.yahoo.astra.layout.modes.ILayoutMode;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;

import net.manaca.controls.listClass.IListItemRenderer;
import net.manaca.core.ClassFactory;
import net.manaca.utils.ArrayUtil;

/**
 * Dispatched when the list item selected.
 * @eventType flash.events.Event.SELECT
 */
[Event(name = "select", type = "flash.events.Event")]

/**
 * LayoutList can be layout it children by ILayoutMode.
 * you can set a array to dataProvider, the object can be display 
 * the array data by itemPenderer. and you can get/set the selected item.
 * @author v-seanzo
 *
 */
public class LayoutList extends LayoutContainer
{
    //==========================================================================
    //  Variables
    //==========================================================================

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>LayoutList</code> instance.
     * @param mode The ILayoutMode implementation to use.
     *
     */
    public function LayoutList(mode:ILayoutMode = null)
    {
        super(mode);
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  allowRepeat
    //----------------------------------
    private var _allowRepeat:Boolean = false;

    /**
     * Is allow repeat select a item.
     * @return
     *
     */
    public function get allowRepeat():Boolean
    {
        return _allowRepeat;
    }

    public function set allowRepeat(value:Boolean):void
    {
        _allowRepeat = value;
    }

    //----------------------------------
    //  allowCancelSelect
    //----------------------------------
    private var _allowCancelSelect:Boolean = false;

    /**
     * Is allow cancel select the selected item.
     * @return
     *
     */
    public function get allowCancelSelect():Boolean
    {
        return _allowCancelSelect;
    }

    public function set allowCancelSelect(value:Boolean):void
    {
        _allowCancelSelect = value;
    }

    //----------------------------------
    //  dataProvider
    //----------------------------------
    private var _dataProvider:Object;

    /**
     * Set of data to be viewed.
     * This property lets you use most types of objects as data providers. 
     * some Array, XML, XMLList and any object.
     * @return
     *
     */
    public function get dataProvider():Object
    {
        return _dataProvider;
    }

    public function set dataProvider(value:Object):void
    {
        _dataProvider = value;

        _selectedIndex = -1;

        updateList();
    }

    //----------------------------------
    //  itemRenderer
    //----------------------------------
    private var _itemRenderer:ClassFactory;

    /**
     * The custom item renderer for the control.
     */
    public function get itemRenderer():ClassFactory
    {
        return _itemRenderer;
    }

    public function set itemRenderer(value:ClassFactory):void
    {
        _itemRenderer = value;

        updateList();
    }

    //----------------------------------
    //  selectedIndex
    //----------------------------------
    private var _selectedIndex:int = -1;

    /**
     * The index in the data provider of the selected item.
     * @return
     *
     */
    public function get selectedIndex():int
    {
        return _selectedIndex;
    }

    public function set selectedIndex(value:int):void
    {
        var item:IListItemRenderer;
        if(dataProvider && (allowRepeat || _selectedIndex != value))
        {
            value = Math.max(-1, Math.min(value, length - 1));

            item = _itemList[_selectedIndex];

            if(item)
            {
                item.selected = false;
            }

            _selectedIndex = value;

            item = _itemList[_selectedIndex];
            if(item)
            {
                item.selected = true;
            }

            dispatchEvent(new Event(Event.SELECT));
        }
        else if(dataProvider && (allowCancelSelect && _selectedIndex == value))
        {
            item = _itemList[_selectedIndex];

            if(item)
            {
                item.selected = false;
            }
            _selectedIndex = -1;
            dispatchEvent(new Event(Event.SELECT));
        }
    }

    //----------------------------------
    //  selectedItem
    //----------------------------------
    /**
     * The index in the data provider of the selected item.
     * @return
     *
     */
    public function get selectedItem():Object
    {
        if(dataProvider && selectedIndex != -1)
        {
            return dataProvider[selectedIndex];
        }
        return null;
    }

    public function set selectedItem(value:Object):void
    {
        if(value && dataProvider)
        {
            var index:int = dataProvider.indexOf(value);
            if(index != -1)
            {
                selectedIndex = index;
            }
        }
        else
        {
            selectedIndex = -1;
        }
    }

    //----------------------------------
    //  itemList
    //----------------------------------
    private var _itemList:Array;

    /**
     * Get all items.
     * @return
     *
     */
    public function get itemList():Array
    {
        return _itemList;
    }

    /**
     * Get the items total.
     * @return
     *
     */
    public function get length():uint
    {
        if(dataProvider is Array)
        {
            return dataProvider.length;
        }
        else if(dataProvider is XMLList)
        {
            return XMLList(dataProvider).length();
        }
        else if(dataProvider)
        {
        	return 1;
        }
        return 0;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * rebuild items.
     *
     */
    private function updateList():void
    {
        removeAll();

        if(dataProvider)
        {
            _itemList = new Array();

            var datas:Array = 
                (dataProvider is Array) ? dataProvider as Array : 
                                            ArrayUtil.toArray(dataProvider);
            var dataLen:uint = datas.length;

            for(var i:uint = 0; i < dataLen; i++)
            {
                var item:IListItemRenderer = itemRenderer.newInstance();
                item.index = i;
                item.data = datas[i];
                item.addEventListener(MouseEvent.CLICK, selectItemHandler);
                addChild(DisplayObject(item));

                _itemList.push(item);
            }
        }
    }

    /**
     * remove all itmes.
     *
     */
    private function removeAll():void
    {
        if( _itemList && _itemList.length > 0 )
        {
            var itemsLen:uint = _itemList.length;
            for(var i:uint = 0;i < itemsLen; i++ )
            {
                var item:IListItemRenderer = _itemList[i];
                item.dispose();
                item.removeEventListener(MouseEvent.CLICK, selectItemHandler);
                if(IAdvancedLayoutMode(layoutMode).hasClient(DisplayObject(item)))
                {
                    IAdvancedLayoutMode(layoutMode).removeClient(
                                                DisplayObject(item));
                }
                removeChild(DisplayObject(item));
            }
        }
        _itemList = null;
    }

    /**
     * dispose this instance.
     *
     */
    public function dispose():void
    {
        removeAll();
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    /**
     *
     * @param event
     *
     */
    private function selectItemHandler(event:Event):void
    {
        var item:IListItemRenderer = event.currentTarget as IListItemRenderer;
        selectedIndex = item.index;
    }
}
}