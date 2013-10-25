/**
 * User: booster
 * Date: 25/10/13
 * Time: 9:57
 */

package cadet.components.errors {

public class ArbiterIllegalResumeError extends Error {
    public function ArbiterIllegalResumeError(message:* = "arbiter can only be resumed outside of an even handler", id:* = 0) {
        super(message, id);
    }
}
}
