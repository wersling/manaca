package net.manaca.application
{

/**
 * The APIs of the IApplication interface
 * provide initialization for our Applications
 */
public interface IApplication
{
    //==========================================================================
    //  Methods
    //==========================================================================

    /**
     * The initialize function will call by proloader complete.
     */
    function initialize():void;
}
}