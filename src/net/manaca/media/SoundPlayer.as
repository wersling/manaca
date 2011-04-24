package net.manaca.media
{
import flash.events.Event;
import flash.events.TimerEvent;
import flash.media.Sound;
import flash.media.SoundChannel;
import flash.media.SoundLoaderContext;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.utils.Timer;

import net.manaca.events.PlayerEvent;
import net.manaca.logging.Tracer;

/**
 * Dispatched when the the play state chenged.
 * @eventType net.manaca.events.PlayerEvent.PLAY_STATE_CHANGE
 */
[Event(name = "playStateChange", type = "net.manaca.events.PlayerEvent")]

/**
 * Dispatched when the play progress chenged.
 * @eventType net.manaca.events.PlayerEvent.PROGRESS_CHANGE
 */
[Event(name = "progressChange", type = "net.manaca.events.PlayerEvent")]

/**
 * Dispatched when the play completed.
 * @eventType flash.events.Event.SOUND_COMPLETE
 */
[Event(name = "soundComplete", type = "flash.events.Event")]

/**
 * The SoundPlayer provide base sound player.
 *
 * @author v-seanzo
 *
 */
public class SoundPlayer extends Sound
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var loops:int = 0;
    private var current_point:int = 0;
    private var planTimer:Timer;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>SoundPlayer</code> instance.
     * @param stream
     * @param context
     *
     */
    public function SoundPlayer(stream:URLRequest = null, context:SoundLoaderContext = null)
    {
        super(stream, context);

        playProgressEnabled = true;
    }

    //==========================================================================
    //  Properties
    //==========================================================================
    //----------------------------------
    //  playing
    //----------------------------------
    private var _playing:Boolean = false;

    /**
     * Define the sound is playing.
     * @return
     *
     */
    public function get playing():Boolean
    {
        return _playing;
    }

    private function setPlaying(value:Boolean):void
    {
        _playing = value;

        updateProgressEvent();

        this.dispatchEvent(new PlayerEvent(PlayerEvent.PLAY_STATE_CHANGE));
    }

    //----------------------------------
    //  planEventEnabled
    //----------------------------------
    private var _playProgressEnabled:Boolean = true;

    /**
     * Define the play progress is update.
     * @return
     *
     */
    public function get playProgressEnabled():Boolean
    {
        return _playProgressEnabled;
    }

    public function set playProgressEnabled(value:Boolean):void
    {
        _playProgressEnabled = value;

        if(_playProgressEnabled)
        {
            planTimer = new Timer(100);
            planTimer.addEventListener(TimerEvent.TIMER, updateProgressHandler);
        }
        else
        {
            if(planTimer)
            {
                planTimer.removeEventListener(TimerEvent.TIMER, updateProgressHandler);
                planTimer.stop();
                planTimer = null;
            }
        }
        updateProgressEvent();
    }

    //----------------------------------
    //  soundChannel
    //----------------------------------
    private var _soundChannel:SoundChannel;

    public function get soundChannel():SoundChannel
    {
        return _soundChannel;
    }

    //----------------------------------
    //  volume
    //----------------------------------
    private var _volume:Number = 1;

    /**
     * The sound volume(0 - 1)
     * @return
     *
     */
    public function get volume():Number
    {
        return _volume;
    }

    public function set volume(value:Number):void
    {
        _volume = value;

        if(_soundChannel)
        {
            var transform:SoundTransform = _soundChannel.soundTransform;
            transform.volume = value;
            _soundChannel.soundTransform = transform;
        }
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * @in
     */
    override public function play(startTime:Number = 0.0, loops:int = 0.0, sndTransform:SoundTransform = null):SoundChannel
    {
        if(sndTransform == null && _soundChannel != null)
        {
            sndTransform = _soundChannel.soundTransform;
        }
        else if(sndTransform == null)
        {
            sndTransform = new SoundTransform(this.volume);
        }

        if(_soundChannel)
        {
            _soundChannel.stop();
            _soundChannel.removeEventListener(Event.SOUND_COMPLETE, playSoundCompleteHanlder);
            _soundChannel = null;
        }

        this.loops = loops;

        _soundChannel = super.play(startTime, loops, sndTransform);
        if(_soundChannel)
        {
            _soundChannel.addEventListener(Event.SOUND_COMPLETE, playSoundCompleteHanlder);
        }
        else
        {
            Tracer.warn("Can't find sound card!");
        }
        setPlaying(true);

        return _soundChannel;
    }

    /**
     * pause play.
     */
    public function pause():void
    {
        if(playing)
        {
            if(_soundChannel)
            {
                current_point = _soundChannel.position;
                _soundChannel.stop();
            }
            else
            {
                current_point = 0;
            }
            setPlaying(false);
        }
        else
        {
            _soundChannel = this.play(current_point, loops);
            _soundChannel.addEventListener(Event.SOUND_COMPLETE, playSoundCompleteHanlder);
            setPlaying(true);
        }
    }

    /**
     * stop play.
     */
    public function stop():void
    {
        if(_soundChannel == null)
        {
            return;
        }

        if(_soundChannel)
        {
            _soundChannel.stop();
        }
        setPlaying(false);
        current_point = 0;
    }

    /**
     * Estimates the time needed for the total execution.
     *
     * @return the estimated total time needed for the execution
     */
    public function getEstimatedTotalTime():uint
    {
        var result:Number = 0;
        if(bytesLoaded != bytesTotal)
        {
            result = Math.ceil(length / (bytesLoaded / bytesTotal));
        }
        else
        {
            result = length;
        }

        return result;
    }

    /**
     *
     *
     */
    private function updateProgressEvent():void
    {
        if(playProgressEnabled)
        {
            if(playing)
            {
                planTimer.start();
            }
            else
            {
                planTimer.stop();
            }
        }
    }

    /**
     * dispose the player.
     */
    public function dispose():void
    {
        if(planTimer)
        {
            planTimer.removeEventListener(TimerEvent.TIMER, updateProgressHandler);
            planTimer.stop();
            planTimer = null;
        }

        if(_soundChannel)
        {
            _soundChannel.stop();
            _soundChannel.removeEventListener(Event.SOUND_COMPLETE, playSoundCompleteHanlder);
            _soundChannel = null;
        }

        try
        {
            this.close();
        }
        catch(error:Error)
        {
        }
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function updateProgressHandler(event:TimerEvent):void
    {
        this.dispatchEvent(new PlayerEvent(PlayerEvent.PROGRESS_CHANGE));
    }

    private function playSoundCompleteHanlder(event:Event):void
    {
        if(this.bytesLoaded == this.bytesTotal)
        {
            if(loops > 0) loops--;
            this.dispatchEvent(event.clone());
        }
    }
}
}