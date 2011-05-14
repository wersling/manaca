/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue.adapter
{
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.net.URLStream;

import net.manaca.loaderqueue.ILoaderAdapter;
import net.manaca.loaderqueue.LoaderQueueEvent;

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
    private var _bytesLoaded:Number = 0;
    public function get bytesLoaded():Number
    {
        return _bytesLoaded;
    }

    private var _bytesTotal:Number = 0;
    public function get bytesTotal():Number
    {
        return _bytesTotal;
    }
    
    public function get progress():Number
    {
        if(bytesLoaded && bytesTotal)
        {
            return bytesLoaded / bytesTotal;
        }
        else
        {
            return 0;
        }
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
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    override protected function container_progressHandler(
        event:ProgressEvent):void
    {
        super.container_progressHandler(event);
        _bytesLoaded = event.bytesLoaded;
        _bytesTotal = event.bytesTotal;
    }
}
}
