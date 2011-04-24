package net.manaca.application.thread
{

/**
 * The ProcessState class defines the values for the state property of 
 * the IProcess state. 
 * 
 * @author v-seanzo
 * @see net.manaca.application.thread.IProcess#state
 */    
public class ProcessState
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    
    /**
     * A thread that has not yet started is in this state. 
     */        
    static public const UNSTARTED:uint = 0;
    /**
     * A thread running is in this state.
     */        
    static public const RUNNING:uint = 2;
    /**
     * A thread suspended is in this state.
     */    
    static public const SUSPENDED:uint = 4;
    /**
     * A thread finished is in this state.
     */    
    static public const FINISHED:uint = 8;
    /**
     * A thread aborted is in this state.
     */    
    static public const ABORTED:uint = 256;
}
}