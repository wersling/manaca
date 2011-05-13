package net.manaca.utils
{
import flash.external.ExternalInterface;
import flash.net.URLRequest;
import flash.net.navigateToURL;
/**
 * Utility for creating pop-up windows, which helps you to launch pop-ups
 * without restriction
 *
 * ActionScript 3.0 / Flash 9
 *
 * Note:
 * 1.   Pop-up type
 *      In Flash, the pop-ups will be treated as two different approaches
 *      in browsers.
 *      •   Mouse-click pop-ups, Flash opens a window with a Mouse-click
 *      •   Auto-launch pop-ups, Flash opens pop-ups without a Mouse-click
 *
 * 2.   Flash Code
 *      *NOTE*: we have to use the MouseEvent.CLICK for capturing Mouse
 *      Event while opening a window. The MouseEvent.MOUSE_DOWN doesn't work
 *      on some of browsers.
 *
 * 3.   Flash Object
 *      1.  In Firefox,
 *      In order for the Firefox to trust the Flash object, thus allow popup
 *      windows, we need to set the wmode property of the Flash object to
 *      "opaque" or "transparent" (obviously don't use transparent unless we
 *      really need to). This is required when working together with the
 *      Flash player \>= 9.0.115, even for Mouse-click pop-ups.
 *
 *      However, if we want to use full screen feature in Flash, we need to
 *      set the wmode to "window" in the following situation: Flash player >
 *      9.0.115 and non-IE browsers. Fortunately all pop-ups work in this
 *      situation after tested.
 *
 *      2.  In Internet Explorer,
 *      We need to set the wmode property of the Flash object to "window" in
 *      order to make the Auto-launch pop-ups work.
 *
 *      *Conclusions:*
 *      If we don’t need Flash full screen and Auto-launch pop-ups in
 *      project, we can simply set the wmode property of the Flash object to
 *      "opaque". This approach would be able to help us to prevent all
 *      Mouse-click pop-ups blocking.
 *
 *      If we need either Flash full screen or Auto-launch pop-ups (in
 *      Internet Explorer), we can set the wmode property of the Flash
 *      object to "window" as default. Then set the wmode property to
 *      “opaque”, if it’s running in Flash players \>= 9.0.115 and non-IE
 *      browsers. The JavaScript of checking Flash player and browsers in
 *      Flash.js could be like the following:
 *
 *      Additionally, we need to set the allowScriptAccess property of the
 *      Flash object to "always" if Flash object and Flash wrapper are
 *      hosted in the different domains.
 *
 *      One more thing: our Flash object will need to have an id in order
 *      for the ExternalInterface class to work.
 *
 * 4.   Test report
 *      The Mouse-click pop-ups are tested on the following browsers with
 *      Flash Player 9.0.28 - 9.0.124:
 *      •   Internet Explorer 6.0 - Windows
 *      •   Internet Explorer 7.0 - Windows
 *      •   Firefox 2.0 - Windows
 *      •   Firefox 3.0 - Windows
 *      •   Opera 9.5 - Windows
 *      •   Safari 3.1.1 - Mac
 *
 *      The Auto-launch pop-ups are not allowed *only* in the following
 *      configurations:
 *      •   Flash Player 9.0.115 - Firefox 2.0
 *      •   Flash Player 9.0.115 - Firefox 3.0
 *
 * based on script by
 * @author Philipp Kyeck / phil@apdevblog.com
 * @see http://apdevblog.com/problems-using-navigatetourl/
 *
 * based on script by
 * @author Sergey Kovalyov
 * @see http://skovalyov.blogspot.com/2007/01/
 *      how-to-prevent-pop-up-blocking-in.html
 *
 * and based on script by
 * @author Jason the Saj
 * @see http://thesaj.wordpress.com/2008/02/12/
 *      the-nightmare-that-is-_blank-part-ii-help
 */
public class URLUtils
{
    static private const WINDOW_OPEN_FUNCTION:String = "window.open";
    static private var browserName:String;

    /**
     * Open a new browser window and prevent browser from blocking it.
     *
     * @param url        url to be opened
     * @param window     window target
     * @param features   additional features for window.open function
     */
    static public function openWindow(url:String, window:String = "_blank",
                                      features:String = ""):void
    {
        if(!browserName)
        {
            browserName = getBrowserName();
        }
        //If Firefox
        if(browserName == Browser.Firefox)
        {
            ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window,
                                   features);
        }
        //If IE
        else if(browserName == Browser.MSIE)
        {
            ExternalInterface.call("function setWMWindow() {"
                            + WINDOW_OPEN_FUNCTION + "('" + url + "', '"
                            + window + "', '" + features + "');}");
        }
        //If Safari
        else if(browserName == Browser.Safari)
        {
            navigateToURL(new URLRequest(url), window);
        }
        //If Opera
        else if(browserName == Browser.Opera)
        {
            navigateToURL(new URLRequest(url), window);
        }
        //Otherwise, use Flash's native 'navigateToURL()' function to pop-up
        //window. This is necessary because Safari 3 no longer works with
        //the above ExternalInterface work-a-round.
        else
        {
            navigateToURL(new URLRequest(url), window);
        }
    }
    
    static public function clearCacheUrl(url:String):String
    {
        if(url.indexOf("?") != -1)
        {
            url += "&temp=" + new Date().getTime();
        }
        else
        {
            url += "?temp=" + new Date().getTime();
        }
        return url;
    }
    /**
     * @return current browser name.
     */
    static private function getBrowserName():String
    {
        var browser:String;
        var browserAgent:String;

        //Uses external interface to reach out to browser and grab browser
        //useragent info.
        if(ExternalInterface.available)
        {
            browserAgent = ExternalInterface.call(
                "function getBrowser(){return navigator.userAgent;}");
        }

        //Determines brand of browser using a find index. If not found
        //indexOf returns (-1).
        if(browserAgent != null &&
                                browserAgent.indexOf(Browser.Firefox) >= 0)
        {
            browser = Browser.Firefox;
        }
        else if(browserAgent != null &&
                                browserAgent.indexOf(Browser.Safari) >= 0)
        {
            browser = Browser.Safari;
        }
        else if(browserAgent != null &&
                                browserAgent.indexOf(Browser.MSIE) >= 0)
        {
            browser = Browser.MSIE;
        }
        else if(browserAgent != null &&
                                browserAgent.indexOf(Browser.Opera) >= 0)
        {
            browser = Browser.Opera;
        }
        else
        {
            browser = Browser.Undefined;
        }
        return browser;
    }
}
}

/**
 * Define a list of browsers
 */
class Browser
{
    static public const MSIE:String         = "MSIE";
    static public const Firefox:String      = "Firefox";
    static public const Safari:String       = "Safari";
    static public const Opera:String        = "Opera";
    static public const Undefined:String    = "Undefined";
}