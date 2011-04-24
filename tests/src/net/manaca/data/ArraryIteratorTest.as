package net.manaca.data
{
import flexunit.framework.TestCase;

public class ArraryIteratorTest extends TestCase
{
    public function ArraryIteratorTest(methodName:String=null)
    {
        super(methodName);
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var iterator:ArrayIterator;
    //==========================================================================
    //  Methods
    //==========================================================================
    override public function setUp() : void
    {
    }
    
    override public function tearDown() : void
    {
        iterator.clear();
        iterator = null;
    }
    
    public function testConstructs():void
    {
        iterator = new ArrayIterator([1,2,3]);
        assertEquals(iterator.size(), 3);
        
        iterator = new ArrayIterator();
        assertEquals(iterator.size(), 0);
        
        iterator = new ArrayIterator(null);
        assertEquals(iterator.size(), 0);
        
        iterator = new ArrayIterator({});
        assertEquals(iterator.size(), 1);
        
        iterator = new ArrayIterator("a");
        assertEquals(iterator.size(), 1);
    }
    
    public function testSize():void
    {
        iterator = new ArrayIterator([1,2,3]);
        assertEquals(iterator.size(), 3);
        
        iterator = new ArrayIterator();
        assertEquals(iterator.size(), 0);
    }
    
    public function testClear():void
    {
        iterator = new ArrayIterator([1,2,3]);
        iterator.clear();
        assertEquals(iterator.size(), 0);
        
        iterator = new ArrayIterator([1,2,3]);
        iterator.next();
        iterator.next();
        iterator.clear();
        assertEquals(iterator.size(), 0);
        assertFalse(iterator.hasNext());
    }
    
    public function testHasNext():void
    {
        iterator = new ArrayIterator([1,2,3]);
        assertTrue(iterator.hasNext());
        iterator.next();
        assertTrue(iterator.hasNext());
        iterator.next();
        iterator.next();
        assertFalse(iterator.hasNext());
    }
    
    public function testNext():void
    {
        iterator = new ArrayIterator([1,2,3]);
        assertEquals(iterator.next(), 1);
        assertEquals(iterator.next(), 2);
        assertEquals(iterator.next(), 3);
    }
    
    public function testHasPrevious():void
    {
        iterator = new ArrayIterator([1,2,3]);
        assertFalse(iterator.hasPrevious());
        iterator.next();
        assertFalse(iterator.hasPrevious());
        iterator.next();
        iterator.next();
        assertTrue(iterator.hasPrevious());
    }
    
    public function testPrevious():void
    {
        iterator = new ArrayIterator([1,2,3]);
        assertEquals(iterator.next(), 1);
        assertEquals(iterator.next(), 2);
        assertEquals(iterator.previous(), 1);
        assertEquals(iterator.next(), 2);
        assertEquals(iterator.next(), 3);
        assertEquals(iterator.previous(), 2);
        assertEquals(iterator.previous(), 1);
    }
    
    public function testNextIndex():void
    {
        iterator = new ArrayIterator(["a", "b", "c"]);
        assertEquals(iterator.nextIndex(), 0);
        iterator.next();
        assertEquals(iterator.nextIndex(), 1);
        iterator.next();
        assertEquals(iterator.nextIndex(), 2);
        iterator.next();
        assertEquals(iterator.nextIndex(), 3);
        iterator.next();
        assertEquals(iterator.nextIndex(), 3);
    }
    
    public function testPreviousIndex():void
    {
        iterator = new ArrayIterator(["a", "b", "c", "d"]);
        assertEquals(iterator.previousIndex(), -1);
        iterator.next();
        assertEquals(iterator.previousIndex(), -1);
        iterator.next();
        assertEquals(iterator.previousIndex(), 0);
        iterator.next();
        assertEquals(iterator.previousIndex(), 1);
        iterator.next();
        assertEquals(iterator.previousIndex(), 2);
        iterator.next();
        assertEquals(iterator.previousIndex(), 2);
        iterator.previous();
        assertEquals(iterator.previousIndex(), 1);
    }
}
}