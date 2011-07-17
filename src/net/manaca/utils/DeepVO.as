package net.manaca.utils
{

/**
 * 将一个SWFAddress获得的value封装成一个对象，便于操作.
 * @author Sean Zou
 *
 */
public class DeepVO
{
    /**
     * 构造函数
     * @param path SWFAddress获取的value.
     *
     */
    public function DeepVO(path:String)
    {
        this._path = path;
        path = path.slice(1);
        _params = path.split("/");
    }
    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  path
    //----------------------------------
    /**
     * @private
     */
    private var _path:String;

    /**
     * SWFAddress获取的value.
     * @return
     *
     */
    public function get path():String
    {
        return _path;
    }

    //----------------------------------
    //  params
    //----------------------------------
    /**
     * @praivate
     */
    private var _params:Array = [];

    /**
     * 将路径以/拆分的数组.
     * @return
     *
     */
    public function get params():Array
    {
        return _params;
    }

    //----------------------------------
    //  length
    //----------------------------------
    /**
     * 将路径以/拆分的数据长度.
     * @return
     *
     */
    public function get length():int
    {
        return params.length;
    }

    /**
     * 获得父级VO
     * @return
     *
     */
    public function getParent():DeepVO
    {
        var p:Array = params.concat();
        p.pop();
        return new DeepVO("/" + p.join("/"));
    }
}
}