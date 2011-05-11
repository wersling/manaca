/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.modules
{
/**
 * 定义模块需要的参数和数据.
 * @author Sean Zou
 * 
 */
public class ModuleVO
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 构造一个<code>ModuleVO</code>实例.
     * @param xmlNode 定义的XML数据
     */
    public function ModuleVO(xmlNode:XML):void
    {
        this.name = xmlNode.@name;
        this.clz = xmlNode.@clz;
        this.url = xmlNode.@url;
        this.encoded = Boolean(xmlNode.@encoded == "true");
        this.preloading = Boolean(xmlNode.@preloading == "true");
    }
    
    //==========================================================================
    //  Properties
    //==========================================================================
    /**
     * 模块名称
     */    
    public var name:String;
    
    /**
     * 类索引
     */    
    public var clz:String;
    
    /**
     * 模块文件位置
     */    
    public var url:String;
    
    /**
     * 是否被加密
     */    
    public var encoded:Boolean;
    
    /**
     * 是否需要预加载
     */    
    public var preloading:Boolean;
}
}
