package net.manaca.tracking.sender
{

/**
 * Interface for tracking senders.
 */    
public interface ITrackingSender
{
    /**
     * Track to external.
     * @param action
     * @param rest
     * 
     */        
    function externalTrack(action:String, rest:Array):void;
}
}