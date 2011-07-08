package net.manaca.application.config
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import mx.core.ByteArrayAsset;

import net.manaca.errors.IllegalArgumentError;
/**
 * 
 * @author sean
 * 
 */
public class ConfigFileHelper extends EventDispatcher
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>ConfigFileHelper</code>实例.
     * 
     */
    public function ConfigFileHelper()
    {
        super();
    }
    //==========================================================================
    //  Properties
    //==========================================================================
    public var configXML:XML;
    //==========================================================================
    //  Methods
    //==========================================================================
    public function init(config:*):void
    {
        if(config is Class)
        {
            var clZ:Class = config as Class;
            var ba:ByteArrayAsset = ByteArrayAsset(new clZ()) ;
            configXML = new XML(ba.readUTFBytes(ba.length));
        }
        else if(config is XML)
        {
            configXML = XML(config);
        }
        else if(config is String && String(config).length > 0)
        {
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, 
                loaderConfig_completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, 
                loaderConfig_errorHandler);
            loader.load(new URLRequest(String(config)));
            trace("start loading config file : " + config);
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
        var loader:URLLoader = URLLoader(event.currentTarget);
        loader.removeEventListener(Event.COMPLETE, 
            loaderConfig_completeHandler);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, 
            loaderConfig_errorHandler);
        
        configXML = XML(event.target.data);
        
        dispatchEvent(new Event(Event.COMPLETE));
    }
    
    private function loaderConfig_errorHandler(event:IOErrorEvent):void
    {
        throw new IllegalArgumentError("load config file error:" + event);
    }
}
}