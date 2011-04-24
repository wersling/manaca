package net.manaca.preloaders
{
import flash.display.Shape;
import flash.events.Event;
import flash.filters.DropShadowFilter;

/**
 * The SimplePreloader provide a had loading bar preloader.
 * @author v-seanzo
 * 
 */    
public class SimplePreloader extends PreloaderBase
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private const barWidth:uint = 160;
    private const barHeight:uint = 12;

    private var loadingBar:Shape;

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a new <code>SimplePreloader</code> instance.
     * 
     */
    public function SimplePreloader()
    {
        super();
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    override protected function initDisplay():void
    {
        loadingBar = new Shape();
        loadingBar.filters = [ new DropShadowFilter(3, 45, 0, 0.5, 3, 3) ];
        addChild(loadingBar);
        
        stage.addEventListener(Event.RESIZE, resizeHandler);
        resizeHandler(null);
    }

    override protected function initialize():void
    {
        stage.removeEventListener(Event.RESIZE, resizeHandler);
        this.removeChild(loadingBar);
        loadingBar = null;
        
        super.initialize();
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================

    override protected function enterFrameHandler(event:Event):void
    {
        if(loadingBar)
        {
            loadingBar.graphics.clear();
            loadingBar.graphics.beginFill(0xFFFFFF);
            loadingBar.graphics.drawRect(0, 0, barWidth, barHeight);
            loadingBar.graphics.beginFill(0x999999);
            loadingBar.graphics.drawRect(1, 1, barWidth - 2, barHeight - 2);
            loadingBar.graphics.beginFill(0x000000);
            loadingBar.graphics.drawRect(1, 1, (loaderInfo.bytesLoaded / loaderInfo.bytesTotal) * (barWidth - 2), barHeight - 2);
        }
        super.enterFrameHandler(event);
    }

    private function resizeHandler(event:Event):void
    {
        if(loadingBar)
        {
            loadingBar.x = int((stage.stageWidth - barWidth) / 2);
            loadingBar.y = int((stage.stageHeight - barHeight) / 2);
        }
    }
}
}