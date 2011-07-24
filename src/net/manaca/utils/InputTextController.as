package net.manaca.utils
{
import flash.events.FocusEvent;
import flash.text.TextField;
import flash.text.TextFieldType;

/**
 * <code>InputTextController</code> 提供一个工具类用于控制文本输入框的输入和提示。
 * @author wersling
 *
 */
public class InputTextController
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>InputTextController</code> instance.
     * @param inputText 需要控制的文本框
     * @param infoText 默认的文本提示信息，如果为空，则采用文本框中内容
     * @param isPassword 是否显示为密码
     * 
     */    
    public function InputTextController(inputText:TextField, 
                                        infoText:String = "", 
                                        isPassword:Boolean = false)
    {
        this._inputText = inputText;
        this.isPassword = isPassword;
        this.infoText = infoText ? infoText : inputText.text;

        errorColor = inputText.textColor;
        inputText.type = TextFieldType.INPUT;

        inputText.addEventListener(FocusEvent.FOCUS_IN,
                                   inputText_focusInHanlder)
        inputText.addEventListener(FocusEvent.FOCUS_OUT,
                                   inputText_focusOutHanlder);
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var errorColor:uint;
    private var isPassword:Boolean;
    //==========================================================================
    //  Properties
    //==========================================================================
    private var _inputText:TextField;

    /**
     * 需要控制的文本框
     * @return 
     * 
     */    
    public function get inputText():TextField
    {
        return _inputText;
    }

    //----------------------------------
    //  infoText
    //----------------------------------
    private var _infoText:String;

    /**
     * 在内容为空时显示的提示文字
     * @return 
     * 
     */    
    public function get infoText():String
    {
        return _infoText;
    }

    public function set infoText(value:String):void
    {
        _infoText = value;

        reset();
    }

    //----------------------------------
    //  text
    //----------------------------------
    /**
     * 获取用户输入的内容，非提示信息和错误信息
     * @return 
     * 
     */    
    public function get text():String
    {
        return inputText.text == infoText ||
            inputText.text == _errorText ? "" : inputText.text;
    }
    //----------------------------------
    //  errorText
    //----------------------------------
    private var _errorText:String;
    /**
     * 显示的错误文本
     * @param value
     * 
     */
    public function errorText(value:String):void
    {
        _errorText = value;
        inputText.displayAsPassword = false;
        inputText.text = _errorText;
        inputText.textColor = errorColor;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * 重设文本框
     * 
     */        
    public function reset():void
    {
        inputText.displayAsPassword = false;
        inputText.text = infoText;
        inputText.textColor = errorColor;
    }
    
    /**
     * 销毁该实例
     * 
     */    
    public function dispose():void
    {
        inputText.removeEventListener(FocusEvent.FOCUS_IN,
            inputText_focusInHanlder)
        inputText.removeEventListener(FocusEvent.FOCUS_OUT,
            inputText_focusOutHanlder);
    }

    //==========================================================================
    //  Event Handlers
    //==========================================================================
    protected function inputText_focusInHanlder(event:FocusEvent):void
    {
        inputText.displayAsPassword = isPassword;

        if (inputText.text == infoText || inputText.text == _errorText)
        {
            inputText.text = "";
            inputText.textColor = 0x000000;
        }
    }

    protected function inputText_focusOutHanlder(event:FocusEvent):void
    {
        if (inputText.text == "")
        {
            inputText.displayAsPassword = false;
            inputText.text = infoText;
            inputText.textColor = errorColor;
        }
    }
}
}