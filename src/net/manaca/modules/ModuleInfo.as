/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import flash.events.EventDispatcher;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.system.SecurityDomain;
import flash.utils.ByteArray;

import net.manaca.loaderqueue.LoaderQueue;
import net.manaca.loaderqueue.LoaderQueueEvent;
import net.manaca.loaderqueue.adapter.LoaderAdapter;

//--------------------------------------
//  Events
//--------------------------------------

/**
 *  Dispatched by the backing ModuleInfo if there was an error during
 *  module loading.
 *
 *  @eventType mx.events.ModuleEvent.ERROR
 *
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
[Event(name="error", type="net.manaca.modules.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo at regular intervals
 *  while the module is being loaded.
 *
 *  @eventType net.manaca.modules.ModuleEvent.PROGRESS
 *
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
[Event(name="progress", type="net.manaca.modules.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo once the module is sufficiently
 *  loaded to call the <code>IModuleInfo.factory()</code> method and the
 *  <code>IModuleFactory.create()</code> method.
 *
 *  @eventType net.manaca.modules.ModuleEvent.READY
 *
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
[Event(name="ready", type="net.manaca.modules.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo when the module data is unloaded.
 *
 *  @eventType net.manaca.modules.ModuleEvent.UNLOAD
 *
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
[Event(name="unload", type="net.manaca.modules.ModuleEvent")]

/**
 *  @private
 *  The ModuleInfo class encodes the loading state of a module.
 *  It isn't used directly, because there needs to be only one single
 *  ModuleInfo per URL, even if that URL is loaded multiple times,
 *  yet individual clients need their own dedicated events dispatched
 *  without re-dispatching to clients that already received their events.
 *  ModuleInfoProxy holds the public IModuleInfo implementation
 *  that can be externally manipulated.
 */
public class ModuleInfo extends EventDispatcher implements IModuleInfo
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * @private
     */
    public function ModuleInfo(moduleName:String)
    {
        super();

        this._moduleName = moduleName;
        moduleVO =
            ModuleManager.getModuleVOByName(moduleName);
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    private var moduleVO:ModuleVO;

    private var loader:LoaderAdapter;

    private var loaderContext:LoaderContext;

    private var loaderQueue:LoaderQueue = ModuleManager.loaderQueueIns;
    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  data
    //----------------------------------
    private var _data:Object;
    /**
     * @inheritDoc 
     */
    public function get data():Object
    {
        return _data;
    }

    public function set data(value:Object):void
    {
        _data = value;
    }
    //----------------------------------
    //  error
    //----------------------------------
    private var _error:Boolean = false;
    /**
     * @inheritDoc
     */
    public function get error():Boolean
    {
        return _error;
    }
    //----------------------------------
    //  factory
    //----------------------------------
    private var _factoy:IModuleFactory;
    /**
     * @inheritDoc
     */
    public function get factory():IModuleFactory
    {
        return _factoy;
    }
    //----------------------------------
    //  loaded
    //----------------------------------
    private var _loaded:Boolean = false;
    /**
     * @inheritDoc
     */
    public function get loaded():Boolean
    {
        return _loaded;
    }

    //----------------------------------
    //  ready
    //----------------------------------
    private var _ready:Boolean = false;
    /**
     * @inheritDoc
     */
    public function get ready():Boolean
    {
        return _ready;
    }

    //----------------------------------
    //  moduleName
    //----------------------------------
    private var _moduleName:String;
    /**
     * @inheritDoc
     */
    public function get moduleName():String
    {
        return _moduleName;
    }

    //----------------------------------
    //  applicationDomain
    //----------------------------------
    private var _applicationDomain:ApplicationDomain;
    /**
     * @private
     */
    public function get applicationDomain():ApplicationDomain
    {
        return _applicationDomain;
    }
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * @inheritDoc
     */
    public function load(applicationDomain:ApplicationDomain=null,
                         securityDomain:SecurityDomain=null,
                         bytes:ByteArray=null, 
                         level:uint = 0):void
    {
        if(_ready)
        {
            dispatchEvent(new ModuleEvent(ModuleEvent.READY));
        }
        if(_loaded)
        {
            return;
        }
        _loaded = true;

        loaderContext = new LoaderContext();
        loaderContext.applicationDomain =
            applicationDomain ?
            applicationDomain :
            new ApplicationDomain(ApplicationDomain.currentDomain);

        try
        {
            loaderContext["allowLoadBytesCodeExecution"] = true;
        }
        catch(error:ReferenceError)
        {
        };
        
        loaderContext.securityDomain = securityDomain;
        if (securityDomain == null && Security.sandboxType == Security.REMOTE)
        {
            loaderContext.securityDomain = SecurityDomain.currentDomain;
        }
        
        var url:String = moduleVO.url;
        var urlRequest:URLRequest = new URLRequest(url);
        if(!moduleVO.encoded)
        {
            loader = new LoaderAdapter(level, urlRequest, 
                loaderContext);
            loader.addEventListener(LoaderQueueEvent.TASK_COMPLETED,
                loader_completedHandler);
            loader.addEventListener(LoaderQueueEvent.TASK_ERROR,
                loader_errorHandler);
            loader.addEventListener(LoaderQueueEvent.TASK_PROGRESS,
                loader_progressHandler);
            loaderQueue.addItem(loader);
        }
    }

    /**
     * @inheritDoc
     */
    public function unload():void
    {
        if(loader)
        {
            loader.dispose();
        }
        clearLoader();
        
        if (_loaded)
        {
            dispatchEvent(new ModuleEvent(ModuleEvent.UNLOAD));
        }

        _applicationDomain = null;
        _factoy = null;
        _loaded = false;
        _ready = false;
        _error = false;
    }

    /**
     * @private
     */
    private function clearLoader():void
    {
        if(loader)
        {
            loader.removeEventListener(LoaderQueueEvent.TASK_COMPLETED,
                loader_completedHandler);
            loader.removeEventListener(LoaderQueueEvent.TASK_ERROR,
                loader_errorHandler);
            loader.removeEventListener(LoaderQueueEvent.TASK_PROGRESS,
                loader_progressHandler);
            loader = null;
        }
    }

    //==========================================================================
    //  Event Handlers
    //==========================================================================
    private function loader_initHandler(event:LoaderQueueEvent):void
    {
        _applicationDomain = 
            loader.adaptee.contentLoaderInfo.applicationDomain;
        _factoy = new ModuleFactory(applicationDomain, moduleVO);

        clearLoader();

        _ready = true;
        dispatchEvent(new ModuleEvent(ModuleEvent.READY));
    }

    private function loader_completedHandler(event:LoaderQueueEvent):void
    {
        var moduleEvent:ModuleEvent =
            new ModuleEvent(ModuleEvent.PROGRESS,
                event.bubbles, event.cancelable);
        moduleEvent.bytesLoaded = 
            loader.adaptee.contentLoaderInfo.bytesLoaded;
        moduleEvent.bytesTotal = loader.adaptee.contentLoaderInfo.bytesTotal;
        dispatchEvent(moduleEvent);
        loader_initHandler(null);
    }
    
    private function loader_progressHandler(event:LoaderQueueEvent):void
    {
        var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.PROGRESS);
        moduleEvent.bytesLoaded = event.bytesLoaded;
        moduleEvent.bytesTotal = event.bytesTotal;
        dispatchEvent(moduleEvent);
    }
    
    private function loader_errorHandler(event:LoaderQueueEvent):void
    {
        _error = true;
        var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.ERROR);
        moduleEvent.errorText = event.toString();
        dispatchEvent(moduleEvent);
    }
}
}
