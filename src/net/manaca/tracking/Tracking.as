package net.manaca.tracking
{
import net.manaca.data.Set;
import net.manaca.tracking.sender.ITrackingSender;

/**
 *
 * @author Sean
 *
 */
public class Tracking
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    static private const senderList:Set = new Set();

    //==========================================================================
    //  Class methods
    //==========================================================================

    /**
     * Do the tracking.
     *
     * @param action    The value to track.
     * @param rest        Additional parameters.
     */
    static public function action(action:String, ... rest):void
    {
        var list:Array = senderList.toArray();
        for each (var sender:ITrackingSender in list)
        {
            sender.externalTrack(action, rest);
        }
    }

    /**
     * Add a sender.
     *
     * @param sender    The sender to add.
     */
    static public function addSender(sender:ITrackingSender):void
    {
        senderList.add(sender);
    }

    /**
     * Remove a sender.
     *
     * @param sender    The sender to remove.
     */
    static public function removeSender(sender:ITrackingSender):void
    {
        senderList.remove(sender);
    }
}
}