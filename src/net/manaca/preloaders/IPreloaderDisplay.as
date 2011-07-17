package net.manaca.preloaders
{
/**
 * Defines the interface that 
 * a class must implement to be used as a download progress bar.
 * @author Sean Zou
 * 
 */
public interface IPreloaderDisplay
{
    /**
     * Update the loading progress percent.
     * @param percent 0-100
     * 
     */    
    function updateProgress(percent:uint):void;
    
    /**
     * Show the loading info
     * @param info
     * 
     */    
    function showLoadingInfo(info:String):void;
}
}