package net.manaca.logging.publishers
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.GradientType;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.system.Capabilities;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.utils.getQualifiedClassName;
import flash.utils.setTimeout;

import net.manaca.errors.SingletonError;
import net.manaca.logging.ILogPublisher;
import net.manaca.logging.LogLevel;
import net.manaca.logging.LogRecord;
import net.manaca.logging.Tracer;
import net.manaca.utils.StringUtil;

/**
 * Provides a console in flash application and show logs.
 *
 * <p>The basic workflow of using loggers is as follows:</p>
 * @example
 * <pre>
 * var logger:Logger = Logger.getLogger("myLog");
 * var output:Output = new Output(150,true);
 * this.stage.addChild(output);
 * logger.addPublisher(output);
 * logger.info("This is an information message.");
 * </pre>
 * @author Sean Zou
 *
 */
public class Output extends Sprite implements ILogPublisher
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * max text show length number.
     */
    public static var MAX_TXT_LENGTH:int = 1000;
    
    /**
     * max text show line number.
     */
    public static var MAX_LINE:int = 50;
    
    //is outo expand.
    private static var autoExpand:Boolean = true;
    
    //the yes/no strong.
    private static var isStrong:Boolean = false;
    
    private static var title:String = "Wersling Output v2.1";
    
    /**
     *  @private
     */
    public static var instance:Output;
    
    //==========================================================================
    //  Variables
    //==========================================================================
    //log history list.
    private var history:Array = new Array();
    
    //default text format
    private const defaultTextFormat:TextFormat = 
        new TextFormat("Verdana,Tahoma,_sans");
    
    //search text field
    private var searchLabel:TextField;
    
    private var searchLabelBg:TextField;
    
    //content text field
    private var outputTxt:TextField;
    
    //title bar
    private var titleBar:Sprite;
    
    //the out put parent.
    private var _parent:DisplayObjectContainer;
    
    private var invalidateTimeOut:int = 0;
    //------------------------
    //  private const
    //------------------------
    [Embed("images/delete.gif")]
    private var deleteIcon:Class;
    
    [Embed("images/pin.gif")]
    private var pinIcon:Class;
    
    [Embed("images/unpin.gif")]
    private var unpinIcon:Class;
    
    [Embed("images/close.gif")]
    private var closeIcon:Class;
    
    private const textClolors:Array = 
        [ "#666666", "#0066FF", "#FFCC00", "#FF0000", "#CC0000", "#000000" ];
    
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Output Constructor.
     * Create a new <code>Output</code> instance.
     * @param outputHeight The output show height
     * @param strong Indicates whether is use strong mode.
     */
    public function Output(outputHeight:uint = 150, strong:Boolean = false)
    {
        if (instance)
        {
            throw new SingletonError(this);
        }
        
        instance = this;
        isStrong = strong;
        
        this.level = LogLevel.ALL;
        // init ui
        addChild(newOutputField(outputHeight));
        addChild(newTitleBar());
        
        // add listener
        addEventListener(Event.ADDED, addedHandler);
        addEventListener(Event.REMOVED, removedHandler);
        
        Tracer.logger.addPublisher(this);
        
        Tracer.info("FlashPlayer version:" + 
            Capabilities.version + "; isDebugger: " + Capabilities.isDebugger);
    }
    
    //==========================================================================
    //  Properties
    //==========================================================================
    
    //----------------------------------
    //  level
    //----------------------------------
    /**
     * @private
     * Storage for the level property.
     */
    private var _level:LogLevel;
    
    /**
     * @inheritDoc
     */
    public function get level():LogLevel
    {
        return _level;
    }
    
    public function set level(value:LogLevel):void
    {
        _level = value;
    }
    
    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * @inheritDoc
     */
    public function publish(logRecord:LogRecord):void
    {
        if (this.isLoggable(logRecord))
        {
            addMsg(this.format(logRecord), logRecord.getLevel().value);
        }
    }
    
    /**
     * Format the provide logRecord to string.
     *
     * <p>the string format:</p>
     * <p>[LevelName]    Time message</p>
     * <p>[DEBUG]    12:02:22 this is debug message</p>
     * @param logRecord a logRecord.
     * @return a formated string.
     */
    private function format(logRecord:LogRecord):String
    {
        var formatted:String;
        formatted = "[" + logRecord.getLevel().name + "]  " + 
            logRecord.getDate().toTimeString().slice(0, 8) + "  " + 
            StringUtil.htmlEncode(logRecord.getMessage());
        return formatted;
    }
    
    /**
     * @inheritDoc
     */
    public function isLoggable(logRecord:LogRecord):Boolean
    {
        if (this.level > logRecord.getLevel())
        {
            
            return false;
        }
        
        return true;
    }
    
    
    //-------------------------------------------------------------------
    // private Methods
    //-------------------------------------------------------------------
    
    /**
     * add a massage to output.
     * @param str
     * @param level
     *
     */
    private function addMsg(str:*, level:uint):void
    {
        if (!instance)
        {
            return;
        }
        
        if (isStrong)
        {
            history.push({ msg:str, level:getColorTextByLevel(str, level)});
            
            if (history.length > MAX_LINE)
            {
                history.shift();
            }
            if (_parent && _parent.contains(this))
            {
                invalidateHtmlText();
            }
        }
        else
        {
            outputTxt.appendText(str + "\n");
            if (outputTxt.length > MAX_TXT_LENGTH)
            {
                outputTxt.text = outputTxt.text.slice(-MAX_TXT_LENGTH);
            }
            outputTxt.scrollV = outputTxt.maxScrollV;
            outputTxt.setTextFormat(defaultTextFormat);
        }
        
        if (autoExpand && !outputTxt.visible)
        {
            toggleCollapse();
        }
    }
    
    private function invalidateHtmlText(...arg):void
    {
        if(!invalidateTimeOut)
        {
            invalidateTimeOut = setTimeout(updateHtmlText, 500);
        }
    }
    /**
     * update the heml text.
     */
    private function updateHtmlText():void
    {
        invalidateTimeOut = 0;
        if (!outputTxt.visible || !isStrong)
        {
            return;
        }
        var str:String = "";
        var len:uint = instance.history.length;
        
        var i:uint;
        if (searchLabel.text.length > 0)
        {
            var serach_str:String = searchLabel.text;
            for (i = 0; i < len; i++)
            {
                var s:String = instance.history[i].msg;
                if (s.indexOf(serach_str) != -1)
                {
                    str = str + instance.history[i].level + "<br>";
                }
            }
        }
        else
        {
            for (i = 0; i < len; i++)
            {
                str = str + instance.history[i].level + "<br>";
            }
        }
        instance.outputTxt.text = "";
        instance.outputTxt.htmlText = str;
        instance.outputTxt.setTextFormat(defaultTextFormat);
        outputTxt.scrollV = outputTxt.maxScrollV;
    }
    
    /**
     * get a text field.
     * @param outputHeight
     * @return
     *
     */
    private function newOutputField(outputHeight:uint):TextField
    {
        outputTxt = new TextField();
        outputTxt.type = TextFieldType.INPUT;
        outputTxt.border = true;
        outputTxt.borderColor = 0;
        outputTxt.background = true;
        outputTxt.backgroundColor = 0xFFFFFF;
        outputTxt.height = outputHeight;
        outputTxt.multiline = true;
        return outputTxt;
    }
    
    /**
     * get a title bar.
     * @return
     *
     */
    private function newTitleBar():Sprite
    {
        //bar
        var barGraphics:Sprite = new Sprite();
        barGraphics.name = "bar";
        var colors:Array = new Array(0xF2F2F2, 0xD9D9D9, 0xCDCDCD);
        var alphas:Array = new Array(1, 1, 1);
        var ratios:Array = new Array(0, 125, 255);
        var gradientMatrix:Matrix = new Matrix();
        gradientMatrix.createGradientBox(20, 20, Math.PI / 2, 0, 0);
        barGraphics.graphics.lineStyle(0, 0xA7A7A7);
        barGraphics.graphics.beginGradientFill(
            GradientType.LINEAR, colors, alphas, ratios, gradientMatrix);
        barGraphics.graphics.drawRect(0, 0, 20, 20);
        
        //title
        var barLabel:TextField = new TextField();
        barLabel.mouseEnabled = false;
        barLabel.selectable = false;
        barLabel.autoSize = TextFieldAutoSize.LEFT;
        barLabel.text = title;
        barLabel.setTextFormat(defaultTextFormat);
        barLabel.x = 2;
        barLabel.y = 1;
        
        if (isStrong)
        {
            //tools
            var tools:Sprite = new Sprite();
            tools.name = "tools";
            
            //search bg
            var searchBg:Shape = new Shape();
            searchBg.graphics.beginFill(0x94959D);
            searchBg.graphics.drawRect(0, 0, 120, 17);
            searchBg.graphics.beginFill(0xFFFFFF);
            searchBg.graphics.drawRect(1, 1, 118, 15);
            
            //search text
            searchLabel = new TextField();
            searchLabel.type = TextFieldType.INPUT;
            searchLabel.width = 120;
            searchLabel.height = 18;
            searchLabel.defaultTextFormat = defaultTextFormat;
            searchLabel.addEventListener(Event.CHANGE, invalidateHtmlText);
            searchLabel.addEventListener(FocusEvent.FOCUS_IN, 
                searchTextFocusEventHandler);
            searchLabel.addEventListener(FocusEvent.FOCUS_OUT, 
                searchTextFocusEventHandler);
            
            searchLabelBg = new TextField();
            searchLabelBg.width = 120;
            searchLabelBg.height = 18;
            searchLabelBg.defaultTextFormat = defaultTextFormat;
            searchLabelBg.textColor = 0xcccccc;
            searchLabelBg.text = "Search";
            searchBg.x = searchLabel.x = searchLabelBg.x = 0;
            searchLabel.y = searchLabelBg.y = -1;
            //deldet butten
            var clearBut:Sprite = new Sprite();
            clearBut.buttonMode = true;
            var clearButUp:DisplayObject = new deleteIcon() as DisplayObject;
            clearBut.addChild(clearButUp);
            clearBut.addEventListener(MouseEvent.CLICK, clear);
            
            clearBut.x = searchBg.x + searchBg.width + 4;
            
            //pin butten
            var pinBut:Sprite = new Sprite();
            pinBut.buttonMode = true;
            var pin:DisplayObject = new pinIcon() as DisplayObject;
            pin.name = "pin";
            var unpin:DisplayObject = new unpinIcon() as DisplayObject;
            unpin.name = "unpin";
            
            pinBut.addChild(pin);
            pinBut.addChild(unpin);
            unpin.visible = false;
            pinBut.x = clearBut.x + clearBut.width + 4;
            pinBut.y = 3;
            pinBut.addEventListener(MouseEvent.CLICK, pinCollapse);
            
            //close butten
            var closeBut:Sprite = new Sprite();
            closeBut.buttonMode = true;
            var closeUp:DisplayObject = new closeIcon() as DisplayObject;
            closeBut.addChild(closeUp);
            closeBut.x = pinBut.x + pinBut.width + 5;
            closeBut.addEventListener(MouseEvent.CLICK, closeButtonHandler);
            
            tools.addChild(searchBg);
            tools.addChild(searchLabelBg);
            tools.addChild(searchLabel);
            tools.addChild(clearBut);
            tools.addChild(pinBut);
            tools.addChild(closeBut);
            tools.y = 2;
        }
        
        titleBar = new Sprite();
        titleBar.addChild(barGraphics);
        if (isStrong)
        {
            titleBar.addChild(tools);
        }
        titleBar.addChild(barLabel);
        return titleBar;
    }
    
    
    /**
     * get color text.
     * @param msg
     * @param levle
     *
     */
    private function getColorTextByLevel(msg:String, level:uint):String
    {
        var colr:String;
        var space:String = "";
        switch (level)
        {
            case LogLevel.DEBUG.value:
            {
                colr = textClolors[0];
                break;
            }
            case LogLevel.INFO.value:
            {
                colr = textClolors[1];
                space = "   ";
                break;
            }
            case LogLevel.WARN.value:
            {
                colr = textClolors[2];
                space = " ";
                break;
            }
            case LogLevel.ERROR.value:
            {
                colr = textClolors[3];
                break;
            }
            case LogLevel.FATAL.value:
            {
                colr = textClolors[4];
                space = " ";
                break;
            }
            default:
            {
                colr = textClolors[5];
                break;
            }
        }
        
        return "<font color=\"" + colr + "\">" + space + msg + "</font>";
    }
    
    //==========================================================================
    //  Event handlers
    //==========================================================================
    /**
     * The Output added event handler.
     *
     */
    private function addedHandler(evt:Event):void
    {
        _parent = this.parent;
        stage.addEventListener(Event.RESIZE, fitToStage);
        stage.addEventListener(KeyboardEvent.KEY_UP, shortcutKey);
        
        titleBar.getChildByName("bar").addEventListener(MouseEvent.CLICK, toggleCollapse);
        
        fitToStage();
        
        if (isStrong && history.length > 0)
        {
            invalidateHtmlText();
        }
    }
    
    /**
     * The Output removed event handler.
     *
     */
    private function removedHandler(evt:Event):void
    {
        stage.removeEventListener(Event.RESIZE, fitToStage);
        
        titleBar.removeEventListener(MouseEvent.CLICK, toggleCollapse);
    }
    
    /**
     * toggle event handler.
     * @param evt
     *
     */
    private function toggleCollapse(evt:Event = null):void
    {
        if (!instance)
            return;
        outputTxt.visible = !outputTxt.visible;
        invalidateHtmlText();
        fitToStage(evt);
    }
    
    
    /**
     * pin or unpin the output.
     * @param e
     *
     */
    private function pinCollapse(e:MouseEvent):void
    {
        var pin:DisplayObject = Sprite(e.target).getChildByName("pin");
        var unpin:DisplayObject = Sprite(e.target).getChildByName("unpin");
        
        pin.visible = !pin.visible;
        unpin.visible = !unpin.visible;
        
        autoExpand = pin.visible;
    }
    
    /**
     * change the output size.
     * @param evt
     *
     */
    private function fitToStage(evt:Event = null):void
    {
        if (!stage)
            return;
        outputTxt.width = stage.stageWidth;
        outputTxt.y = stage.stageHeight - outputTxt.height;
        titleBar.y = (outputTxt.visible) ? 
            outputTxt.y - titleBar.height : stage.stageHeight - titleBar.height;
        titleBar.getChildByName("bar").width = stage.stageWidth;
        
        if (isStrong)
        {
            var tools:DisplayObject = titleBar.getChildByName("tools");
            tools.x = stage.stageWidth - tools.width - 4;
        }
    }
    
    /**
     * remove the output.
     * @param e
     *
     */
    private function closeButtonHandler(e:MouseEvent = null):void
    {
        if (parent && parent.contains(this))
        {
            parent.removeChild(this);
        }
    }
    
    /**
     * shortcutKey handler.
     * @param e
     */
    private function shortcutKey(e:KeyboardEvent):void
    {
        var effective:Boolean = false;
        if (e.shiftKey && e.altKey && e.ctrlKey && e.keyCode == 79)
        {
            effective = true;
        }
        
        if (Capabilities.os.toLowerCase().indexOf("mac") != -1)
        {
            if (e.shiftKey && e.ctrlKey && e.keyCode == 15)
            {
                effective = true;
            }
        }
        if (effective)
        {
            if (instance && _parent != null)
            {
                if (parent && parent.contains(this))
                {
                    parent.removeChild(this);
                }
                else
                {
                    _parent.addChild(this);
                    updateHtmlText();
                }
            }
        }
    }
    
    /**
     * show/hide search tooltip.
     * @param e
     *
     */
    private function searchTextFocusEventHandler(e:Event):void
    {
        if (e.type == FocusEvent.FOCUS_IN)
        {
            searchLabelBg.text = "";
        }
        else if (e.type == FocusEvent.FOCUS_OUT && searchLabel.text.length == 0)
        {
            searchLabelBg.text = "Search";
        }
    }
    
    /**
     * clear all massage.
     */
    private function clear(e:MouseEvent):void
    {
        outputTxt.text = "";
        if (searchLabel)
            searchLabel.text = "";
        history = new Array();
    }
    
    /**
     *
     * @return
     * @see Object#toString()
     */
    override public function toString():String
    {
        return "[object " + getQualifiedClassName(this) + "]";
    }
    
    public function dispose():void
    {
        clear(null);
    }
}
}