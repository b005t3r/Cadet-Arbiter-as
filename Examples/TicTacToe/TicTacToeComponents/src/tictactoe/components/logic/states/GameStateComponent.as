/**
 * User: booster
 * Date: 28/10/13
 * Time: 12:02
 */

package tictactoe.components.logic.states {
import tictactoe.components.model.GameModelComponent;
import cadet.components.states.AbstractStateComponent;

public class GameStateComponent extends AbstractStateComponent {
    private var _gameModel:GameModelComponent = null;

    public function GameStateComponent(name:String = "Game State") {
        super(name);
    }

    public function get gameModel():GameModelComponent { return _gameModel; }
    public function set gameModel(value:GameModelComponent):void { _gameModel = value;}

    override public function execute():* {
        // 1. check for victory
        var victorSymbol:int = getVictor();

        if(victorSymbol != GameModelComponent.EMPTY)
            return arbiter.executePreviousStateResult();

        // 2. set current player
        _gameModel.currentSymbol = _gameModel.nextSymbol();

        // 3. let TurnState do its part
        return arbiter.executeStateResult(new TurnStateComponent());
    }

    override protected function addedToScene():void {
        super.addedToScene();

        addSceneReference(GameModelComponent, "gameModel");
    }

    private function getVictor():int {
        var i:int;
        var sum:int = getRowSum(i);
        for(i = 0; i < 3; i++) {
            sum = getRowSum(i);

            if(sum / GameModelComponent.O == 3)
                return GameModelComponent.O;
            else if(sum / GameModelComponent.X == 3)
                return GameModelComponent.X;
        }

        for(i = 0; i < 3; i++) {
            sum = getColumnSum(i);

            if(sum / GameModelComponent.O == 3)
                return GameModelComponent.O;
            else if(sum / GameModelComponent.X == 3)
                return GameModelComponent.X;
        }

        sum = getLeftDiagonalSum();

        if(sum / GameModelComponent.O == 3)
            return GameModelComponent.O;
        else if(sum / GameModelComponent.X == 3)
            return GameModelComponent.X;

        sum = getRightDiagonalSum();

        if(sum / GameModelComponent.O == 3)
            return GameModelComponent.O;
        else if(sum / GameModelComponent.X == 3)
            return GameModelComponent.X;

        return GameModelComponent.EMPTY;
    }

    private function getRowSum(row:int):int {
        return _gameModel.getSymbol(row, 0) + _gameModel.getSymbol(row, 1) + _gameModel.getSymbol(row, 2);
    }

    private function getColumnSum(col:int):int {
        return _gameModel.getSymbol(0, col) + _gameModel.getSymbol(1, col) + _gameModel.getSymbol(2, col);
    }

    private function getLeftDiagonalSum():int {
        return _gameModel.getSymbol(0, 0) + _gameModel.getSymbol(1, 1) + _gameModel.getSymbol(2, 2);
    }

    private function getRightDiagonalSum():int {
        return _gameModel.getSymbol(2, 0) + _gameModel.getSymbol(1, 1) + _gameModel.getSymbol(0, 2);
    }
}
}
