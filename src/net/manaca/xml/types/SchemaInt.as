package net.manaca.xml.types
{
public class SchemaInt extends SchemaSimpleNode
{
    public function SchemaInt(newValue:*)
    {
        super(newValue);
    }
    
    public function getValue():int
    {
        return domNode;
    }
    
    public function setValue(value:int):void
    {
        domNode = value;
    }
    
    public function clone():SchemaInt
    {
        return new SchemaInt(domNode);
    }
    
    public function valueOf():Object
    {
        return this.getValue();
    }
}
}