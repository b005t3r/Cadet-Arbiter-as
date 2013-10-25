/**
 * User: booster
 * Date: 25/10/13
 * Time: 9:55
 */

package cadet.components.errors {

public class ArbiterIllegalPauseError extends Error {
    public function ArbiterIllegalPauseError(message:* = "arbiter can only be paused from an even handler", id:* = 0) {
        super(message, id);
    }
}
}
