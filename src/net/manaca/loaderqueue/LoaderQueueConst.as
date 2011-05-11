/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.loaderqueue
{
/**
 * 用于标明LoaderQueue所使用的Adapter的状态
 *
 * p.s:请注意，LoaderQueue并不具有状态，
 * 所以此状态并非为LoaderQueue使用，即不是LoaderQueue的状态
 */
public class LoaderQueueConst
{
    public static const STATE_COMPLETED:String = "completed";
    public static const STATE_ERROR:String = "error";
    public static const STATE_REMOVED:String = "removed";
    public static const STATE_STARTED:String = "started";
    public static const STATE_WAITING:String = "waiting";
//	public static const STATE_PAUSE:String = "4";
}
}
