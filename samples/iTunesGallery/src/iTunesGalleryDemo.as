package
{
import net.manaca.itunesGallery.iTunesGallery;
import net.manaca.logging.publishers.Output;

[SWF(width='1200', height='600',frameRate='24', backgroundColor='#000000')]

public class iTunesGalleryDemo extends iTunesGallery
{
    public function iTunesGalleryDemo()
    {
        var output:Output = new Output(150, true);
        this.stage.addChild(output);
        this.stage.removeChild(output);
        super();
    }
}
}
