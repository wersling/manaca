package net.manaca.loading
{
import flexunit.framework.TestCase;

import net.manaca.loading.queue.LoadingEvent;
import net.manaca.loading.queue.MultiLoading;

public class MultiLoadingTest extends TestCase
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var loader:MultiLoading;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>MultiLoadingTest</code> instance.
     * 
     */    
    override public function MultiLoadingTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        loader = new MultiLoading();
    }

    override public function tearDown():void
    {
        loader.dispose();
        loader = null;
    }

    public function testLoaderMultiFile():void
    {
        /* loader.addImageURL("net/manaca/loading/youandme2.png", 40);
        loader.addSwfURL("net/manaca/loading/CookieExample.swf", 50);
        loader.addXMLURL("net/manaca/loading/build.xml", 10);
        loader.addEventListener(LoadingEvent.COMPLETE, this.addAsync(verifyLoadingCompleted, 200));
        loader.start(); */
    }

    private function verifyLoadingCompleted(event:LoadingEvent):void
    {
        assertTrue(loader.percent == 100);
    }
}
}