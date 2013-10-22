/**
 * User: booster
 * Date: 10/22/13
 * Time: 15:17
 */

package cadet.components.players {
import cadet.components.processes.IArbiterProcess;
import cadet.components.requests.Request;
import cadet.core.ComponentContainer;

public class AbstractPlayerComponent extends ComponentContainer implements IPlayerComponent {
    protected var _arbiter:IArbiterProcess  = null;
    protected var _request:Request          = null;

    public function AbstractPlayerComponent(name:String = "Player") {
        super(name);
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }
    public function set arbiter(value:IArbiterProcess):void { _arbiter = value; }

    public function get request():Request { return _request; }
    public function set request(value:Request):void { _request = value; }

    public function processRequest():* {
        throw new Error("this method has to be implemented by a subclass");
    }
}
}
