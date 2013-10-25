/**
 * User: booster
 * Date: 25/10/13
 * Time: 10:31
 */
package cadet.components.states {
import cadet.components.processes.IArbiterProcess;
import cadet.components.requests.Request;
import cadet.core.IComponent;

public interface IStateComponent extends IComponent {
    /** State handles its logic part in this method. */
    function execute():*;

    /** State handles response to a previously send request in this method. */
    function executeWithResponse():*;

    /** Arbiter which is currently executing this state. Available in execute() and executeWithResponse() methods, null otherwise. */
    function get arbiter():IArbiterProcess;
    function set arbiter(value:IArbiterProcess):void;

    /** Request to which player has responded. Available in executeWithResponse() method, null otherwise. */
    function get request():Request;
    function set request(value:Request):void;
}
}
