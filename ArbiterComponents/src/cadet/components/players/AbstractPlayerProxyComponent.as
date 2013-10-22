/**
 * User: booster
 * Date: 10/22/13
 * Time: 15:30
 */

package cadet.components.players {
import cadet.components.processes.IArbiterProcess;
import cadet.components.requests.Request;
import cadet.core.ComponentContainer;
import cadet.core.IComponent;

public class AbstractPlayerProxyComponent extends ComponentContainer implements IPlayerProxyComponent {
    public function AbstractPlayerProxyComponent(name:String = "Player Proxy") {
        super(name);
    }

    public function get player():IPlayerComponent {
        if(children.length == 0)
            return null;

        return children[0];
    }

    public function get arbiter():IArbiterProcess { return player.arbiter; }
    public function set arbiter(value:IArbiterProcess):void { player.arbiter = value; }

    public function get request():Request { return player.request; }
    public function set request(value:Request):void { player.request = value; }

    public function processRequest():* {
        return null;
    }

    override protected function childAdded(child:IComponent, index:uint):void {
        if(children.length > 0)
            throw new Error("each proxy can only have one child component");

        if(child is IPlayerComponent == false)
            throw new TypeError("child has to be a IPlayerComponent");

        super.childAdded(child, index);
    }
}
}
