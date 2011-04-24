package
{
import com.yahoo.astra.layout.modes.TileLayout;

import flash.display.Sprite;

import net.manaca.controls.LayoutList;
import net.manaca.controls.ListPaging;
import net.manaca.core.patterns.factory.ClassFactory;

/**
 *
 * @author v-seanzo
 *
 */
public class LayoutListExample extends Sprite
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>LayoutListExample</code> instance.
     *
     */
    public function LayoutListExample()
    {
        super();

        var layout:TileLayout = new TileLayout();
        layout.paddingTop = 5;
        layout.paddingLeft = 5;
        layout.horizontalGap = 5;
        layout.verticalGap = 5;
        var list:LayoutList = new LayoutList(layout);
        list.autoMask = false;
        list.width = 100;
        list.height = 100;
        list.itemRenderer = new ClassFactory(BaseListItemRenderer);

        var data:Array = [];
        for(var i:uint = 0 ;i < 99; i++ )
        {
            data.push(i);
        }

        var paging:ListPaging = new ListPaging(list, 5);
        paging.dataProvider = data;
        paging.pageCount = 8;
        this.addChild(list);
    }
}
}