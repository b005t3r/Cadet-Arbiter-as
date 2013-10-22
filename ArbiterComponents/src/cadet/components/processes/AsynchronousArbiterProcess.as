/**
 * User: booster
 * Date: 10/22/13
 * Time: 14:48
 */

package cadet.components.processes {

public class AsynchronousArbiterProcess extends BasicArbiterProcess {
    protected static var PAUSE_EXECUTION_RESPONSE:String = "pauseExecutionResponse";

    public function AsynchronousArbiterProcess(name:String = "Asynchronous Arbiter") {
        super(name);
    }
}
}
