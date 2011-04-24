package net.manaca.tracking.sender
{
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import net.manaca.errors.IllegalArgumentError;
import net.manaca.logging.Tracer;
import net.manaca.utils.StringUtil;

/**
 *     <tracking basePath="http://musicbo.googlecode.com/files/">
<track action="track_main">track_main.txt</track>
<track action="track_play">track_play.txt</track>
<track action="track_list">track_list.txt</track>
</tracking>
 *
 * @author Sean
 *
 */
public class DefaultSender implements ITrackingSender
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var trackingList:*;

    private var basePath:String;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>DefaultSender</code> instance.
     * @param trackingList the value is XML or XMLList
     */
    public function DefaultSender(trackingList:*)
    {
        if(trackingList && (trackingList is XML || trackingList is XMLList))
        {
            this.trackingList = trackingList;

            basePath = trackingList.@basePath;
        }
        else
        {
            throw new IllegalArgumentError("The trackingList value need is XML or XMLList");
        }
    }

    /**
     *
     * @param action
     * @param rest
     *
     */
    public function externalTrack(action:String, rest:Array):void
    {
        if(action == null || action == "")
        {
            return;
        }
        var value:String = trackingList.track.(@action == action);
        if(value && rest)
        {
            value = StringUtil.substitute(value, rest);
        }

        if(value)
        {
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            var urlRequest:URLRequest = new URLRequest();
            urlRequest.url = basePath + value;
            try
            {
                loader.load(urlRequest);
            }
            catch(error:Error)
            {
                Tracer.error(error);
            }

            Tracer.debug("[TRACKING]:" + urlRequest.url);
        }
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function errorHandler(event:Event):void
    {
        Tracer.error(event);
    }
}
}