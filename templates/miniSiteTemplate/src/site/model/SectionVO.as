package site.model
{

/**
 * 
 * @author Sean Zou
 * 
 */
public class SectionVO
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>SectionVO</code> instance.
     */
    public function SectionVO(xmlNode:XML):void
    {
        this.name = xmlNode.@name;
        this.deep = xmlNode.@deep;
        this.module = xmlNode.@module;
        var list:XMLList = xmlNode.File;
        
        for each(var item:XML in list)
        {
            var fileVO:FileVO = new FileVO(item);
            files.push(fileVO);
        }
    }
    //==========================================================================
    //  Properties
    //==========================================================================
    public var name:String;
    public var deep:String;
    public var module:String;
    
    public var menuChildren:Array = [];
    public var files:Array = [];
}
}