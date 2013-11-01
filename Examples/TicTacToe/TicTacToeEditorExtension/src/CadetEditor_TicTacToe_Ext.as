package {

import cadet.assets.CadetEngineIcons;
import cadet.core.CadetScene;
import cadet.entities.ComponentFactory;

import core.app.CoreApp;
import core.app.managers.ResourceManager;

import flash.display.Sprite;

import tictactoe.components.display.BoardDisplayComponent;

import tictactoe.components.display.BoxDisplayComponent;

import tictactoe.components.display.RefreshDisplaysProcess;
import tictactoe.components.logic.players.human.MoveRequestPlugin;
import tictactoe.components.logic.states.GameStateComponent;
import tictactoe.components.logic.states.TurnStateComponent;
import tictactoe.components.model.GameModelComponent;

public class CadetEditor_TicTacToe_Ext extends Sprite {
    public function CadetEditor_TicTacToe_Ext() {
        var resourceManager:ResourceManager = CoreApp.resourceManager;

        // Processes
        resourceManager.addResource(new ComponentFactory(RefreshDisplaysProcess, "Refresh Display", "Tic Tac Toe", CadetEngineIcons.Process, CadetScene));

        // Displays
        resourceManager.addResource(new ComponentFactory(BoxDisplayComponent, "Box Display", "Tic Tac Toe", CadetEngineIcons.Component));
        resourceManager.addResource(new ComponentFactory(BoardDisplayComponent, "Board Display", "Tic Tac Toe", CadetEngineIcons.Component));

        // Player plugins
        resourceManager.addResource(new ComponentFactory(MoveRequestPlugin, "Move Request Plugin", "Tic Tac Toe", CadetEngineIcons.Component));

        // States
        resourceManager.addResource(new ComponentFactory(GameStateComponent, "Game State", "Tic Tac Toe", CadetEngineIcons.Component));
        resourceManager.addResource(new ComponentFactory(TurnStateComponent, "Turn State", "Tic Tac Toe", CadetEngineIcons.Component));

        // Model
        resourceManager.addResource(new ComponentFactory(GameModelComponent, "Game Model", "Tic Tac Toe", CadetEngineIcons.Component));
    }
}
}
