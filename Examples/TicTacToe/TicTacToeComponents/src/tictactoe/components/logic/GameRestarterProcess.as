/**
 * User: booster
 * Date: 04/11/13
 * Time: 12:19
 */

package tictactoe.components.logic {
import cadet.components.processes.AsynchronousArbiterProcess;
import cadet.components.processes.IArbiterProcess;
import cadet.components.states.StateContainer;
import cadet.core.Component;
import cadet.core.IComponent;
import cadet.events.arbiter.StateEvent;
import cadet.util.ComponentUtil;

import cadet2D.components.renderers.Renderer2D;

import starling.events.Touch;

import starling.events.TouchEvent;
import starling.events.TouchPhase;

import tictactoe.components.display.BoardDisplayComponent;
import tictactoe.components.display.BoxDisplayComponent;

import tictactoe.components.logic.states.GameFinishedStateComponent;
import tictactoe.components.model.GameModelComponent;

public class GameRestarterProcess extends Component {
    private var _arbiter:IArbiterProcess    = null;
    private var _renderer:Renderer2D        = null;

    public function GameRestarterProcess(name:String = "Game Restarter") {
        super(name);
    }

    public function get arbiter():IArbiterProcess { return _arbiter; }
    public function set arbiter(value:IArbiterProcess):void {
        if(_arbiter != null)
            _arbiter.removeEventListener(StateEvent.DID_EXECUTE_STATE, onStateExecuted);

        _arbiter = value;

        if(_arbiter != null)
            _arbiter.addEventListener(StateEvent.DID_EXECUTE_STATE, onStateExecuted);
    }

    public function get renderer():Renderer2D { return _renderer; }
    public function set renderer(value:Renderer2D):void { _renderer = value; }

    override protected function addedToScene():void {
        super.addedToScene();

        addSceneReference(Renderer2D, "renderer");
        addSceneReference(AsynchronousArbiterProcess, "arbiter");
    }

    private function onStateExecuted(event:StateEvent):void {
        if(event.currentState is GameFinishedStateComponent == false)
            return;

        _renderer.viewport.stage.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function onTouch(event:TouchEvent):void {
        var touches:Vector.<Touch> = event.getTouches(renderer.viewport.stage);

        if(touches.length == 0)
            return;

        var touch:Touch = touches[0];

        if(touch.phase != TouchPhase.ENDED)
            return;

        _renderer.viewport.stage.removeEventListener(TouchEvent.TOUCH, onTouch);

        restartGame();
    }

    private function restartGame():void {
        var gameModel:GameModelComponent = ComponentUtil.getChildOfType(scene, GameModelComponent);
        var states:StateContainer = ComponentUtil.getChildOfType(scene, StateContainer);

        states.popState(); // remove GameFinishedStateComponent

        scene.children.removeItem(gameModel);
        scene.children.addItem(new GameModelComponent());

        var boardDisplay:BoardDisplayComponent = ComponentUtil.getChildOfType(scene, BoardDisplayComponent);
        var boxDisplays:Vector.<IComponent> = ComponentUtil.getChildrenOfType(boardDisplay, BoxDisplayComponent);

        for each (var box:BoxDisplayComponent in boxDisplays)
            box.texture = null;

        arbiter.beginExecution();
    }
}
}
