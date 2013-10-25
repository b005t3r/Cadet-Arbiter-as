package {

import cadet.assets.CadetEngineIcons;
import cadet.components.players.PlayerContainer;
import cadet.components.players.PluggablePlayerComponent;
import cadet.components.processes.AsynchronousArbiterProcess;
import cadet.components.processes.BasicArbiterProcess;
import cadet.components.states.StateContainer;
import cadet.core.CadetScene;
import cadet.entities.ComponentFactory;

import core.app.CoreApp;
import core.app.managers.ResourceManager;

import flash.display.Sprite;

public class CadetEditor_Arbiter_Ext extends Sprite {
    public function CadetEditor_Arbiter_Ext() {
        var resourceManager:ResourceManager = CoreApp.resourceManager;

        // Processes
        resourceManager.addResource(new ComponentFactory(BasicArbiterProcess, "Basic Arbiter", "Processes", CadetEngineIcons.Process, CadetScene));
        resourceManager.addResource(new ComponentFactory(AsynchronousArbiterProcess, "Asynchronous Arbiter", "Processes", CadetEngineIcons.Process, CadetScene));

        // Components
        resourceManager.addResource(new ComponentFactory(PluggablePlayerComponent, "Pluggable Player", "Components"));
        resourceManager.addResource(new ComponentFactory(PlayerContainer, "Player Container", "Components"));

        resourceManager.addResource(new ComponentFactory(StateContainer, "State Container", "Components"));
    }
}
}
