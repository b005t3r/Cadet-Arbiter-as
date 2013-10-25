/**
 * User: booster
 * Date: 10/21/13
 * Time: 9:57
 */

package cadet.components.processes {
import cadet.components.players.IPlayerComponent;
import cadet.components.players.PlayerContainer;
import cadet.components.requests.Request;
import cadet.components.states.StateComponent;
import cadet.components.states.StateContainer;
import cadet.core.IComponent;

/**
 * Arbiter is responsible for executing game logic parts, called states, and handling the communication
 * between states and players.
 * Some arbiters can be paused (asynchronous) while others has to execute synchronously until there's no more states
 * to execute or they have been stopped.
 */
public interface IArbiterProcess extends IComponent {
    /** Players this arbiter send requests to. */
    function get players():PlayerContainer
    function set players(value:PlayerContainer):void

    /** Stack of states this arbiter executes, top of the stack being the currently executed state. */
    function get states():StateContainer
    function set states(value:StateContainer):void

    /**
     * Starts execution of the current state.
     * For synchronous arbiters this method returns after the processing has been finished. For asynchronous arbiters
     * it returns immediately.
     */
    function beginExecution():void

    /** States call this method while finishing their execution to be executed again. */
    function executeCurrentStateResult():*

    /** States call this method while finishing their execution to be popped off the stack and its 'parent state' to be called. */
    function executePreviousStateResult():*

    /** States call this method while finishing their execution to push a new state onto the stack and start its execution. */
    function executeStateResult(state:StateComponent):*

    /** States call this method while finishing their execution to send a request to the given player. */
    function sendRequestResult(request:Request, player:IPlayerComponent):*

    /** Players call this method while finishing processing request to signalize it's been processed. */
    function requestResponse(request:Request):*

    /** Players call this method while finishing processing request to stop arbiter's execution. */
    function stopExecutionResponse():*

    /**
     * Players call this method while finishing processing request to pause arbiter's execution
     * If current arbiter is not asynchronous, it will throw SynchronousArbiterError when receiving this response.
     */
    function pauseExecutionResponse():*

    /** Returns true if this arbiter is no longer running. */
    function isStopped():Boolean

    /** Stops execution of this arbiter. Can only be called from an even handler. */
    function stopExecution():void

    /** Returns true if this arbiter is paused. */
    function isPaused():Boolean

    /** Pauses an asynchronous arbiter's execution. Can only be called from an even handler. */
    function pauseExecution():void

    /**
     * Resumes execution of an asynchronous arbiter, which will cause current player's processRequest() method to be called again.
     * Cannot be called from an even handler.
     */
    function resumeExecution():void
}
}
