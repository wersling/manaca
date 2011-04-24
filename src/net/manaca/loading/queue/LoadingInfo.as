package net.manaca.loading.queue
{
import flash.net.URLRequest;
import flash.system.LoaderContext;

/**
 * @private
 * @author Sean Zou
 * 
 */    
internal class LoadingInfo
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * LoadingInfo Constructor.
     * @param loader
     * @param urlRequest
     * 
     */
    public function LoadingInfo(loader:Object, urlRequest:URLRequest, rate:Number)
    {
        this.loader = loader;
        this.urlRequest = urlRequest;
        this.rate = rate;
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    /**
     * A Loader object.
     */        
    internal var loader:Object;

    /**
     * A URLRequest object.
     */        
    internal var urlRequest:URLRequest;

    /**
     * A LoaderContext object.
     */        
    internal var context:LoaderContext;

    /**
     * The load file compute size.
     */        
    internal var rate:Number;

    //==========================================================================
    //  Methods
    //==========================================================================
    public function dispose():void
    {
        loader = null;
        urlRequest = null;
        context = null;
    }
}
}