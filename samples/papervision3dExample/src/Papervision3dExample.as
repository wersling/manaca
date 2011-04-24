package
{
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;

import org.papervision3d.view.BasicView;

[SWF(width='800', height='600',frameRate='30', backgroundColor='#FFFFFF')]

public class Papervision3dExample extends Sprite
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Papervision3dExample</code> instance.
     *
     */
    public function Papervision3dExample()
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.quality = StageQuality.BEST;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        var example:BasicView = new ColladaView(this.stage.stageWidth, this.stage.stageHeight, true);
        addChild(example);

        this.graphics.beginFill(0xff);
        this.graphics.drawRect(this.stage.stageWidth / 2 - 50, this.stage.stageHeight / 2 - 25, 50, 50);
    }
}
}