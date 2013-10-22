/**
 * User: booster
 * Date: 10/22/13
 * Time: 13:12
 */

package cadet.components.processes {
import cadet.components.errors.SynchronousArbiterError;
import cadet.components.players.IPlayerComponent;
import cadet.components.players.PlayerContainer;
import cadet.components.requests.Request;
import cadet.components.states.StateComponent;
import cadet.components.states.StateContainer;
import cadet.core.Component;

import flash.utils.getDefinitionByName;

import flash.utils.getQualifiedClassName;

public class BasicArbiterProcess extends Component implements IArbiterProcess {
    protected static var EXECUTE_CURRENT_STATE_RESULT:String    = "executeCurrentState";
    protected static var EXECUTE_PREVIOUS_STATE_RESULT:String   = "executePreviousState";
    protected static var STOP_EXECUTION_RESPONSE:String         = "stopExecutionResponse";

    protected var _currentRequest:Request                       = null;
    protected var _currentRequestPlayer:IPlayerComponent        = null;
    protected var _currentResult:*                              = null;

    protected var _executing:Boolean        = false;

    protected var _players:PlayerContainer  = null;
    protected var _states:StateContainer    = null;

    public function BasicArbiterProcess(name:String = "Basic Arbiter") {
        super(name);
    }

    public function set players(value:PlayerContainer):void { _players = value; }
    public function get players():PlayerContainer { return _players; }

    public function set states(value:StateContainer):void { _states = value; }
    public function get states():StateContainer { return _states; }

    public function beginExecution():void {
        _executing = true;

        runExecutionLoop();
    }

    public function executeCurrentStateResult():* { return EXECUTE_CURRENT_STATE_RESULT; }
    public function executePreviousStateResult():* { return EXECUTE_PREVIOUS_STATE_RESULT; }
    public function executeStateResult(state:StateComponent):* { return state; }

    public function sendRequestResult(request:Request, player:IPlayerComponent):* {
        request.player = player;

        return request;
    }

    public function requestResponse(request:Request):* {
        if(request is Class(getDefinitionByName(getQualifiedClassName(_currentRequest))) == false)
            throw new TypeError("request: " + request + " has to be related to the currently processed request: " + _currentRequest);

        return request;
    }

    public function stopExecutionResponse():* { return STOP_EXECUTION_RESPONSE; }
    public function pauseExecutionResponse():* { throw new SynchronousArbiterError(); }
    public function isExecutionPaused():Boolean { return false; }
    public function resumeExecution():void { throw new SynchronousArbiterError(); }

    protected function runExecutionLoop():void {

    }
}
}
