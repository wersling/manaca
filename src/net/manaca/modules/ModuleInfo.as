package net.manaca.modules
{
import flash.display.Loader;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.net.URLStream;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.system.SecurityDomain;
import flash.utils.ByteArray;

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
            BootstrapConfiguration.getInstance().getModuleVOByName(moduleName);
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    private var moduleVO:ModuleVO;

    private var urlStream:URLStreamAdapter;
    private var loader:Loader;

    private var loaderContext:LoaderContext;

    private var loaderQueue:LoaderQueue =
        BootstrapConfiguration.getInstance().loaderQueue;
    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  data
    //----------------------------------
    private var _data:Object;
    /**
     * @private
     */
    public function get data():Object
    {
        return _data;
    }

    public function set data(value:Object):void
    {
        _data = _data;
    }
    //----------------------------------
    //  error
    //----------------------------------
    private var _error:Boolean = false;
    /**
     * @private
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
     * @private
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
     * @private
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
     * @private
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
     * @private
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
     * @private
     */
    public function load(applicationDomain:ApplicationDomain=null,
                         securityDomain:SecurityDomain=null,
                         bytes:ByteArray=null):void
    {
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
        
        var url:String = BootstrapConfiguration.getInstance().getSwfPath(moduleVO.url);
        var urlRequest:URLRequest = new URLRequest(url);
        if(moduleVO.encoded)
        {
            urlStream =
                new URLStreamAdapter(LoaderQueueLevel.MODULE_DLL, urlRequest);
            urlStream.addEventListener(LoaderQueueEvent.TASK_COMPLETED,
                urlStream_completedHandler);
            urlStream.addEventListener(LoaderQueueEvent.TASK_ERROR,
                urlStream_errorHandler);
            urlStream.addEventListener(LoaderQueueEvent.TASK_PROGRESS,
                urlStream_progressHandler);
            loaderQueue.addItem(urlStream);
            Tracer.debug("[Module] loading encoded module : " + urlRequest.url);
        }
        else
        {
            createLoader();
            Tracer.debug("[Module] loading module : " + urlRequest.url);
            loader.load(urlRequest, loaderContext);
        }
    }

    /**
     * @private
     */
    public function unload():void
    {
        clearLoader();

        if (_loaded)
        {
            dispatchEvent(new ModuleEvent(ModuleEvent.UNLOAD));
        }

        ModuleFactory(_factoy).dispose();
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
        if(urlStream)
        {
            urlStream.removeEventListener(LoaderQueueEvent.TASK_COMPLETED,
                urlStream_completedHandler);
            urlStream.removeEventListener(LoaderQueueEvent.TASK_ERROR,
                urlStream_errorHandler);
            urlStream.removeEventListener(LoaderQueueEvent.TASK_PROGRESS,
                urlStream_progressHandler);
            loaderQueue.removeItem(urlStream);
            urlStream.dispose();
            urlStream = null;
        }

        if(loader)
        {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,
                loader_completeHandler);
            loader.contentLoaderInfo.removeEventListener(Event.INIT,
                loader_initHandler);
            try
            {
                loader.close();
            }
            catch(error:Error)
            {
            }

            try
            {
                loader.unload();
            }
            catch(error:Error)
            {
            }

            loader = null;
        }
    }

    private function createLoader():void
    {
        if(!loader)
        {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,
                loader_completeHandler);
            loader.contentLoaderInfo.addEventListener(Event.INIT,
                loader_initHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 
                loader_ioErrorHandler);
        }
    }
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    private function loader_initHandler(event:Event):void
    {
        _applicationDomain = loader.contentLoaderInfo.applicationDomain;
        _factoy = new ModuleFactory(applicationDomain, moduleVO);

        clearLoader();

        _ready = true;
        dispatchEvent(new ModuleEvent(ModuleEvent.READY));
    }

    private function loader_completeHandler(event:Event):void
    {
        var moduleEvent:ModuleEvent =
            new ModuleEvent(ModuleEvent.PROGRESS,
                event.bubbles, event.cancelable);
        moduleEvent.bytesLoaded = loader.contentLoaderInfo.bytesLoaded;
        moduleEvent.bytesTotal = loader.contentLoaderInfo.bytesTotal;
        dispatchEvent(moduleEvent);
    }
    
    private function loader_ioErrorHandler(event:IOErrorEvent):void
    {
        _error = true;
        Tracer.error("[Module] " + event.toString());
        var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.ERROR);
        moduleEvent.errorText = event.toString();
        dispatchEvent(moduleEvent);
    }

    private function urlStream_completedHandler(event:LoaderQueueEvent):void
    {
        var sloader:URLStream = urlStream.container;
        var by:ByteArray = new ByteArray();
        sloader.readBytes(by, 0, sloader.bytesAvailable);
        by.position = 0;

        //TODO decode

        createLoader();
        Tracer.debug("[Module] encoding module : " + moduleName);
        loader.loadBytes(by, loaderContext);
    }

    private function urlStream_errorHandler(event:LoaderQueueEvent):void
    {
        _error = true;
        Tracer.error("[Module] " + event.errorMsg);
        var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.ERROR);
        moduleEvent.errorText = event.errorMsg;
        dispatchEvent(moduleEvent);
    }

    private function urlStream_progressHandler(event:LoaderQueueEvent):void
    {
        var moduleEvent:ModuleEvent = new ModuleEvent(ModuleEvent.PROGRESS);
        moduleEvent.bytesLoaded = event.bytesLoaded;
        moduleEvent.bytesTotal = event.bytesTotal;
        dispatchEvent(moduleEvent);
    }
}
}
