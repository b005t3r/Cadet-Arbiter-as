/**
 * User: booster
 * Date: 24/10/13
 * Time: 12:26
 */

package cadet.events.arbiter {
import cadet.components.processes.IArbiterProcess;
import cadet.components.states.IStateComponent;

import flash.events.Event;

public class StateEvent extends ArbiterEvent {
    public static var WILL_SWITCH_STATE:String                  = "WillSwitchStateEvent";
    public static var DID_EXECUTE_STATE:String                  = "DidExecuteStateEvent";
    public static var DID_EXECUTE_STATE_WITH_RESPONSE:String    = "DidExecuteStateWithResponseEvent";

    private var _currentState:IStateComponent     = null;
    private var _newState:IStateComponent     = null;

    public function StateEvent(type:String, arbiter:IArbiterProcess) {
        super(type, arbiter);
    }

    public function get currentState():IStateComponent { return _currentState; }
    public function set currentState(value:IStateComponent):void { _currentState = value; }

    public function get newState():IStateComponent { return _newState; }
    public function set newState(value:IStateComponent):void { _newState = value; }

    override public function clone():Event {
        var e:StateEvent    = new StateEvent(type, arbiter);
        e.currentState      = currentState;
        e.newState          = newState;

        return e;
    }
}
}
