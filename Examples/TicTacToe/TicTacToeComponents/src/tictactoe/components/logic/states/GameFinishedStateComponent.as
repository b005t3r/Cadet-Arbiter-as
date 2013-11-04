/**
 * User: booster
 * Date: 04/11/13
 * Time: 10:43
 */

package tictactoe.components.logic.states {
import cadet.components.states.AbstractStateComponent;

public class GameFinishedStateComponent extends AbstractStateComponent {
    public function GameFinishedStateComponent(name:String = "State") {
        super(name);
    }

    override public function execute():* {
        return arbiter.stopExecutionResult();
    }
}
}
