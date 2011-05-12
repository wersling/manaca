package net.manaca.application.config
{
import flash.events.EventDispatcher;
import flash.utils.Dictionary;

import net.manaca.errors.IllegalArgumentError;
import net.manaca.loading.queue.LoadingEvent;
import net.manaca.loading.queue.MultiLoading;
import net.manaca.logging.Tracer;
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
     * @param info the files list.
     *
     */
    public function FilePreloadingHelper(info:XML)
    {
        super();

        if(info != null)
        {
            this.info = info;
        }
        else
        {
            throw new IllegalArgumentError("invalid info argument:" + info);
        }
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var info:XML;
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
     * Get the external files map.
     * @return
     *
     */
    public function get externalFiles():Dictionary
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
        for each(var file:XML in info.Files.File)
        {
            var loader:* = null;
            switch(String(file.@type))
            {
                case FileTypeInfo.IMAGE:
                {
                    loader = loadingQueue.addImageURL(file.@url, 10);
                    break;
                }
                case FileTypeInfo.SWF:
                {
                    loader = loadingQueue.addSwfURL(file.@url, 10);
                    break;
                }
                case FileTypeInfo.XML:
                {
                    loader = loadingQueue.addXMLURL(file.@url, 10);
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
            Tracer.debug("Start loading file:" + [file.@name, file.@url]);
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