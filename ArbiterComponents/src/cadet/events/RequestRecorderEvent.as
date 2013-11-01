/**
 * User: booster
 * Date: 26/10/13
 * Time: 11:59
 */
package cadet.events {

import cadet.components.requests.RequestRecorderComponent;

import flash.events.Event;

public class RequestRecorderEvent extends Event {
    public static const REQUEST_RECORDED:String = "requestRecordedEvent";

    private var _recorder:RequestRecorderComponent;

    public function RequestRecorderEvent(type:String, recorder:RequestRecorderComponent) {
        super(type, false, false);

        _recorder = recorder;
    }

    public function get recorder():RequestRecorderComponent { return _recorder; }

    override public function clone():Event { return new RequestRecorderEvent(type, recorder); }
}
}
