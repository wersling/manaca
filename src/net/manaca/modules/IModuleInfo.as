/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{

import flash.events.IEventDispatcher;
import flash.system.ApplicationDomain;
import flash.system.SecurityDomain;
import flash.utils.ByteArray;

//--------------------------------------
//  Events
//--------------------------------------

/**
 *  Dispatched by the backing ModuleInfo if there was an error during
 *  module loading.
 *
 *  @eventType mx.events.ModuleEvent.ERROR
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
[Event(name="error", type="net.manaca.modules.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo at regular intervals 
 *  while the module is being loaded.
 *
 *  @eventType net.manaca.modules.ModuleEvent.PROGRESS
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
[Event(name="progress", type="net.manaca.modules.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo once the module is sufficiently
 *  loaded to call the <code>IModuleInfo.factory()</code> method and the
 *  <code>IModuleFactory.create()</code> method.
 *
 *  @eventType net.manaca.modules.ModuleEvent.READY
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
[Event(name="ready", type="net.manaca.modules.ModuleEvent")]

/**
 *  Dispatched by the backing ModuleInfo when the module data is unloaded.
 *
 *  @eventType net.manaca.modules.ModuleEvent.UNLOAD
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
[Event(name="unload", type="net.manaca.modules.ModuleEvent")]

/**
 *  An interface that acts as a handle for a particular module.
 *  From this interface, the module status can be queried,
 *  its inner factory can be obtained, and it can be loaded or unloaded.
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
public interface IModuleInfo extends IEventDispatcher
{
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  data
    //----------------------------------

    /**
     *  User data that can be associated with the singleton IModuleInfo
     *  for a given URL.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function get data():Object;
    
    /**
     *  @private
     */
    function set data(value:Object):void;

    //----------------------------------
    //  error
    //----------------------------------

    /**
     *  A flag that is <code>true</code> if there was an error
     *  during module loading.
     *  
     *  <p>This flag is <code>true</code> when the ModuleManager dispatches the
     *  <code>ModuleEvent.ERROR</code> event.</p>
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function get error():Boolean;
    
    //----------------------------------
    //  factory
    //----------------------------------

    /**
     *  The IModuleFactory implementation defined in the module.
     *  This will only be non-<code>null</code> after the
     *  <code>ModuleEvent.SETUP</code> event has been dispatched
     *  (or the <code>IModuleInfo.setup()</code> method returns <code>true</code>).
     *  At this point, the <code>IModuleFactory.info()</code> method can be called.
     *  Once a <code>ModuleEvent.READY</code> event is dispatched
     *  (or the <code>IModuleInfo.ready()</code> method returns <code>true</code>),
     *  it is possible to call the <code>IModuleFactory.create()</code> method.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function get factory():IModuleFactory;
    
    //----------------------------------
    //  loaded
    //----------------------------------

    /**
     *  A flag that is <code>true</code> if the <code>load()</code>
     *  method has been called on this module.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function get loaded():Boolean;
    
    //----------------------------------
    //  ready
    //----------------------------------

    /**
     *  A flag that is <code>true</code> if the module is sufficiently loaded
     *  to get a handle to its associated IModuleFactory implementation
     *  and call its <code>create()</code> method.
     *  
     *  <p>This flag is <code>true</code> when the ModuleManager dispatches the
     *  <code>ModuleEvent.READY</code> event.</p>
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function get ready():Boolean;
    
    /**
     * 模块名称.
     * @return 
     * 
     */    
    function get moduleName():String;
    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     *  Requests that the module be loaded. If the module is already loaded,
     *  the call does nothing. Otherwise, the module begins loading and dispatches 
     *  <code>progress</code> events as loading proceeds.
     *  
     *  @param applicationDomain The current application domain in which your code is executing.
     *  
     *  @param securityDomain The current security "sandbox".
     * 
     *  @param bytes A ByteArray object. The ByteArray is expected to contain 
     *  the bytes of a SWF file that represents a compiled Module. The ByteArray
     *  object can be obtained by using the URLLoader class. If this parameter
     *  is specified the module will be loaded from the ByteArray. If this 
     *  parameter is null the module will be loaded from the url specified in
     *  the url property.
     * 
     *  @param moduleFactory The moduleFactory of the caller. One use of the 
     *  moduleFactory is to determine the parent style manager of the loaded 
     *  module.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function load(applicationDomain:ApplicationDomain = null,
                  securityDomain:SecurityDomain = null,
                  bytes:ByteArray = null,
                  level:uint = 0):void;

    /**
     *  Unloads the module.
     *  Flash Player and AIR will not fully unload and garbage collect this module if
     *  there are any outstanding references to definitions inside the
     *  module.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    function unload():void;
}

}
