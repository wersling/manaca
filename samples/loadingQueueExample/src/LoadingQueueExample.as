package
{
import flash.display.Sprite;
import flash.net.URLLoader;

import net.manaca.loading.queue.LoadingEvent;
import net.manaca.loading.queue.LoadingQueue;

/**
 *
 * @author v-seanzo
 *
 */
public class LoadingQueueExample extends Sprite
{
    //==========================================================================
    //  Variables
    //==========================================================================

    private var web1:URLLoader;
    private var web2:URLLoader;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Constructs a new <code>LoadingQueueExample</code> instance.
     *
     */
    public function LoadingQueueExample()
    {
        //create a LoadingQueue
        var loader:LoadingQueue = new LoadingQueue();
        //add events
        loader.addEventListener(LoadingEvent.COMPLETE, completedHandler);
        loader.addEventListener(LoadingEvent.PROGRESS, updateHandler);
        //add a swf url and add the return loader to secne
        this.addChild(loader.addSwfURL("http://beet-starterkit-demo.msn-int.com/./static/swf/1/fish.swf", 20));
        //add a image url and add the return loader to secne
        this.addChild(loader.addImageURL("http://beet-starterkit-demo.msn-int.com/static/i/1/maskNew.png", 15));
        //add two web page.
        web1 = loader.addXMLURL("http://www.msn.com", 5);
        web2 = loader.addXMLURL("http://www.baidu.com", 1);

        //start loading queue.
        loader.start();
    }

    private function completedHandler(event:LoadingEvent):void
    {
        trace("[loading completed!]");

        //print web1 html data
        trace(web1.data);
    }

    private function updateHandler(event:LoadingEvent):void
    {
        //print loading percent
        trace("[loading percent] : " + event.target.percent)
    }
}
}
