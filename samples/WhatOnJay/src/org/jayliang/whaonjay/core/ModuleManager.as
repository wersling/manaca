package org.jayliang.whaonjay.core
{
import flash.display.DisplayObjectContainer;
import flash.display.Loader;
import flash.events.EventDispatcher;
import flash.net.URLRequest;

import org.jayliang.whaonjay.data.ConfigVO;
import org.jayliang.whaonjay.view.ModuleFrame;
import org.jayliang.whaonjay.view.layout.ILayout;

public class ModuleManager extends EventDispatcher
{
	public function ModuleManager()
	{
		
	}
	
	private var modules:Array = [];
	
	private var layoutRef:Class;

	public function set layoutClass(v:Class):void
	{
		layoutRef = v;
	}
	
	public function init(vos:Array, stage:DisplayObjectContainer):void
	{
		var layout:ILayout = new layoutRef() as ILayout;
		for each (var vo:ConfigVO in vos)
		{
			var frame:ModuleFrame = new ModuleFrame(stage);
			frame.configVO = vo;
			stage.addChildAt(frame, 0);
			layout.appendChild(frame);
			var loader:Loader = new Loader();
			frame.addLoader(loader);
		    loader.load(new URLRequest(vo.domain + vo.src));
		    		    
		    modules.push(frame);
		}
		layout.layout();
	}
}
}