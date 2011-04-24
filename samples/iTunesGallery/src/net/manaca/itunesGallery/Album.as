package net.manaca.itunesGallery
{
import caurina.transitions.Tweener;

import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;

public class Album extends Sprite
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    private var imagePath:String;
    
    private var loader:Loader;
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * 
     * 
     */        
    public function Album(imagePath:String)
    {
        super();
        this.imagePath = imagePath;
        
        initDisplay();
        
        loadingImage();
    }
    //==========================================================================
    //  Properties
    //==========================================================================
    public var index:uint = 0;
    
    public function get _rotationY():Number
    {
        return this.rotationY;
    }
    public function set _rotationY(value:Number):void
    {
        if(rotationY != value)
            this.rotationY = value;
    }
    
    //==========================================================================
    //  Methods
    //==========================================================================
    private function initDisplay():void
    {
        this.graphics.beginFill(0xFFFFFF, 0.5);
        this.graphics.drawRect(- iTunesGallery.IMAGE_WIDTH/2, - iTunesGallery.IMAGE_HEIGHT/2, iTunesGallery.IMAGE_WIDTH, iTunesGallery.IMAGE_HEIGHT);
        this.graphics.beginFill(0, 0.5);
        this.graphics.drawRect(- (iTunesGallery.IMAGE_WIDTH - 2)/2, - (iTunesGallery.IMAGE_HEIGHT - 2)/2, iTunesGallery.IMAGE_WIDTH - 2, iTunesGallery.IMAGE_HEIGHT - 2);
    }
    private function loadingImage():void
    {
        if(imagePath)
        {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadImageCompletedHandler);
            loader.load(new URLRequest(imagePath));
        }
    }
    
    //==========================================================================
    //  Event handlers
    //==========================================================================

    private function loadImageCompletedHandler(event:Event):void
    {
        var imageData:BitmapData = new BitmapData(iTunesGallery.IMAGE_WIDTH, iTunesGallery.IMAGE_HEIGHT);
        imageData.draw(loader);
        
        var img:Bitmap = new Bitmap(imageData);
        
        
        img.x = - iTunesGallery.IMAGE_WIDTH/2;
        img.y = - iTunesGallery.IMAGE_HEIGHT/2;
        
        img.alpha = 0;
        
        this.addChild(img);
        this.graphics.clear();
        Tweener.addTween(img, {alpha:1, time : 2});
    }
}
}