package
{
import com.adobe.viewsource.ViewSource;

import flash.display.Sprite;

/**
 * Cookie example.
 * @author Sean
 * @see http://www.wersling.com/blog
 */
public class CookieExample extends Sprite
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>CookieExample</code> instance.
     *
     */
    public function CookieExample()
    {
        ViewSource.addMenuItem(this, "srcview/index.html");

        var cookie:Cookie = new Cookie("myCookie");
        cookie.name = "foo";
        cookie.value = Math.PI;
        trace(cookie.name);    // foo
        trace(cookie.value);// 3.141592653589793

        cookie.clear();
    }
}
}
