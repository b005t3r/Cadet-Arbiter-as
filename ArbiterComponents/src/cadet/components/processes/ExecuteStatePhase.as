/**
 * User: booster
 * Date: 24/10/13
 * Time: 13:28
 */

package cadet.components.processes {
import cadet.components.requests.Request;
import cadet.components.states.StateComponent;

public class ExecuteStatePhase extends ExecutionPhase {
    internal var state:StateComponent = null;

    override internal function run(arbiter:BasicArbiterProcess):ExecutionPhase {
        var response:* = executeState();

        return processResponse(response, arbiter);
    }

    override internal function deactivate():void {
        state = null;
    }

    protected function executeState():* {
        var response:* = state.execute();

        return response;
    }

    protected function processResponse(response:*, arbiter:BasicArbiterProcess):ExecutionPhase {
        if(response == arbiter.stopExecutionResponse()) {
            arbiter.internalStop();

            return null;
        }
        else if(response == arbiter.pauseExecutionResponse()) {
            arbiter.internalPause();

            return this;
        }
        else if(response == arbiter.executeCurrentStateResult()) {
            arbiter.changeStatePhase.oldState = state;
            arbiter.changeStatePhase.newState = state;

            return arbiter.changeStatePhase;
        }
        else if(response == arbiter.executePreviousStateResult()) {
            arbiter.changeStatePhase.oldState = state;
            arbiter.changeStatePhase.newState = arbiter.states.previousState;

            return arbiter.changeStatePhase;
        }
        else if(response is StateComponent) {
            arbiter.changeStatePhase.oldState = state;
            arbiter.changeStatePhase.newState = response as StateComponent;

            return arbiter.changeStatePhase;
        }
        else if(response is Request) {
            arbiter.sendRequestPhase.request = response as Request;

            return arbiter.sendRequestPhase;
        }
        else {
            throw new Error("invalid response: " + response);
        }
    }
}
}
