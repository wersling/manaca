package net.manaca.application.config
{
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import net.manaca.application.Bootstrap;
import net.manaca.errors.IllegalArgumentError;
import net.manaca.loaderqueue.ILoaderAdapter;
import net.manaca.loaderqueue.LoaderProgress;
import net.manaca.loaderqueue.LoaderQueue;
import net.manaca.loaderqueue.adapter.LoaderAdapter;
import net.manaca.loaderqueue.adapter.URLLoaderAdapter;
import net.manaca.loaderqueue.adapter.URLStreamAdapter;
import net.manaca.logging.Tracer;
import net.manaca.modules.ModuleVO;
import net.manaca.utils.URLUtils;

/**
 * 任务队列总进度更新时派发
 * @eventType flash.events.Event.CHANGE
 */
[Event(name="change", type="flash.events.Event")]
/**
 * 任务队列完成时派发
 * @eventType flash.events.Event.COMPLETE
 */
[Event(name="complete", type="flash.events.Event")]

/**
 * The FilePreloadConfiguration loading the files by xml files node.
 * You can get these files in externalFiles map.
 * @author Sean Zou
 *
 */
public class FilePreloadingHelper extends EventDispatcher
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>FilePreloadConfiguration</code> instance.
     * @param filesXML the files list.
     *
     */
    public function FilePreloadingHelper(filesXML:XMLList, 
                                         modules:Vector.<ModuleVO>)
    {
        super();
        
        if(filesXML != null)
        {
            this.filesXML = filesXML;
        }
        else
        {
            throw new IllegalArgumentError("invalid info argument:" + filesXML);
        }
        
        this.modules = modules;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var filesXML:XMLList;
    private var modules:Vector.<ModuleVO>;
    private var loaderProgressCounter:LoaderProgress;
    public var files:Dictionary;
    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  percentage
    //----------------------------------
    /**
     * The files loading percentage.
     * @return
     *
     */
    public function get percentage():uint
    {
        return loaderProgressCounter ? 
            int(loaderProgressCounter.totalProgress * 100): 0;
    }

    //----------------------------------
    //  externalFiles
    //----------------------------------
    /**
     * Get the preload files map.
     * @return
     *
     */
    public function get preloadFiles():Dictionary
    {
        return files;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * Start loading all files.
     */
    public function start():void
    {
        files = new Dictionary();

        var loadingQueue:LoaderQueue = Bootstrap.getInstance().loaderQueue;
        loaderProgressCounter =  new LoaderProgress();
        addEventListeners();
        for each(var file:XML in filesXML)
        {
            var loader:ILoaderAdapter = null;
            var url:String = String(file.@url);
            
            if(String(file.@clearCache) == "true")
            {
                url = URLUtils.clearCacheUrl(url);
            }
            
            switch(String(file.@type))
            {
                case FileTypeInfo.IMAGE:
                {
                    loader = new LoaderAdapter(1, new URLRequest(url));
                    break;
                }
                case FileTypeInfo.SWF:
                {
                    loader = new LoaderAdapter(1, new URLRequest(url));
                    break;
                }
                case FileTypeInfo.XML:
                {
                    loader = new URLLoaderAdapter(1, new URLRequest(url));
                    break;
                }
                default:
                {
                    loader = new URLStreamAdapter(1, new URLRequest(url));
                    break;
                }
            }
            if(loader)
            {
                files[String(file.@name)] = loader;
                loadingQueue.addItem(loader);
                loaderProgressCounter.addItem(loader);
            }
            Tracer.debug("Start loading file:" + [file.@name, url]);
        }
        
        for each(var moduleVO:ModuleVO in modules)
        {
            if(moduleVO.preloading)
            {
                loader = new URLStreamAdapter(1, new URLRequest(moduleVO.url));
                loadingQueue.addItem(loader);
                loaderProgressCounter.addItem(loader);
                Tracer.debug("Preloading module:" + 
                    [moduleVO.name, moduleVO.url]);
            }
        }
        loaderProgressCounter.start();
    }

    private function addEventListeners():void
    {
        loaderProgressCounter.addEventListener(Event.COMPLETE, 
                                                    loadCompletedHandler);
        loaderProgressCounter.addEventListener(Event.CHANGE, progressHandler);
    }

    private function removeEventListeners():void
    {
        loaderProgressCounter.removeEventListener(Event.COMPLETE, 
            loadCompletedHandler);
        loaderProgressCounter.removeEventListener(Event.CHANGE, 
            progressHandler);
    }

    /**
     * dispose the instance.
     *
     */
    public function dispose():void
    {
        if(loaderProgressCounter)
        {
            removeEventListeners();
            loaderProgressCounter.dispose();
            loaderProgressCounter = null;
        }
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    /**
     * handle when these files loaded.
     * @param event
     *
     */
    private function loadCompletedHandler(event:Event):void
    {
        dispatchEvent(event.clone());
    }

    /**
     * handle loading has new prgress.
     * @param event
     *
     */
    private function progressHandler(event:Event):void
    {
        dispatchEvent(event.clone());
    }
}
}