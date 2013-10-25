/**
 * User: booster
 * Date: 24/10/13
 * Time: 9:25
 */

package cadet.components.requests {
import com.adobe.serialization.json.JSON;

public class RequestCoder {
    public function encode(request:Request):String {
        var jsonString:String = com.adobe.serialization.json.JSON.encode(request);

        return jsonString;
    }

    public function decode(jsonString:String):Request {
        var obj:Object = com.adobe.serialization.json.JSON.decode(jsonString);

        return null;
    }
}
}
