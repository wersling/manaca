package org.jayliang.whaonjay.core
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

import org.jayliang.whaonjay.data.ConfigVO;

public class AppConfiguration extends EventDispatcher
{
	private static const CONFIG_URL:String = "AppConfig.xml";
	
	public function AppConfiguration()
	{
	}
	
	private var loader:URLLoader;
	
	private var _list:Array = []; /* ConfigVO */

	public function get list():Array
	{
		return _list;
	}
	
	public function init():void
	{
		loader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, configLoadedHandler);
		loader.load(new URLRequest(CONFIG_URL));
	}
	
	private function configLoadedHandler(event:Event):void
	{
		loader.removeEventListener(Event.COMPLETE, configLoadedHandler);
		var config:XML = XML(loader.data);
		for (var i:int = 0; i < config..module.length(); i++)
		{
		    var vo:ConfigVO = new ConfigVO();
		    vo.domain = config..module[i].@domain;
		    vo.src = config..module[i].@src;
			list.push(vo);
		}
		loader = null;
		this.dispatchEvent(new Event(Event.COMPLETE));
	}
}
}