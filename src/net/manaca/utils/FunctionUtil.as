package net.manaca.utils
{

/**
 *  The FunctionUtil utility class is an all-static class with methods for
 *  working with debug and develop tools.
 */
public class FunctionUtil
{
    /**
     * Benchmark a function
     * @param func The benchmark of function.
     * @return The test result;
     *
     */
    static public function benchmark(func:Function):String
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
    static public function calledMethod():String
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