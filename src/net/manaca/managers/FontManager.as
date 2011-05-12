package net.manaca.managers
{
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

import net.manaca.errors.IllegalStateError;
import net.manaca.logging.Tracer;

//--------------------------------------
//  Events
//--------------------------------------
/**
 * Dispatched when the fonts file loading completed.
 * @eventType flash.events.Event.COMPLETE
 */
[Event(name = "complete", type = "flash.events.Event")]

/**
 * Dispatched when the fonts file update progress.
 * @eventType flash.events.ProgressEvent.PROGRESS
 */
[Event(name = "progress", type = "flash.events.ProgressEvent")]

/**
 * Dispatched when the fonts file had ioError.
 * @eventType flash.events.IOErrorEvent.IO_ERROR
 */
[Event(name = "ioError", type = "flash.events.IOErrorEvent")]

/**
 * The FontManager manager the embed fonts.
 * You can loading fonts file using the manager,
 * and set a embed file to TextFiled.
 * @author Sean
 * 
 */    
public class FontManager extends EventDispatcher
{
    //==========================================================================
    //  Class methods
    //==========================================================================
    /**
     * Set text to appointed TextField using embed font.
     * @param textFiled the appointed TextField
     * @param text will setting text string.
     * @param font the embed fontName
     * @param isHtml is setting the html test.
     * @param size change the font size of textField. if NaN, do not change.
     * @param color change the font color of textField. if NaN, do not change.
     * @throws com.msn.beet.errors.ArgumentNullException 
     * if the textField is null.
     */
    static public function setText(textField:TextField, 
                                   text:String, 
                                   fontName:String,
                                   isHtml:Boolean = false,
                                   size:Number = NaN,
                                   color:Number = NaN
                                    ):void
    {
        if (textField == null) 
        {
            throw new ArgumentError("Argument textField can't is null");
        }
        
        if (text == null)
        {
            text = "";
        }
        textField.embedFonts = true;
        
        var textFormat:TextFormat = textField.getTextFormat();
        
        if (!isNaN(size))
        {
            textFormat.size = size;
        }
        
        if (!isNaN(color))
        {
            textFormat.color = color;
        }
        
        if (isHtml)
        {
            textField.htmlText = text;
        }
        else
        {
            textField.text = text;
        }
        
        textFormat.font = fontName;
        textField.setTextFormat(textFormat);
    }
    
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>FontManager</code> instance.
     * 
     */
    public function FontManager()
    {
        super();
    }
    
    //==========================================================================
    //  Variables
    //==========================================================================
    private var urlList:Array /* of String */ = [];
    private var loader:Loader;
    
    //==========================================================================
    //  Publc methods
    //==========================================================================
    /**
     * Start loading a fonts file.
     * @param url a swf file.
     * 
     */
    public function loadFontsFile(url:String):void
    {
        urlList.push(url);
        loadNextFile();
    }

    /**
     * Start loading a fonts file list.
     * @param urls the swf files list.
     * 
     */
    public function loadFontsFiles(urls:Array):void
    {
        urlList = urlList.concat(urls);
        loadNextFile();
    }
    
    /**
     * Register fonts.
     * @param A swf with incloud some fonts. 
     * @throws com.adobe.errors.IllegalStateError if the loaderInfo is null or 
     * not swf format, throw this error.
     */
    public function registerFonts(loaderInfo:LoaderInfo):void
    {
        if (loaderInfo && 
                loaderInfo.contentType == "application/x-shockwave-flash")
        {
            var className:String = getFilename(loaderInfo.url);
            var fontClz:Class = 
                loaderInfo.applicationDomain.getDefinition(className) as Class;
            
            var fonts:Array = new fontClz().fonts;
            if (fonts)
            {
                var len:uint = fonts.length;
                for (var i:uint = 0; i < len; i++)
                {
                    Font.registerFont(fonts[i]);
                    
                    Tracer.debug("Register font:" + fonts[i].toString());
                }
            }
        }
        else
        {
            throw new IllegalStateError("Register fonts failed!");
        }
    }
    
    //==========================================================================
    //  Private methods
    //==========================================================================
    /**
     * loading next fonts file.
     * 
     */
    private function loadNextFile():void
    {
        if (!loader && urlList.length > 0)
        {
            var url:String = urlList.shift();
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, 
                                                    loadCompletedHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, 
                                                    errorHandler);
            loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, 
                                                    progressHandler);
            loader.load(new URLRequest(url));
        }
        else if(urlList.length == 0)
        {
            this.dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    /**
     * Get file name of url.
     * @param path
     * @return 
     * 
     */
    private function getFilename(path:String):String
    {
        var pathStr:String = path;
        var filename:String;
        var index:int;
    
        // Find the last path separator.
        index = pathStr.lastIndexOf("/");
    
        if (index != -1)
        {
            filename = pathStr.substr(index + 1);
        }
        else
        {
            filename = pathStr;
        }
    
        // The caller has requested that the extension be removed
        index = filename.lastIndexOf(".");

        if (index != -1)
        {
            filename = filename.substr(0, index);
        }
        return filename;
    }

    private function removeListeners():void
    {
        if (loader)
        {
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, 
                                                    loadCompletedHandler);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, 
                                                    errorHandler);
            loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, 
                                                    progressHandler);
            loader = null;
        }
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function loadCompletedHandler(event:Event):void
    {
        registerFonts(loader.contentLoaderInfo);
        
        removeListeners();
        
        loadNextFile();
    }

    private function errorHandler(event:IOErrorEvent):void
    {
        removeListeners();
        
        if (this.willTrigger(IOErrorEvent.IO_ERROR))
        {
            this.dispatchEvent(event.clone());
        }
        else
        {
            throw new Error("Unhandled IOErrorEvent:" + event.toString(), 2044);
        }
        
        loadNextFile();
    }

    private function progressHandler(event:ProgressEvent):void
    {
        this.dispatchEvent(event.clone());
    }
}
}