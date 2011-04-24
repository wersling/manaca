package net.manaca.xml.types
{
public class SchemaBoolean extends SchemaSimpleNode
{
    public function SchemaBoolean(newValue:*)
    {
        super(newValue);
    }
    
    public function getValue():Boolean
    {
        if(domNode is String)
        {
            return (domNode == "true");
        }
        else if(domNode is Number)
        {
            return (domNode == 1);
        }
        else if(domNode is XML)
        {
            return (domNode.toString() == "true");
        }
        else
        {
            return Boolean(domNode);
        }
    }
    
    public function setValue(value:Boolean):void
    {
        domNode = value ? true : false;
    }
    
    public function clone():SchemaBoolean
    {
        return new SchemaBoolean(domNode);
    }
    
    public function valueOf():Object
    {
        return this.getValue();
    }
}
}