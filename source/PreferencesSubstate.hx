package;

import flixel.effects.FlxFlicker;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import lime.utils.Assets;
import haxe.Json;
import openfl.net.FileReference;

using StringTools;

class PreferencesSubstate extends MusicBeatSubstate
{
	private static var curSelected:Int = 0;
	var options:Array<String> = [
		'Naughtyness',
		'Downscroll',
		'Flashing Menu',
		'Camera Zooming On Beat',
		'FPS Counter',
		'Auto Pause'
	];

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var checkboxArray:Array<CheckboxThingie> = [];

	var nextAccept:Int = 5;

	private var flickering:Bool = false;

	public function new()
	{
		super();

		curSelected = 0;

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, (70 *i), options[i], true, false);
			optionText.isMenuItem = true;
			optionText.x += 250;
			optionText.forceX = 120;
			// optionText.forceY = 38 + (120 * i);
			optionText.lerpMult = 2.6;
			optionText.yMult = 92;
			optionText.yAdd = -308;
			optionText.targetY = i;
			grpOptions.add(optionText);

			var checkbox:CheckboxThingie = new CheckboxThingie(optionText.x - 120, optionText.y - 38, false);
			checkbox.sprTracker = optionText;
			checkboxArray.push(checkbox);
			add(checkbox);
		}

		changeSelection();
		reloadCheckboxes();
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			close();
		}

		if (!flickering)
		{
			if (controls.UI_UP_P)
			{
				changeSelection(-1);
			}
			if (controls.UI_DOWN_P)
			{
				changeSelection(1);
			}
	
			if(controls.ACCEPT && nextAccept <= 0) {
				FlxG.sound.play(Paths.sound('confirmMenu'));
	
				flickering = true;
				FlxFlicker.flicker(grpOptions.members[curSelected], 1, 0.06, true, false, function(flick:FlxFlicker)
				{
					switch(options[curSelected]) {
						case 'Naughtyness':
							ClientPrefs.naughtyness = !ClientPrefs.naughtyness;
		
						case 'Downscroll':
							ClientPrefs.downScroll = !ClientPrefs.downScroll;
		
						case 'Flashing Menu':
							ClientPrefs.flashingMenu = !ClientPrefs.flashingMenu;
		
						case 'Camera Zooming On Beat':
							ClientPrefs.cameraZoomingOnBeat = !ClientPrefs.cameraZoomingOnBeat;
		
						case 'FPS Counter':
							ClientPrefs.fpsCounter = !ClientPrefs.fpsCounter;
							if(Main.fpsVar != null)
								if(ClientPrefs.fpsCounter)
									Main.fpsVar.x = 10;
								else
									Main.fpsVar.x = -100;
							
						case 'Auto Pause':
							ClientPrefs.autoPause = !ClientPrefs.autoPause;
							FlxG.autoPause = ClientPrefs.autoPause;
					}
					reloadCheckboxes();
					flickering = false;
				});
			}
		}

		if(nextAccept > 0) {
			nextAccept -= 1;
		}
		super.update(elapsed);
	}
	
	function changeSelection(change:Int = 0)
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
			
			// item.forceY = item.forceY = 38 + (120 * bullShit) - (120 * curSelected);
			
			bullShit++;
		}
		if (change != 0)
			FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function reloadCheckboxes() {
		for (i in 0...grpOptions.length) {
			for (j in 0...checkboxArray.length) {
				var checkbox:CheckboxThingie = checkboxArray[j];
				if(checkbox != null && grpOptions.members != null)
				{
					if (checkbox.sprTracker == grpOptions.members[i]) {
						var daValue:Bool = false;
						switch(options[i]) {
							case 'Naughtyness':
								daValue = ClientPrefs.naughtyness;
							case 'Downscroll':
								daValue = ClientPrefs.downScroll;
							case 'Flashing Menu':
								daValue = ClientPrefs.flashingMenu;
							case 'Camera Zooming On Beat':
								daValue = ClientPrefs.cameraZoomingOnBeat;
							case 'FPS Counter':
								daValue = ClientPrefs.fpsCounter;
							case 'Auto Pause':
								daValue = ClientPrefs.autoPause;
						}
						checkbox.set_daValue(daValue);
						break;
					}
				}
			}
		}
	}
}
