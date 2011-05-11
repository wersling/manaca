/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue
{
/**
 * LoaderQueue的接口，主要用于提供给第三方模块调用
 */
public interface ILoaderQueue
{
    function addItem(loaderAdapter:ILoaderAdapter):void
    function removeAllItem():void
    function removeItem(loaderAdapter:ILoaderAdapter):void
    function removeItemByLevel(level:uint):void
    function saveItemByLevel(level:uint):void
    function dispose():void
}
}
