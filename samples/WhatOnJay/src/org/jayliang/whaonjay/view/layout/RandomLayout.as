package org.jayliang.whaonjay.view.layout
{
import flash.display.DisplayObject;

public class RandomLayout extends AbstractLayout
{
	public function RandomLayout()
	{
	}
	
	protected var minX:Number = 100;
	protected var maxX:Number = 700;
	
    protected var minY:Number = 80;
	protected var maxY:Number = 570;
    
    override public function appendChild(child:DisplayObject):void
    {
    	var tempX:Number = minX + Math.random() * (maxX- minX);
    	var tempY:Number = minY + Math.random() * (maxY- minY);
    	child.x = tempX;
    	child.y = tempY;
    }
	
	override public function refresh():void
	{
		for (var i:int = 0; i < container.numChildren; i++)
		{
			var child:DisplayObject = container.getChildAt(i);
			var tempX:Number = minX + Math.random() * (maxX- minX);
	        var tempY:Number = minY + Math.random() * (maxY- minY);
	        child.x = tempX;
	        child.y = tempY;
		}
	}
}
}