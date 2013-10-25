/**
 * User: booster
 * Date: 24/10/13
 * Time: 14:59
 */

package cadet.components.processes {
import cadet.components.players.IPlayerComponent;
import cadet.components.requests.Request;

public class SendRequestPhase extends ExecutionPhase {
    internal var request:Request = null;

    private var response:* = null;

    private var willEventSent:Boolean       = false;
    private var didEventSent:Boolean        = false;

    override internal function run(arbiter:BasicArbiterProcess):ExecutionPhase {
        if(! willEventSent) {
            willEventSent = true;

            arbiter.willSendRequestEvent.request = request;
            arbiter.dispatchEvent(arbiter.willSendRequestEvent);
            arbiter.willSendRequestEvent.request = null;
        }

        if(arbiter.isStopped())
            return null;

        if(arbiter.isPaused())
            return this;

        if(response == null) {
            var player:IPlayerComponent = request.player;

            player.arbiter = arbiter;
            player.request = request;

            response = player.processRequest();

            if(response == arbiter.stopExecutionResponse()) {
                arbiter.internalStop();

                return null;
            }
            else if(response == arbiter.pauseExecutionResponse()) {
                arbiter.internalPause();

                response = null; // not a 'real' response, call processRequest() again on next run() call
                return this;
            }
            else if(response is Request == false) {
                throw new Error("invalid response: " + response);
            }

            player.arbiter = null;
            player.request = null;
        }

        if(! didEventSent) {
            didEventSent = true;

            arbiter.didSendRequestEvent.request = response as Request;
            arbiter.didSendRequestEvent.player = request.player;
            arbiter.dispatchEvent(arbiter.didSendRequestEvent);
            arbiter.didSendRequestEvent.request = null;
            arbiter.didSendRequestEvent.player = null;
        }

        if(arbiter.isStopped())
            return null;

        if(arbiter.isPaused())
            return this;

        arbiter.executeStateWithResponsePhase.state     = arbiter.states.currentState;
        arbiter.executeStateWithResponsePhase.response  = response as Request;

        return arbiter.executeStateWithResponsePhase;
    }

    override internal function deactivate():void {
        response = request = null;
        willEventSent = didEventSent = false;
    }
}
}
