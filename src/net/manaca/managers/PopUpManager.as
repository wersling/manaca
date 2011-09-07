package net.manaca.managers
{
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Stage;

import net.manaca.errors.SingletonError;
import net.manaca.utils.DepthUtil;

/**
 * The PopUpManager singleton class creates new top-level windows and
 * places or removes those windows from the layer on top of all other
 * visible windows.
 * @author Sean Zou
 */
public class PopUpManager
{
    /**
     *  @private
     */
    static private var instance:PopUpManager;

    /**
     *  Returns the sole instance of this singleton class,
     *  creating it if it does not already exist.
     */
    static public function getInstance():PopUpManager
    {
        if (!instance)
        {                
            instance = new PopUpManager();
        }
        return instance;
    }

    /**
     * 
     * 
     */    
    public function PopUpManager()
    {
        if(instance)
        {
            throw new SingletonError(instance);
        }
    }

    /**
     * Pops up a top-level window.
     * It is good practice to call <code>removePopUp()</code> to remove popups
     * created by using the <code>addPopUp()</code> method.
     *
     * <p><b>Example</b></p> 
     *
     * <pre>var tw = new TitleWindow();
     *    tw.title = "My Title";
     *    mx.managers.PopUpManager.addPopUp(tw, pnl, false);</pre>
     *
     * <p>Creates a popup window using the <code>tw</code> instance of the 
     * TitleWindow class and <code>pnl</code> as the Sprite for determining
     * where to place the popup.
     * It is defined to be a non-modal window.</p>
     * 
     * @param window The DisplayObject to be popped up.
     *
     * @param parent DisplayObjectContainer to be used for determining which SystemManager's layers
     * to use and optionally the reference point for centering the new
     * top level window. It may not be the actual parent of the popup as all popups
     * are parented by the SystemManager.
     */
    public function addPopUp(window:DisplayObject, parent:DisplayObjectContainer):void
    {
        if(window && parent)
        {
            window.visible = true;
            parent.addChild(window);
        }
    }

    /**
     * Centers a popup window over whatever window was used in the call 
     * to the <code>createPopUp()</code> or <code>addPopUp()</code> method.
     *
     * @param popUp The DisplayObject representing the popup.
     */
    public function centerPopUp(popUp:DisplayObject):void
    {
        if(popUp && popUp.parent)
        {
            if(popUp.parent is Stage)
            {
                popUp.x = 
                    int((Stage(popUp.parent).stageWidth - popUp.width) / 2);
                popUp.y = 
                    int((Stage(popUp.parent).stageHeight - popUp.height) / 2);
            }
            else
            {
                popUp.x = int((popUp.parent.width - popUp.width) / 2);
                popUp.y = int((popUp.parent.height - popUp.height) / 2);
            }
        }
    }

    /**
     * Removes a popup window popped up by 
     * the <code>createPopUp()</code> or <code>addPopUp()</code> method.
     * 
     * @param window The DisplayObject representing the popup window.
     */
    public function removePopUp(popUp:DisplayObject):void
    {
        if(popUp && popUp.parent)
        {
            popUp.parent.removeChild(popUp);
        }
    }

    /**
     * Makes sure a popup window is higher than other objects in its child list
     * The SystemManager does this automatically if the popup is a top level window
     * and is moused on, 
     * but otherwise you have to take care of this yourself.
     *
     * @param The DisplayObject representing the popup.
     */
    public function bringToFront(popUp:DisplayObject):void
    {
        if(popUp)
        {
            DepthUtil.bringToTop(popUp);
        }
    }

    /**
     * Creates a top-level window and places it above other windows in the
     * z-order.
     * It is good practice to call the <code>removePopUp()</code> method 
     * to remove popups created by using the <code>createPopUp()</code> method.     
     * 
     * @param parent DisplayObjectContainer to be used for determining which SystemManager's layers
     * to use and optionally the reference point for centering the new
     * top level window.  It may not be the actual parent of the popup as all popups
     * are parented by the SystemManager.
     * 
     * @param className Class of object that is to be created for the popup.
     * The class must implement IFlexDisplayObject.
     * 
     * @return Reference to new top-level window.
     */    
    public function createPopUp(parent:DisplayObjectContainer, className:Class):DisplayObject
    {
        const window:DisplayObject = new className();
        addPopUp(window, parent);
        return window;
    }
}
}