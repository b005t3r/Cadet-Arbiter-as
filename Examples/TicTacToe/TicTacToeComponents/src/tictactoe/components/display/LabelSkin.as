/**
 * User: booster
 * Date: 04/11/13
 * Time: 9:43
 */

package tictactoe.components.display {
import cadet2D.components.skins.AbstractSkin2D;

import starling.core.Starling;

import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class LabelSkin extends AbstractSkin2D {
    private var _label:TextField = null;

    public function LabelSkin(w:Number, h:Number, name:String = "AbstractSkin2D") {
        super(name);

        _label = new TextField(w, h, "Testing 1, 2, 3...", "Verdana", 14, 0xFFFFFFFF, true);

        _displayObject = _label;
        _width = w;
        _height = h;
    }

    public function get label():TextField { return _label; }

    override protected function validateDisplay():Boolean {
        if(Starling.context == null)
            return false;

        if(_label != null && (_label.width != _width || _label.height != _height)) {
            _label.width = _width;
            _label.height = _height;
        }

        return true;
    }


}
}
