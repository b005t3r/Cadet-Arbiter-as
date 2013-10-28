/**
 * User: booster
 * Date: 24/10/13
 * Time: 12:26
 */

package cadet.events {
import cadet.components.processes.IArbiterProcess;
import cadet.components.states.IStateComponent;

import flash.events.Event;

public class StateEvent extends Event {
    public static var WILL_SWITCH_STATE:String = "WillSwitchStateEvent";

    private var _arbiter:IArbiterProcess     = null;
    private var _oldState:IStateComponent     = null;
    private var _newState:IStateComponent     = null;

    public function StateEvent(type:String, arbiter:IArbiterProcess) {
        super(type, false, false);

        _arbiter = arbiter;
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }

    public function get oldState():IStateComponent { return _oldState; }
    public function set oldState(value:IStateComponent):void { _oldState = value; }

    public function get newState():IStateComponent { return _newState; }
    public function set newState(value:IStateComponent):void { _newState = value; }
}
}
