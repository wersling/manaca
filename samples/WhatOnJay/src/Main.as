package
{
import flash.display.Sprite;
import flash.events.Event;

import org.jayliang.whaonjay.core.AppConfiguration;
import org.jayliang.whaonjay.core.ComponentContainer;
import org.jayliang.whaonjay.core.ModuleManager;
import org.jayliang.whaonjay.events.ComponentEvent;
import org.jayliang.whaonjay.view.layout.RandomLayout;

//[Frame(factoryClass = "Preloader")]
[SWF(width=1024, height=768, backgroundColor=0x000000, frameRate = 35)]
public class Main extends Sprite
{
	public function Main()
	{
        setupEventListener();
        init();
	}
	
	private var configuration:AppConfiguration;
	private var moduleManager:ModuleManager;
	private var componentContainer:ComponentContainer;
	
	private function init():void
	{
        componentContainer = new ComponentContainer(1024, 768);
        this.addChild(componentContainer);
        
        configuration = new AppConfiguration();		
        configuration.addEventListener(Event.COMPLETE, configReadyHandler);
        configuration.init();
	}
	
	private function setupEventListener():void
	{
	    this.addEventListener(ComponentEvent.SHOW, showComponentHandler);
	    this.addEventListener(ComponentEvent.CLOSE, closeComponentHandler);
	}	
	
	private function configReadyHandler(event:Event):void
	{
		moduleManager = new ModuleManager();
		moduleManager.layoutClass = RandomLayout;
		moduleManager.init(configuration.list, this);
		configuration.removeEventListener(Event.COMPLETE, configReadyHandler);
		configuration = null;
	}
	
	private function showComponentHandler(event:ComponentEvent):void
	{
	    componentContainer.show(event.component);
	}
    
    private function closeComponentHandler(event:ComponentEvent):void
    {
        componentContainer.close();
    }
}
}