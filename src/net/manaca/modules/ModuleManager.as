package net.manaca.modules
{

public class ModuleManager
{
    static public function getAssociatedFactory(object:Object):IModuleFactory
    {
        return getSingleton().getAssociatedFactory(object);
    }

    static public function getModule(moduleName:String):IModuleInfo
    {
        return getSingleton().getModule(moduleName);
    }

    static private var managerSingleton:ModuleManagerImpl;

    static private function getSingleton():ModuleManagerImpl
    {
        if (!managerSingleton)
        {
            managerSingleton = new ModuleManagerImpl();
        }

        return managerSingleton;
    }
}
}