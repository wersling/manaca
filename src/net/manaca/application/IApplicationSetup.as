package net.manaca.application
{
import flash.events.IEventDispatcher;
/**
 * 
 * @author Sean Zou
 * 
 */
public interface IApplicationSetup extends IEventDispatcher
{
    function start():void;
}
}