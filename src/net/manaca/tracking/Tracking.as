package net.manaca.tracking
{
import net.manaca.tracking.sender.ITrackingSender;
import net.manaca.utils.ArrayUtil;

/**
 *
 * @author Sean Zou
 *
 */
public class Tracking
{
    //==========================================================================
    //  Class variables
    //==========================================================================
    static private const senderList:Array = [];

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
        for each (var sender:ITrackingSender in senderList)
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
        senderList.push(sender);
    }

    /**
     * Remove a sender.
     *
     * @param sender    The sender to remove.
     */
    static public function removeSender(sender:ITrackingSender):void
    {
        ArrayUtil.removeValueFromArray(senderList, sender);
    }
}
}