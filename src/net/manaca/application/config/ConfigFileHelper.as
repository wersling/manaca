package net.manaca.application.config
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import mx.core.ByteArrayAsset;

import net.manaca.errors.IllegalArgumentError;
import net.manaca.logging.Tracer;
public class ConfigFileHelper extends EventDispatcher
{
    public function ConfigFileHelper()
    {
        super();
    }
    
    public var config:XML;
    
    public function init(config:*):void
    {
        if(config is Class)
        {
            var clZ:Class = config as Class;
            var ba:ByteArrayAsset = ByteArrayAsset(new clZ()) ;
            config = new XML(ba.readUTFBytes(ba.length));
        }
        else if(config is XML)
        {
            config = XML(config);
        }
        else if(config is String && String(config).length > 0)
        {
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, 
                loaderConfig_completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, 
                loaderConfig_errorHandler);
            loader.load(new URLRequest(String(config)));
            Tracer.debug("start loading config file : " + config);
            return;
        }
        else
        {
            throw new IllegalArgumentError("invalid config argument:" + config);
        }
        dispatchEvent(new Event(Event.COMPLETE));
    }
    
    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function loaderConfig_completeHandler(event:Event):void
    {
        try
        {
            config = XML(event.target.data);
        }
        catch(error:Error)
        {
            trace("Config file error : " + error.toString());
        }
        dispatchEvent(new Event(Event.COMPLETE));
    }
    
    private function loaderConfig_errorHandler(event:IOErrorEvent):void
    {
        throw new IllegalArgumentError("load config file error:" + event);
    }
}
}