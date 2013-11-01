/**
 * User: booster
 * Date: 28/10/13
 * Time: 10:12
 */

package tictactoe.components.display {
import cadet.core.ComponentContainer;

import cadet2D.components.transforms.Transform2D;

public class BoardDisplayComponent extends ComponentContainer {
    public function BoardDisplayComponent(name:String = "Board Display") {
        super(name);
    }

    public function createChildren():void {
        var trans:Transform2D = new Transform2D(0, 0);

        for(var i:int = 0; i < 9; i++) {
            var x:int = i % 3, y:int = i / 3;

            var box:BoxDisplayComponent = new BoxDisplayComponent("Row: " + (x + 1) + " Col: " + (y + 1));
            box.createChildren(5 + x * 100, 5 + y * 100, 100, 100);

            children.addItem(box);
        }
    }
}
}
