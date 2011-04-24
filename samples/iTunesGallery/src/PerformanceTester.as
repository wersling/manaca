package
{
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;

[SWF(width='1200', height='600',frameRate='24', backgroundColor='#000000')]

public class PerformanceTester extends Sprite
{

    [Embed("2.jpg")]
    private var imgClz:Class;

    /**
     *
     *
     */
    public function PerformanceTester()
    {
        super();
        initDisplay();

        this.addEventListener(Event.ENTER_FRAME, onEnter);
    }

    private function initDisplay():void
    {
        for(var i:uint = 0 ;i < 12; i++ )
        {
            var img:DisplayObject = new imgClz();
            img.cacheAsBitmap = true;
            img.name = "img" + i;
            img.x = 200 + i * 50;
            img.y = 130;
            this.addChild(img);
        }
    }

    private function onEnter(e:Event):void
    {
        for(var i:uint = 0 ;i < 12; i++ )
        {
            var img:DisplayObject = this.getChildByName("img" + i);
            img.rotationY += 1;
        }
    }
}
}