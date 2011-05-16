package site.model
{
import net.manaca.modules.ModuleManager;
import net.manaca.utils.DeepVO;

/**
 * 菜单数据接口
 * @author wersling
 * 
 */
public class SectionModel
{
    /**
     *  @private
     */
    private static var instance:SectionModel;
    
    //==========================================================================
    //  Class methods
    //==========================================================================
    
    /**
     *  Returns the sole instance of this singleton class,
     *  creating it if it does not already exist.
     */
    public static function getInstance():SectionModel
    {
        if (!instance)
        {                
            instance = new SectionModel();
        }
        return instance;
    }
    
    public function SectionModel()
    {
    }
    
    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  sectionList
    //----------------------------------
    private var _sectionList:Array = [];
    /**
     * 所有页面的数据
     * @return 
     * 
     */    
    public function get sectionList():Array
    {
        return _sectionList;
    }
    
    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * 通过地址获取对于页面属性.
     * @param deepVO
     * @return 
     * 
     */    
    public function getSectionByDeepVO(deepVO:DeepVO):SectionVO
    {
        var sectionVO:SectionVO;
        if(deepVO.length > 0)
        {
            var params:Array = deepVO.params;
            if(deepVO.length >= 1)
            {
                sectionVO = getSectionByDeep(deepVO.params[0], _sectionList);
            }
            for(var i:int = 1; i < params.length; i++)
            {
                if(sectionVO)
                {
                    sectionVO = 
                        getSectionByDeep(deepVO.params[i], sectionVO.menuChildren);
                }
            }
        }
        return sectionVO;
    }
    
    /**
     * 获得指定SectionVO的模块
     * @param sectionVO
     * @return 
     * 
     */    
    public function getModulePath(sectionVO:SectionVO):String
    {
        var result:String;
        if(sectionVO && sectionVO.module)
        {
            result = ModuleManager.getModuleVOByName(sectionVO.module).url;
        }
        else
        {
            return null;
        }
        return result;
    }
    
    private function getSectionByDeep(deep:String, list:Array):SectionVO
    {
        for each(var item:SectionVO in list)
        {
            if(item.deep == deep)
            {
                return item;
            }
        }
        return null;
    }
    
    public function init(sectionNode:XMLList):void
    {
        var list:XMLList = sectionNode.Section;
        for each(var item:XML in list)
        {
            var sectionVO:SectionVO = new SectionVO(item);
            if(item.Section.length())
            {
                addSectionVO(item, sectionVO);
            }
            _sectionList.push(sectionVO);
        }
    }
    
    private function addSectionVO(node:XML, superior:SectionVO):void
    {
        var list:XMLList = node.Section;
        for each(var item:XML in list)
        {
            var sectionVO:SectionVO = new SectionVO(item);
            if(item.Section.length())
            {
                addSectionVO(item, sectionVO);
            }
            superior.menuChildren.push(sectionVO);
        }
    }
}
}