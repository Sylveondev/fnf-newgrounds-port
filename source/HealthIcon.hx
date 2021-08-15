package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;
	private var curicon:String = 'bf';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		// loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		// animation.add('bf', [0, 1], 0, false, isPlayer);
		// animation.add('bf-car', [0, 1], 0, false, isPlayer);
		// animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
		// animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
		// animation.add('spooky', [2, 3], 0, false, isPlayer);
		// animation.add('pico', [4, 5], 0, false, isPlayer);
		// animation.add('mom', [6, 7], 0, false, isPlayer);
		// animation.add('mom-car', [6, 7], 0, false, isPlayer);
		// animation.add('tankman', [8, 9], 0, false, isPlayer);
		// animation.add('face', [10, 11], 0, false, isPlayer);
		// animation.add('dad', [12, 13], 0, false, isPlayer);
		// animation.add('senpai', [22, 22], 0, false, isPlayer);
		// animation.add('senpai-angry', [22, 22], 0, false, isPlayer);
		// animation.add('spirit', [23, 23], 0, false, isPlayer);
		// animation.add('bf-old', [14, 15], 0, false, isPlayer);
		// animation.add('gf', [16], 0, false, isPlayer);
		// animation.add('parents-christmas', [17], 0, false, isPlayer);
		// animation.add('monster', [19, 20], 0, false, isPlayer);
		// animation.add('monster-christmas', [19, 20], 0, false, isPlayer);
		setIcon(char, isPlayer);
		scrollFactor.set();
	}

	public function setIcon(char:String = 'bf', flipX:Bool = false)
	{
		var correctFuckingIcon = char;
		switch (char)
		{
			case 'parents-christmas':
				correctFuckingIcon = 'parents';

			case 'monster-christmas':
				correctFuckingIcon = 'monster';

			case 'bf-car':
				correctFuckingIcon = 'bf';

			case 'bf-christmas':
				correctFuckingIcon = 'bf';

			case 'mom-car':
				correctFuckingIcon = 'mom';

			case 'senpai-angry':
				correctFuckingIcon = 'senpai';

			case 'bf-holding-gf':
				correctFuckingIcon = 'bf';

			case 'pico-speaker':
				correctFuckingIcon = 'pico';
		}
		loadGraphic(Paths.image('icons/icon-' + correctFuckingIcon), true, 150, 150);
		animation.add(char, [0, 1], 0, false, flipX);
		animation.play(char);
		curicon = char;
	}

	public function getIcon()
	{
		return curicon;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
