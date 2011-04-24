package
{
import net.manaca.controls.listClass.ListItemRenderer;

public class BaseListItemRenderer extends ListItemRenderer
{
    public function BaseListItemRenderer()
    {
        super();
    }

    override public function set data(value:Object):void
    {
        super.data = value;
        this.graphics.beginFill(0);
        this.graphics.drawRect(0, 0, 15, 20);
        this.alpha = 0.5;
        this.buttonMode = true;
    }

    override public function set selected(value:Boolean):void
    {
        super.selected = value;
        this.alpha = value ? 1 : .5;
    }
}
}