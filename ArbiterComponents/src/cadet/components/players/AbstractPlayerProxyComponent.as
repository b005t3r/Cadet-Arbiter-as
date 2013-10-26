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

    public function get nonProxyPlayer():IPlayerComponent {
        var proxy:IPlayerProxyComponent = this;

        while(proxy is IPlayerProxyComponent)
            proxy = proxy.player as IPlayerProxyComponent;

        return proxy;
    }

    [Inspectable(priority="0")]
    override public function set name(value:String):void { if(player != null) player.name = value; }
    override public function get name():String { return player != null ? player.name : null; }

    public function get arbiter():IArbiterProcess { return player != null ? player.arbiter : null; }
    public function set arbiter(value:IArbiterProcess):void { if(player != null) player.arbiter = value; }

    public function get request():Request { return player!= null ? player.request : null; }
    public function set request(value:Request):void { if(player != null) player.request = value; }

    public function processRequest():* {
        throw new Error("this method has to be implemented by a subclass");
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
