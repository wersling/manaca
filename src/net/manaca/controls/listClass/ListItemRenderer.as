package net.manaca.controls.listClass
{
import flash.display.Sprite;

/**
 * The ListItemRenderer class defines the default item renderer for 
 * a List control. You can override the default item renderer by creating 
 * a custom item renderer.
 * 
 * @author Sean Zou
 */
public class ListItemRenderer extends Sprite implements IListItemRenderer
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>LogRecord</code> instance.
     *
     */
    public function ListItemRenderer()
    {
        super();
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  index
    //----------------------------------
    private var _index:uint;

    /**
     * @inheritDoc
     */
    public function set index(value:uint):void
    {
        _index = value;
    }

    public function get index():uint
    {
        return _index;
    }

    //----------------------------------
    //  selected
    //----------------------------------
    private var _selected:Boolean = false;

    /**
     * @inheritDoc
     */
    public function get selected():Boolean
    {
        return _selected;
    }

    public function set selected(value:Boolean):void
    {
        _selected = value;
    }

    //----------------------------------
    //  data
    //----------------------------------
    protected var _data:Object;

    /**
     * @inheritDoc
     */
    public function get data():Object
    {
        return _data;
    }

    public function set data(value:Object):void
    {
        _data = value;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    public function dispose():void
    {
        _data = null;
    }
}
}