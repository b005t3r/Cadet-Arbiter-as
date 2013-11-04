/**
 * User: booster
 * Date: 04/11/13
 * Time: 10:35
 */

package tictactoe.components.display {
import cadet.components.processes.AsynchronousArbiterProcess;
import cadet.components.processes.IArbiterProcess;
import cadet.core.Component;
import cadet.events.arbiter.StateEvent;

import tictactoe.components.logic.states.GameFinishedStateComponent;

import tictactoe.components.logic.states.GameStateComponent;
import tictactoe.components.logic.states.TurnStateComponent;

import tictactoe.components.model.GameModelComponent;

public class RefreshInfoDisplayProcess extends Component {
    private var _arbiter:IArbiterProcess            = null;
    private var _gameModel:GameModelComponent       = null;
    private var _infoDisplay:InfoDisplayComponent   = null;

    public function RefreshInfoDisplayProcess(name:String = "Refresh Info Display Process") {
        super(name);
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }
    public function set arbiter(value:IArbiterProcess):void {
        if(_arbiter != null)
            _arbiter.removeEventListener(StateEvent.WILL_SWITCH_STATE, onStateChange);

        _arbiter = value;

        if(_arbiter != null)
            _arbiter.addEventListener(StateEvent.WILL_SWITCH_STATE, onStateChange);
    }

    public function get gameModel():GameModelComponent { return _gameModel; }
    public function set gameModel(value:GameModelComponent):void { _gameModel = value; }

    public function get infoDisplay():InfoDisplayComponent { return _infoDisplay; }
    public function set infoDisplay(value:InfoDisplayComponent):void { _infoDisplay = value; }

    override protected function addedToScene():void {
        super.addedToScene();

        addSceneReference(AsynchronousArbiterProcess, "arbiter");
        addSceneReference(GameModelComponent, "gameModel");
        addSceneReference(InfoDisplayComponent, "infoDisplay");
    }

    private function onStateChange(event:StateEvent):void {
        // next turn
        if(event.currentState is GameStateComponent && event.newState is TurnStateComponent) {
            if(gameModel.currentSymbol == GameModelComponent.O) {
                infoDisplay.text = "O, make your move.";
            }
            else if(gameModel.currentSymbol == GameModelComponent.X) {
                infoDisplay.text = "X, it's your turn.";
            }
        }
        // game finished
        else if(event.currentState is GameStateComponent && event.newState is GameFinishedStateComponent) {
            if(gameModel.victorSymbol == GameModelComponent.O) {
                infoDisplay.text = "O is the new Champion!";
            }
            else if(gameModel.victorSymbol == GameModelComponent.X) {
                infoDisplay.text = "Glory to the new Champion, X!";
            }
            else {
                infoDisplay.text = "A tie! You are both equally awesome!";
            }
        }
    }
}
}
