package site.model
{
public class FileVO
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>FileVO</code> instance.
     * 
     */
    public function FileVO(xmlNode:XML):void
    {
        this.url = xmlNode.@url;
        this.name = xmlNode.@name;
        this.type = xmlNode.@type;
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    
    //==========================================================================
    //  Properties
    //==========================================================================
    public var url:String;
    public var name:String;
    public var type:String;
}
}