package org.jayliang.whaonjay.view.slidershow
{
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 *
 * @author v-jliang
 *
 */
public class IntervalSliderShowController extends AbstractSliderShowController
{
    //==========================================================================
    //  Class constants
    //==========================================================================
    protected static const CYCLE_TIME:int = 6000;
    //==========================================================================
    //  Constructor
    //==========================================================================
    public function IntervalSliderShowController(screen:SliderShowScreen)
    {
        super(screen);
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    protected var timer:Timer;

    //==========================================================================
    //  Protected methods
    //==========================================================================
    protected function startSlider():void
    {
        if (timer)
        {
            timer.addEventListener(TimerEvent.TIMER, timer_sliderHandler);
            timer.start();
        }
    }

    protected function stopSlider():void
    {
        if (timer)
        {
            timer.stop();
            timer.reset();
            timer.removeEventListener(TimerEvent.TIMER, timer_sliderHandler);
        }
    }

    //==========================================================================
    //  Overridden methods: TVController
    //==========================================================================
    override public function dispose():void
    {
        stopSlider();
        timer = null;

        super.dispose();
    }

    override public function initialize(xml:XML):void
    {
        super.initialize(xml);

        timer = new Timer(CYCLE_TIME);
    }

    override protected function fadeInComplete(event:Event = null):void
    {
        super.fadeInComplete();
        this.startSlider();
    }

    override public function showNext():void
    {
        super.showNext();
        stopSlider();
    }

    override public function showPrev():void
    {
        super.showPrev();
        stopSlider();
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    protected function timer_sliderHandler(event:TimerEvent):void
    {
        this.screen.nextBtn.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
    }
}
}