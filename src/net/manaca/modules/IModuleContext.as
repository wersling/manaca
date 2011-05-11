/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
import org.robotlegs.core.IContext;

public interface IModuleContext extends IContext
{
    function startup():void;
    function shutdown():void;
}
}
