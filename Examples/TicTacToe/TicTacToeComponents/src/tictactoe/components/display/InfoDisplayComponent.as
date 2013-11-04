/**
 * User: booster
 * Date: 04/11/13
 * Time: 9:39
 */

package tictactoe.components.display {
import cadet.core.ComponentContainer;

import cadet2D.components.geom.RectangleGeometry;
import cadet2D.components.skins.GeometrySkin;
import cadet2D.components.transforms.Transform2D;

public class InfoDisplayComponent extends ComponentContainer {
    private var _labelSkin:LabelSkin = null;

    public function InfoDisplayComponent(name:String = "Info Display") {
        super(name);
    }

    public function createChildren():void {
        var rect:RectangleGeometry = new RectangleGeometry(300, 30);
        var trans:Transform2D = new Transform2D(5, 310);
        var geomSkin:GeometrySkin = new GeometrySkin(2);
        _labelSkin = new LabelSkin(300, 30);

        children.addItem(rect);
        children.addItem(trans);
        children.addItem(geomSkin);
        children.addItem(_labelSkin);
    }

    public function get text():String { return _labelSkin.label.text; }
    public function set text(value:String):void { _labelSkin.label.text = value; }
}
}
