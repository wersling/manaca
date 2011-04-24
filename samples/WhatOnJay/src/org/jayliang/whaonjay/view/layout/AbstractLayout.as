package org.jayliang.whaonjay.view.layout
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;

public class AbstractLayout extends EventDispatcher implements ILayout
{
	public function AbstractLayout()
	{
		
	}
	
	protected var container:DisplayObjectContainer;
	
	public function setContainer(container:DisplayObjectContainer):void
	{
		this.container = container;
	}
	
	public function appendChild(child:DisplayObject):void
	{		
	}
	
	public function layout(...args):void
	{
	}
	
	public function refresh():void
	{		
	}
}
}