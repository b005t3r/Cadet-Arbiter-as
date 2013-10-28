/**
 * User: booster
 * Date: 25/10/13
 * Time: 9:31
 */

package cadet.errors {

public class ArbiterIllegalStopError extends Error {
    public function ArbiterIllegalStopError(message:* = "arbiter can only be stopped from an even handler", id:* = 0) {
        super(message, id);
    }
}
}
