package site
{
import com.asual.swfaddress.SWFAddress;
import com.asual.swfaddress.SWFAddressEvent;

import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

import net.manaca.application.Bootstrap;
import net.manaca.application.config.FileTypeInfo;
import net.manaca.loaderqueue.ILoaderAdapter;
import net.manaca.loaderqueue.LoaderProgressCounter;
import net.manaca.loaderqueue.LoaderQueue;
import net.manaca.loaderqueue.adapter.LoaderAdapter;
import net.manaca.loaderqueue.adapter.URLLoaderAdapter;
import net.manaca.loaderqueue.adapter.URLStreamAdapter;
import net.manaca.logging.Tracer;
import net.manaca.modules.ModuleManager;
import net.manaca.utils.DeepVO;

import site.menu.Menu;
import site.model.FileVO;
import site.model.SectionModel;
import site.model.SectionVO;
import site.module.ModuleBase;

/**
 * 主容器
 * @author wersling
 *
 */
public class MainContainer extends Sprite
{
    static public var BACK_ADDRESS:String = "/";
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>MainContainer</code> instance.
     *
     */
    public function MainContainer()
    {
        super();

        addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var currentDeep:DeepVO;
    private var moduleLoader:LoaderAdapter;
    private var files:Object;
    private var loaderProgressCounter:LoaderProgressCounter;
    
    private var menu:Menu;
    private var content:Content;
    private var footer:Footer;
    
    private var loadingModuleDeep:DeepVO;
    private var currentModulePath:String;
    private var currentModule:ModuleBase;
    //==========================================================================
    //  Properties
    //==========================================================================

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * init display.
     *
     */
    private function initDisplay():void
    {
        SectionModel.getInstance().init(
            Bootstrap.getInstance().config.Sections);
            
        content = new Content();
        addChild(content);
        
        menu = new Menu();
        menu.initMenu();
        addChild(menu);
        
        footer = new Footer();
        addChild(footer);
        
        stage.addEventListener(Event.RESIZE, stage_reSizeHandler);
        stage_reSizeHandler(null);

        SWFAddress.addEventListener(SWFAddressEvent.CHANGE,
                                    swfAddress_changeHandler);
        
        var oldUrl:String = Bootstrap.getInstance().href;
        if(oldUrl.indexOf("?") != -1)
        {
            Tracer.debug("oldurl : " + oldUrl);
            var vars:Array = oldUrl.split("?");
            SWFAddress.setValue(vars[1]);
        }
    }
    
    
    private function deepChange(path:String):void
    {
        Tracer.info("change : " + path);
        var deepVO:DeepVO = new DeepVO(path);
        if (!currentDeep || currentDeep.path != deepVO.path)
        {
            if(currentDeep)
            {
                BACK_ADDRESS = currentDeep.path;
            }
            currentDeep = deepVO;
            menu.changeDeep(deepVO);
            startLoadingAssets();
        }
    }
    
    private function removeCurrentLoading():void
    {
        if(loaderProgressCounter)
        {
            loaderProgressCounter.removeEventListener(Event.CHANGE,
                loaderProgressCounter_changeHandler);
            loaderProgressCounter.removeEventListener(Event.COMPLETE,
                loaderProgressCounter_completeHandler);
            loaderProgressCounter.dispose();
            loaderProgressCounter = null;
        }
        
        if(files)
        {
            var loaderQueue:LoaderQueue = Bootstrap.getInstance().loaderQueue;
            for each(var name:String in files)
            {
                loaderQueue.removeItem(files[name]);
            }
        }
        
        if(moduleLoader)
        {
            loaderQueue.removeItem(moduleLoader);
            moduleLoader.dispose();
            moduleLoader = null;
        }
    }
    
    private function startLoadingAssets():void
    {
        removeCurrentLoading();
        
        var sectionVO:SectionVO =
            SectionModel.getInstance().getSectionByDeepVO(currentDeep);
        
        var loaderQueue:LoaderQueue = Bootstrap.getInstance().loaderQueue;
        loaderProgressCounter =  new LoaderProgressCounter();
        
        //加载模块
        var moduleUrl:String =
            SectionModel.getInstance().getModulePath(sectionVO);
        loadingModuleDeep = currentDeep;
        //递归到上级，直到找到一个模块.
        //主要修正deep进入一个没有模块的页面.
        while(!moduleUrl)
        {
            loadingModuleDeep = loadingModuleDeep.getParent();
            sectionVO =
                SectionModel.getInstance().getSectionByDeepVO(loadingModuleDeep);
            moduleUrl =
                SectionModel.getInstance().getModulePath(sectionVO);
        }
        
        if (true || currentModulePath != moduleUrl)
        {
            currentModulePath = moduleUrl;
            var context:LoaderContext = new LoaderContext();
            context.applicationDomain = ApplicationDomain.currentDomain;
            moduleLoader = 
                new LoaderAdapter(1, new URLRequest(moduleUrl), context);
            loaderQueue.addItem(moduleLoader);
            loaderProgressCounter.addItem(moduleLoader);
            Tracer.debug("start loading module : " + moduleUrl);
        }

        //加载扩展文件
        if (sectionVO && sectionVO.files.length > 0)
        {
            files = {};
            var loader:ILoaderAdapter = null;
            for each (var vo:FileVO in sectionVO.files)
            {
                switch(String(vo.type))
                {
                    case FileTypeInfo.IMAGE:
                    {
                        loader = new LoaderAdapter(1, new URLRequest(vo.url));
                        break;
                    }
                    case FileTypeInfo.SWF:
                    {
                        loader = new LoaderAdapter(1, new URLRequest(vo.url));
                        break;
                    }
                    case FileTypeInfo.XML:
                    {
                        loader = new URLLoaderAdapter(1, new URLRequest(vo.url));
                        break;
                    }
                    default:
                    {
                        loader = new URLStreamAdapter(1, new URLRequest(vo.url));
                        break;
                    }
                }
                loader.data = vo;
                files[vo.name] = loader;
                loaderQueue.addItem(loader);
                loaderProgressCounter.addItem(loader);
                Tracer.debug("loading files " + vo.url);
            }
        }
        loaderProgressCounter.addEventListener(Event.CHANGE,
            loaderProgressCounter_changeHandler);
        loaderProgressCounter.addEventListener(Event.COMPLETE,
            loaderProgressCounter_completeHandler);
        loaderProgressCounter.start();
    }

    /**
     * 显示新的内容
     * 
     */    
    private function displayNewContent():void
    {
        if (moduleLoader)
        {
            var sectionVO:SectionVO =
                SectionModel.getInstance().getSectionByDeepVO(loadingModuleDeep);
            var moduleUrl:String = moduleLoader.container.contentLoaderInfo.url;

            var moduleName:String;
            if (sectionVO && sectionVO.module)
            {
                moduleName = sectionVO.module;
                var moduleClz:String= 
                    ModuleManager.getModuleVOByName(moduleName).clz;
                var app:ApplicationDomain =
                    moduleLoader.container.contentLoaderInfo.applicationDomain
                var moduleClass:Class = app.getDefinition(moduleClz) as Class;
                currentModule = new moduleClass();
                currentModule.init(currentDeep, sectionVO, files);
                content.show(currentModule);
            }
            else if(currentModule)
            {
                currentModule.changeDeep(currentDeep);
            }
        }
        else if(currentModule)
        {
            currentModule.changeDeep(currentDeep);
        }
        moduleLoader = null;
        files = null;
    }

    //==========================================================================
    //  Event Handlers
    //==========================================================================
    private function loaderProgressCounter_completeHandler(event:Event):void
    {
        loaderProgressCounter.removeEventListener(Event.CHANGE,
            loaderProgressCounter_changeHandler);
        loaderProgressCounter.removeEventListener(Event.COMPLETE,
            loaderProgressCounter_completeHandler);
        loaderProgressCounter.dispose();
        loaderProgressCounter = null;
        displayNewContent();
    }
    
    private function loaderProgressCounter_changeHandler(event:Event):void
    {
    }

    private function swfAddress_changeHandler(event:SWFAddressEvent):void
    {
        deepChange(event.value);
    }

    private function addToStageHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
        initDisplay();
    }

    private function stage_reSizeHandler(event:Event):void
    {
        var w:int = stage.stageWidth;
        var h:int = stage.stageHeight;

        if (content)
        {
            content.width = w;
            content.height = h;
        }
        if (footer)
        {
            footer.width = w;
            footer.y = h - footer.height;
        }
    }
}
}