package net.manaca.application
{
import flash.events.IEventDispatcher;

public interface IApplicationSetup extends IEventDispatcher
{
    function start():void;
}
}