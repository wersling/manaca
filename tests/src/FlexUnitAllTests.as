package
{
    import flexunit.framework.*;
    import net.manaca.app.BaseApplicationConfigurationTest;
    import net.manaca.data.ArraryIteratorTest;
    import net.manaca.data.HashMapTest;
    import net.manaca.data.SetTest;
    import net.manaca.formatters.DateFormatterTest;
    import net.manaca.formatters.NumberFormatterTest;
    import net.manaca.formatters.StringFormatterTest;
    import net.manaca.loading.LoadingQueueTest;
    import net.manaca.loading.MultiLoadingTest;
    import net.manaca.manager.DepthManagerTest;
    import net.manaca.manager.PupopManagerTest;
    import net.manaca.utils.CookieClearTest;
    import net.manaca.utils.CookieTest;
    import net.manaca.utils.NumberUtilTest;
    import net.manaca.utils.StringUtilTest;
    import net.manaca.xml.type.SchemaNumberTest;
    import net.manaca.xml.type.SchemaStringTest;
    import net.manaca.xml.type.SchmeaBooleanTest;
    import net.manaca.xml.XMLNodeTest;

    public class FlexUnitAllTests 
    {
        public static function suite() : TestSuite
        {
            var testSuite:TestSuite = new TestSuite();
            testSuite.addTestSuite(net.manaca.app.BaseApplicationConfigurationTest);
            testSuite.addTestSuite(net.manaca.data.ArraryIteratorTest);
            testSuite.addTestSuite(net.manaca.data.HashMapTest);
            testSuite.addTestSuite(net.manaca.data.SetTest);
            testSuite.addTestSuite(net.manaca.formatters.DateFormatterTest);
            testSuite.addTestSuite(net.manaca.formatters.NumberFormatterTest);
            testSuite.addTestSuite(net.manaca.formatters.StringFormatterTest);
            testSuite.addTestSuite(net.manaca.loading.LoadingQueueTest);
            testSuite.addTestSuite(net.manaca.loading.MultiLoadingTest);
            testSuite.addTestSuite(net.manaca.manager.DepthManagerTest);
            testSuite.addTestSuite(net.manaca.manager.PupopManagerTest);
            testSuite.addTestSuite(net.manaca.utils.CookieClearTest);
            testSuite.addTestSuite(net.manaca.utils.CookieTest);
            testSuite.addTestSuite(net.manaca.utils.NumberUtilTest);
            testSuite.addTestSuite(net.manaca.utils.StringUtilTest);
            testSuite.addTestSuite(net.manaca.xml.type.SchemaNumberTest);
            testSuite.addTestSuite(net.manaca.xml.type.SchemaStringTest);
            testSuite.addTestSuite(net.manaca.xml.type.SchmeaBooleanTest);
            testSuite.addTestSuite(net.manaca.xml.XMLNodeTest);
            return testSuite;
        }
    }
}
