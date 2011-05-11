/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.xml.types
{
public class SchemaString extends SchemaSimpleNode
{
    public function SchemaString(newValue:*)
    {
        super(newValue);
    }
    public function getValue():String
    {
        return domNode;
    }
    public function setValue(value:String):void
    {
        domNode = value;
    }
    public function clone():SchemaString
    {
        return new SchemaString(domNode);
    }

    public function valueOf():Object
    {
        return this.getValue();
    }
}
}
