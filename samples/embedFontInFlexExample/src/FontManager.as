package
{
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.text.AntiAliasType;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.getQualifiedClassName;

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
    //  Class variables
    //==========================================================================

    /**
     *  @private
     */
    private static var instance:FontManager;

    //==========================================================================
    //  Class methods
    //==========================================================================

    /**
     *  Returns the sole instance of this singleton class,
     *  creating it if it does not already exist.
     */
    public static function getInstance():FontManager
    {
        if (!instance)
        {
            instance = new FontManager();
        }
        return instance;
    }

    /**
     * Set text to appointed TextField using embed font.
     * @param textFiled the appointed TextField
     * @param text will setting text string.
     * @param font the embed fontName
     *
     */
    public static function setTest(textField:TextField, text:String, fontName:String):void
    {
        if(textField == null) return;

        var textFormat:TextFormat = textField.getTextFormat();
        textField.text = text;
        textField.embedFonts = true;
        textField.antiAliasType = AntiAliasType.ADVANCED;
        textFormat.font = fontName;

        textField.setTextFormat(textFormat);
    }

    /**
     * Set htmlText to appointed TextField using embed font.
     * @param textFiled the appointed TextField
     * @param text will setting text string.
     * @param font the embed fontName
     *
     */
    public static function setHtmlTest(textField:TextField, htmlText:String, fontName:String):void
    {
        if(textField == null) return;

        var textFormat:TextFormat = textField.getTextFormat();
        textField.text = htmlText;
        textField.embedFonts = true;
        textField.antiAliasType = AntiAliasType.ADVANCED;
        textFormat.font = fontName;

        textField.setTextFormat(textFormat);
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    private var urlList:Array = [];
    private var loader:Loader;

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
        if(instance)
        {
            throw new Error("Only one " + getQualifiedClassName(instance) + " instance can be instantiated.");
        }
    }


    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * Start loading a fonts file.
     * @param url
     *
     */
    public function loadFontFile(url:String):void
    {
        urlList.push(url);
        loadNextFile();
    }

    /**
     * Start loading a fonts file list.
     * @param urls
     *
     */
    public function loadFontsFiles(urls:Array):void
    {
        urlList = urlList.concat(urls);
        loadNextFile();
    }

    /**
     * loading next fonts file.
     *
     */
    private function loadNextFile():void
    {
        if(!loader && urlList.length > 0)
        {
            var url:String = urlList.shift();
            if(url)
            {
                loader = new Loader();
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompletedHandler);
                loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
                loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
                loader.load(new URLRequest(url));
            }
        }
        else
        {
            this.dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    /**
     * register fonts.
     *
     */
    public function registerFonts(loaderInfo:LoaderInfo):void
    {
        if(loaderInfo && loaderInfo.contentType == "application/x-shockwave-flash")
        {
            var className:String = getFilename(loaderInfo.url);
            var fontClz:Class = loaderInfo.applicationDomain.getDefinition(className) as Class;

            var fonts:Array = new fontClz().fonts;
            if(fonts)
            {
                var len:uint = fonts.length;
                for(var i:uint = 0 ;i < len; i++ )
                {
                    Font.registerFont(fonts[i]);
                }
            }
        }
        else
        {
            throw new Error("Register fonts failed!");
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
        loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadCompletedHandler);
        loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
        loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
        loader = null;
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

        if(this.willTrigger(IOErrorEvent.IO_ERROR))
        {
            this.dispatchEvent(event.clone());
        }
        else
        {
            throw new Error('Unhandled IOErrorEvent:' + event.toString(), 2044);
        }

        loadNextFile();
    }

    private function progressHandler(event:ProgressEvent):void
    {
        this.dispatchEvent(event.clone());
    }
}
}