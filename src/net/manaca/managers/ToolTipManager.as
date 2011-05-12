package net.manaca.managers
{
import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Dictionary;
import flash.utils.Timer;

import net.manaca.errors.SingletonError;

/**
 * The ToolTipManager lets you set basic ToolTip functionality, such as display delay and the disabling of ToolTips.
 * @author v-seanzo
 * 
 */    
public class ToolTipManager extends EventDispatcher
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    /**
     * Define mouse over target this time start show tooltip.
     */        
    static public var TRIGG_TIME:uint = 1000;
    /**
     * Define the tooltip max display time.
     */        
    static public var MAX_DISPLAY_TIME:uint = 5000;
    /**
     * Define reset the fast mode time.
     */        
    static public var QUASH_TIME:uint = 1000;
    /**
     * Define the faet mode display tooltip time.
     */
    static public var FAST_DISPLAY_TIME:uint = 50;

    /**
     *  @private
     */
    static private var instance:ToolTipManager;

    //==========================================================================
    //  Class methods
    //==========================================================================
    
    /**
     *  Returns the sole instance of this singleton class,
     *  creating it if it does not already exist.
     */
    static public function getInstance():ToolTipManager
    {
        if (!instance)
        {                
            instance = new ToolTipManager();
        }
        return instance;
    }

    //==========================================================================
    //  Variables
    //==========================================================================
    /* all need tooltip objects */
    private var toolTipMap:Dictionary;

    /* current show tooltip target */
    private var currentTarget:InteractiveObject;

    /* is use fast mode display tooltip */
    private var isFastDisplay:Boolean = false;

    /* trigg tooltip timer */
    private var triggTimer:Timer;

    /* quash fast mode timer */
    private var quashTimer:Timer;

    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * Constructs a singleton <code>ToolTipManager</code> instance.
     * 
     */
    public function ToolTipManager()
    {
        super();
        
        if(instance)
        {
            throw new SingletonError(instance);
        }
        
        toolTipMap = new Dictionary(true);
        
        triggTimer = new Timer(TRIGG_TIME, 1);
        triggTimer.addEventListener(TimerEvent.TIMER_COMPLETE, triggTimeConplete);
        
        quashTimer = new Timer(QUASH_TIME, 1);
        quashTimer.addEventListener(TimerEvent.TIMER_COMPLETE, quashTimeConplete);
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  toolTipDisplay
    //----------------------------------
    private var _toolTipDisplay:IToolTipDisplay = new ToolTipDisplay();

    /**
     * Define the tooltip view.
     * @return 
     * 
     */
    public function get toolTipDisplay():IToolTipDisplay
    {
        return _toolTipDisplay;
    }

    public function set toolTipDisplay(value:IToolTipDisplay):void
    {
        _toolTipDisplay = value;
    }

    //----------------------------------
    //  enabled
    //----------------------------------
    private var _enabled:Boolean = true;

    /**
     * If true, the ToolTipManager will automatically show ToolTips when the user moves the mouse pointer over components. 
     * If false, no ToolTips will be shown. 
     * @return 
     * 
     */
    public function get enabled():Boolean
    {
        return _enabled;
    }

    public function set enabled(value:Boolean):void
    {
        _enabled = value;
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * Add a tooltip target to manager.
     * @param target spring the tooltip target.
     * @param toolTip the show info.
     * 
     */
    public function addToolTip(target:InteractiveObject, toolTip:* = null):void
    {
        if(target)
        {
            if(toolTipMap[target] == null)
            {
                target.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHanlder, false, 0, true);
                target.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHanlder, false, 0, true);
                target.addEventListener(Event.REMOVED, mouseOutHanlder, false, 0, true);
            }
            
            if(target.hasOwnProperty("toolTip"))
            {
                toolTipMap[target] = target["toolTip"];
            }
            else if(toolTip) 
            {
                toolTipMap[target] = toolTip;
            }
        }
    }

    /**
     * Remove a tooltip target.
     * @param target will remove tooltip target
     * 
     */
    public function removeToolTip(target:InteractiveObject):void
    {
        if(target && toolTipMap[target] != null)
        {
            target.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHanlder);
            target.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHanlder);
            target.removeEventListener(Event.REMOVED, mouseOutHanlder);
            delete toolTipMap[target];
        }
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function mouseOverHanlder(event:MouseEvent):void
    {
        if( !enabled) return;
        currentTarget = InteractiveObject(event.currentTarget);
        if(currentTarget.stage)
        {
            triggTimer.stop();
            
            if(isFastDisplay) 
            {
                triggTimer.delay = FAST_DISPLAY_TIME;
            }
            else 
            {
                triggTimer.delay = TRIGG_TIME;
            }
            
            triggTimer.reset();
            triggTimer.start();
        }
    }

    private function mouseOutHanlder(event:Event):void
    {
        if(toolTipDisplay && DisplayObject(toolTipDisplay).stage)
        {
            DisplayObject(toolTipDisplay).stage.removeChild(DisplayObject(toolTipDisplay));
        }
        
        triggTimer.stop();
        quashTimer.stop();
        quashTimer.reset();
        quashTimer.start();
        
        currentTarget = null;
    }

    private function triggTimeConplete(event:TimerEvent):void
    {
        isFastDisplay = true;
        if(currentTarget && currentTarget.stage)
        {
            var toolTipTemp:DisplayObject = DisplayObject(toolTipDisplay);
            
            toolTipDisplay.display(toolTipMap[currentTarget]);
            currentTarget.stage.addChild(toolTipTemp);
            
            var tx:int = currentTarget.stage.mouseX;
            var ty:int = currentTarget.stage.mouseY + 20;
            if(toolTipTemp.width + tx > currentTarget.stage.stageWidth) 
            {
                tx = currentTarget.stage.stageWidth - toolTipTemp.width - 3;
            }
            if(toolTipTemp.height + ty > currentTarget.stage.stageHeight) 
            {
                ty = currentTarget.stage.stageHeight - toolTipTemp.height - 30;
            }
            toolTipTemp.x = tx;
            toolTipTemp.y = ty;
        } 
    }

    private function quashTimeConplete(event:TimerEvent):void
    {
        isFastDisplay = false;
    }
}
}