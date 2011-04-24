package net.manaca
{
import flexunit.framework.TestSuite;

import net.manaca.data.HashMapTest;
import net.manaca.data.SetTest;
import net.manaca.loading.LoadingQueueTest;
import net.manaca.loading.MultiLoadingTest;
import net.manaca.manager.DepthManagerTest;
import net.manaca.manager.PupopManagerTest;
import net.manaca.utils.CookieClearTest;
import net.manaca.utils.CookieTest;
import net.manaca.utils.StringUtilTest;
import net.manaca.utils.NumberUtilTest;
import net.manaca.xml.XMLNodeTest;
import net.manaca.xml.type.SchemaNumberTest;
import net.manaca.xml.type.SchemaStringTest;
import net.manaca.xml.type.SchmeaBooleanTest;

public class AllTests extends TestSuite
{
    public function AllTests()
    {
        super();

        addTestSuite(SetTest);
        addTestSuite(HashMapTest);

        addTestSuite(CookieTest);
        addTestSuite(CookieClearTest);

        addTestSuite(XMLNodeTest);
        addTestSuite(SchemaStringTest);
        addTestSuite(SchmeaBooleanTest);
        addTestSuite(SchemaNumberTest);

        addTestSuite(StringUtilTest);
        addTestSuite(NumberUtilTest);
        
        addTestSuite(MultiLoadingTest);
        addTestSuite(LoadingQueueTest);

        addTestSuite(DepthManagerTest);
        addTestSuite(PupopManagerTest);
    }
}
}