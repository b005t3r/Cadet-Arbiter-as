/**
 * User: booster
 * Date: 25/10/13
 * Time: 12:51
 */

package cadet.components.requests {
import cadet.components.processes.IArbiterProcess;
import cadet.core.Component;
import cadet.events.RequestEvent;
import cadet.events.RequestRecorderEvent;

import com.adobe.serialization.json.JSON;

public class RequestRecorderComponent extends Component {
    protected var _requestRecordedEvent:RequestRecorderEvent;

    protected var _arbiter:IArbiterProcess  = null;
    protected var _requests:Object          = {};
    protected var _requestIndex:int         = 0;

    public function RequestRecorderComponent(name:String = "Request Recorder") {
        super(name);

        _requestRecordedEvent = new RequestRecorderEvent(RequestRecorderEvent.REQUEST_RECORDED, this);
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }
    public function set arbiter(value:IArbiterProcess):void {
        if(_arbiter != null)
            _arbiter.removeEventListener(RequestEvent.DID_PROCESS_REQUEST, onRequestProcessed);

        _arbiter = value;

        if(_arbiter != null)
            _arbiter.addEventListener(RequestEvent.DID_PROCESS_REQUEST, onRequestProcessed);
    }

    public function encodeRecordedRequests():String {
        return com.adobe.serialization.json.JSON.encode(_requests);
    }

    protected function onRequestProcessed(event:RequestEvent):void {
        var wrapper:Object  = {
            "index"     : _requestIndex,
            "request"   : event.request
        };

        var playerRequests:Array = _requests[event.player.name];

        if(playerRequests == null) {
            playerRequests = [];
            _requests[event.player.name] = playerRequests;
        }

        playerRequests.push(wrapper);

        _requestIndex++;

        dispatchEvent(_requestRecordedEvent);
    }
}
}
