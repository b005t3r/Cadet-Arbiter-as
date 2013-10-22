/**
 * User: booster
 * Date: 10/21/13
 * Time: 14:29
 */

package cadet.components.players {
import cadet.components.processes.IArbiterProcess;
import cadet.components.requests.Request;
import cadet.core.IComponent;

/**
 * Players are responsible for making decisions, called requests, currently executed state needs them to make.
 * In a scenario where you'd need to roll 2 dice and then pick one you like, state would roll the dice,
 * send a request to make a player choose one and then continue its execution based on player's choice.
 */
public interface IPlayerComponent extends IComponent {
    /** Arbiter which sent currently processed request. */
    function get arbiter():IArbiterProcess;
    function set arbiter(value:IArbiterProcess):void;

    /** Currently processed request. */
    function get request():Request;
    function set request(value:Request):void;

    /** Called whenever there's a request to being processed waiting. */
    function processRequest():*;
}
}
