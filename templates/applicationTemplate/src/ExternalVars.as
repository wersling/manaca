package
{
import flash.display.LoaderInfo;
import flash.system.Capabilities;
import flash.text.TextFormat;

/**
 * 
 * @author Sean Zou
 * 
 */    
public class ExternalVars
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    private static var _params:Object;
    
    public static var isSignin:Boolean = false;
    //==========================================================================
    //                            Public Method
    //==========================================================================
    public static function initialize(info:LoaderInfo):void
    {
        var playerType:String = Capabilities.playerType;
        if ((playerType == "PlugIn" || playerType == "ActiveX"))
        {
            var params:Object = info.parameters;
            if(params.hasOwnProperty("isSignin"))
            {
                isSignin =  params["isSignin"] == "true";
            }
        }
    }
    
    public static function get defaultTextFormat():TextFormat
    {
        return new TextFormat("Tahoma,Verdana,宋体", 12, 0xFFFFFF);
    }
}
}