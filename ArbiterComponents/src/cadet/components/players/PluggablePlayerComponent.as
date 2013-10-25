/**
 * User: booster
 * Date: 10/23/13
 * Time: 11:07
 */

package cadet.components.players {
import cadet.core.IComponent;

public class PluggablePlayerComponent extends AbstractPlayerComponent {
    protected var activePlugin:IPlayerPluginComponent = null;

    public function PluggablePlayerComponent(name:String = "Pluggable Player") {
        super(name);
    }

    public function registerPlugin(plugin:IPlayerPluginComponent):void {
        children.addItem(plugin);
    }

    public function unregisterPlugin(plugin:IPlayerPluginComponent):void {
        children.removeItem(plugin);
    }

    override public function processRequest():* {

    }

    override protected function childAdded(child:IComponent, index:uint):void {
        if(child is IPlayerPluginComponent == false)
            throw new TypeError("PluggablePlayerComponent can only hold IPlayerPluginComponents");

        super.childAdded(child, index);
    }
}
}
