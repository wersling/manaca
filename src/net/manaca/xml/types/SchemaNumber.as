/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.xml.types
{
public class SchemaNumber extends SchemaSimpleNode
{
    public function SchemaNumber(newValue:*)
    {
        super(newValue);
    }
    
    public function getValue():Number
    {
        return domNode;
    }
    public function setValue(value:Number):void
    {
        domNode = value;
    }
    
    public function clone():SchemaNumber
    {
        return new SchemaNumber(domNode);
    }
    
    public function valueOf():Object{
        return this.getValue();
    }
}
}
