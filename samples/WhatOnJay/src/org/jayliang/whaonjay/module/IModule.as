package org.jayliang.whaonjay.module
{
import flash.display.DisplayObjectContainer;

public interface IModule
{
	function initialize(showStage:DisplayObjectContainer, baseDomain:String):void;
	
	function show():void;
	
	function close():void;
}
}