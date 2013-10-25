/**
 * User: booster
 * Date: 24/10/13
 * Time: 12:26
 */

package cadet.components.events {
import cadet.components.processes.IArbiterProcess;
import cadet.components.states.StateComponent;

import flash.events.Event;

public class StateEvent extends Event {
    public static var WILL_SWITCH_STATE:String = "WillSwitchStateEvent";

    private var _arbiter:IArbiterProcess     = null;
    private var _oldState:StateComponent     = null;
    private var _newState:StateComponent     = null;

    public function StateEvent(type:String, arbiter:IArbiterProcess) {
        super(type, false, false);

        _arbiter = arbiter;
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }

    public function get oldState():StateComponent { return _oldState; }
    public function set oldState(value:StateComponent):void { _oldState = value; }

    public function get newState():StateComponent { return _newState; }
    public function set newState(value:StateComponent):void { _newState = value; }
}
}
