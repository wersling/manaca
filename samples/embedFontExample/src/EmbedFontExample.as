package
{
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;

import net.manaca.managers.FontManager;

public class EmbedFontExample extends Sprite
{
    public function EmbedFontExample()
    {
        loadingFont();
    }

    private function loadingFont():void
    {
        FontManager.getInstance().addEventListener(Event.COMPLETE, loadedHandler);
        FontManager.getInstance().loadFontFile("GraCoBd.swf");
    }

    private function loadedHandler(event:Event):void
    {
        var text:TextField = new TextField();
        FontManager.setText(text, "Font Example?", "GraCoBd");
        this.addChild(text);
    }
}
}