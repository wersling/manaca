package net.manaca.core.patterns.command
{

/**
 * A base <code>ICommand</code> implementation that executes other <code>ICommand</code>s.
 * 
 * <p>
 * A <code>MacroCommand</code> maintains an list of
 * <code>ICommand</code> Class references called <i>SubCommands</i>.</p>
 * 
 * <p>
 * When <code>execute</code> is called, the <code>MacroCommand</code> 
 * instantiates and calls <code>execute</code> on each of its <i>SubCommands</i> turn.
 * Each <i>SubCommand</i> will be passed a reference to the original
 * <code>INotification</code> that was passed to the <code>MacroCommand</code>"s 
 * <code>execute</code> method.</p>
 * 
 * <p>
 * Unlike <code>SimpleCommand</code>, your subclass
 * should not override <code>execute</code>, but instead, should 
 * override the <code>initializeMacroCommand</code> method, 
 * calling <code>addSubCommand</code> once for each <i>SubCommand</i>
 * to be executed.</p>
 * 
 * @author Sean Zou
 * 
 */    
public class MacroCommand implements ICommand
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    
    /**
     * <p>
     * You should not need to define a constructor, 
     * instead, override the <code>initializeMacroCommand</code>
     * method.</p>
     * 
     * <p>
     * If your subclass does define a constructor, be 
     * sure to call <code>super()</code>.</p>
     */    
    public function MacroCommand()
    {
        super();
        commands = new Array();
        initialize();
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    /**
     * The commands list.
     */        
    private var commands:Array;

    //==========================================================================
    //  Methods
    //==========================================================================
    
    /**
     * Initialize the <code>MacroCommand</code>.
     * <p>
     * In your subclass, override this method to 
     * initialize the <code>MacroCommand</code>"s <i>SubCommand</i>  
     * list with <code>ICommand</code> class references like 
     * this:</p>
     * 
     * <listing>
     *        // Initialize MyMacroCommand
     *        override protected function initialize( ):void
     *        {
     *            addSubCommand( com.me.myapp.FirstCommand );
     *            addSubCommand( com.me.myapp.SecondCommand );
     *            addSubCommand( com.me.myapp.ThirdCommand );
     *        }
     * </listing>
     * 
     */
    protected function initialize():void
    {
    }

    /**
     * Add a <i>SubCommand</i>.
     * 
     * <p>
     * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
     * order.</p>
     * 
     * @param commandClassRef a reference to the 
     * <code>Class</code> of the <code>ICommand</code>.
     */
    protected function addSubCommand( commandClassRef:Class ):void
    {
        commands.push(commandClassRef);
    }

    /** 
     * Execute this <code>MacroCommand</code>"s <i>SubCommands</i>.
     * 
     * <p>
     * The <i>SubCommands</i> will be called in First In/First Out (FIFO)
     * order. </p>
     * 
     * @param notification the <code>CommandEvent</code> object to be passsed 
     * to each <i>SubCommand</i>.
     */
    public function execute( event:CommandEvent = null ):void
    {
        while ( commands.length > 0) 
        {
            var commandClassRef:Class = commands.shift();
            var commandInstance:ICommand = new commandClassRef();
            commandInstance.execute(event);
        }
    }
}
}