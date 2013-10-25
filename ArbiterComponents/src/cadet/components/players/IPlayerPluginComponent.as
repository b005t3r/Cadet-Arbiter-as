/**
 * User: booster
 * Date: 10/23/13
 * Time: 11:06
 */

package cadet.components.players {
import cadet.components.requests.Request;

public interface IPlayerPluginComponent extends IPlayerComponent {
    function get player():PluggablePlayerComponent

    function canHandleRequest(request:Request):Boolean

    function activate():void
    function deactivate():void
}
}
