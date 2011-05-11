/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue
{
import flash.events.IEventDispatcher;

/**
 * 适配器接口类,所有任务适配器需引用此接口
 * @see LoaderAdapter
 * @see CommandAdapter
 */
public interface ILoaderAdapter extends IEventDispatcher
{
    function start():void
    function stop():void
    function dispose():void
    function get isStarted():Boolean
    function get level():uint
    function get state():String
    function set state(value:String):void
    function get bytesLoaded():Number;
    function get bytesTotal():Number;
    function get progress():Number;
    function get data():*;
    function set data(obj:*):void;
    function get url():String;
}
}
