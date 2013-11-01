/**
 * User: booster
 * Date: 28/10/13
 * Time: 14:10
 */

package tictactoe.components.logic.states {
import cadet.components.players.IPlayerComponent;
import cadet.components.states.AbstractStateComponent;

import tictactoe.components.logic.requests.MoveRequest;

import tictactoe.components.model.GameModelComponent;

public class TurnStateComponent extends AbstractStateComponent {
    private var _gameModel:GameModelComponent = null;

    public function TurnStateComponent(name:String = "Turn State") {
        super(name);
    }

    public function get moveRequest():MoveRequest { return request as MoveRequest; }

    public function get gameModel():GameModelComponent { return _gameModel; }
    public function set gameModel(value:GameModelComponent):void { _gameModel = value; }

    override public function execute():* {
        var playerIndex:int         = _gameModel.currentSymbol == GameModelComponent.O ? 0 : 1;
        var player:IPlayerComponent = arbiter.players.getPlayer(playerIndex);

        return arbiter.sendRequestResult(new MoveRequest(), player);
    }

    override public function executeWithResponse():* {
        _gameModel.putSymbol(_gameModel.currentSymbol, moveRequest.x, moveRequest.y);

        return arbiter.executePreviousStateResult();
    }

    override protected function addedToScene():void {
        super.addedToScene();

        addSceneReference(GameModelComponent, "gameModel");
    }
}
}
