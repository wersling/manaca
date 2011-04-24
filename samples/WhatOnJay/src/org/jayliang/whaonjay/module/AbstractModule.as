package org.jayliang.whaonjay.module
{
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

import org.jayliang.whaonjay.events.ComponentEvent;

public class AbstractModule extends Sprite implements IModule
{
	public function AbstractModule()
	{
		super();
	}
	
	protected var baseDomain:String;
	protected var showStage:DisplayObjectContainer;
	protected var configLoader:URLLoader;
	protected var config:XML;
	protected var thumbLoader:Loader;
	
	public function initialize(showStage:DisplayObjectContainer, 
	                           baseDomain:String):void
	{
	   this.showStage = showStage;
	   this.baseDomain = baseDomain;
	   configLoader = new URLLoader();
	   configLoader.addEventListener(Event.COMPLETE, configLoadedHandler);
	   configLoader.load(new URLRequest(baseDomain + "ModuleConfig.xml"));
	}
	
	public function show():void
	{
		
	}
    
    public function close():void
    {
    	this.dispatchEvent(new ComponentEvent(ComponentEvent.CLOSE, null, true));
    }
    
    protected function configLoadedHandler(event:Event):void
    {
        config = XML(configLoader.data);
        configLoader.removeEventListener(Event.COMPLETE, configLoadedHandler);
        configLoader = null;
        
        thumbLoader = new Loader();
        this.addChild(thumbLoader);
        thumbLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbLoadedHandler);
        thumbLoader.load(new URLRequest(config.@thumbUrl));
    }
    
    protected function thumbLoadedHandler(event:Event):void
    {
        thumbLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, thumbLoadedHandler);
    }
}
}