package net.manaca.loading
{
import flexunit.framework.TestCase;

import net.manaca.loading.queue.LoadingEvent;
import net.manaca.loading.queue.LoadingQueue;

public class LoadingQueueTest extends TestCase
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var loader:LoadingQueue;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>LoadingQueueTest</code> instance.
     * 
     */    
    override public function LoadingQueueTest(testMethod:String = null)
    {
        super(testMethod);
    }

    override public function setUp():void
    {
        loader = new LoadingQueue();
    }

    override public function tearDown():void
    {
        loader.dispose();
        loader = null;
    }

    public function testLoadingFile():void
    {
        /* loader.addImageURL("net/manaca/loading/youandme2.png", 40);
        loader.addSwfURL("net/manaca/loading/CookieExample.swf", 50);
        loader.addXMLURL("net/manaca/loading/build.xml", 10);
        loader.addEventListener(LoadingEvent.COMPLETE, this.addAsync(verifyLoadingCompleted, 1000));
        loader.start(); */
    }

    private function verifyLoadingCompleted(event:LoadingEvent):void
    {
        assertTrue(loader.percent == 100);
    }
}
}