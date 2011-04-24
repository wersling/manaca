package org.jayliang.whaonjay.view.slidershow
{
import assets.whatonjay.SliderShowItemAsset;

import flash.events.Event;
import flash.events.MouseEvent;

import org.jayliang.whaonjay.utils.URLUtils;

/**
 * TVScreen
 * @author v-jliang
 *
 */
public class SliderShowScreen extends SliderShowItemAsset
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    public function SliderShowScreen()
    {
        super();
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    private var controller:AbstractSliderShowController;
    private var link:String;
    //==========================================================================
    //  Private methods
    //==========================================================================
    public function initialize(feed:XML):void
    {
        link = feed.@link;
        
        controller = new IntervalSliderShowController(this);
        controller.container = this.bg;
        controller.addEventListener(Event.COMPLETE, allLoadComplete);
        controller.initialize(feed);
        
        prevBtn.buttonMode = true;
        prevBtn.useHandCursor = true;

        nextBtn.buttonMode = true;
        nextBtn.useHandCursor = true;
        
        closeBtn.buttonMode = true;
        closeBtn.useHandCursor = true;
        
        visitBtn.addEventListener(MouseEvent.CLICK, visitHandler);

        initListener();
    }

    public function activeControl():void
    {
        closeBtn.addEventListener(MouseEvent.CLICK, closeHandler);
        prevBtn.addEventListener(MouseEvent.CLICK,
                                            sliderPrevMedia);
        nextBtn.addEventListener(MouseEvent.CLICK,
                                            sliderNextMedia);
    }

    public function unactiveControl():void
    {
        closeBtn.removeEventListener(MouseEvent.CLICK, closeHandler);
        prevBtn.removeEventListener(MouseEvent.CLICK,
                                               sliderPrevMedia);
        nextBtn.removeEventListener(MouseEvent.CLICK,
                                               sliderNextMedia);
    }

    public function dispose():void
    {
        clearListener();
        visitBtn.removeEventListener(MouseEvent.CLICK, visitHandler);

        controller.removeEventListener(Event.COMPLETE, allLoadComplete);
        controller.dispose();
        controller = null;
    }
    //==========================================================================
    //  Private methods
    //==========================================================================
    private function initListener():void
    {
        activeControl();
    }

    private function clearListener():void
    {
        unactiveControl();
    }

    private function allLoadComplete(event:Event):void
    {
        controller.removeEventListener(Event.COMPLETE, allLoadComplete);

        this.visible = true;
        controller.showNext();
    }

    protected function sliderPrevMedia(event:MouseEvent):void
    {
        controller.showPrev();
    }

    protected function sliderNextMedia(event:MouseEvent):void
    {
        controller.showNext();
    }

    protected function closeHandler(event:MouseEvent):void
    {
        this.dispatchEvent(new SliderShowEvent(SliderShowEvent.CLOSE));
    }

    protected function visitHandler(event:MouseEvent):void
    {
        URLUtils.openWindow(link);
    }

}
}