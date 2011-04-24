package org.jayliang.whaonjay.view
{
import assets.whatonjay.ModuleFrameAsset;
import assets.whatonjay.ModulePreloader;

import com.gskinner.motion.GTween;

import fl.motion.easing.Elastic;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.ProgressEvent;
import flash.geom.Rectangle;

import org.jayliang.whaonjay.data.ConfigVO;
import org.jayliang.whaonjay.module.IModule;

public class ModuleFrame extends ModuleFrameAsset
{
	public function ModuleFrame(showStage:DisplayObjectContainer)
	{
		this.showStage = showStage;
		init();
	}
	
	private var showStage:DisplayObjectContainer;
	private var loader:Loader;
	private var progressor:ModulePreloader;
	private var rect:Rectangle;
	private var module:IModule;
	private var tween:GTween;
	
	private var _configVO:ConfigVO;

	public function get configVO():ConfigVO
	{
	    return _configVO;
	}

	public function set configVO(v:ConfigVO):void
	{
	    _configVO = v;
	}

	
	public function addLoader(loader:Loader):void
	{
		this.loader = loader;
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,
		                                          moduleProgressHandler);
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
                                                  moduleLoadedHandler);
	}
	
	private function init():void
	{
		rect = new Rectangle(0, -header.height, header.width, header.height + hotArea.height);
		
		header.y = 0;
        header.visible = false;
		
		hotArea.useHandCursor = true;
		hotArea.buttonMode = true;
		
		hotArea.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
		hotArea.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		
		header.useHandCursor = true;
		header.buttonMode = true;		
		header.addEventListener(MouseEvent.MOUSE_UP, header_mouseUpHandler);
		header.addEventListener(MouseEvent.MOUSE_DOWN, header_mouseDownHandler);
		
		progressor = ModulePreloader(this.preloader);
	}
    
    private function moduleProgressHandler(event:ProgressEvent):void
    {
    	var pect:Number = Math.round(100 * event.bytesLoaded / event.bytesTotal);
        progressor.info.text = pect.toString();
    }
    
    private function moduleLoadedHandler(event:Event):void
    {
        loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,
                                                     moduleProgressHandler);
        loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, 
                                                     moduleLoadedHandler);
        preloader.visible = false;
        module = loader.content as IModule;
        this.addChildAt(DisplayObject(module), this.getChildIndex(hotArea) - 1);
        DisplayObject(module).x = 3;
        DisplayObject(module).y = 3;
        module.initialize(showStage, _configVO.domain);
        this.hotArea.addEventListener(MouseEvent.CLICK, clickHandler);
    }
    
    private function rollOverHandler(event:MouseEvent):void
    {
        header.visible = true;
        if (tween) tween.pause();
        tween = new GTween(header, 0.3, {y:- header.height}, Elastic.easeIn);
    }
    
    private function rollOutHandler(event:MouseEvent):void
    {
    	this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
    }
    
    private function header_mouseUpHandler(event:MouseEvent):void
    {
        this.stopDrag();
    }
    
    private function header_mouseDownHandler(event:MouseEvent):void
    {
        this.parent.addChild(this);
        this.startDrag();
    }
    
    private function clickHandler(event:MouseEvent):void
    {
        module.show();
    }
    
    private function enterFrameHandler(event:Event):void
    {    	
    	if (!rect.contains(mouseX, mouseY))
    	{
    		this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
    		if (tween) tween.pause();
            tween = new GTween(header, 0.3, {y:0}, Elastic.easeIn);
            tween.addEventListener(Event.COMPLETE, function():void { header.visible = false; });
    	}
    }
}
}