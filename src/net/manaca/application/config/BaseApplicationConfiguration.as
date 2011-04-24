package net.manaca.application.config
{
import flash.display.Stage;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.system.Capabilities;
import flash.utils.Dictionary;

import mx.core.ByteArrayAsset;

import net.manaca.application.config.model.AddInfo;
import net.manaca.application.config.model.ConfigurationInfo;
import net.manaca.application.thread.SimpleBatch;
import net.manaca.errors.IllegalArgumentError;
import net.manaca.logging.Tracer;

/**
 * The BaseApplicationConfiguration provide a base application configuration.
 * <ul>
 *     <li>
 *         Initialize Logging
 *     </li>
 *     <li>
 *         Initialize Stage
 *     </li>
 *     <li>
 *         Initialize SecuritySettings
 *     </li>
 *     <li>
 *         Initialize external files
 *     </li>
 * </ul>
 * @author v-seanzo
 *
 */
public class BaseApplicationConfiguration extends SimpleBatch
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var stage:Stage;
    private var files:FilePreloadConfiguration;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Constructs a new <code>BaseApplictionConfiguration</code> instance.
     * @param stage
     *
     */
    public function BaseApplicationConfiguration(stage:Stage, config:*)
    {
        super();

        if(stage != null)
        {
            this.stage = stage;
        }
        else
        {
            throw new IllegalArgumentError("invalid stage argument:" + stage);
        }

        if(config is Class)
        {
            var clZ:Class = config as Class;
            var ba:ByteArrayAsset = ByteArrayAsset(new clZ()) ;
            config = new XML(ba.readUTFBytes(ba.length));
            _configInfo = new ConfigurationInfo(config);
        }
        else if(config is XML)
        {
            _configInfo = new ConfigurationInfo(XML(config));
        }
        else if(config is String && String(config).length > 0)
        {
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, loader_completeHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
            loader.load(new URLRequest(String(config)));
            Tracer.debug("start loading config file : " + config);
            return;
        }
        else
        {
            throw new IllegalArgumentError("invalid config argument:" + config);
        }

        initProjectSettings();
        addConfigurationProcess();
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  externalFiles
    //----------------------------------
    /**
     * Get the external files map.
     * @return
     *
     */
    public function get externalFiles():Dictionary
    {
        return files.externalFiles;
    }

    //----------------------------------
    //  configInfo
    //----------------------------------
    private var _configInfo:ConfigurationInfo;

    /**
     * Get the configuration info object.
     * @return
     *
     */
    public function get configInfo():ConfigurationInfo
    {
        return _configInfo;
    }

    //----------------------------------
    //  projectSettings
    //----------------------------------
    private var _projectSettings:Dictionary;

    /**
     * Get the project settings map.
     * @return
     *
     */
    public function get projectSettings():Dictionary
    {
        return _projectSettings;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    override public function start():void
    {
        if(_configInfo != null)
        {
            super.start();
        }
    }
    
    /**
     * dispose the instance.
     *
     */
    public function clear():void
    {
        removeAllProcesses();
        if(files)
        {
            files.dispose();
        }
    }
    
    /**
     * inittalize project setttings.
     */
    private function initProjectSettings():void
    {
        _projectSettings = new Dictionary();
        if(configInfo.ProjectSettings != null && 
                                configInfo.ProjectSettings.Add != null)
        {
            var len:uint = configInfo.ProjectSettings.getAddCount();
            for(var i:uint = 0 ;i < len; i++ )
            {
                var add:AddInfo = configInfo.ProjectSettings.getAddAt(i);
                _projectSettings[add.key] = add.value;
            }
        }
        
        //override extend file path
        var playerType:String = Capabilities.playerType;
        if ((playerType == "PlugIn" || playerType == "ActiveX"))
        {
            var params:Object = stage.loaderInfo.parameters;
            if(params["extendConfigFile"] && params["extendConfigFile"] != "")
            {
                configInfo.ExtendFile = params["extendConfigFile"];
            }
        }
    }
    
    /**
     * add configuration process.
     */
    private function addConfigurationProcess():void
    {
        this.addProcess(new LoggingConfiguration(stage, 
                                    _configInfo.AppSettings.LoggingSettings));
        this.addProcess(new ExtendFileConfiguration(configInfo, 
                                                        projectSettings));
        this.addProcess(new StageConfiguration(stage));
        this.addProcess(new SecuritySettingsConfiguration(
                                    _configInfo.AppSettings.SecuritySettings));
        files = new FilePreloadConfiguration(_configInfo.Files);
        this.addProcess(files);
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function loader_completeHandler(event:Event):void
    {
        var xml:XML = XML(event.target.data);
        _configInfo = new ConfigurationInfo(xml);
        initProjectSettings();
        addConfigurationProcess();
        start();
    }
    
    private function loader_errorHandler(event:IOErrorEvent):void
    {
        throw new IllegalArgumentError("load config file error:" + event);
    }
}
}