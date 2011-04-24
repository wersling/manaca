package net.manaca.application.config
{
import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.Dictionary;

import net.manaca.application.config.model.AddInfo;
import net.manaca.application.config.model.ConfigurationInfo;
import net.manaca.application.config.model.FileInfo;
import net.manaca.application.thread.AbstractProcess;
import net.manaca.logging.Tracer;

/**
 * The ExtendFileConfiguration loading a extend file, and merge the file to 
 * project settings and files of configuration.
 * @author wersling
 * 
 */
public class ExtendFileConfiguration extends AbstractProcess
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>ExtendFileConfiguration</code> instance.
     * 
     */
    public function ExtendFileConfiguration(info:ConfigurationInfo, 
                                                projectSettings:Dictionary)
    {
        super();
        this.configInfo = info;
        this.projectSettings = projectSettings;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var configInfo:ConfigurationInfo;
    private var projectSettings:Dictionary;
    private var loader:URLLoader;
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
        return loader ? int(loader.bytesLoaded / loader.bytesTotal * 100) : 0;
    }
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * dispose the instance.
     *
     */
    override public function dispose():void
    {
        if(loader)
        {
           loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
           loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
           loader.removeEventListener(ProgressEvent.PROGRESS, 
                                                loader_progressHandler);
           try
           {
               loader.close();
           }
           catch(error:Error)
           {
               
           }
           loader = null;
        }
        
        configInfo = null;
        projectSettings = null;
        
        super.dispose();
    }
    
    override protected function run():void
    {
        if(configInfo.ExtendFile)
        {
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, loader_completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
            loader.addEventListener(ProgressEvent.PROGRESS, 
                                                loader_progressHandler);
            
            var urlRequest:URLRequest = new URLRequest();
            urlRequest.url = configInfo.ExtendFile;
            loader.load(urlRequest);
            
            Tracer.debug("start loading extend file:" + urlRequest.url);
        }
        else
        {
            this.finish();
        }
    }
    
    
    private function mergeConfig(xml:XML):void
    {
        var tempInfo:ConfigurationInfo = new ConfigurationInfo(xml);
        
        //merge files
        var files:Array = tempInfo.Files.FileList;
        var len:int = files.length;
        var newFile:FileInfo;
        var oldFile:FileInfo;
        for(var i:uint = 0; i < len; i++)
        {
            newFile = files[i];
            oldFile = getFileInfoByName(newFile.name);
            if(oldFile)
            {
                oldFile.FileType = newFile.FileType;
                oldFile.url = newFile.url;
            }
            else
            {
                configInfo.Files.addFile(newFile);
            }
        }
        
        //merge project settings 
        var addList:Array = tempInfo.ProjectSettings.AddList;
        len = addList.length;
        var add:AddInfo;
        for(var j:uint = 0; j < len; j++)
        {
            add = addList[j];
            projectSettings[add.key] = add.value;
        }
    }
    
    private function getFileInfoByName(name:String):FileInfo
    {
        var files:Array = configInfo.Files.FileList;
        var len:int = files.length;
        var file:FileInfo;
        for(var i:uint = 0; i < len; i++)
        {
            file = files[i];
            if(file.name == name)
            {
                return file;
            }
        }
        return null;
    }
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    /**
     * handle when these files loaded.
     * @param event
     *
     */
    private function loader_completeHandler(event:Event):void
    {
        mergeConfig(XML(loader.data));
        finish();
    }

    /**
     * handle loading file error.
     * @param event
     *
     */
    private function loader_errorHandler(event:IOErrorEvent):void
    {
        this.dispatchErrorEvent(new IOError(event.toString()));
    }

    /**
     * handle loading has new prgress.
     * @param event
     *
     */
    private function loader_progressHandler(event:ProgressEvent):void
    {
        this.dispatchUpdateEvent();
    }
}
}