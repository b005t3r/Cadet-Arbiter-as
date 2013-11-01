/**
 * User: booster
 * Date: 24/10/13
 * Time: 14:57
 */

package cadet.components.processes {
import cadet.components.states.IStateComponent;

public class ChangeStatePhase extends ExecutionPhase {
    internal var oldState:IStateComponent = null;
    internal var newState:IStateComponent = null;

    private var eventSent:Boolean = false;

    override internal function run(arbiter:BasicArbiterProcess):ExecutionPhase {
        if(! eventSent) {
            eventSent = true;

            arbiter.willSwitchStateEvent.currentState = oldState;
            arbiter.willSwitchStateEvent.newState = newState;

            arbiter.dispatchEvent(arbiter.willSwitchStateEvent);

            arbiter.willSwitchStateEvent.currentState = null;
            arbiter.willSwitchStateEvent.newState = null;
        }

        if(arbiter.isStopped())
            return null;

        if(arbiter.isPaused())
            return this;

        if(oldState == arbiter.states.currentState && newState == arbiter.states.previousState) {
            arbiter.states.popState();
        }
        else if(oldState != newState) {
            arbiter.states.pushState(newState);
        }

        if(newState != null) {
            arbiter.executeStatePhase.state = newState;

            return arbiter.executeStatePhase;
        }
        else {
            // this arbiter has finished its execution
            return null;
        }
    }

    override internal function deactivate():void {
        eventSent = false;
        oldState = newState = null;
    }
}
}
