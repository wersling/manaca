/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue.adapter
{
import net.manaca.loaderqueue.ILoaderAdapter;
import net.manaca.loaderqueue.LoaderQueueEvent;

import flash.net.URLRequest;
import flash.net.URLStream;
/**
 * 将URLStream类包装成可用于LoaderQueue的适配器
 * @see net.manaca.loaderqueue#LoaderQueue
 * @author sean
 */
public class URLStreamAdapter extends AbstractLoaderAdapter implements ILoaderAdapter
{
    public function URLStreamAdapter(level:uint,
                                  urlRequest:URLRequest)
    {
        super(level, urlRequest);

        _container = new URLStream();
        containerAgent = _container;
    }


    //==========================================================================
    //  Properties
    //==========================================================================
    public function get bytesLoaded():Number
    {
        return container.bytesAvailable;
    }

    public function get bytesTotal():Number
    {
        return 0;
    }

    //----------------------------------
    //  container
    //----------------------------------
    private var _container:URLStream;

    public function get container():URLStream
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
		super.dispose();
        _container = null;
    }

    public function start():void
    {
        preStartHandle();
        try
        {
            container.load(urlRequest);
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
