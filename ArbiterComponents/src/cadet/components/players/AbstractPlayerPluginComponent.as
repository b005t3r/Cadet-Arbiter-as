/**
 * User: booster
 * Date: 24/10/13
 * Time: 9:03
 */
package cadet.components.players {
import cadet.components.processes.IArbiterProcess;
import cadet.components.requests.Request;
import cadet.core.Component;

public class AbstractPlayerPluginComponent extends Component implements IPlayerPluginComponent {
    public function AbstractPlayerPluginComponent(name:String = "Component") {
        super(name);
    }

    // abstract methods

    public function canHandleRequest(request:Request):Boolean {
        throw new Error("this method has to be implemented by a subclass");
    }

    public function processRequest():* {
        throw new Error("this method has to be implemented by a subclass");
    }

    // implemented methods

    public function get player():PluggablePlayerComponent {
        if(parentComponent is PluggablePlayerComponent == false)
            return null;

        return parentComponent as PluggablePlayerComponent;
    }

    public function activate():void {}
    public function deactivate():void {}

    public function get arbiter():IArbiterProcess { return player.arbiter; }
    public function set arbiter(value:IArbiterProcess):void { player.arbiter = value; }

    public function get request():Request { return player.request; }
    public function set request(value:Request):void { player.request = value; }
}
}
