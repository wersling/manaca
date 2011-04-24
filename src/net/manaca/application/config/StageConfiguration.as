package net.manaca.application.config
{
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;

import net.manaca.application.thread.AbstractProcess;
import net.manaca.errors.IllegalArgumentError;
import net.manaca.managers.StageManager;

/**
 * The StageConfiguration provide a initialize stage operation.
 * <ul>
 *     <li>
 *         Initialize the <code>StageManager</code>
 *     </li>
 *     <li>
 *         Set StageAlign  = StageAlign.TOP_LEFT
 *     </li>
 *     <li>
 *         Set scaleMode  = StageScaleMode.NO_SCALE
 *     </li>
 * </ul>
 * @author v-seanzo
 * @see net.manaca.managers.StageManager
 * @see flash.display.StageAlign
 * @see flash.display.StageScaleMode
 */
public class StageConfiguration extends AbstractProcess
{
    //==========================================================================
    //  Variables
    //==========================================================================
    private var stage:Stage;

    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>StageConfiguration</code> instance.
     * @param stage
     *
     */
    public function StageConfiguration(stage:Stage)
    {
        super();

        if(stage != null)
        {
            this.stage = stage;
        }
        else
        {
            throw new IllegalArgumentError("invalid stage argument:" + stage);
        }
    }

    //==========================================================================
    //  Methods
    //==========================================================================
    /**
     * Start initialize stage.
     * <ul>
     *     <li>
     *         Initialize the <code>StageManager</code>
     *     </li>
     *     <li>
     *         Set StageAlign  = StageAlign.TOP_LEFT
     *     </li>
     *     <li>
     *         Set scaleMode  = StageScaleMode.NO_SCALE
     *     </li>
     * </ul>
     */
    override protected function run():void
    {
        StageManager.initialize(stage);
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.quality = StageQuality.HIGH;
        this.finish();
    }
}
}