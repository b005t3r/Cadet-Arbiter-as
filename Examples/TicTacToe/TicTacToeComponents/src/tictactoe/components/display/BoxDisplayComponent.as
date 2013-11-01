/**
 * User: booster
 * Date: 28/10/13
 * Time: 10:13
 */

package tictactoe.components.display {
import cadet.core.ComponentContainer;

import cadet2D.components.geom.RectangleGeometry;
import cadet2D.components.skins.GeometrySkin;
import cadet2D.components.skins.ImageSkin;

import cadet2D.components.textures.TextureComponent;
import cadet2D.components.transforms.Transform2D;

public class BoxDisplayComponent extends ComponentContainer {
    private var _imageSkin:ImageSkin = null;

    public function BoxDisplayComponent(name:String = "Box") {
        super(name);
    }

    public function get texture():TextureComponent {
        return _imageSkin != null ? _imageSkin.texture : null;
    }

    public function set texture(value:TextureComponent):void {
        if(_imageSkin == null)
            return;

        _imageSkin.texture = value;
    }

    public function createChildren(x:Number, y:Number, w:Number, h:Number):void {
        var rect:RectangleGeometry = new RectangleGeometry(w, h);
        var trans:Transform2D = new Transform2D(x, y);
        var geomSkin:GeometrySkin = new GeometrySkin(2);
        _imageSkin = new ImageSkin();

        children.addItem(rect);
        children.addItem(trans);
        children.addItem(geomSkin);
        children.addItem(_imageSkin);
    }
}
}
