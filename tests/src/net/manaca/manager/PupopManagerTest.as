package net.manaca.manager
{
import flexunit.framework.TestCase;

import net.manaca.errors.SingletonError;
import net.manaca.managers.PopUpManager;

public class PupopManagerTest extends TestCase
{
    public function PupopManagerTest(methodName:String = null)
    {
        super(methodName);
    }

    public function testSingletonError():void
    {
        PopUpManager.getInstance();
        try
        {
            new PopUpManager();
            fail("the singleton error can't throw.")
        }
    catch(error:SingletonError)
        {
        //can't handle
        }
    }
}
}