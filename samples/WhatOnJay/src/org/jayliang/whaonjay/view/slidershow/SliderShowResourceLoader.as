////////////////////////////////////////////////////////////////////////////////
//
//  MICROSOFT CORPORATION
//  Copyright (c) Microsoft Corporation.
//  All Rights Reserved.
//
//  NOTICE: Microsoft Confidential. Intended for Internal Use Only.
//
////////////////////////////////////////////////////////////////////////////////
package org.jayliang.whaonjay.view.slidershow
{
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;

public class SliderShowResourceLoader extends Loader
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    public function SliderShowResourceLoader()
    {
        super();
        _resourceHolder = new Sprite();
    }
    //==========================================================================
    //  Properties
    //==========================================================================
    private var _vo:SliderShowResourceVO;

    public function set vo(value:SliderShowResourceVO):void
    {
        this._vo = value;
    }

    public function get vo():SliderShowResourceVO
    {
        return this._vo;
    }

    private var _loading:Boolean = false;

    public function set loading(value:Boolean):void
    {
        _loading = value;
    }

    public function get loading():Boolean
    {
        return _loading;
    }

    private var _resourceHolder:Sprite;

    public function get resourceHolder():Sprite
    {
        return _resourceHolder;
    }
    //==========================================================================
    //  Public methods
    //==========================================================================
    public function startLoad():void
    {
        if (content)
        {
            this.dispatchEvent(new Event(Event.COMPLETE));
            return;
        }
        var request:URLRequest = new URLRequest(vo.url);
        contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
        contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,
                                           securityErrorHandler);
        load(request);
    }
    
    public function active():void
    {
        if (_resourceHolder)
        {
            this._resourceHolder.mouseChildren = true;
            this._resourceHolder.mouseEnabled = true;            
        }
    }
    
    public function disable():void
    {
        if (_resourceHolder)
        {
            this._resourceHolder.mouseChildren = false;
            this._resourceHolder.mouseEnabled = false;
        }
    }

    public function dispose():void
    {
        if (_resourceHolder)
        {
            _resourceHolder.removeEventListener(MouseEvent.CLICK,
                                                clickLinkHandler);
            if (_resourceHolder.contains(this))
            {
                _resourceHolder.removeChild(this);
            }
            _resourceHolder = null;
        }

        contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
        contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,
                                              securityErrorHandler);
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function completeHandler(event:Event):void
    {
        contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
        contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,
                                              securityErrorHandler);

        _resourceHolder.addChild(this);
        if (vo.link != "")
        {
            _resourceHolder.mouseChildren = false;
            _resourceHolder.useHandCursor = true;
            _resourceHolder.buttonMode = true;
            _resourceHolder.addEventListener(MouseEvent.CLICK, clickLinkHandler);
        }
        this.dispatchEvent(new Event(Event.COMPLETE));
    }

    private function securityErrorHandler(event:SecurityErrorEvent):void
    {
        
    }

    private function clickLinkHandler(event:MouseEvent):void
    {
        
    }

}
}