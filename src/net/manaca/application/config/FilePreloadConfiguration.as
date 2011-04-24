package net.manaca.application.config
{
import flash.errors.IOError;
import flash.utils.Dictionary;

import net.manaca.application.config.model.FileInfo;
import net.manaca.application.config.model.FilesInfo;
import net.manaca.application.config.model.FileTypeInfo;
import net.manaca.application.thread.AbstractProcess;
import net.manaca.errors.IllegalArgumentError;
import net.manaca.loading.queue.LoadingEvent;
import net.manaca.loading.queue.MultiLoading;
import net.manaca.logging.Tracer;

/**
 * The FilePreloadConfiguration loading the files by xml files node.
 * You can get these files in externalFiles map.
 * @author Sean
 *
 */
public class FilePreloadConfiguration extends AbstractProcess
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var info:FilesInfo;
    private var loadingQueue:MultiLoading;
    private var files:Dictionary;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>FilePreloadConfiguration</code> instance.
     * @param info the files list.
     *
     */
    public function FilePreloadConfiguration(info:FilesInfo)
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
    override public function get percentage():uint
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
    override protected function run():void
    {
        files = new Dictionary(true);

        loadingQueue = new MultiLoading();
        addEventListeners();

        var len:uint = info.getFileCount();
        if(len > 0)
        {
            var file:FileInfo;
            for(var i:uint = 0 ;i < len; i++ )
            {
                file = info.getFileAt(i);
                if(file)
                {
                    var loader:* = null;
                    switch(file.FileType.valueOf())
                    {
                        case FileTypeInfo.IMAGE:
                            loader = loadingQueue.addImageURL(file.url, 10);
                            break;
                        case FileTypeInfo.SWF:
                            loader = loadingQueue.addSwfURL(file.url, 10);
                            break;
                        case FileTypeInfo.XML:
                            loader = loadingQueue.addXMLURL(file.url, 10);
                            break;
                    }

                    if(loader)
                    {
                        files[file.name] = loader;
                    }

                    Tracer.debug("Start loading file:" + file.url);
                }
            }

            loadingQueue.start();
        }
        else
        {
            finish();
        }
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
    override public function dispose():void
    {
        if(loadingQueue)
        {
            removeEventListeners();
            loadingQueue.dispose();
            loadingQueue = null;
        }
        
        super.dispose();
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
        this.finish();
    }

    /**
     * handle loading file error.
     * @param event
     *
     */
    private function errorHandler(event:LoadingEvent):void
    {
        this.dispatchErrorEvent(new IOError(event.error.toString()));
    }

    /**
     * handle loading has new prgress.
     * @param event
     *
     */
    private function progressHandler(event:LoadingEvent):void
    {
        this.dispatchUpdateEvent();
    }
}
}