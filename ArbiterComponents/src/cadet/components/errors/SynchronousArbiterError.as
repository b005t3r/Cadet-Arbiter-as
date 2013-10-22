/**
 * User: booster
 * Date: 10/22/13
 * Time: 9:30
 */

package cadet.components.errors {

/** Thrown when trying to pause a synchronous IArbiterProcess instance. */
public class SynchronousArbiterError extends Error {
    public function SynchronousArbiterError(message:* = "This is a synchronous arbiter instance - it cannot be paused", id:* = 0) {
        super(message, id);
    }
}
}
