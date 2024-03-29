/**
 * User: booster
 * Date: 10/22/13
 * Time: 13:12
 */

package cadet.components.processes {
import cadet.components.players.IPlayerComponent;
import cadet.components.players.PlayerContainer;
import cadet.components.requests.Request;
import cadet.components.states.IStateComponent;
import cadet.components.states.StateContainer;
import cadet.core.Component;
import cadet.errors.ArbiterIllegalStopError;
import cadet.errors.SynchronousArbiterError;
import cadet.events.arbiter.PlayerEvent;
import cadet.events.arbiter.StateEvent;

import flash.events.Event;

public class BasicArbiterProcess extends Component implements IArbiterProcess {
    protected static var STOP_EXECUTION_RESULT:String                           = "stopExecutionResult";
    protected static var EXECUTE_CURRENT_STATE_RESULT:String                    = "executeCurrentState";
    protected static var EXECUTE_PREVIOUS_STATE_RESULT:String                   = "executePreviousState";
    protected static var STOP_EXECUTION_RESPONSE:String                         = "stopExecutionResponse";
    protected static var PAUSE_EXECUTION_RESPONSE:String                        = "pauseExecutionResponse";

    protected var _players:PlayerContainer                                      = null;
    protected var _states:StateContainer                                        = null;

    protected var _dispatchingEvents:Boolean                                    = false;

    internal var _running:Boolean                                               = false;

    internal var willSwitchStateEvent:StateEvent                                = null;
    internal var didExecuteStateEvent:StateEvent                                = null;
    internal var didExecuteStateWithResponseEvent:StateEvent                    = null;
    internal var willSendRequestEvent:PlayerEvent                              = null;
    internal var didSendRequestEvent:PlayerEvent                               = null;

    internal var executeStatePhase:ExecuteStatePhase                            = new ExecuteStatePhase();
    internal var executeStateWithResponsePhase:ExecuteStateWithResponsePhase    = new ExecuteStateWithResponsePhase();
    internal var changeStatePhase:ChangeStatePhase                              = new ChangeStatePhase();
    internal var sendRequestPhase:SendRequestPhase                              = new SendRequestPhase();

    protected var _activePhase:ExecutionPhase   = null;

    public function BasicArbiterProcess(name:String = "Basic Arbiter") {
        super(name);

        willSwitchStateEvent                = new StateEvent(StateEvent.WILL_SWITCH_STATE, this);
        didExecuteStateEvent                = new StateEvent(StateEvent.DID_EXECUTE_STATE, this);
        didExecuteStateWithResponseEvent    = new StateEvent(StateEvent.DID_EXECUTE_STATE_WITH_RESPONSE, this);
        willSendRequestEvent                = new PlayerEvent(PlayerEvent.WILL_PROCESS_REQUEST, this);
        didSendRequestEvent                 = new PlayerEvent(PlayerEvent.DID_PROCESS_REQUEST, this);
    }

    public function set players(value:PlayerContainer):void { _players = value; }
    public function get players():PlayerContainer { return _players; }

    public function set states(value:StateContainer):void { _states = value; }
    public function get states():StateContainer { return _states; }

    public function beginExecution():void {
        _running = true;

        executeStatePhase.state = states.currentState;

        runExecutionLoop(executeStatePhase);
    }

    public function stopExecutionResult():* { return STOP_EXECUTION_RESULT; }
    public function executeCurrentStateResult():* { return EXECUTE_CURRENT_STATE_RESULT; }
    public function executePreviousStateResult():* { return EXECUTE_PREVIOUS_STATE_RESULT; }
    public function executeStateResult(state:IStateComponent):* { return state; }

    public function sendRequestResult(request:Request, player:IPlayerComponent):* {
        request.player = player;

        return request;
    }

    public function requestProcessedResponse(request:Request):* { return request; }

    public function stopExecutionResponse():* { return STOP_EXECUTION_RESPONSE; }
    public function pauseExecutionResponse():* { return PAUSE_EXECUTION_RESPONSE; }

    public function isStopped():Boolean { return ! _running; }
    public function stopExecution():void {
        if(! _dispatchingEvents)
            throw new ArbiterIllegalStopError();

        _running = false;
    }

    public function isPaused():Boolean { return false; }
    public function pauseExecution():void { throw new SynchronousArbiterError(); }
    public function resumeExecution():void { throw new SynchronousArbiterError(); }

    [cppcall]
    override public function dispatchEvent(event:Event):Boolean {
        _dispatchingEvents = true;

        var retVal:Boolean = super.dispatchEvent(event);

        _dispatchingEvents = false;

        return retVal;
    }

    internal function internalStop():void { _running = false; }
    internal function internalPause():void { throw new SynchronousArbiterError(); }

    protected function runExecutionLoop(phase:ExecutionPhase):void {
        if(phase != _activePhase) {
            _activePhase = phase;

            _activePhase.activate();
        }

        while(shouldExecuteNextPhase()) {
            var nextPhase:ExecutionPhase = _activePhase.run(this);

            if(nextPhase != _activePhase) {
                _activePhase.deactivate();

                _activePhase = nextPhase;

                if(_activePhase != null)
                    _activePhase.activate();
            }
        }
    }

    protected function shouldExecuteNextPhase():Boolean {
        return _running && _activePhase != null;
    }
}
}
