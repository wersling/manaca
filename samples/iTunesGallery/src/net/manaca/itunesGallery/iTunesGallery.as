package net.manaca.itunesGallery
{
import caurina.transitions.Tweener;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class iTunesGallery extends Sprite
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    static public const MAX_IMAGE:uint = 15;
    
    static public const IMAGE_WIDTH:uint = 400;
    static public const IMAGE_HEIGHT:uint = 400;
    
    private const albumPileDist    :Number = 200;
    private const albumSortX    :Number = 45;
    private const albumSortY    :Number = 0;
    private const albumSortZ    :Number = 0;
    private const cdRotation    :Number = 60;
    
    private const primeTransTime    :Number = 0.5;
    private const transEquation        :String = "linear";
    //==========================================================================
    //  Variables
    //==========================================================================
    private var scene:Sprite;
    
       private var currentAlbum:uint = 1;
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    public function iTunesGallery()
    {
        super();
        
        init3D();
        resortAlbums();
    }
    //==========================================================================
    //  Methods
    //==========================================================================
    
    private function init3D():void
    {
        scene = new Sprite();
        scene.x = 600;
        scene.y = 300;
        this.addChild(scene);
        
        for(var i :uint = 1 ; i <= MAX_IMAGE ; i++ )
        {
            var album:Album = new Album("images/" + i + ".jpg");
            album.name = "Album" + i;
            album.index = i;
            album.addEventListener(MouseEvent.CLICK, doPress);
            scene.addChild(album);
        }
    }
    
    private function resortAlbums():void
    {
        var albumPointer     : Album;
        var target             : Album;
        var i                : Number;
        
        var xTarget            : Number;
        var yTarget            : Number;
        var zTarget            : Number;
        
        for( i = 1; albumPointer = Album ( scene.getChildByName( "Album" + i ) ); i++ )
        {
            if ( i == currentAlbum ) break;
            target = albumPointer;
            
            scene.addChild(target);
            
            xTarget = - albumPileDist - ((currentAlbum - i) * albumSortX);
            yTarget = (currentAlbum - i)  * albumSortY;
            zTarget = (currentAlbum - i)  * albumSortZ;
            
            Tweener.addTween(target, {x:xTarget, _rotationY: - cdRotation, time : primeTransTime, transition:transEquation});
        }
        
        for( i = MAX_IMAGE; i > currentAlbum;  i -- )
        {    
            albumPointer = Album ( scene.getChildByName( "Album" + i )) ;
            target = albumPointer;
            xTarget = albumPileDist + ((i - currentAlbum) * albumSortX);
            yTarget = (i - currentAlbum)  * albumSortY;
            
            scene.addChild(target);
            
            Tweener.addTween(target, {x : xTarget, _rotationY: cdRotation, time : primeTransTime, transition:transEquation});
        }
        
        albumPointer = scene.getChildByName( "Album"+ currentAlbum ) as Album;
        target = albumPointer;
        scene.addChild(target);
        Tweener.addTween(target, {x:0, _rotationY: 0, time : primeTransTime, transition:transEquation});
    }
    
    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function doPress(event:Event):void
    {
        currentAlbum = event.currentTarget.index;
        resortAlbums();
    }
}
}