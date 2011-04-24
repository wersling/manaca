package net.manaca.loading.queue
{
import flash.display.Loader;
import flash.net.URLLoader;
import flash.system.LoaderContext;

public interface ILoading
{
    //==========================================================================
    //  Properties
    //==========================================================================
    function get percent():int;

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Add a image url to LoadingQueue.
     * @param url
     * @param rate
     * @return 
     * 
     */        
    function addImageURL(url:String, rate:Number):Loader;

    /**
     * Add a swf url to LoadingQueue.
     * @param url
     * @param rate
     * @param context
     * @return 
     * 
     */        
    function addSwfURL(url:String, rate:Number, context:LoaderContext = null):Loader;

    
    /**
     * Add a xml url to LoadingQueue.
     * @param url
     * @param rate
     * @return 
     * 
     */        
    function addXMLURL(url:String, rate:Number):URLLoader;

    function start():void;

    function stop():void;

    function dispose():void;
}
}