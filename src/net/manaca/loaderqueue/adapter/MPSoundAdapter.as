/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue.adapter
{
import net.manaca.loaderqueue.ILoaderAdapter;
import net.manaca.loaderqueue.LoaderQueueEvent;

import flash.events.Event;
import flash.media.ID3Info;
import flash.media.Sound;
import flash.media.SoundLoaderContext;
import flash.net.URLRequest;

/**
 * 将Sound类包装成可用于LoaderQueue的适配器
 * @see net.manaca.loaderqueue#LoaderQueue
 * @author sean
 */
public class MPSoundAdapter extends AbstractLoaderAdapter
                            implements ILoaderAdapter
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Application</code> instance.
     *
     */
    public function MPSoundAdapter(level:uint,
                                   urlRequest:URLRequest,
                                   loaderContext:SoundLoaderContext = null)
    {
        super(level, urlRequest, loaderContext);
        _container = new Sound();
        _container.addEventListener(Event.ID3, onID3Event);
        containerAgent = _container;
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    private var _container:Sound;

    public function get bytesLoaded():Number
    {
        return container.bytesLoaded;
    }

    public function get bytesTotal():Number
    {
        return container.bytesTotal;
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
    
    public function get container():Sound
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
        }

    }

    //==========================================================================
    //  Event Handlers
    //==========================================================================
    private function onID3Event(event:Event):void
    {
        var obj:ID3Info = event.currentTarget["id3"] as ID3Info;
    }
}
}
