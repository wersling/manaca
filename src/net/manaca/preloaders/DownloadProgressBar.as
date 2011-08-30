package net.manaca.preloaders
{
import flash.display.GradientType;
import flash.display.Shape;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;

public class DownloadProgressBar extends Sprite implements IPreloaderDisplay
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    static private const BAR_WIDTH:int = 200;
    static private const BAR_HEIGHT:int = 12;
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>DownloadProgressBar</code>实例.
     * 
     */
    public function DownloadProgressBar()
    {
        super();
        
        initDisplay();
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var progressBar:Shape;
    //==========================================================================
    //  Methods
    //==========================================================================
    private function initDisplay():void
    {
        progressBar = new Shape();
        addChild(progressBar);
        
        updateProgress(0);
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }
    
    public function updateProgress(percent:uint):void
    {
        progressBar.graphics.clear();
        progressBar.graphics.beginFill(0x999999, 1);
        progressBar.graphics.drawRect(0, 0, BAR_WIDTH, BAR_HEIGHT);
        progressBar.graphics.drawRect(1, 1, BAR_WIDTH - 2, BAR_HEIGHT - 2);
        
        var gradientMatrix:Matrix = new Matrix();
        gradientMatrix.createGradientBox(20, 20, Math.PI / 2, 0, 0);
        progressBar.graphics.beginGradientFill(
            GradientType.LINEAR,
            [0x666666, 0x202020],
            [1, 1],
            [0x00, 0xFF],
            gradientMatrix,
            SpreadMethod.PAD);
        progressBar.graphics.drawRect(1, 1, 
            (BAR_WIDTH - 2) * percent / 100, BAR_HEIGHT - 2);
    }
    
    public function showLoadingInfo(info:String):void
    {
    }
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    protected function addedToStageHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageHandler);
        stage.addEventListener(Event.RESIZE, resizeHandler);
        resizeHandler(null);
        
    }
    
    protected function removeFromStageHandler(event:Event):void
    {
        removeEventListener(Event.REMOVED_FROM_STAGE, addedToStageHandler);
        stage.removeEventListener(Event.RESIZE, resizeHandler);
    }
    
    protected function resizeHandler(event:Event):void
    {
        if(progressBar && stage.stageWidth)
        {
            progressBar.x = int((stage.stageWidth - progressBar.width)/2);
            progressBar.y = int((stage.stageHeight - progressBar.height)/2);
        }
    }
}
}