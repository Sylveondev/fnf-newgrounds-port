package;

import Alphabet.ExAlphabet;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class InputItem extends ExAlphabet
{
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;
	public var sprTracker:FlxSprite;
	public var isAlt:Bool = false;
	public function new(text:String = "", ?offsetX:Float = 0, ?offsetY:Float = 0) {
		if (text == '`')
		{
			text = '~';
		}
		super(0, 0, text);
		isMenuItem = false;
		this.offsetX = offsetX;
		this.offsetY = offsetY;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null)
			setPosition(sprTracker.x + offsetX, sprTracker.y + offsetY);

		super.update(elapsed);
	}
}