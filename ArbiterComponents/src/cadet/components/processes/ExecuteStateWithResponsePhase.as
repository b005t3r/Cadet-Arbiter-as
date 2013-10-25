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

    override protected function executeState():* {
        state.request = response;

        return state.executeWithResponse();
    }

    override protected function processResponse(response:*, arbiter:BasicArbiterProcess):ExecutionPhase {
        state.request = null;

        return super.processResponse(response, arbiter);
    }
}
}
