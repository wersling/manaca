package net.manaca.managers
{
import flash.display.GradientType;
import flash.display.SpreadMethod;
import flash.display.Sprite;
import flash.events.Event;
import flash.filters.DropShadowFilter;
import flash.geom.Matrix;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

/**
 * Define a defaule tooltip display.
 * @author v-seanzo
 *
 */
public class ToolTipDisplay extends Sprite implements IToolTipDisplay
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>ToolTipDisplay</code> instance.
     *
     */
    public function ToolTipDisplay()
    {
        super();

        initDisplay();

        this.filters = [ new DropShadowFilter(2, 45, 0, 0.5, 2, 2) ];
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    /**
     * Define the text field.
     */
    public var textField:TextField;
    /**
     * Define the TextFormat of textField.
     */
    public var textFormat:TextFormat;

    //==========================================================================
    //  Methods
    //==========================================================================

    private function initDisplay():void
    {
        textField = new TextField();
        textField.x = 2;
        textField.y = 1;
        textField.multiline = true;
        textField.selectable = false;
        textField.mouseEnabled = false;
        //textField.wordWrap = true;
        this.addChild(textField);

        textFormat = new TextFormat();
        textFormat.font = "Verdana,Tahoma,_sans";
        textFormat.size = 12;
        textFormat.color = 0x575757;

        this.mouseEnabled = false;
        this.mouseChildren = false;

        this.addEventListener(Event.ADDED, addedHandler);
    }

    /**
     * @inheritDoc
     */
    public function display(value:*):void
    {
        textField.autoSize = TextFieldAutoSize.LEFT;
        textField.wordWrap = false;
        if(value)
        {
            textField.htmlText = value.toString();
        }
        else
        {
            textField.htmlText = "";
        }
        textField.setTextFormat(textFormat);
    }

    private function reprint():void
    {
        var w:uint = textField.width + 4;
        var h:uint = textField.height + 4;
        var t:uint = 2;

        this.graphics.clear();
        this.graphics.beginFill(0x767676);
        this.graphics.drawRoundRectComplex(0, 0, w, h, t, t, t, t);

        var matrix:Matrix = new Matrix();
        matrix.createGradientBox(w, h, Math.PI / 2);
        this.graphics.beginGradientFill(GradientType.LINEAR, [ 0xFFFFFF, 0xe4e5f0 ], [ 100, 100 ], [ 0x00, 0xFF ], matrix, SpreadMethod.PAD);
        this.graphics.drawRoundRectComplex(1, 1, w - 2, h - 2, t, t, t, t);
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function addedHandler(event:Event):void
    {
        if(stage)
        {
            var maxWidth:Number = stage.stageWidth - 20;
            if(maxWidth && textField.width > maxWidth)
            {
                textField.wordWrap = true;
                textField.width = maxWidth;
            }
        }
        reprint();
    }
}
}