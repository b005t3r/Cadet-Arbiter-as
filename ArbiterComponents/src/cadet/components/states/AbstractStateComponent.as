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
public class AbstractStateComponent extends Component implements IStateComponent {
    private var _arbiter:IArbiterProcess    = null;
    private var _request:Request            = null;

    public function AbstractStateComponent(name:String = "State") {
        super(name);
    }

    public function execute():* {
        throw new Error("this method has to be implemented by a subclass");
    }

    public function executeWithResponse():* {
        throw new Error("this method has to be implemented by a subclass");
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }

    public function set arbiter(value:IArbiterProcess):void { _arbiter = value; }

    public function get request():Request { return _request; }

    public function set request(value:Request):void { _request = value; }
}
}
