package org.jayliang.whaonjay.view.slidershow
{
import flash.display.Sprite;

public class SliderShowComponent extends Sprite
{
    //==========================================================================
    //  Constructor
    //==========================================================================
	public function SliderShowComponent()
	{
	    view = new SliderShowScreen();
        view.initialize(XML(null));
        this.addChild(view);
	}
	
	//==========================================================================
    //  Variables
    //==========================================================================
    private var view:SliderShowScreen;
}
}