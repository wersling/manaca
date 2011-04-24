package net.manaca.xml.types
{
public class SchemaUint extends SchemaSimpleNode
{
    public function SchemaUint(newValue:*)
    {
        super(newValue);
    }
    
    public function getValue():uint
    {
        return domNode;
    }
    
    public function setValue(value:uint):void
    {
        domNode = value;
    }
    
    public function clone():SchemaUint
    {
        return new SchemaUint(domNode);
    }
    
    public function valueOf():Object
    {
        return this.getValue();
    }
}
}