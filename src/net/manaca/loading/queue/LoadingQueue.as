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
public class LoadingQueue extends EventDispatcher
{
    //==========================================================================
    //  Variables
    //==========================================================================

    private var queue:Array = [];

    private var isRuning:Boolean;

    private var totalRate:Number;

    private var loadedRate:Number;

    private var currentLoadingInfo:LoadingInfo;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * LoadingQueue Constructor.
     */
    public function LoadingQueue()
    {
        isRuning = false;
        totalRate = 0;
        loadedRate = 0;
        currentLoadingInfo = null;
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
        queue.push(loadingInfo);
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
        queue.push(loadingInfo);
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
        queue.push(loadingInfo);
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
            var loaderTotal:int = queue.length;
            totalRate = 0;
            for(var i:uint = 0 ;i < loaderTotal; i++ )
            {
                totalRate += queue[i].rate;
            }
            loadNextFile();
        }
    }

    /**
     * Stop all loading.
     *
     */
    public function stop():void
    {
        if(this.isRuning && currentLoadingInfo)
        {
            try
            {
                if(currentLoadingInfo.loader is Loader)
                {
                    Loader(currentLoadingInfo.loader).close();
                }
                else if(currentLoadingInfo.loader is URLLoader)
                {
                    URLLoader(currentLoadingInfo.loader).close();
                }
                currentLoadingInfo.dispose();
                currentLoadingInfo = null;
            }
            catch(error:Error)
            {
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
        for each(var info:LoadingInfo in queue)
        {
            if(info.loader is Loader)
            {
                removeListeners(Loader(info.loader).contentLoaderInfo);
            }
            else if(info.loader is URLLoader)
            {
                removeListeners(URLLoader(info.loader));
            }
            info.dispose();
        }
        queue = null;
    }

    /**
     *
     *
     */
    private function loadNextFile():void
    {
        if(currentLoadingInfo)
        {
            currentLoadingInfo.dispose();
            currentLoadingInfo = null;
        }

        /* if the queue lenght > 0 */
        if(queue.length > 0)
        {
            currentLoadingInfo = queue.shift() as LoadingInfo;
            /* set the current loader value */
            var currentLoader:Object = currentLoadingInfo.loader;
            /* check the currentLoader type */
            if(currentLoader is Loader)
            {
                Loader(currentLoader).load(currentLoadingInfo.urlRequest, currentLoadingInfo.context);
            }
            else if(currentLoader is URLLoader)
            {
                URLLoader(currentLoader).load(currentLoadingInfo.urlRequest);
            }
        }
        else
        {
            isRuning = false;
            _percent = 100;
            this.dispatchEvent(new LoadingEvent(LoadingEvent.COMPLETE));
        }
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
        _percent = (loadedRate + (event.bytesLoaded / event.bytesTotal) * currentLoadingInfo.rate) / totalRate * 100;

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
        loadedRate += currentLoadingInfo.rate;
        /* update percent */
        _percent = loadedRate / totalRate * 100;
        /* remove event linstener */
        if(currentLoadingInfo.loader is Loader)
        {
            removeListeners(Loader(currentLoadingInfo.loader).contentLoaderInfo);
        }
        else if(currentLoadingInfo.loader is URLLoader)
        {
            removeListeners(URLLoader(currentLoadingInfo.loader));
        }

        this.dispatchEvent(new LoadingEvent(LoadingEvent.PROGRESS));
        /* load next file */
        loadNextFile();
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