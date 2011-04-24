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
public class SliderShowResourceVO
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    public function SliderShowResourceVO(url:String, link:String = "",
                                         target:String = "_blank")
    {
        _url = url;
        _link = link;
        _target = target;
    }
    //==========================================================================
    //  Properties
    //==========================================================================
    private var _url:String;

    public function get url():String
    {
        return this._url;
    }

    private var _link:String;

    public function get link():String
    {
        return this._link;
    }

    private var _target:String;

    public function get target():String
    {
        return this._target;
    }
}
}