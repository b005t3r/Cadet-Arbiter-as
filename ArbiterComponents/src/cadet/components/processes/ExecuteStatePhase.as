/**
 * User: booster
 * Date: 24/10/13
 * Time: 13:28
 */

package cadet.components.processes {
import cadet.components.requests.Request;
import cadet.components.states.IStateComponent;

public class ExecuteStatePhase extends ExecutionPhase {
    internal var state:IStateComponent  = null;
    private var result:*                = null;

    override internal function run(arbiter:BasicArbiterProcess):ExecutionPhase {
        if(result == null)
            result = executeState(arbiter);

        return processResponse(result, arbiter);
    }

    override internal function deactivate():void {
        state = result = null;
    }

    protected function executeState(arbiter:BasicArbiterProcess):* {
        state.arbiter = arbiter;

        var response:* = state.execute();

        arbiter.didExecuteStateEvent.currentState = state;
        arbiter.dispatchEvent(arbiter.didExecuteStateEvent);
        arbiter.didExecuteStateEvent.currentState = null;

        state.arbiter = null;

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
        else if(response is IStateComponent) {
            arbiter.changeStatePhase.oldState = state;
            arbiter.changeStatePhase.newState = response as IStateComponent;

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
