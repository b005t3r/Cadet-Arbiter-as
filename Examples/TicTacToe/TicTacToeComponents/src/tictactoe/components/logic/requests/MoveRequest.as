/**
 * User: booster
 * Date: 28/10/13
 * Time: 14:25
 */

package tictactoe.components.logic.requests {
import cadet.components.requests.Request;

public class MoveRequest extends Request {
    private var _x:int = -1;
    private var _y:int = -1;

    public function get x():int { return _x; }
    public function set x(value:int):void { _x = value; }

    public function get y():int { return _y; }
    public function set y(value:int):void { _y = value; }
}
}
