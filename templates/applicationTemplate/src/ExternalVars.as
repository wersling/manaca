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
    static private var _params:Object;
    
    static public var isSignin:Boolean = false;
    
    /**
     * The mian swf path.
     */    
    static public var swfPath:String;
    //==========================================================================
    //                            Public Method
    //==========================================================================
    static public function initialize(info:LoaderInfo):void
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
        
        var swfUrl:String = info.url;
        swfUrl = swfUrl.split("\\").join("/");
        var lastIndex:int = swfUrl.lastIndexOf("/");
        swfPath = swfUrl.slice(0, lastIndex);
    }
    
    static public function get defaultTextFormat():TextFormat
    {
        return new TextFormat("Tahoma,Verdana,宋体", 12, 0xFFFFFF);
    }
}
}