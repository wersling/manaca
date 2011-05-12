package net.manaca.utils
{
import flash.display.BitmapData;
import flash.display.GradientType;
import flash.display.Shape;
import flash.display.SpreadMethod;
import flash.geom.Matrix;
import flash.geom.Point;


/**
 * BitmapDataUtil
 *
 * @author Sean Zou
 */
public class BitmapDataUtil
{

    static public function getBitmapWithReflection(value:BitmapData):BitmapData
    {
        var bmReflection:BitmapData = 
            new BitmapData(value.width, value.height * 2, true, 0);
        bmReflection.draw(value);

        var gMatrix:Matrix = new Matrix();
        gMatrix.createGradientBox(value.width, value.height, Math.PI * 0.5);

        var holder:Shape = new Shape();
        holder.graphics.beginGradientFill(
            GradientType.LINEAR, [0xFFFFFF, 0xFFFFFF], 
            [0, 1], [0, 0xFF], gMatrix, SpreadMethod.PAD);
        holder.graphics.drawRect(0, 0, value.width, value.height);
        holder.graphics.endFill();

        var gBitmap:BitmapData = 
            new BitmapData(holder.width, holder.height, true, 0);
        gBitmap.draw(holder);

        var res:BitmapData = new BitmapData(value.width, value.height, true, 0);
        res.copyPixels(
            value, res.rect, new Point(), gBitmap, new Point(), true);

        var flipM:Matrix = new Matrix(1, 0, 0, -1, 0, value.height * 2);
        bmReflection.draw(res, flipM);

        return bmReflection;
    }
}
}