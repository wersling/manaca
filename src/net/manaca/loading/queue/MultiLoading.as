package net.manaca.loading.queue
{
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.LoaderContext;

import net.manaca.errors.IllegalArgumentError;
import net.manaca.errors.UnsupportedOperationError;

/**
 * Dispatched when the loading completed.
 * @eventType net.manaca.loading.queue.LoadingEvent.COMPLETE
 */
[Event(name = "complete", type = "net.manaca.loading.queue.LoadingEvent")]

/**
 * Dispatched when the loading error.
 * @eventType net.manaca.loading.queue.LoadingEvent.ERROR
 */
[Event(name = "error", type = "net.manaca.loading.queue.LoadingEvent")]

/**
 * Dispatched when the loading update.
 * @eventType net.manaca.loading.queue.LoadingEvent.PROGRESS
 */
[Event(name = "progress", type = "net.manaca.loading.queue.LoadingEvent")]

/**
 * The LoadingQueue class that controls the download of multiple loaders.
 *
 * @example
 * <listing version = "3.0" >
package {
import net.manaca.loading.queue.LoadingEvent;
import net.manaca.loading.queue.LoadingQueue;

import flash.display.Sprite;
import flash.net.URLLoader;
public class LoadingQueueExample extends Sprite
{
private var web1:URLLoader;
private var web2:URLLoader;
public function LoadingQueueExample()
{
//create a LoadingQueue
var loader:LoadingQueue = new LoadingQueue();
//add events
loader.addEventListener(LoadingEvent.COMPLETE,completedHandler);
loader.addEventListener(LoadingEvent.UPDATE,updateHandler);
//add a swf url and add the return loader to secne
this.addChild(    loader.addSwfURL("http://beet-starterkit-demo.msn-int.com/./static/swf/1/fish.swf",20));
//add a image url and add the return loader to secne
this.addChild(    loader.addImageURL("http://beet-starterkit-demo.msn-int.com/static/i/1/maskNew.png",15));
//add two web page.
web1 =             loader.addXMLURL("http://www.msn.com",5);
web2 =             loader.addXMLURL("http://www.baidu.com",1);

//start loading queue.
loader.start();
}

private function completedHandler(event:LoadingEvent):void
{
trace("[loading completed!]");

//print web1 html data
trace(web1.data);
}

private function updateHandler(event:LoadingEvent):void
{
//print loading percent
trace("[loading percent]:" + event.target.percent)
}
}
}
 * </listing>
 * @author Sean Zou
 *
 */
//TODO document

public class MultiLoading extends EventDispatcher
{
    //==========================================================================
    //  Variables
    //==========================================================================

    private var list:Array = [];

    private var isRuning:Boolean;

    private var totalRate:Number;

    private var loadedCount:Number;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * LoadingQueue Constructor.
     */
    public function MultiLoading()
    {
        isRuning = false;
        totalRate = 0;
        loadedCount = 0;
        _percent = 0;
    }

    //==========================================================================
    //  Properties
    //==========================================================================

    private var _percent:Number;

    /**
     * The loading percent.
     * @return
     *
     */
    public function get percent():int
    {
        return _percent;
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * Add a image url to LoadingQueue.
     * @param url
     * @return
     *
     */
    public function addImageURL(url:String, rate:Number):Loader
    {
        checkAllowAdd(url, rate);

        var loader:Loader = new Loader();
        registerListeners(loader.contentLoaderInfo);
        var loadingInfo:LoadingInfo = new LoadingInfo(loader, new URLRequest(url), rate);
        list.push(loadingInfo);
        return loader;
    }

    /**
     * Add a swf url to LoadingQueue.
     * @param url
     * @param context
     * @return
     *
     */
    public function addSwfURL(url:String, rate:Number, context:LoaderContext = null):Loader
    {
        checkAllowAdd(url, rate);
        var loader:Loader = new Loader();
        registerListeners(loader.contentLoaderInfo);
        var loadingInfo:LoadingInfo = new LoadingInfo(loader, new URLRequest(url), rate);
        loadingInfo.context = context;
        list.push(loadingInfo);
        return loader;
    }

    /**
     * Add a XML url to LoadingQueue.
     * @param url
     * @return
     *
     */
    public function addXMLURL(url:String, rate:Number):URLLoader
    {
        checkAllowAdd(url, rate);
        var loader:URLLoader = new URLLoader();
        registerListeners(loader);
        var loadingInfo:LoadingInfo = new LoadingInfo(loader, new URLRequest(url), rate);
        list.push(loadingInfo);
        return loader;
    }

    /**
     * Start the loading queue.
     *
     */
    public function start():void
    {
        if(!this.isRuning)
        {
            isRuning = true;
            var loaderTotal:int = list.length;
            totalRate = 0;
            var loadingInfo:LoadingInfo;
            var currentLoader:*;
            for(var i:uint = 0 ;i < loaderTotal; i++ )
            {
                loadingInfo = list[i];
                currentLoader = loadingInfo.loader;
                totalRate += loadingInfo.rate;

                if(currentLoader is Loader)
                {
                    Loader(currentLoader).load(loadingInfo.urlRequest, loadingInfo.context);
                }
                else if(currentLoader is URLLoader)
                {
                    URLLoader(currentLoader).load(loadingInfo.urlRequest);
                }
            }
            if(loaderTotal == 0)
            {
                isRuning = false;
                _percent = 100;
                dispatchEvent(new LoadingEvent(LoadingEvent.COMPLETE));
            }
        }
    }

    /**
     * Stop all loading.
     *
     */
    public function stop():void
    {
        if(this.isRuning)
        {
            for each(var loadingInfo:LoadingInfo in list)
            {
                try
                {
                    if(loadingInfo.loader is Loader)
                    {
                        Loader(loadingInfo.loader).close();
                    }
                    else if(loadingInfo.loader is URLLoader)
                    {
                        URLLoader(loadingInfo.loader).close();
                    }
                }
                catch(error:Error)
                {
                }
            }

            isRuning = false;
        }
    }

    /**
     *
     *
     */
    public function dispose():void
    {
        for each(var loadingInfo:LoadingInfo in list)
        {
            try
            {
                if(loadingInfo.loader is Loader)
                {
                    Loader(loadingInfo.loader).close();
                }
                    else if(loadingInfo.loader is URLLoader)
                {
                    URLLoader(loadingInfo.loader).close();
                }
            }
            catch(error:Error)
            {
            }

            if(loadingInfo.loader is Loader)
            {
                removeListeners(Loader(loadingInfo.loader).contentLoaderInfo);
            }
            else if(loadingInfo.loader is URLLoader)
            {
                removeListeners(URLLoader(loadingInfo.loader));
            }
            loadingInfo.dispose();
        }

        list = null;
    }

    private function checkAllowAdd(url:String, rate:Number):void
    {
        /* check is runing, if true, return flase. */
        if(this.isRuning)
        {
            throw new UnsupportedOperationError("The Loading queue is strat!");
        }
        /* check url is availability */
        if(url == null || url.length == 0)
        {
            throw new IllegalArgumentError("invalid \"url\" value:" + url);
        }

        if(rate <= 0)
        {
            throw new IllegalArgumentError("invalid \"rate\" value:" + url + ", the value must > 0");
        }
    }

    /**
     * Register the events of the <code>AbstractLoader</code>.
     * @see #removeListeners()
     */
    private function registerListeners(eventDispatcher:EventDispatcher):void
    {
        eventDispatcher.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        eventDispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
        eventDispatcher.addEventListener(ProgressEvent.PROGRESS, updateHandler);
        eventDispatcher.addEventListener(Event.COMPLETE, completeHandler);
    }

    /**
     * Remove the events of the <code>AbstractLoader</code>.
     * @see #registerListeners()
     */
    private function removeListeners(eventDispatcher:EventDispatcher):void
    {
        eventDispatcher.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        eventDispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
        eventDispatcher.removeEventListener(ProgressEvent.PROGRESS, updateHandler);
        eventDispatcher.removeEventListener(Event.COMPLETE, completeHandler);
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    /**
     * Distributes loader update event.
     * @param event
     *
     */
    private function updateHandler(event:ProgressEvent):void
    {
        var rate:Number = 0;
        for each(var loadingInfo:LoadingInfo in list)
        {
            if(loadingInfo.loader is URLLoader)
            {
                if(URLLoader(loadingInfo.loader).bytesTotal > 0)
                {
                    rate += (URLLoader(loadingInfo.loader).bytesLoaded /
                        URLLoader(loadingInfo.loader).bytesTotal) * loadingInfo.rate;
                }
            }
            else if(loadingInfo.loader is Loader)
            {
                if(Loader(loadingInfo.loader).contentLoaderInfo.bytesTotal > 0)
                {
                    rate += (Loader(loadingInfo.loader).contentLoaderInfo.bytesLoaded /
                        Loader(loadingInfo.loader).contentLoaderInfo.bytesTotal) * loadingInfo.rate;
                }
            }
        }
        _percent = rate / totalRate * 100;
        var evt:LoadingEvent = new LoadingEvent(LoadingEvent.PROGRESS);
        evt.percent = _percent;
        this.dispatchEvent(evt);
    }

    /**
     * Distributes loader finish event.
     * @param event
     *
     */
    private function completeHandler(event:Event):void
    {
        loadedCount++;
        if(loadedCount == list.length)
        {
            isRuning = false;
            _percent = 100;
            this.dispatchEvent(new LoadingEvent(LoadingEvent.COMPLETE));
        }
    }

    /**
     * Distributes loader error event.
     * @param event
     *
     */
    private function errorHandler(event:Event):void
    {
        if(this.willTrigger(LoadingEvent.ERROR))
        {
            var evt:LoadingEvent = new LoadingEvent(LoadingEvent.ERROR);
            evt.error = event;
            this.dispatchEvent(evt);
        }
        else
        {
            throw new Error("Unhandled LoadingEvent:" + event.toString(), 2044);
        }
    }
}
}