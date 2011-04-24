package net.manaca.core.patterns.command
{

/**
 * The <code>ICommand</code> interface definition for a Model-View-Presenter Command.
 * @author Sean Zou
 * @see net.manaca.core.presenter.CommandEvent
 */
public interface ICommand
{
    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * Execute the <code>ICommand</code>"s logic to handle a given <code>CommandEvent</code>.
     * @param eventan <code>CommandEvent</code> to handle.
     *
     */
    function execute(event:CommandEvent = null):void;
}
}