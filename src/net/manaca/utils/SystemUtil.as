package net.manaca.utils
{
/**
 *  The SystemUtil utility class is an all-static class with methods for
 *  working with debug and develop tools.
 */
public class SystemUtil
{
    /**
     * Benchmark a function
     * @param func The benchmark of function.
     * @return The test result;
     * 
     */    
    public static function benchmark(func:Function):String
    {
        var startTime:Date = new Date();
        
        func();
        
        var endTime:Date = new Date();
    
        var benchmark:Number = endTime.time - startTime.time;
        var result:String = benchmark + "ms";
        
        return result;
    }
    
    /**
     * Return the call method trace.
     * @return 
     * 
     */    
    public static function calledMethod():String
    {
        try
        {
            throw new Error("my error");
        }
        catch (error:Error)
        {
            return error.getStackTrace();
        }
        return "";
    }
}
}