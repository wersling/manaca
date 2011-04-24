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
import com.gskinner.motion.GTween;

import fl.motion.easing.Elastic;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;

public class AbstractSliderShowController extends EventDispatcher
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     *
     * @param xml
     *
     *  <tv>
     *        <resource type="image" url="http://stb.sand.msn-int.com/i/BB/569EA9E71E2BE7137F76B1968B95A.jpg" link="http://www.google.com" description="testtesttest" />
     *        <resource type="swf" url="http://stb.sand.msn-int.com/i/E1/79D1FFB3E349316A95DA6567A53F.swf" link="" description="" />
     *    </tv>
     *
     */
    public function AbstractSliderShowController(screen:SliderShowScreen)
    {
        this.screen = screen;
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    protected var _imageContainer:DisplayObjectContainer;

    protected var _showIndex:int = -1;
    protected var _lastIndex:int = -1;
    protected var _loadArray:Array;
    protected var _loadedIndex:uint;
    protected var _data:Array;/* SliderShowResourceVO */

    protected var screen:SliderShowScreen;
    
    protected var fadeInTween:GTween;
    protected var fadeOutTween:GTween;
    //==========================================================================
    //  Properties
    //==========================================================================
    public function set container(obj:DisplayObjectContainer):void
    {
        this._imageContainer = obj;
    }

    public function set showIndex(value:int):void
    {
        this._showIndex = value;
        if(this._showIndex < 0)
        {
            this._showIndex = this._loadArray.length - 1;
        }
        else if(this._showIndex > this._loadArray.length - 1)
        {
            this._showIndex = 0;
        }

        fadeInLoader(SliderShowResourceLoader(_loadArray[_showIndex]));
        if (this._lastIndex >= 0)
        {
            this.fadeOutLoader(SliderShowResourceLoader(_loadArray[_lastIndex]));
        }
        _lastIndex = _showIndex;
    }

    //==========================================================================
    //  Public methods
    //==========================================================================
    public function initialize(xml:XML):void
    {
        this.screen.visible = false;

        this._loadedIndex = 0;
        this._loadArray = new Array();

        var list:XMLList = xml..resource;
        var length:int = list.length();
        for(var i:int = 0; i < length; i++)
        {
            var url:String = list[i].@url;
            var link:String = list[i].@link;
            var target:String = list[i].@target;
            var loader:SliderShowResourceLoader = new SliderShowResourceLoader();
            loader.vo = new SliderShowResourceVO(url, link, target);
            loader.resourceHolder.alpha = 0;
            loader.disable();
            this._loadArray.push(loader);
            
            _imageContainer.addChild(loader.resourceHolder);
            loader.addEventListener(Event.COMPLETE, onLoaderComplete);
            loader.startLoad();
        }
    }

    public function showNext():void
    {
        this.showIndex = this._showIndex + 1;
    }

    public function showPrev():void
    {
        this.showIndex = this._showIndex - 1;
    }

    public function dispose():void
    {
        for each (var loader:SliderShowResourceLoader in this._loadArray)
        {
            if (loader)
            {                
                loader.removeEventListener(Event.COMPLETE, onLoaderComplete);
                loader.dispose();
                loader = null;
            }
        }
        _loadArray = null;

        _data = null;

        _imageContainer = null;

        this.screen = null;
    }

    //==========================================================================
    //  Protected methods
    //==========================================================================
    protected function fadeInLoader(loader:SliderShowResourceLoader):void
    {
        loader.active();
        if (fadeInTween) 
        {
            fadeInTween.pause();
            fadeInTween.removeEventListener(Event.COMPLETE, fadeInComplete);
        }
        fadeInTween = new GTween(loader.resourceHolder, 0.8, null, Elastic.easeIn);
        fadeInTween.addEventListener(Event.COMPLETE, fadeInComplete);
        fadeInTween.setProperties({alpha:1});
    }

    protected function fadeOutLoader(loader:SliderShowResourceLoader):void
    {
        loader.disable();
        if (fadeOutTween) fadeOutTween.pause();
        fadeOutTween = new GTween(loader.resourceHolder, 0.8, null, Elastic.easeIn);
        fadeOutTween.setProperties({alpha:0});
    }

    protected function fadeInComplete(event:Event = null):void
    {
        //Overrided by subchildren
    }

    protected function clearTweeners():void
    {
        if (fadeInTween) 
        {
            fadeInTween.pause();
            fadeInTween.removeEventListener(Event.COMPLETE, fadeInComplete);
        }
        fadeInTween = null;
        if (fadeOutTween) fadeOutTween.pause();
        fadeOutTween = null;
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    protected function onLoaderComplete(event:Event):void
    {
        SliderShowResourceLoader(event.target).removeEventListener(Event.COMPLETE,
                                                           onLoaderComplete);
        var holder:Sprite = SliderShowResourceLoader(event.target).resourceHolder;
        holder.x = (_imageContainer.width - holder.width) / 2;
        holder.y = (_imageContainer.height - holder.height) / 2;
        
        this._loadedIndex ++;
        if (this._loadedIndex == this._loadArray.length)
        {
            SliderShowResourceLoader(_loadArray[0]).active();
            this.dispatchEvent(new Event(Event.COMPLETE));
        }
    }
}
}