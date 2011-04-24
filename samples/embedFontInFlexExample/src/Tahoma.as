package
{
import flash.display.Sprite;
import flash.system.Security;

/**
 * Tahoma font library.
 * @author v-seanzo
 *
 */
public class Tahoma extends Sprite
{
    /**
    * The the FontLibrary allow domain is all.
    */
    Security.allowDomain("*");

    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * Embed Font.
     * Embedded font syntax:
     * <listing version = "3.0" >
     * [Embed(    source = './tahoma.ttf',
     *             fontName = 'GraCoBd',
     *             [fontStyle = italic | oblique | normal],
     *             [fontWeight =  bold | heavy | normal],
     *             [advancedAntiAliasing = true | false],
     *             [unicodeRange = '']
     *         )]
     * </listing>
     * Reference:
     * http://www.unicode.org/charts/PDF/U0000.pdf
     * http://livedocs.adobe.com/flex/3/html/help.html?content=fonts_07.html
     * C:\Program Files\Adobe\Flex Builder 3\sdks\3.0.0\frameworks\flash-unicode-table.xml
     */
    [Embed(    source = './Tahoma.ttf',
            fontName = 'Tahoma',
            fontStyle = 'narmal',    //italic | oblique | normal
            fontWeight = 'normal',    //bold | heavy | normal
            advancedAntiAliasing = true,     //true | false
            unicodeRange = 'U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E,U+2026,U+8230'
            )]
    public static var Tahoma:Class;

    //==========================================================================
    //  Variables
    //==========================================================================

    /**
     * The will register fonts.
     */
    public var fonts:Array = [ Tahoma ];
}
}