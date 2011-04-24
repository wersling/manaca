package net.manaca.app
{
import flexunit.framework.TestCase;

import mx.core.Application;

import net.manaca.application.config.BaseApplicationConfiguration;
import net.manaca.application.thread.BatchEvent;

public class BaseApplicationConfigurationTest extends TestCase
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /* Embed config file. */
    [Embed(source="../../../assets/application.xml", 
                                    mimeType="application/octet-stream")]
    private var configClz:Class;
    
    public function BaseApplicationConfigurationTest(methodName:String=null)
    {
        super(methodName);
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var configuration:BaseApplicationConfiguration;
    //==========================================================================
    //  Public methods
    //==========================================================================
    override public function setUp():void
    {
    }
    
    override public function tearDown():void
    {
        if(configuration)
        {
            configuration.dispose();
            configuration = null;
        }
    }
    
    public function testEmbed():void
    {
        configuration = new BaseApplicationConfiguration(
                    Application.application.stage, configClz);
        configuration.addEventListener(BatchEvent.BATCH_FINISH,
                                addAsync(completeHandler, 1000));
        configuration.start();
    }
    
    public function testLoadConfigFile():void
    {
        configuration = new BaseApplicationConfiguration(
                    Application.application.stage, "assets/application.xml");
        configuration.addEventListener(BatchEvent.BATCH_FINISH,
                                addAsync(completeHandler, 1000));
        configuration.start();
    }
    
    
    public function completeHandler(event:BatchEvent):void
    {
        confirmInfo();
        confirmProjectSettings();
        confirmFiles();
    }
    
    public function confirmInfo():void
    {
        assertEquals(configuration.configInfo.appSettings.version, "1.0");
        assertEquals(
            configuration.configInfo.appSettings.loggingSettings.logLevel, 
            "debug");
    }
    
    private function confirmProjectSettings():void
    {
        assertEquals(configuration.projectSettings.TEST_VALUE1, "value1");
        assertEquals(configuration.projectSettings.TEST_VALUE2, "value2");
        assertEquals(configuration.projectSettings.TEST_VALUE3, "value3");
    }
    
    private function confirmFiles():void
    {
        assertNotNull(configuration.externalFiles.file);
        assertNotNull(configuration.externalFiles.xml);
        assertNotNull(configuration.externalFiles.swf);
        assertNotNull(configuration.externalFiles.jpg);
        assertNotNull(configuration.externalFiles.png);
    }
}
}