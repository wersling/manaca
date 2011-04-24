package net.manaca.logging.publishers
{
import flash.utils.getQualifiedClassName;

import net.manaca.core.AbstractHandler;
import net.manaca.logging.ILogPublisher;
import net.manaca.logging.LogLevel;
import net.manaca.logging.LogRecord;

/**
 *  This class provides the basic functionality required by the logging framework 
 *  for a target implementation.
 * @author Sean Zou
 * 
 */    
public class AbstractLogPublisher implements ILogPublisher
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Can"t Constructs the <code>AbstractLogPublisher</code> instance.
     * 
     */
    public function AbstractLogPublisher()
    {
        AbstractHandler.handlerClass(this, AbstractLogPublisher);
        
        this._level = LogLevel.ALL;
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    
    //----------------------------------
    //  level
    //----------------------------------
    /**
     * @private
     * Storage for the level property.
     */    
    private var _level:LogLevel;

    /**
     * @inheritDoc 
     */    
    public function get level():LogLevel
    {
        return _level;
    }

    public function set level(value:LogLevel):void
    {
        _level = value;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
       
    /**
     * @inheritDoc 
     */
    public function publish(logRecord:LogRecord):void
    {
    }

    /**
     * @inheritDoc 
     */    
    public function isLoggable(logRecord:LogRecord):Boolean
    {
        if( this.level > logRecord.getLevel() ) 
        {
            
            return false;
        }
        
        return true;
    }

    /**
     * Return a string of the AbstractLogPublisher
     * @return 
     * @see Object#toString() 
     */
    public function toString():String
    {
        return "[object " + getQualifiedClassName(this) + "]";        
    }
}
}