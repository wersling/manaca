package net.manaca.utils
{
import flash.net.SharedObject;
import flash.utils.Proxy;
import flash.utils.flash_proxy;

/**
 * The Cookie carry a proxy provide a more useful SharedObject.
 * @author v-seanzo
 * 
 */    
dynamic public class Cookie extends Proxy
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var _name:String;

    private var _timeOut:Number;

    private var _so:SharedObject;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Cookie</code> instance.
     * @param name the SharedObject name.
     * @param timeOut the value time out value.
     * 
     */    
    public function Cookie(name:String, timeOut:Number = 3600)
    {
        super();
        this._name = name;
        this._timeOut = timeOut;
        
        _so = SharedObject.getLocal(name);
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    /**
     * The SharedObject name.
     * @return 
     * 
     */
    public function getName():String
    {
        return _name;
    }

    /**
     * Get time out value.
     * @return 
     * 
     */
    public function getTimeOut():Number
    {
        return _timeOut;
    }

    /**
     * Get the SharedObject size.
     * @return 
     * 
     */
    public function getSize():uint
    {
        return _so.size;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Clear when timeout.
     */
    public function clearTimeOut():void
    {
        var obj:* = _so.data.cookie;
        if(obj == null) return;
        for(var key:String in obj)
        {
            if(isTimeOut(obj[key].time))
            {
                remove(key); 
            }
        }
        _so.flush();
    }

    /**
     * Remove all cookie.
     * 
     */
    public function clear():void
    {
        _so.clear();
        _so.flush();
    }

    /**
     * Check timeout.
     * @param time
     * @return 
     * 
     */
    public function isTimeOut(time:Number):Boolean
    {
        var today:Date = new Date();
        return time + _timeOut * 1000 < today.getTime(); 
    }

    /**
     * Check Cookie item exist.
     * @param key
     * @return 
     * 
     */
    public function isExist(key:String):Boolean
    { 
        return _so.data.cookie != null && _so.data.cookie[key] != null;
    } 

    /**
     * Remove Cookie item by key.
     * @param key
     * 
     */
    public function remove(key:String):void
    { 
        if(isExist(key))
        {
            delete _so.data.cookie[key];
            _so.flush();
        }
    }

    /**
     * 
     * @param name
     * @return 
     * 
     */
    override flash_proxy function getProperty(name:*):* 
    {
        return isExist(name) ? _so.data.cookie[name].value : null;
    }

    /**
     * 
     * @param name
     * @param value
     * 
     */
    override flash_proxy function setProperty(name:*, value:*):void 
    {
        var obj:Object;
        if(isExist(name))
        {
            obj = _so.data.cookie[name];
        }
        else
        {
            obj = new Object();
        }
        
        var today:Date = new Date(); 
        obj.time = today.getTime().toString(); 
        obj.name = name;
        obj.value = value;
        
        createCookie();
        
        _so.data.cookie[name] = obj;
        _so.flush();
    }

    private function createCookie():void
    {
        if(_so.data.cookie == null)
        {
            _so.data.cookie = new Object();
            _so.flush();
        }
    }
}
}