package net.manaca.xml.types
{
import flash.utils.ByteArray;

public class SchemaByte extends SchemaSimpleNode
{
    public function SchemaByte(newValue:*)
    {
        super(newValue);
    }
    
    public function getValue():ByteArray
    {
        return domNode;
    }
    
    public function setValue(value:ByteArray):void
    {
        domNode = value;
    }
    
    public function clone():SchemaByte
    {
        return new SchemaByte(domNode);
    }
    
    public function valueOf():Object
    {
        return this.getValue();
    }
}
}