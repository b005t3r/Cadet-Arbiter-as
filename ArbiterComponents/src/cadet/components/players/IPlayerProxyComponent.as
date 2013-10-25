/**
 * User: booster
 * Date: 10/21/13
 * Time: 14:30
 */

package cadet.components.players {
import cadet.core.IComponentContainer;

public interface IPlayerProxyComponent extends IPlayerComponent, IComponentContainer {
    /** Player this proxy covers. Implementation should make sure this is always the first child component of this proxy. */
    function get player():IPlayerComponent;

    /** Returns the last player in this proxy chain which does not implement IPlayerProxyComponent interface. */
    function get nonProxyPlayer():IPlayerComponent;
}
}
