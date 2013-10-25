/**
 * User: booster
 * Date: 10/21/13
 * Time: 10:13
 */

package cadet.components.states {
import cadet.core.ComponentContainer;
import cadet.core.IComponent;

/** Holds (as its child components) state collection to be used by an arbiter. */
public class StateContainer extends ComponentContainer {
    public function StateContainer(name:String = "States") {
        super(name);
    }

    public function pushState(state:IStateComponent):void {
        children.addItem(state);
    }

    public function popState():IStateComponent {
        var state:IStateComponent = children[children.length - 1];
        children.removeItemAt(children.length - 1);

        return state;
    }

    public function get currentState():IStateComponent {
        if(children.length == 0)
            return null;

        return children[children.length - 1];
    }

    public function get previousState():IStateComponent {
        if(children.length <= 1)
            return null;

        return children[children.length - 2];
    }

    public function get stateCount():int {
        return children.length;
    }

    override protected function childAdded(child:IComponent, index:uint):void {
        if(child is IStateComponent == false)
            throw new TypeError("StateContainer can only hold StateComponents");

        super.childAdded(child, index);
    }
}
}
