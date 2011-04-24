package
{
import net.manaca.application.Application;

[Frame(factoryClass="net.manaca.preloaders.SimplePreloader")]

public class ApplicationExample extends Application
{

    [Embed(source="./application.xml", mimeType="application/octet-stream")]
    private var configClz:Class;

    public function ApplicationExample()
    {
        super(configClz);
    }

    override protected function startup():void
    {
        trace(Application.config)
        trace(Application.externalFiles)
        trace(Application.projectSettings)
    }
}
}
