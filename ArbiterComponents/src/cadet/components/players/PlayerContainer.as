/**
 * User: booster
 * Date: 10/21/13
 * Time: 10:08
 */

package cadet.components.players {

import cadet.core.ComponentContainer;
import cadet.core.IComponent;

/** Holds (as its child components) player collection to be used by an arbiter. */
public class PlayerContainer extends ComponentContainer {
    public function PlayerContainer(name:String = "Players") {
        super(name);
    }

    public function registerPlayer(player:IPlayerComponent):void {
        children.addItem(player);
    }

    public function unregisterPlayer(player:IPlayerComponent):void {
        children.removeItem(player);
    }

    public function get playerCount():int {
        return children.length;
    }

    public function getPlayer(index:int):IPlayerComponent {
        return children.getItemAt(index);
    }

    override protected function childAdded(child:IComponent, index:uint):void {
        if(child is IPlayerComponent == false)
            throw new TypeError("PlayerContainer can only hold IPlayerComponents");

        super.childAdded(child, index);
    }
}
}
