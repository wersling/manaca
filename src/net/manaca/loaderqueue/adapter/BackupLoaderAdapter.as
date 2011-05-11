/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue.adapter
{
import net.manaca.loaderqueue.ILoaderAdapter;
import net.manaca.loaderqueue.LoaderQueueEvent;

import flash.display.Loader;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.LoaderContext;

/**
 * BackupLoaderAdapter可以设置两个URL地址，如果一个地址加载错误，
 * 程序将加载第二个地址。本对象一般用于确定服务的稳定性，如果数据服务器出现问题，
 * 我们可以设置一个静态文件路径，以确保最终显示正常。
 * @see net.manaca.loaderqueue#LoaderQueue
 * @author sean
 */
public class BackupLoaderAdapter extends AbstractLoaderAdapter
    implements ILoaderAdapter
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * BackupLoaderAdapter
     * @param level 等级值,数值越小等级越高,越早被下载
     * @param urlRequest 需下载项的url地址
     * @param backupUrlRequest 备份的url地址
     */
    public function BackupLoaderAdapter(level:uint,
                                           urlRequest:URLRequest, 
                                           backupUrlRequest:URLRequest,
                                           loaderContext:LoaderContext = null)
    {
        super(level, urlRequest, loaderContext);
        _container = new Loader();
        containerAgent = _container.contentLoaderInfo;
        
        this.backupUrlRequest = backupUrlRequest;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var backupUrlRequest:URLRequest;
    private var isUseBackup:Boolean = false;
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
    
    private var _container:Loader;
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
            if(!isUseBackup)
            {
                container.load(urlRequest, loaderContext);
            }
            else
            {
                container.load(backupUrlRequest, loaderContext);
            }
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
    override protected function container_errorHandler(event:IOErrorEvent):void
    {
        if(!isUseBackup)
        {
            stop();
            isUseBackup = true;
            _container = new Loader();
            containerAgent = _container;
            start();
        }
        else
        {
            super.container_errorHandler(event);
        }
    }
}
}
