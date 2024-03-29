/**
 * User: booster
 * Date: 10/21/13
 * Time: 14:35
 */

package cadet.components.requests {
import cadet.components.players.IPlayerComponent;
import cadet.components.processes.IArbiterProcess;

public class Request {
    private var _arbiter:IArbiterProcess    = null;
    private var _player:IPlayerComponent    = null;

    /** Arbiter which sent this request. */
    [Transient]
    public function get arbiter():IArbiterProcess { return _arbiter; }
    public function set arbiter(value:IArbiterProcess):void { _arbiter = value; }

    /** Player which is currently processing this request. */
    [Transient]
    public function get player():IPlayerComponent { return _player; }
    public function set player(value:IPlayerComponent):void { _player = value; }
}
}
