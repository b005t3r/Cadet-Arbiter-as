/**
 * User: booster
 * Date: 01/11/13
 * Time: 11:01
 */

package cadet.events.arbiter {
import cadet.components.processes.IArbiterProcess;

import flash.events.Event;

/** Base class for all event classes that arbiter dispatches. */
public class ArbiterEvent extends Event {
    private var _arbiter:IArbiterProcess;

    public function ArbiterEvent(type:String, arbiter:IArbiterProcess) {
        super(type, bubbles, cancelable);

        _arbiter = arbiter;
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }
}
}
