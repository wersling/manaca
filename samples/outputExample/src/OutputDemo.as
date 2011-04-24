package
{
import com.hexagonstar.util.debug.Debug;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.external.ExternalInterface;
import flash.system.Capabilities;

import net.manaca.application.BaseApplication;
import net.manaca.logging.Tracer;
import net.manaca.logging.publishers.AlconPublisher;
import net.manaca.logging.publishers.LongingPublisher;
import net.manaca.logging.publishers.Output;
import net.manaca.logging.publishers.TracePublisher;

/**
 *
 * @author Sean
 *
 */
[Frame(factoryClass="net.manaca.preloaders.SimplePreloader")]

[SWF(frameRate="40")]

public class OutputDemo extends BaseApplication
{
    public function OutputDemo()
    {
    }

    override protected function startup():void
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        Tracer.logger.addPublisher(new AlconPublisher());
        Tracer.logger.addPublisher(new TracePublisher());
        Tracer.logger.addPublisher(new LongingPublisher());
        var output:Output = new Output(150, true);

        this.addChild(output);

        Debug.fpsStart(this.stage);

        //this.addEventListener(Event.ENTER_FRAME, enterHandler);
        this.stage.addEventListener(MouseEvent.CLICK, gc);

        Debug.timerStart("timer");

        Tracer.debug("debug");
        Tracer.info("info");
        Tracer.warn("warn");
        Tracer.error("error");
        Tracer.fatal("fatal");
        Tracer.info(Capabilities.os);
        if(ExternalInterface.available)
        {
            Tracer.info(ExternalInterface.call("function getBrowser(){return navigator.userAgent;}"));
        }
        Tracer.info(unescape(Capabilities.serverString));
    }

    private function gc(e:Event):void
    {
        Debug.forceGC();
        Debug.timerStop();
        Debug.timerToString();
        Debug.fpsStart(this.stage);
    }

    private function enterHandler(e:Event):void
    {
        Tracer.fatal("fatal");
        var obj:Sprite = new Sprite();
        obj.graphics.beginFill(0, 0.2);
        obj.graphics.drawRect(0, 0, 10, 10);
        this.addChild(obj);
    }
}
}
