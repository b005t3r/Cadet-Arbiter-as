package {

import cadet.components.players.PlayerContainer;
import cadet.components.players.PluggablePlayerComponent;
import cadet.components.processes.AsynchronousArbiterProcess;
import cadet.components.states.StateContainer;
import cadet.core.CadetScene;

import cadet2D.components.textures.TextureComponent;

import cadet2D.launcher.Cadet2DLauncher;

import core.app.managers.ResourceManager;

import flash.display.Sprite;

import tictactoe.components.display.BoardDisplayComponent;
import tictactoe.components.display.InfoDisplayComponent;
import tictactoe.components.display.RefreshBoardDisplayProcess;
import tictactoe.components.display.RefreshInfoDisplayProcess;
import tictactoe.components.logic.GameRestarterProcess;
import tictactoe.components.logic.players.human.MoveRequestPlugin;
import tictactoe.components.logic.states.GameStateComponent;

import tictactoe.components.model.GameModelComponent;

[SWF(width="310", height="345", backgroundColor="0x002135", frameRate="60")]
public class TicTacToeDesktop extends Sprite {
    public function TicTacToeDesktop() {
        var launcher:Cadet2DLauncher = new Cadet2DLauncher();
        launcher.sceneInitializer = function(scene:CadetScene, resourceManager:ResourceManager):void {
            scene.children.addItem(new GameModelComponent());

            var boardDisplay:BoardDisplayComponent = new BoardDisplayComponent();
            boardDisplay.createChildren();
            scene.children.addItem(boardDisplay);

            var infoDisplay:InfoDisplayComponent = new InfoDisplayComponent();
            infoDisplay.createChildren();
            scene.children.addItem(infoDisplay);

            var infoRefresher:RefreshInfoDisplayProcess = new RefreshInfoDisplayProcess();
            scene.children.addItem(infoRefresher);

            var boardRefresher:RefreshBoardDisplayProcess = new RefreshBoardDisplayProcess();
            var oTexture:TextureComponent = new TextureComponent();
            var xTexture:TextureComponent = new TextureComponent();

            resourceManager.bindResource("o.png", oTexture, "bitmapData");
            resourceManager.bindResource("x.png", xTexture, "bitmapData");

            boardRefresher.oTexture = oTexture;
            boardRefresher.xTexture = xTexture;

            scene.children.addItem(oTexture);
            scene.children.addItem(xTexture);
            scene.children.addItem(boardRefresher);

            scene.children.addItem(new GameRestarterProcess());

            var arbiter:AsynchronousArbiterProcess  = new AsynchronousArbiterProcess();
            var states:StateContainer               = new StateContainer();
            var players:PlayerContainer             = new PlayerContainer();
            var playerOne:PluggablePlayerComponent  = new PluggablePlayerComponent("Player One");
            var playerTwo:PluggablePlayerComponent  = new PluggablePlayerComponent("Player Two");

            playerOne.registerPlugin(new MoveRequestPlugin());
            playerTwo.registerPlugin(new MoveRequestPlugin());
            players.registerPlayer(playerOne);
            players.registerPlayer(playerTwo);

            states.pushState(new GameStateComponent());

            arbiter.players = players;
            arbiter.states  = states;

            scene.children.addItem(arbiter);
            scene.children.addItem(players);
            scene.children.addItem(states);

            arbiter.beginExecution();
        };

        launcher.launch(this);
    }
}
}
