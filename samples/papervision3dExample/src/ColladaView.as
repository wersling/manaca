package
{
import flash.display.BitmapData;
import flash.display.Shape;
import flash.events.Event;

import org.papervision3d.materials.BitmapMaterial;
import org.papervision3d.materials.ColorMaterial;
import org.papervision3d.materials.utils.MaterialsList;
import org.papervision3d.objects.primitives.Cube;
import org.papervision3d.view.BasicView;

/**
 *
 * @author v-seanzo
 *
 */
public class ColladaView extends BasicView
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var boxMaterialList:MaterialsList;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     *
     * @param viewportWidth
     * @param viewportHeight
     * @param scaleToStage
     * @param interactive
     * @param cameraType
     *
     */
    public function ColladaView(viewportWidth:Number = 640, viewportHeight:Number = 480, scaleToStage:Boolean = true, interactive:Boolean = false)
    {
        super(viewportWidth, viewportHeight, scaleToStage, interactive);

        init3D();
    }

    //==========================================================================
    //  Methods
    //==========================================================================

    private function init3D():void
    {
        initEngine();
        initMaterial();
        initObjects();
        initController();
        initListeners();
    }

    private function initEngine():void
    {
        camera.zoom = 100;
    }

    private function initMaterial():void
    {
        boxMaterialList = new MaterialsList();

        var skin:Shape = new Shape();
        skin.graphics.beginFill(0x000000);
        skin.graphics.drawRect(0, 0, 100, 100);
        skin.graphics.drawRect(1, 1, 98, 98);
        skin.graphics.beginFill(0xFF0000, 0.5);
        skin.graphics.drawRect(1, 1, 98, 98);

        var bitmapData:BitmapData = new BitmapData(100, 100, true, 0);
        bitmapData.draw(skin);

        var boxMaterial:BitmapMaterial = new BitmapMaterial(bitmapData);
        boxMaterial.smooth = true;
        boxMaterial.interactive = false;
        boxMaterialList.addMaterial(boxMaterial, "all");
    }

    private function initObjects():void
    {
        /* var obj3d:Plane = new Plane(new ColorMaterial(0x666666, 0.5), 50, 50, 5, 5);
        obj3d.material.doubleSided = true;
        scene.addChild(obj3d,"box");
         */
        createABox();
        /* createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox();
        createABox(); */
    }

    private function createABox():void
    {
        var cube:Cube = new Cube(boxMaterialList, 50, 50, 50, 5, 5, 5);
        cube.z = 25;
        scene.addChild(cube, "box");
    }


    private function initController():void
    {
    }

    private function initListeners():void
    {
        //Start rendering
        startRendering();
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    override protected function onRenderTick(event:Event = null):void
    {
        //Rotate the spheres.
        scene.getChildByName("box").rotationY += 2;
        scene.getChildByName("box").rotationX += 5;
        super.onRenderTick(event);
    }
}
}