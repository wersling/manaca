package net.manaca.xml
{
public class XMLNode extends Object
{
    public static const ATTRIBUTE:int			= 0;
    public static const ELEMENT:int   			= 1;
    
    protected var domNode:*;

    public function XMLNode(node:*)
    {
        this.domNode = node;
    }

    public function get node():*
    {
        return domNode;
    }

    public function getChildCount(type:int, namespaceURI:String, name:String):int
    {
        var qName:QName = new QName(namespaceURI, name);
        if(domNode is XML)
        {
            switch(type)
            {
                case ATTRIBUTE:
                    return domNode.attribute(qName).length();
                break;
                case ELEMENT:
                    return domNode.child(qName).length();
                break;
            }
        }
        return 0;
    }
    
    public function getChildAt(type:int, namespaceURI:String, name:String, index:int):XML
    {
        var qName:QName = new QName(namespaceURI, name);
        if(domNode is XML)
        {
            switch(type)
            {
                case ATTRIBUTE:
                    return domNode.attribute(qName)[index];
                break;
                case ELEMENT:
                    return domNode.child(qName)[index];
                break;
            }
        }
        return null;
    }
    
    
    public function setChildAt(type:int, namespaceURI:String, name:String, index:int, value:*):void
    {
        var qName:QName = new QName(namespaceURI, name);
        if(domNode is XML)
        {
            switch(type)
            {
                case ATTRIBUTE:
                    if(value != null)
                    {
                        domNode.attribute(qName)[index] = value.toString();
                    }
                    else
                    {
                        delete domNode.attribute(qName)[0];
                    }
                break;
                case ELEMENT:
                    if(value is XML)
                    {
                        if(XML(domNode).child(qName).length() == 0)
                        {
                            domNode.appendChild(value);
                        }
                        else
                        {
                            domNode.child(qName)[index] = '';
                            domNode.child(qName)[index].normalize();
                            domNode.child(qName)[index].appendChild(value);
                        }
                    }
                    else
                    {
                        if(value != null)
                        {
                            domNode.child(qName)[index] = value.toString();
                        }
                        else
                        {
                            delete domNode.child(qName)[index];
                        }
                    }
                break;
            }
        }
    }
    
    public function addChild(type:int, namespaceURI:String, name:String, value:*):void
    {
        var qName:QName = new QName(namespaceURI, name);
        if(domNode is XML)
        {
            switch(type)
            {
                case ELEMENT:
                    domNode.appendChild(value);
                break;
            }
        }
    }
    
    public function removeChild(type:int, namespaceURI:String, name:String, index:int):void
    {
        var qName:QName = new QName(namespaceURI, name);
        switch(type)
        {
            case ELEMENT:
                delete domNode.child(qName)[index];
            break;
            case ATTRIBUTE:
                delete domNode.attribute(qName)[0];
            break;
        }
    }
}
}