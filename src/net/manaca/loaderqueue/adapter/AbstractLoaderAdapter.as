/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue.adapter
{
import net.manaca.loaderqueue.LoaderQueueConst;
import net.manaca.loaderqueue.LoaderQueueEvent;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;

/**
 * 任务完成后派发
 * @eventType net.manaca.loaderqueue.LoaderQueueEvent.TASK_COMPLETED
 */
[Event(name="taskCompleted", type="net.manaca.loaderqueue.LoaderQueueEvent")]

/**
 * 任务出错后派发
 * @eventType net.manaca.loaderqueue.LoaderQueueEvent.TASK_ERROR
 */
[Event(name="taskError", type="net.manaca.loaderqueue.LoaderQueueEvent")]

/**
 * 任务进程中派发
 * @eventType net.manaca.loaderqueue.LoaderQueueEvent.TASK_PROGRESS
 */
[Event(name="taskProgress", type="net.manaca.loaderqueue.LoaderQueueEvent")]

/**
 * 任务启动后派发
 * @eventType net.manaca.loaderqueue.LoaderQueueEvent.TASK_START
 */
[Event(name="taskStart", type="net.manaca.loaderqueue.LoaderQueueEvent")]

/**
 * 任务停止或移出后派发
 * @eventType net.manaca.loaderqueue.LoaderQueueEvent.TASK_STOP
 */
[Event(name="taskStop", type="net.manaca.loaderqueue.LoaderQueueEvent")]

/**
 * 任务消毁时派发
 * @eventType net.manaca.loaderqueue.LoaderQueueEvent.TASK_DISPOSE
 */

[Event(name="taskDispose", type="net.manaca.loaderqueue.LoaderQueueEvent")]
/**
 * 虚构类，用于提供给adapter子类继承使用，同时adapter子类需引用ILoaderAdapter接口
 * @see ILoaderAdapter
 *
 * @author sean
 */
public class AbstractLoaderAdapter extends EventDispatcher
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>Application</code> instance.
     *
     */
    public function AbstractLoaderAdapter(level:uint,
                                          urlRequest:URLRequest,
                                          loaderContext:* = null)
    {
        _level = level;
        this.urlRequest = urlRequest;
        this.loaderContext = loaderContext;
        this._url = urlRequest.url;
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    protected var loaderContext:*;
    protected var urlRequest:URLRequest;


    //==========================================================================
    //  Properties
    //==========================================================================
    private var _data:*;
    /**
     * 提供给开发者用于数据或参数传递
     * LoaderQueue或是任何Adapter自身并不对此变量附值
     */
    public function get data():*
    {
        return _data;
    }
    public function set data(obj:*):void
    {
        _data = obj;
    }

    public function get isStarted():Boolean
    {
        return state == LoaderQueueConst.STATE_STARTED;
    }

    public function get isCompleted():Boolean
    {
        return state == LoaderQueueConst.STATE_COMPLETED;
    }

    protected var _level:uint;
    public function get level():uint
    {
        return _level;
    }

    protected var _state:String;
    /**
     * 适配器的状态
     * @return 可能的值为LoaderQueueConst中的常量
     * @see net.manaca.loaderqueue#LoaderQueueConst
     */
    public function get state():String
    {
        return _state;
    }
    public function set state(value:String):void
    {
        _state = value;
    }

    private var _containerAgent:*;
    /**
     * 将子类的 container传给本类的containerAgent,用于在此处理一些事件侦听
     */
    protected function set containerAgent(loader:*):void
    {
        _containerAgent = loader;
    }
    protected function get containerAgent():EventDispatcher
    {
        return _containerAgent;
    }
    
    private var _url:String;
    public function get url():String
    {
        return _url;
    }
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * 消毁此项目内在引用
     * 调用此方法后，此adapter实例会自动从LoaderQueue中移出
     * p.s: 停止下载的操作LoaderQueue会自动处理
     */
    public function dispose():void
    {
        dispatchEvent(new LoaderQueueEvent(LoaderQueueEvent.TASK_DISPOSE,
                                                                    this.data));
        removeAllListener();
        loaderContext = null;
        urlRequest = null;
    }
    /**
     * 此方法应包含在子类start()函数中调用
     */
    protected function preStartHandle():void
    {
        with (containerAgent)
        {
            //containerAgent的事件
            addEventListener(Event.COMPLETE, container_completeHandler);
            addEventListener(ProgressEvent.PROGRESS, container_progressHandler);
            addEventListener(IOErrorEvent.DISK_ERROR, container_errorHandler);
            addEventListener(IOErrorEvent.IO_ERROR, container_errorHandler);
            addEventListener(IOErrorEvent.NETWORK_ERROR,
                             container_errorHandler);
        }
        //adapter自身的事件
        addEventListener(IOErrorEvent.DISK_ERROR, container_errorHandler);
        addEventListener(IOErrorEvent.IO_ERROR, container_errorHandler);
        addEventListener(IOErrorEvent.NETWORK_ERROR,
                            container_errorHandler);
        dispatchEvent(new LoaderQueueEvent(LoaderQueueEvent.TASK_START,
                                                                    this.data));
    }

    /**
     * 此方法应包含在子类stop()函数中调用
     */
    protected function preStopHandle():void
    {
        removeAllListener();
        dispatchEvent(new LoaderQueueEvent(LoaderQueueEvent.TASK_STOP,
                                                                    this.data));
    }

    private function removeAllListener():void
    {
        with (containerAgent)
        {
            removeEventListener(Event.COMPLETE, container_completeHandler);
            removeEventListener(ProgressEvent.PROGRESS,
                                container_progressHandler);
            removeEventListener(IOErrorEvent.DISK_ERROR,
                                container_errorHandler);
            removeEventListener(IOErrorEvent.IO_ERROR, container_errorHandler);
            removeEventListener(IOErrorEvent.NETWORK_ERROR,
                                container_errorHandler);
        }
        removeEventListener(IOErrorEvent.DISK_ERROR,
            container_errorHandler);
        removeEventListener(IOErrorEvent.IO_ERROR, container_errorHandler);
        removeEventListener(IOErrorEvent.NETWORK_ERROR,
            container_errorHandler);
    }

    //==========================================================================
    //  Event Handlers
    //==========================================================================
    /**
     * 目下载完成后调用,由preStartHandle()触发
     * @param event
     */
    protected function container_completeHandler(event:Event):void
    {
        state = LoaderQueueConst.STATE_COMPLETED;
        dispatchEvent(new LoaderQueueEvent(LoaderQueueEvent.TASK_COMPLETED,
                                                                    this.data));
    }

    protected function container_errorHandler(event:IOErrorEvent):void
    {
        state = LoaderQueueConst.STATE_ERROR;
        var errorEvent:LoaderQueueEvent =
            new LoaderQueueEvent(LoaderQueueEvent.TASK_ERROR, this.data);
        errorEvent.errorMsg = event.text;
        dispatchEvent(errorEvent);
    }

    /**
     * 项目下载过程中调用,由preStartHandle()触发
     * @param event
     */
    protected function container_progressHandler(event:ProgressEvent):void
    {
        var progressEvent:LoaderQueueEvent =
            new LoaderQueueEvent(LoaderQueueEvent.TASK_PROGRESS, this.data);
        progressEvent.bytesLoaded = event.bytesLoaded;
        progressEvent.bytesTotal = event.bytesTotal;
        dispatchEvent(progressEvent);
    }
}
}
