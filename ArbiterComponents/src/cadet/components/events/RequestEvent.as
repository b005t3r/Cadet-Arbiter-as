/**
 * User: booster
 * Date: 24/10/13
 * Time: 15:34
 */

package cadet.components.events {
import cadet.components.processes.IArbiterProcess;
import cadet.components.requests.Request;

import flash.events.Event;

public class RequestEvent extends Event {
    public static var WILL_PROCESS_REQUEST:String   = "WillProcessRequestEvent";
    public static var DID_PROCESS_REQUEST:String    = "DidProcessRequestEvent";

    private var _arbiter:IArbiterProcess    = null;
    private var _request:Request            = null;

    public function RequestEvent(type:String, arbiter:IArbiterProcess) {
        super(type, false, false);

        _arbiter = arbiter;
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }

    public function get request():Request { return _request; }
    public function set request(value:Request):void { _request = value; }
}
}
