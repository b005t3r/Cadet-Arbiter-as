/**
 * User: booster
 * Date: 28/10/13
 * Time: 10:33
 */

package tictactoe.components.display {
import cadet.components.processes.AsynchronousArbiterProcess;
import cadet.components.processes.IArbiterProcess;
import cadet.core.Component;
import cadet.core.IComponent;
import cadet.events.arbiter.StateEvent;
import cadet.util.ComponentUtil;

import cadet2D.components.textures.TextureComponent;

import tictactoe.components.logic.requests.MoveRequest;
import tictactoe.components.logic.states.TurnStateComponent;
import tictactoe.components.model.GameModelComponent;

public class RefreshBoardDisplayProcess extends Component {
    private var _arbiter:IArbiterProcess            = null;
    private var _gameModel:GameModelComponent       = null;
    private var _boardDisplay:BoardDisplayComponent = null;
    private var _oTexture:TextureComponent          = null;
    private var _xTexture:TextureComponent          = null;

    public function RefreshBoardDisplayProcess(name:String = "Refresh Board Diplay Process") {
        super(name);
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }
    public function set arbiter(value:IArbiterProcess):void {
        if(_arbiter != null)
            _arbiter.removeEventListener(StateEvent.DID_EXECUTE_STATE_WITH_RESPONSE, onStateExecutedWithResponse);

        _arbiter = value;

        if(_arbiter != null)
            _arbiter.addEventListener(StateEvent.DID_EXECUTE_STATE_WITH_RESPONSE, onStateExecutedWithResponse);
    }

    public function get gameModel():GameModelComponent { return _gameModel; }
    public function set gameModel(value:GameModelComponent):void { _gameModel = value; }

    public function get boardDisplay():BoardDisplayComponent { return _boardDisplay; }
    public function set boardDisplay(value:BoardDisplayComponent):void { _boardDisplay = value; }

    [Serializable][Inspectable(editor="ComponentList", scope="scene")]
    public function get oTexture():TextureComponent { return _oTexture; }
    public function set oTexture(value:TextureComponent):void { _oTexture = value; }

    [Serializable][Inspectable(editor="ComponentList", scope="scene")]
    public function get xTexture():TextureComponent { return _xTexture; }
    public function set xTexture(value:TextureComponent):void { _xTexture = value; }

    override protected function addedToScene():void {
        super.addedToScene();

        addSceneReference(AsynchronousArbiterProcess, "arbiter");
        addSceneReference(GameModelComponent, "gameModel");
        addSceneReference(BoardDisplayComponent, "boardDisplay");
    }

    private function onStateExecutedWithResponse(event:StateEvent):void {
        if(event.currentState is TurnStateComponent == false || event.currentState.request is MoveRequest == false)
            return;

        refreshDisplays();
    }

    private function refreshDisplays():void {
        var boxDisplays:Vector.<IComponent> = ComponentUtil.getChildrenOfType(_boardDisplay, BoxDisplayComponent);

        for(var y:int = 0; y < 3; y++) {
            for(var x:int = 0; x < 3; x++) {
                var symbol:int = _gameModel.getSymbol(x, y);

                var box:BoxDisplayComponent = boxDisplays[y * 3 + x] as BoxDisplayComponent;

                switch(symbol) {
                    case GameModelComponent.O:
                        box.texture = _oTexture;
                        break;

                    case GameModelComponent.X:
                        box.texture = _xTexture;
                        break;

                    default:
                        box.texture = null;
                        break;
                }
            }
        }
    }
}
}
