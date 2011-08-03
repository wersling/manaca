package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.Injector;

    public class InjectionPoint
    {
        /*******************************************************************************************
        *								public methods											   *
        *******************************************************************************************/
        public function InjectionPoint(node : XML, injector : Injector)
        {
            initializeInjection(node, injector);
        }
        
        public function applyInjection(target : Object, injector : Injector) : Object
        {
            return target;
        }


        /*******************************************************************************************
        *								protected methods										   *
        *******************************************************************************************/
        protected function initializeInjection(node : XML, injector : Injector) : void
        {
        }
    }
}
