/*
 * ConfigurationInfo.as
 *
 * This file was generated by asSchema.
 * http://www.wersling.com
 *
 * YOU SHOULD NOT MODIFY THIS FILE, BECAUSE IT WILL BE
 * OVERWRITTEN WHEN YOU RE-RUN CODE GENERATION.
 */
package net.manaca.application.config.model
{
import net.manaca.xml.XMLNode;
import net.manaca.xml.types.*;

/**
 * The configuration xml root node
 * @author v-seanzo
 * 
 */    
public class ConfigurationInfo extends XMLNode
{

    private const namespaceURI:String = "www.manaca.net";
    
    /**
     * Constructs a new ConfigurationInfo instance. 
     * @param node The XML to create the new Node object. 
     * @return 
     * 
     */
    public function ConfigurationInfo(node:XML = null)
    {
        if (node == null)
        {
            node = <Configuration xmlns="www.manaca.net"/>;
        }
        super(node);
    }
    
    /**
     * Gets a application settings info. 
     * @return a application settings info. 
     */    
    public function get AppSettings():AppSettingsInfo
    {
        return getAppSettingsAt(0);
    }
    
    /**
     * Gets a application settings info by index. 
     * @return 
     */    
    public function getAppSettingsAt(index:int):AppSettingsInfo
    {
        var node:XML = getChildAt(ELEMENT, namespaceURI, 'AppSettings', index);
        if (node)
        {
            return new AppSettingsInfo(node);
        }
        else
        {
            return null;
        }
    }
    
    /**
     * Sets a application settings info. 
     */    
    public function set AppSettings(value:AppSettingsInfo):void
    {
        setAppSettingsAt(0, value);
    }
    
    /**
     * Sets a application settings info by index. 
     * @return 
     */    
    public function setAppSettingsAt(index:int, value:AppSettingsInfo):void
    {
        if (value)
        {
            setChildAt(ELEMENT, namespaceURI, 'AppSettings', index, value.node);
        }
        else
        {
            setChildAt(ELEMENT, namespaceURI, 'AppSettings', index, value);
        }
    }
    
    /**
     * Gets a Number that defines the total count of the AppSettings. 
     * @return a Number that defines the total count of the AppSettings. 
     */    
    public function getAppSettingsCount():Number
    {
        return getChildCount(ELEMENT, namespaceURI, 'AppSettings');
    }
    
    /**
     * Gets a project settings info. 
     * @return a project settings info. 
     */    
    public function get ProjectSettings():ProjectSettingsInfo
    {
        return getProjectSettingsAt(0);
    }
    
    /**
     * Gets a project settings info by index. 
     * @return 
     */    
    public function getProjectSettingsAt(index:int):ProjectSettingsInfo
    {
        var node:XML = getChildAt(ELEMENT, namespaceURI, 'ProjectSettings', index);
        if (node)
        {
            return new ProjectSettingsInfo(node);
        }
        else
        {
            return null;
        }
    }
    
    /**
     * Sets a project settings info. 
     */    
    public function set ProjectSettings(value:ProjectSettingsInfo):void
    {
        setProjectSettingsAt(0, value);
    }
    
    /**
     * Sets a project settings info by index. 
     * @return 
     */    
    public function setProjectSettingsAt(index:int, value:ProjectSettingsInfo):void
    {
        if (value)
        {
            setChildAt(ELEMENT, namespaceURI, 'ProjectSettings', index, value.node);
        }
        else
        {
            setChildAt(ELEMENT, namespaceURI, 'ProjectSettings', index, value);
        }
    }
    
    /**
     * Gets a Number that defines the total count of the ProjectSettings. 
     * @return a Number that defines the total count of the ProjectSettings. 
     */    
    public function getProjectSettingsCount():Number
    {
        return getChildCount(ELEMENT, namespaceURI, 'ProjectSettings');
    }
    
    /**
     * Gets a The external file list. 
     * @return a The external file list. 
     */    
    public function get Files():FilesInfo
    {
        return getFilesAt(0);
    }
    
    /**
     * Gets a The external file list by index. 
     * @return 
     */    
    public function getFilesAt(index:int):FilesInfo
    {
        var node:XML = getChildAt(ELEMENT, namespaceURI, 'Files', index);
        if (node)
        {
            return new FilesInfo(node);
        }
        else
        {
            return null;
        }
    }
    
    /**
     * Sets a The external file list. 
     */    
    public function set Files(value:FilesInfo):void
    {
        setFilesAt(0, value);
    }
    
    /**
     * Sets a The external file list by index. 
     * @return 
     */    
    public function setFilesAt(index:int, value:FilesInfo):void
    {
        if (value)
        {
            setChildAt(ELEMENT, namespaceURI, 'Files', index, value.node);
        }
        else
        {
            setChildAt(ELEMENT, namespaceURI, 'Files', index, value);
        }
    }
    
    /**
     * Gets a Number that defines the total count of the Files. 
     * @return a Number that defines the total count of the Files. 
     */    
    public function getFilesCount():Number
    {
        return getChildCount(ELEMENT, namespaceURI, 'Files');
    }
    
    /**
     * Gets a ExtendFile. 
     * @return a ExtendFile. 
     */    
    public function get ExtendFile():String
    {
        var result:* = getExtendFileAt(0);
        if(result)
        {
            return result.getValue();
        }
        else 
        {
            return result;
        }
    }
    
    /**
     * Gets a ExtendFile by index. 
     * @return 
     */    
    public function getExtendFileAt(index:int):SchemaString
    {
        var node:XML = getChildAt(ELEMENT, namespaceURI, 'ExtendFile', index);
        if (node)
        {
            return new SchemaString(node);
        }
        else
        {
            return null;
        }
    }
    
    /**
     * Sets a ExtendFile. 
     */    
    public function set ExtendFile(value:String):void
    {
        setExtendFileAt(0, new SchemaString(value));
    }
    
    /**
     * Sets a ExtendFile by index. 
     * @return 
     */    
    public function setExtendFileAt(index:int, value:SchemaString):void
    {
        if (value)
        {
            setChildAt(ELEMENT, namespaceURI, 'ExtendFile', index, value.node);
        }
        else
        {
            setChildAt(ELEMENT, namespaceURI, 'ExtendFile', index, value);
        }
    }
    
    /**
     * Gets a Number that defines the total count of the ExtendFile. 
     * @return a Number that defines the total count of the ExtendFile. 
     */    
    public function getExtendFileCount():Number
    {
        return getChildCount(ELEMENT, namespaceURI, 'ExtendFile');
    }
    
    public function clone():ConfigurationInfo
    {
        return new ConfigurationInfo(domNode.copy());
    }
    
    public function toString():String
    {
        var result:String = '------------ConfigurationInfo------------';
        result += '\nAppSettings:' + this.AppSettings;
        result += '\nProjectSettings:' + this.ProjectSettings;
        result += '\nFiles:' + this.Files;
        result += '\nExtendFile:' + this.ExtendFile;
        return result;
    }
}
}