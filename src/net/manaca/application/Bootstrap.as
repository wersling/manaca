/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.application
{
import flash.external.ExternalInterface;
import flash.utils.Dictionary;

import net.manaca.application.config.ServerVO;
import net.manaca.core.manaca_internal;
import net.manaca.loaderqueue.LoaderQueue;
import net.manaca.utils.URLUtils;

use namespace manaca_internal;
/**
 * <code>Bootstrap</code> 用于处理系统级变量和参数.
 * 通过<code>Bootstrap</code>可以获取服务器配置情况，系统设置等.
 * @author sean
 *
 */
public class Bootstrap
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    static private var instance:Bootstrap;
    //==========================================================================
    //  Class Methods
    //==========================================================================
    /**
     * 获得<code>Bootstrap</code>实例
     * @return
     *
     */
    public static function getInstance():Bootstrap
    {
        if (!instance)
        {
            instance = new Bootstrap();
        }

        return instance;
    }

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>ConnectionManager</code>实例.
     *
     */
    public function Bootstrap()
    {
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var config:XML;
    private var preloadFiles:Dictionary;
    private const projectSettings:Dictionary = new Dictionary();
    //==========================================================================
    //  Properties -- Server Path
    //==========================================================================
    /**
     * 客户端版本
     */    
    public var clientVersion:int = 1;
    
    /**
     * 返回当前浏览器地址.
     * @return 
     * 
     */    
    public function get href():String
    {
        var result:String = "";
        if(ExternalInterface.available)
        {
            result = ExternalInterface.call(
                "function getHref(){return document.location.href;}");
        }
        return result;
    }
    //----------------------------------
    //  servers
    //----------------------------------
    private var _servers:Array;
    /**
     * 服务器列表.
     * @return
     *
     */
    public function get servers():Array /* of ServerVO */
    {
        return _servers;
    }
    //----------------------------------
    //  currentServer
    //----------------------------------
    private var _currentServer:ServerVO;
    /**
     * 服务器请求地址.
     * @return
     *
     */
    public function get currentServer():ServerVO
    {
        return _currentServer;
    }

    //----------------------------------
    //  loaderQueue
    //----------------------------------
    private const _loaderQueue:LoaderQueue = new LoaderQueue(8, 500);
    /**
     * 数据加载队列
     * @return
     *
     */
    public function get loaderQueue():LoaderQueue
    {
        return _loaderQueue;
    }
    //==========================================================================
    //  Properties -- Config
    //==========================================================================
    /**
     * 获得指定swf文件的绝对路径.
     * @param name
     * @return 
     * 
     */    
    public function getSwfPath(name:String, addVersion:Boolean = true):String
    {
        var result:String;
        if(currentServer.swfPath.indexOf("http://") != -1)
        {
            result = currentServer.swfPath + name;
        }
        else
        {
            result = currentServer.domain + currentServer.swfPath + name;
        }
        return addVersion ? addVersionUrl(result) : result;
    }
    
    /**
     * 获得指定图片文件的绝对路径.
     * @param name
     * @return 
     * 
     */
    public function getImagePath(name:String, addVersion:Boolean = false):String
    {
        var result:String;
        if(currentServer.imagePath.indexOf("http://") != -1)
        {
            result = currentServer.imagePath + name;
        }
        else
        {
            result = currentServer.domain + currentServer.imagePath + name;
        }
        return addVersion ? addVersionUrl(result) : result;
    }

    /**
     * 返回指定请求的http请求绝对地址.
     * @param request
     * @return 
     * 
     */    
    public function getHttpServerPath(name:String, 
                                      clearCache:Boolean = true):String
    {
        var result:String;
        if(currentServer.httpServer.indexOf("http://") != -1)
        {
            result = currentServer.httpServer + name;
        }
        else
        {
            result = currentServer.domain + currentServer.httpServer + name;
        }
        if(clearCache)
        {
            result = URLUtils.clearCacheUrl(result);
        }
        return result;
    }
    
    /**
     * 获得指定名称的设置值。
     * @param name
     * @return 
     * 
     */    
    public function getSettings(name:String):*
    {
        return projectSettings[name];
    }
    
    /**
     * 获得指定名称的预加载文件对象.
     * @param name
     * @return 
     * 
     */    
    public function getPreloadFile(name:String):*
    {
        return preloadFiles[name];
    }
    
    /**
     * 将请求加入版本
     * @param url
     * @return 
     * 
     */    
    private function addVersionUrl(url:String):String
    {
        if(url.indexOf("?") != -1)
        {
            url += "&v=" + clientVersion;
        }
        else
        {
            url += "?v=" + clientVersion;
        }
        return url;
    }
    //==========================================================================
    //  Private Methods
    //==========================================================================
    /**
     * 初始化
     * @param config
     * 
     */    
    final manaca_internal function init(config:XML):void
    {
        this.config = config;
        
        //init project settings
        for each(var settingNode:XML in config.ProjectSettings.Add)
        {
            projectSettings[String(settingNode.@key)] = 
                String(settingNode.@value);
        }
        
        //init servers
        _servers = [];
        for each (var node:XML in config.Servers.Server)
        {
            var vo:ServerVO = new ServerVO(node);
            _servers.push(vo);
        }
    }
    
    /**
     * 设置预加载文件表.
     * @param files
     * 
     */    
    final manaca_internal function setPreloadFiles(files:Dictionary):void
    {
        this.preloadFiles = files;
    }
    
    /**
     * 设置服务器根据名称
     * @param name 服务器名称
     * @return
     *
     */
    final manaca_internal function setServerByName(name:String):Boolean
    {
        for each(var server:ServerVO in servers)
        {
            if(server.id == name)
            {
                setCurrentServer(server);
                return true;
            }
        }
        return false;
    }
    
    /**
     * 设置默认的服务器配置
     * @param vo
     * 
     */    
    final manaca_internal function setCurrentServer(vo:ServerVO):void
    {
        _currentServer = vo;
    }
}
}
