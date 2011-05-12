package net.manaca.core.patterns.command
{
import net.manaca.errors.SingletonError;

import flash.events.EventDispatcher;

/**
 * A base class for an application specific Command Manager
 * The CommandManager is the centralised request handling class in a
 * application.
 * @author Sean Zou
 * 
 */    
public class CommandManager extends EventDispatcher
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    
    /**
     *  @private
     */
    static private var instance:CommandManager;

    //==========================================================================
    //  Class methods
    //==========================================================================
    
    /**
     *  Returns the sole instance of this singleton class,
     *  creating it if it does not already exist.
     */
    static public function getInstance():CommandManager
    {
        if (!instance)
        {                
            instance = new CommandManager();
        }
        return instance;
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    /* The commands map */
    private const commandMap:Object = new Object();

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>CommandManager</code> instance.
     * 
     * The CommandManager is singleton, Only one CommandManager instance can be instantiated.
     * @throws net.manaca.errors.SingletonError 
     */
    public function CommandManager()
    {
        super();
        if(instance != null)
        {
            throw new SingletonError(this);
        }
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    
    /**
     * Register a particular ICommand class as the handler for a particular CommandEvent. 
     * @param eventType
     * @param commandClassRef
     * 
     */
    public function registerCommand(eventType:String, commandClassRef:Class):void
    {
        commandMap[ eventType ] = commandClassRef;
    }

    /**
     * Execute the ICommand previously registered as the handler for CommandEvents 
     * with the given event type.
     * @param @param commandClassRef
     */    
    public function executeCommand(event:CommandEvent):void
    {
        var commandClassRef:Class = commandMap[ event.type ];
        if ( commandClassRef != null )
        {
            var commandInstance:ICommand = new commandClassRef();
            commandInstance.execute(event);
        }
    }

    /**
     * Remove a previously registered ICommand to CommandEvent mapping. 
     * @param eventType
     * 
     */
    public function removeCommand(eventType:String):void
    {
        commandMap[ eventType ] = null;
    }
}
}