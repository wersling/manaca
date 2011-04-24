package net.manaca.controls
{
import flash.events.EventDispatcher;

import net.manaca.utils.ArrayUtil;

/**
 * The ListPaging can be paging the LayoutList datas.
 * You can set a layoutList and pageConunt do paging use nextPage and 
 * previousPage.
 * 
 * @author v-seanzo
 *
 */
public class ListPaging extends EventDispatcher
{
    //==========================================================================
    //  Variables
    //==========================================================================

    private var list:LayoutList;

    //==========================================================================
    //  Constructor
    //==========================================================================

    /**
     * Constructs a new <code>ListPaging</code> instance.
     * @param list A layoutList instance.
     * @param pageCount the page count of paging.
     *
     */
    public function ListPaging(list:LayoutList, pageCount:uint = 5)
    {
        super();

        this.list = list;
        this.pageCount = pageCount;
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  dataProvider
    //----------------------------------
    private var _dataProvider:Object;

    /**
     * Set of data to be viewed.
     * This property lets you use most types of objects as data providers. 
     * some Array, XML, XMLList and any object.
     * @return
     *
     */
    public function get dataProvider():Object
    {
        return _dataProvider;
    }

    public function set dataProvider(value:Object):void
    {
        _dataProvider = ArrayUtil.toArray(value);

        _currentPage = 0;
        _totalPage = Math.ceil(dataProvider.length / pageCount);

        updateList();
    }

    //----------------------------------
    //  pageCount
    //----------------------------------
    private var _pageCount:uint = 5;

    /**
     * The page count of paging.
     * @return
     *
     */
    public function get pageCount():uint
    {
        return _pageCount;
    }

    public function set pageCount(value:uint):void
    {
        _pageCount = Math.max(1, value);

        if(dataProvider)
        {
            var dataLen:uint = dataProvider.length;
            if(_currentPage != 0)
            {
                while(_currentPage * _pageCount >= dataLen)
                {
                    _currentPage--;
                }
            }

            _totalPage = Math.ceil(dataLen / pageCount);
            updateList();
        }
    }

    //----------------------------------
    //  currentPage
    //----------------------------------
    private var _currentPage:uint = 0;

    /**
     * Get current page number.
     * @return
     *
     */
    public function get currentPage():uint
    {
        return _currentPage;
    }

    public function set currentPage(value:uint):void
    {
        _currentPage = Math.max(0, Math.min(value, totalPage - 1));

        updateList();
    }

    //----------------------------------
    //  totalPage
    //----------------------------------

    private var _totalPage:uint = 0;

    /**
     * Get total page number.
     * @return
     *
     */
    public function get totalPage():uint
    {
        return _totalPage;
    }

    //----------------------------------
    //  hasPreviousPage
    //----------------------------------
    /**
     * The paging has previous page.
     * @return if has return ture, else false.
     *
     */
    public function get hasPreviousPage():Boolean
    {
        return _currentPage > 0;
    }

    //----------------------------------
    //  hasNextPage
    //----------------------------------
    /**
     * The paging has next page.
     * @return if has return ture, else false.
     *
     */
    public function get hasNextPage():Boolean
    {
        return (_currentPage < _totalPage && _totalPage > 1);
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * update the list.
     *
     */
    private function updateList():void
    {
        if(list && dataProvider)
        {
            list.dataProvider = dataProvider.slice(_currentPage * _pageCount, 
                                            (_currentPage + 1) * _pageCount);
        }
    }

    /**
     * Display previous page if has previous page.
     *
     */
    public function previousPage():void
    {
        if(hasPreviousPage)
        {
            currentPage-- ;
        }
    }

    /**
     * Display next page if has next page.
     *
     */
    public function nextPage():void
    {
        if(hasNextPage)
        {
            currentPage++;
        }
    }

    /**
     * dispose the instance.
     */
    public function dispose():void
    {
        list.dispose();
        list = null;
    }
}
}