/**
 * User: booster
 * Date: 28/10/13
 * Time: 10:00
 */

package tictactoe.components.model {
import cadet.core.Component;

public class GameModelComponent extends Component {
    public static const X:int       = 1;
    public static const O:int       = -1;
    public static const EMPTY:int   = 0;

    private var board:Vector.<Vector.<int>> = new <Vector.<int>>[
        new <int>[0, 0, 0],
        new <int>[0, 0, 0],
        new <int>[0, 0, 0]
    ];

    private var _currentSymbol:int = EMPTY;

    public function GameModelComponent(name:String = "Game Model") {
        super(name);
    }

    public function get currentSymbol():int { return _currentSymbol; }
    public function set currentSymbol(value:int):void { _currentSymbol = value; }
    public function nextSymbol():int { return currentSymbol == O ? X : O; }

    public function putSymbol(symbol:int, x:int, y:int):void {
        board[y][x] = symbol;
    }

    public function getSymbol(x:int, y:int):int {
        return board[y][x];
    }
}
}
