/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue.adapter
{
import net.manaca.loaderqueue.ILoaderAdapter;
import net.manaca.loaderqueue.LoaderQueueEvent;

import flash.display.Loader;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;
import flash.system.LoaderContext;

/**
 * 将Loader类包装成可用于LoaderQueue的适配器
 * @see net.manaca.loaderqueue#LoaderQueue
 *
 * @author sean
 */
public class LoaderAdapter extends AbstractLoaderAdapter
                            implements ILoaderAdapter
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Application</code> instance.
     *
     */
    public function LoaderAdapter(level:uint,
                                  urlRequest:URLRequest,
                                  loaderContext:LoaderContext = null)
    {
        super(level, urlRequest, loaderContext);
        _container = new Loader();
        containerAgent = _container.contentLoaderInfo;
    }
    private var _container:Loader;

    //==========================================================================
    //  Properties
    //==========================================================================
    public function get bytesLoaded():Number
    {
        return container.contentLoaderInfo.bytesLoaded;
    }

    public function get bytesTotal():Number
    {
        return container.contentLoaderInfo.bytesTotal;
    }

    public function get container():Loader
    {
        return _container;
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * 消毁此项目内在引用
     * 调用此方法后，此adapter实例会自动从LoaderQueue中移出
     * p.s: 停止下载的操作LoaderQueue会自动处理
     */
    override public function dispose():void
    {
		stop();
		_container && _container.unloadAndStop();
		super.dispose();
		_container = null;
    }

    public function start():void
    {
        preStartHandle();
        try
        {
            container.load(urlRequest, loaderContext);
        }
        catch (error:Error)
        {
            dispatchEvent(new LoaderQueueEvent(LoaderQueueEvent.TASK_ERROR,
                                                                    this.data));
        }
    }

    public function stop():void
    {
        preStopHandle();
        try
        {
            container.close();
        }
        catch (error:Error)
        {
            //do nothing
        }
    }
}
}
