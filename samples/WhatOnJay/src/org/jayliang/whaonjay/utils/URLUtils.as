package org.jayliang.whaonjay.utils
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
	 * 1. You need to set the wmode property of the Flash object to "opaque"
	 * 	  or "transparent" (obviously don't use transparent unless you really
	 * 	  need to).
	 * 	  If you use full screen feature in Flash, please set the wmode
	 *    to "window" in the following situation: Flash player < 9.0.115 and
	 * 	  non-IE browsers (fortunately the pop-up works in this situation).
	 *
	 * 	  You need to set the allowScriptAccess property of the Flash object
	 * 	  to "always" if Flash object and Flash wrapper are hosted in the
	 * 	  different domains.
	 *
	 * 2. In Flash, you have to use the MouseEvent.CLICK for capturing Mouse
	 * 	  Event. The MouseEvent.MOUSE_DOWN doesn't work on some of browsers.
	 *
	 * 	  The mouse-click pop-ups are tested on the following browsers with
	 * 	  Flash Player 9.0.28 - 9.0.124:
	 *    • Internet Explorer 6.0 - Windows
	 *    • Internet Explorer 7.0 - Windows
	 *    • Firefox 2.0 - Windows
	 *    • Firefox 3.0 - Windows
	 *    • Opera 9.5 - Windows
	 *    • Safari 3.1.1 - Mac
	 *
	 * 3. Auto-launch pop-ups are not allowed with the following configurations:
	 * 	  • Flash Player 9.0.115 - Firefox 2.0
	 * 	  • Flash Player 9.0.115 - Firefox 3.0
	 *
	 *
	 * based on script by
	 * @author Philipp Kyeck / phil@apdevblog.com
	 * @see http://apdevblog.com/problems-using-navigatetourl/
	 *
	 * based on script by
	 * @author Sergey Kovalyov
	 * @see http://skovalyov.blogspot.com/2007/01/
	 * 		how-to-prevent-pop-up-blocking-in.html
	 *
	 * and based on script by
	 * @author Jason the Saj
	 * @see http://thesaj.wordpress.com/2008/02/12/
	 * 		the-nightmare-that-is-_blank-part-ii-help
	 */
	public class URLUtils
	{
		private static const WINDOW_OPEN_FUNCTION:String = "window.open";
		private static var browserName:String;

		/**
		 * Open a new browser window and prevent browser from blocking it.
		 *
		 * @param url        url to be opened
		 * @param window     window target
		 * @param features   additional features for window.open function
		 */
		public static function openWindow(url:String, window:String = "_blank",
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

		/**
		 * @return current browser name.
		 */
		private static function getBrowserName():String
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
	public static const MSIE:String			= "MSIE";
	public static const Firefox:String		= "Firefox";
	public static const Safari:String		= "Safari";
	public static const Opera:String		= "Opera";
	public static const Undefined:String	= "Undefined";
}