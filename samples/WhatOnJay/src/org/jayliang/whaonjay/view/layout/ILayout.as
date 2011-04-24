package org.jayliang.whaonjay.view.layout
{

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

public interface ILayout
{
	function setContainer(container:DisplayObjectContainer):void;
	
	function appendChild(child:DisplayObject):void;
	
	function layout(...args):void;
	
	function refresh():void;
}
}