/*
 * Copyright (c) 2011, 9nali.com All rights reserved.
 */
package com.yahoo.astra.layout.modes
{
import com.yahoo.astra.layout.modes.BoxLayout;
import com.yahoo.astra.layout.modes.LayoutModeUtil;
import com.yahoo.astra.layout.modes.PercentageSizeUtil;

import flash.display.DisplayObject;
import flash.geom.Rectangle;

/**
 * 继承自BoxLayout,基本逻辑一样，但在layout的时候
 * 如maintainAspectRatio值为true,则会重设所有Children的宽度或高度
 * @author austin
 *
 */
public class AdvancedBoxLayout extends BoxLayout
{
    //--------------------------------------
    //  Static Properties
    //--------------------------------------

    /**
     * @private
     * The default maximum number of pixels to calculate width sizing.
     */
    private static const DEFAULT_MAX_WIDTH:Number = 10000;

    /**
     * @private
     * The default maximum number of pixels to calculate height sizing.
     */
    private static const DEFAULT_MAX_HEIGHT:Number = 10000;

    public function AdvancedBoxLayout()
    {
        super();
    }

    private var _maintainAspectRatio:Boolean;

    /**
     * 是否维持外观比例, 默认为false
     * 为false时不对Children进行任何操作
     *
     * 为true时:
     * direction == "vertical"时重设所有 Children的宽度
     * direction == "horizontal"时重设所有 Children的高度
     * @return
     *
     */
    public function get maintainAspectRatio():Boolean
    {
        return _maintainAspectRatio;
    }

    public function set maintainAspectRatio(value:Boolean):void
    {
        _maintainAspectRatio = value;
    }


    override public function layoutObjects(displayObjects:Array, bounds:Rectangle):Rectangle
    {
        var childrenInLayout:Array = this.configureChildren(displayObjects);

        //determine the available horizontal space
        var hSpaceForChildren:Number = bounds.width - this.paddingLeft - this.paddingRight;
        if((hSpaceForChildren == Infinity)||(hSpaceForChildren >9000))
        {
            hSpaceForChildren = DEFAULT_MAX_WIDTH;
        }

        //determine the available vertical space
        var vSpaceForChildren:Number = bounds.height - this.paddingTop - this.paddingBottom;
        if((vSpaceForChildren == Infinity)||(vSpaceForChildren >9000))
        {
            vSpaceForChildren = DEFAULT_MAX_HEIGHT;
        }

        //resize the children based on the available space and the specified percentage width and height values.
        if(this.direction == "vertical")
        {
            vSpaceForChildren -= (this.verticalGap * (childrenInLayout.length - 1));
            PercentageSizeUtil.flexChildHeightsProportionally(this.clients, this.configurations, hSpaceForChildren, vSpaceForChildren);
        }
        else
        {
            hSpaceForChildren -= (this.horizontalGap * (childrenInLayout.length - 1));
            PercentageSizeUtil.flexChildWidthsProportionally(this.clients, this.configurations, hSpaceForChildren, vSpaceForChildren);
        }

        this.maxChildWidth = 0;
        this.maxChildHeight = 0;
        var childCount:int = childrenInLayout.length;
        for(var i:int = 0; i < childCount; i++)
        {
            var child:DisplayObject = DisplayObject(childrenInLayout[i]);
            if (_maintainAspectRatio)
            {
                if(this.direction == "vertical")
                {
                    child.width = bounds.width;
                }
                else
                {
                    child.height = bounds.height;
                }
            }
            //measure the child's width
            this.maxChildWidth = Math.max(this.maxChildWidth, child.width);
            this.maxChildHeight = Math.max(this.maxChildHeight, child.height);
        }

        if(this.direction == "vertical")
        {
            this.layoutChildrenVertically(childrenInLayout, bounds);
        }
        else
        {
            this.layoutChildrenHorizontally(childrenInLayout, bounds);
        }

        bounds = LayoutModeUtil.calculateChildBounds(childrenInLayout);
        bounds.width += this.paddingRight;
        bounds.height += this.paddingBottom;
        return bounds;
    }
}
}
