package net.manaca.core.patterns.command
{

/**
 * A base <code>ICommand</code> implementation.
 *
 * <P>Your subclass should override the <code>execute</code>
 * method where your business logic will handle the <code>CommandEvent</code>. </P>
 * @author Sean Zou
 * @see net.manaca.core.presenter.CommandEvent
 */
public class Command implements ICommand
{
    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * Fulfill the use-case initiated by the given <code>CommandEvent</code>.
     *
     * <P>In the Command Pattern, an application use-case typically
     * begins with some user action, which results in an <code>CommandEvent</code> being broadcast, which
     * is handled by business logic in the <code>execute</code> method of an
     * <code>ICommand</code>.</P>
     * @param event the <code>CommandEvent</code> to handle.
     *
     */
    public function execute(event:CommandEvent = null):void
    {
    }
}
}