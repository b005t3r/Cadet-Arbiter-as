/**
 * User: booster
 * Date: 10/22/13
 * Time: 14:48
 */

package cadet.components.processes {
import cadet.core.ISteppableComponent;
import cadet.errors.ArbiterIllegalPauseError;
import cadet.errors.ArbiterIllegalResumeError;

public class AsynchronousArbiterProcess extends BasicArbiterProcess implements ISteppableComponent {
    protected var _paused:Boolean = false;

    public function AsynchronousArbiterProcess(name:String = "Asynchronous Arbiter") {
        super(name);
    }

    public function step(dt:Number):void {
        if(shouldExecuteNextPhase())
            runExecutionLoop(_activePhase);
    }

    override public function beginExecution():void {
        _running = true;
        _paused = false;

        executeStatePhase.state = states.currentState;
        _activePhase = executeStatePhase;

        // runExecutionLoop() will be called on next step() call
    }

    override public function isPaused():Boolean { return _paused; }

    override public function pauseExecution():void {
        if(! _dispatchingEvents)
            throw new ArbiterIllegalPauseError();

        _paused = true;
    }

    override public function resumeExecution():void {
        if(_dispatchingEvents)
            throw new ArbiterIllegalResumeError();

        _paused = false;
    }

    override internal function internalPause():void {
        _paused = true;
    }

    override protected function shouldExecuteNextPhase():Boolean {
        return ! _paused && super.shouldExecuteNextPhase();
    }
}
}
