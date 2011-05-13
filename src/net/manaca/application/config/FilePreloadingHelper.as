package net.manaca.application.config
{
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import net.manaca.errors.IllegalArgumentError;
import net.manaca.loading.queue.LoadingEvent;
import net.manaca.loading.queue.MultiLoading;
import net.manaca.logging.Tracer;
import net.manaca.modules.ModuleVO;
import net.manaca.utils.URLUtils;

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
 * The FilePreloadConfiguration loading the files by xml files node.
 * You can get these files in externalFiles map.
 * @author Sean
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
    private var loadingQueue:MultiLoading;
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
        return loadingQueue ? loadingQueue.percent : 0;
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

        loadingQueue = new MultiLoading();
        addEventListeners();
        for each(var file:XML in filesXML)
        {
            var loader:* = null;
            var url:String = String(file.@url);
            
            if(String(file.@clearCache) == "true")
            {
                url = URLUtils.clearCacheUrl(url);
            }
            
            switch(String(file.@type))
            {
                case FileTypeInfo.IMAGE:
                {
                    loader = loadingQueue.addImageURL(url, 10);
                    break;
                }
                case FileTypeInfo.SWF:
                {
                    loader = loadingQueue.addSwfURL(url, 10);
                    break;
                }
                case FileTypeInfo.XML:
                {
                    loader = loadingQueue.addXMLURL(url, 10);
                    break;
                }
                default:
                {
                    
                }
            }
            if(loader)
            {
                files[String(file.@name)] = loader;
            }
            Tracer.debug("Start loading file:" + [file.@name, url]);
        }
        
        for each(var moduleVO:ModuleVO in modules)
        {
            if(moduleVO.preloading)
            {
                loader = loadingQueue.addSwfURL(moduleVO.url, 10);
                Tracer.debug("Preloading module:" + 
                    [moduleVO.name, moduleVO.url]);
            }
        }
        loadingQueue.start();
    }

    private function addEventListeners():void
    {
        loadingQueue.addEventListener(LoadingEvent.COMPLETE, 
                                                    loadCompletedHandler);
        loadingQueue.addEventListener(LoadingEvent.ERROR, errorHandler);
        loadingQueue.addEventListener(LoadingEvent.PROGRESS, progressHandler);
    }

    private function removeEventListeners():void
    {
        loadingQueue.removeEventListener(LoadingEvent.COMPLETE, 
                                                    loadCompletedHandler);
        loadingQueue.removeEventListener(LoadingEvent.ERROR, errorHandler);
        loadingQueue.removeEventListener(LoadingEvent.PROGRESS, progressHandler);
    }

    /**
     * dispose the instance.
     *
     */
    public function dispose():void
    {
        if(loadingQueue)
        {
            removeEventListeners();
            loadingQueue.dispose();
            loadingQueue = null;
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
    private function loadCompletedHandler(event:LoadingEvent):void
    {
        dispatchEvent(event.clone());
    }

    /**
     * handle loading file error.
     * @param event
     *
     */
    private function errorHandler(event:LoadingEvent):void
    {
        Tracer.error(event.error);
    }

    /**
     * handle loading has new prgress.
     * @param event
     *
     */
    private function progressHandler(event:LoadingEvent):void
    {
        dispatchEvent(event.clone());
    }
}
}