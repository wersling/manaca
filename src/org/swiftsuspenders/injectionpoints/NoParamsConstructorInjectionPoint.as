package org.swiftsuspenders.injectionpoints
{
    import org.swiftsuspenders.Injector;

    public class NoParamsConstructorInjectionPoint extends InjectionPoint
    {
        public function NoParamsConstructorInjectionPoint()
        {
            super(null, null);
        }
        
        override public function applyInjection(target : Object, injector : Injector) : Object
        {
            return new target();
        }
    }
}
