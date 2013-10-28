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
        for each (var plugin:IPlayerPluginComponent in children) {
            if(! plugin.canHandleRequest(request))
                continue;

            // deactivate previously used plugin and activate the new one, if different from the previous one
            if(activePlugin == null) {
                activePlugin = plugin;
                activePlugin.activate();
            }
            else if(activePlugin != plugin) {
                activePlugin.deactivate();
                activePlugin = plugin;
                activePlugin.activate();
            }

            var response:* = activePlugin.processRequest();

            // don't deactivate current plugin, if just pausing
            if(response == arbiter.pauseExecutionResponse())
                return response;

            activePlugin.deactivate();
            activePlugin = null;

            return response;
        }
    }

    override protected function childAdded(child:IComponent, index:uint):void {
        if(child is IPlayerPluginComponent == false)
            throw new TypeError("PluggablePlayerComponent can only hold IPlayerPluginComponents");

        super.childAdded(child, index);
    }
}
}
