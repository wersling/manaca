/*
 * Copyright (c) 2011, wersling.com All rights reserved.
 */
package net.manaca.xml.types
{
import net.manaca.xml.XMLNode;

public class SchemaSimpleNode extends XMLNode
{
    public function SchemaSimpleNode(node:*)
    {
        super(node);
    }
    
    public function toString():String
    {
        return (domNode != null) ? domNode.toString() : null;
    }
}
}
