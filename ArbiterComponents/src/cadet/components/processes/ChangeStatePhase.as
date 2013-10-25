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

            arbiter.willSwitchStateEvent.oldState = oldState;
            arbiter.willSwitchStateEvent.newState = newState;

            arbiter.dispatchEvent(arbiter.willSwitchStateEvent);

            arbiter.willSwitchStateEvent.oldState = null;
            arbiter.willSwitchStateEvent.newState = null;
        }

        if(arbiter.isStopped())
            return null;

        if(arbiter.isPaused())
            return this;

        arbiter.executeStatePhase.state = newState;

        if(oldState == arbiter.states.currentState && newState == arbiter.states.previousState) {
            arbiter.states.popState();
        }
        else if(oldState != newState) {
            arbiter.states.pushState(newState);
        }

        return arbiter.executeStatePhase;
    }

    override internal function deactivate():void {
        eventSent = false;
        oldState = newState = null;
    }
}
}
