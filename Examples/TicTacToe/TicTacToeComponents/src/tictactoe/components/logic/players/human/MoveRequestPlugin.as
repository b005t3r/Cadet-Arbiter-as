/**
 * User: booster
 * Date: 28/10/13
 * Time: 15:13
 */
package tictactoe.components.logic.players.human {
import cadet.components.players.AbstractPlayerPluginComponent;
import cadet.components.requests.Request;
import cadet.util.ComponentUtil;

import cadet2D.components.geom.RectangleGeometry;
import cadet2D.components.renderers.Renderer2D;
import cadet2D.components.transforms.Transform2D;

import flash.geom.Matrix;

import flash.geom.Point;

import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

import tictactoe.components.display.BoardDisplayComponent;
import tictactoe.components.display.BoxDisplayComponent;
import tictactoe.components.logic.requests.MoveRequest;
import tictactoe.components.model.GameModelComponent;

public class MoveRequestPlugin extends AbstractPlayerPluginComponent {
    private var _gameModel:GameModelComponent       = null;
    private var _renderer:Renderer2D                = null;
    private var _boardDisplay:BoardDisplayComponent = null;

    public function MoveRequestPlugin(name:String = "Move Request Plugin") {
        super(name);
    }

    public function get gameModel():GameModelComponent { return _gameModel; }
    public function set gameModel(value:GameModelComponent):void { _gameModel = value;}

    public function get renderer():Renderer2D { return _renderer; }
    public function set renderer(value:Renderer2D):void { _renderer = value; }

    public function get boardDisplay():BoardDisplayComponent { return _boardDisplay; }
    public function set boardDisplay(value:BoardDisplayComponent):void { _boardDisplay = value; }

    public function get moveRequest():MoveRequest { return request as MoveRequest; }

    override public function canHandleRequest(request:Request):Boolean { return request is MoveRequest; }

    override public function processRequest():* {
        if(moveRequest.x == -1 && moveRequest.y == -1) {
            _renderer.viewport.stage.addEventListener(TouchEvent.TOUCH, onTouch);

            return arbiter.pauseExecutionResponse(); // let the ser select a unoccupied space
        }
        else {
            return arbiter.requestProcessedResponse(request);
        }
    }

    override protected function addedToScene():void {
        super.addedToScene();

        addSceneReference(GameModelComponent, "gameModel");
        addSceneReference(Renderer2D, "renderer");
        addSceneReference(BoardDisplayComponent, "boardDisplay");
    }

    private function onTouch(event:TouchEvent):void {
        var touches:Vector.<Touch> = event.getTouches(renderer.viewport.stage);

        if(touches.length == 0)
            return;

        var touch:Touch = touches[0];

        if(touch.phase != TouchPhase.ENDED)
            return;

        for (var i:int = 0; i < boardDisplay.children.length; i++) {
            var x:int = i % 3;
            var y:int = i / 3;

            if(gameModel.getSymbol(x, y) != GameModelComponent.EMPTY)
                continue;

            var box:BoxDisplayComponent = boardDisplay.children[i];
            var transform:Transform2D   = ComponentUtil.getChildOfType(box, Transform2D);
            var rect:RectangleGeometry  = ComponentUtil.getChildOfType(box, RectangleGeometry);

            var globalToLocalMatrix:Matrix = transform.globalMatrix.clone();
            globalToLocalMatrix.invert();

            var globalPoint:Point   = touch.getLocation(renderer.viewport.stage);
            var localPoint:Point    = globalToLocalMatrix.transformPoint(globalPoint);

            if(localPoint.x > 0 && localPoint.x < rect.width && localPoint.y > 0 && localPoint.y < rect.height) {
                moveRequest.x = x;
                moveRequest.y = y;

                renderer.viewport.stage.removeEventListener(TouchEvent.TOUCH, onTouch);

                arbiter.resumeExecution();
                break;
            }
        }
    }
}
}
