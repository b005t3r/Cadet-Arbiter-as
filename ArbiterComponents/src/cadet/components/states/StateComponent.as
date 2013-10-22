/**
 * User: booster
 * Date: 10/21/13
 * Time: 10:18
 */

package cadet.components.states {
import cadet.components.processes.IArbiterProcess;
import cadet.components.requests.Request;
import cadet.core.Component;

/**
 * States are modular parts of game logic. Every one should do its, possible small, part and when done pass the
 * execution to another state. I.e. in a turn based game you'd have a GameState which handles initialization/cleanup
 * between turns and when done creates a TurnState instance and sets it as a current state by calling
 * IArbiterProcess' executeStateResult() method and passing a new TurnState instance. TurnState, when a turn is over,
 * should call IArbiterProcess' executePreviousStateResult() to roll back to GameState and let it do its part, before
 * a new turn starts.
 */
public class StateComponent extends Component {
    private var _arbiter:IArbiterProcess    = null;
    private var _request:Request            = null;

    public function StateComponent(name:String = "State") {
        super(name);
    }

    /** State handles its logic part in this method. */
    public function execute():* {
        throw new Error("this method has to be implemented by a subclass");
    }

    /** State handles response to a previously send request in this method. */
    public function executeWithResponse():* {
        throw new Error("this method has to be implemented by a subclass");
    }

    /** Arbiter which is currently executing this state. Available in execute() and executeWithResponse() methods, null otherwise. */
    public function get arbiter():IArbiterProcess { return _arbiter; }
    public function set arbiter(value:IArbiterProcess):void { _arbiter = value; }

    /** Request to which player has responded. Available in executeWithResponse() method, null otherwise. */
    public function get request():Request { return _request; }
    public function set request(value:Request):void { _request = value; }
}
}
