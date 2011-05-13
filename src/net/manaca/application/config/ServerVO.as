/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.application.config
{
public class ServerVO
{
    public function ServerVO(xmlNode:XML):void
    {
        this.id = xmlNode.@id;
        this.domain = xmlNode.@domain;
        this.swfPath = xmlNode.@swfPath;
        this.imagePath = xmlNode.@imagePath;
        this.httpServer = xmlNode.@httpServer;
    }
    //==========================================================================
    //  Properties
    //==========================================================================
    public var id:String;
    public var domain:String;
    public var imagePath:String;
    public var scenePath:String;
    public var swfPath:String;
    public var httpServer:String;
}
}
