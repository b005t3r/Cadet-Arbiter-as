/**
 * User: booster
 * Date: 24/10/13
 * Time: 14:59
 */

package cadet.components.processes {
import cadet.components.requests.Request;

public class ExecuteStateWithResponsePhase extends ExecuteStatePhase {
    internal var response:Request = null;

    override internal function deactivate():void {
        response = null;

        super.deactivate();
    }

    override protected function executeState(arbiter:BasicArbiterProcess):* {
        state.arbiter = arbiter;
        state.request = response;

        var result:* = state.executeWithResponse();

        arbiter.didExecuteStateWithResponseEvent.currentState = state;
        arbiter.dispatchEvent(arbiter.didExecuteStateWithResponseEvent);
        arbiter.didExecuteStateWithResponseEvent.currentState = null;

        state.arbiter = null;
        state.request = null;

        return result;
    }
}
}
