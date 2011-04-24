package org.jayliang.whaonjay.module
{
import flash.events.Event;

import org.jayliang.whaonjay.events.ComponentEvent;
import org.jayliang.whaonjay.module.AbstractModule;
import org.jayliang.whaonjay.view.slidershow.SliderShowEvent;
import org.jayliang.whaonjay.view.slidershow.SliderShowScreen;

public class SliderShowModule extends AbstractModule
{
    public function SliderShowModule()
    {
        super();
    }
    
    private var sliderShow:SliderShowScreen;
    
    override public function show():void
    {
        if (!sliderShow)
        {
            sliderShow = new SliderShowScreen();            
            sliderShow.initialize(XML(config));
        } 
        sliderShow.addEventListener(SliderShowEvent.CLOSE, closeSliderShow);       
        this.dispatchEvent(new ComponentEvent(ComponentEvent.SHOW, sliderShow, true));
    }
    
    private function closeSliderShow(event:Event):void
    {
        sliderShow.removeEventListener(SliderShowEvent.CLOSE, closeSliderShow);
        this.dispatchEvent(new ComponentEvent(ComponentEvent.CLOSE, null, true));
        sliderShow.dispose();
        sliderShow = null;
    }
}
}