package;

import flixel.addons.display.shapes.FlxShapeType;
import flixel.group.FlxGroup;
import flixel.addons.display.shapes.FlxShapeBox;
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
import flixel.input.keyboard.FlxKey;
import lime.utils.Assets;
import haxe.Json;
import openfl.net.FileReference;
import Controls;

using StringTools;

class ControlsSubstate extends MusicBeatSubstate {
	var options:Array<String> = [];
	private static var curSelected:Int = 1;
	private static var curAlt:Bool = false;
	public static var overlay:FlxGroup;
	public static var overlayshadow:FlxShapeBox;
	public static var overlaybg:FlxShapeBox;

	var optionShit:Array<String> = [
		'NOTES',
		'Left',
		'Down',
		'Up',
		'Right',
		'UI',
		'Left',
		'Down',
		'Up',
		'Right',
		'Reset',
		'Accept',
		'Back',
		'Pause',];

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var grpInputs:Array<InputItem> = [];
	private var controlArray:Array<FlxKey> = [];
	var rebindingKey:Int = -1;
	var rebindingOppositeKey:Int = -1;
	var nextAccept:Int = 5;

	private var flickering:Bool = false;

	public function new() {
		super();

		curSelected = 1;

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		controlArray = ClientPrefs.lastControls.copy();
		for (i in 0...optionShit.length) {
			var isCentered:Bool = false;
			if(unselectableCheck(i)) {
				isCentered = true;
			}

			var optionText:Alphabet = new Alphabet(0, (10 * i), optionShit[i], unselectableCheck(i) || !isCentered, false, 0.05, 1, 9.6, true);
			optionText.isMenuItem = true;
			if(isCentered) {
				optionText.screenCenter(X);
				optionText.forceX = optionText.x;
			} else {
				optionText.forceX = 150;
			}
			optionText.lerpMult = 2.6;
			optionText.yMult = 55;
			optionText.yAdd += -236;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(!isCentered) {
				addBindTexts(optionText);
			}
		}

		overlay = new FlxGroup();
		overlay.visible = false;
		overlayshadow = new FlxShapeBox(0, 0, 1415, 803, {  }, 0x80000000);
		overlayshadow.screenCenter();
		overlayshadow.antialiasing = false;
		#if web
		overlayshadow.shape_id = FlxShapeType.UNKNOWN;
		overlayshadow.redrawShape();
		overlayshadow.screenCenter();
		#end
		overlay.add(overlayshadow);
		overlaybg = new FlxShapeBox(0, 0, 1080, 520, { }, 0xFFFAFD6D);
		overlaybg.screenCenter();
		overlaybg.antialiasing = false;
		#if web
		overlaybg.shape_id = FlxShapeType.UNKNOWN;
		overlaybg.redrawShape();
		overlaybg.screenCenter();
		#end
		overlay.add(overlaybg);
		var overlayShit1:Alphabet = new Alphabet(0, 184, "Press any key to rebind", true);
		overlayShit1.screenCenter(X);
		overlay.add(overlayShit1);
		var overlayShit2:Alphabet = new Alphabet(0, 496, "Escape to cancel", true);
		overlayShit2.screenCenter(X);
		overlay.add(overlayShit2);
		add(overlay);

		changeSelection();
	}

	override function update(elapsed:Float) {
		if(rebindingKey < 0) {
			if (controls.BACK) {
				ClientPrefs.removeControls(ClientPrefs.lastControls);
				ClientPrefs.lastControls = controlArray.copy();
				ClientPrefs.loadControls(ClientPrefs.lastControls);
				close();
			}

			if (!flickering)
			{
				if (controls.UI_UP_P) {
					changeSelection(-1);
				}
				if (controls.UI_DOWN_P) {
					changeSelection(1);
				}
				if (controls.UI_LEFT_P || controls.UI_RIGHT_P) {
					changeAlt();
				}
	
				if(controls.ACCEPT && nextAccept <= 0) {
					FlxG.sound.play(Paths.sound('confirmMenu'));

					flickering = true;
					FlxFlicker.flicker(grpInputs[getSelectedKey()], 1, 0.06, true, false, function(flick:FlxFlicker)
					{
						rebindingKey = getSelectedKey();
						rebindingOppositeKey = getSelectedKey(true);
						overlay.visible = true;
						flickering = false;
					});
				}
			}
		} else {
			var keyPressed:Int = FlxG.keys.firstJustPressed();
			if (keyPressed > -1) {
				if (keyPressed != 27) // cancel bind if they pressed ESCAPE
				{
					controlArray[rebindingKey] = keyPressed;
					if(controlArray[rebindingOppositeKey] == controlArray[rebindingKey]) {
						controlArray[rebindingOppositeKey] = NONE;
					}

					reloadKeys();
				}
				trace("rebound to key " + keyPressed);
				rebindingKey = -1;
				rebindingOppositeKey = -1;
				
				overlay.visible = false;
			}
		}

		if(nextAccept > 0) {
			nextAccept -= 1;
		}
		super.update(elapsed);
	}
	
	function changeSelection(change:Int = 0) {
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = optionShit.length - 1;
			if (curSelected >= optionShit.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var bullShit:Int = 0;

		for (i in 0...grpInputs.length) {
			grpInputs[i].alpha = 0.6;
		}

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
					for (i in 0...grpInputs.length) {
						if(grpInputs[i].sprTracker == item && grpInputs[i].isAlt == curAlt) {
							grpInputs[i].alpha = 1;
						}
					}
				}
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function changeAlt() {
		curAlt = !curAlt;
		for (i in 0...grpInputs.length) {
			if(grpInputs[i].sprTracker == grpOptions.members[curSelected]) {
				grpInputs[i].alpha = 0.6;
				if(grpInputs[i].isAlt == curAlt) {
					grpInputs[i].alpha = 1;
				}
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	private function unselectableCheck(num:Int):Bool {
		return optionShit[num] == 'NOTES' || optionShit[num] == 'UI' || optionShit[num] == '';
	}

	private function getSelectedKey(?oppositeAlt:Bool = false):Int {
		var max:Int = 0;
		var selected:Int = 0;
		for (i in 0...grpOptions.length) {
			if(!unselectableCheck(i)) {
				if(grpOptions.members[i].targetY == 0) selected = max;
				max++;
			}
		}

		var isAlt:Int = oppositeAlt ? 0 : 1;
		var value:Int = curAlt ? isAlt : (1 - isAlt);
		for (i in 0...max) {
			if(i == selected) return value;
			value += 2;
		}
		return value;
	}

	private function addBindTexts(optionText:Alphabet) {
		var text1 = new InputItem(InputFormatter.getKeyName(controlArray[grpInputs.length]), 400, -55);
		// trace('text1:'+text1.text);
		text1.setPosition(optionText.x + 400, optionText.y - 55);
		text1.sprTracker = optionText;
		grpInputs.push(text1);
		add(text1);

		var text2 = new InputItem(InputFormatter.getKeyName(controlArray[grpInputs.length]), 650, -55);
		// trace('text2:'+text1.text);
		text2.setPosition(optionText.x + 650, optionText.y - 55);
		text2.sprTracker = optionText;
		text2.isAlt = true;
		grpInputs.push(text2);
		add(text2);
	}

	function reloadKeys() {
		while(grpInputs.length > 0) {
			var item:InputItem = grpInputs[0];
			grpInputs.remove(item);
			remove(item);
		}

		for (i in 0...grpOptions.length) {
			if(!unselectableCheck(i)) {
				addBindTexts(grpOptions.members[i]);
			}
		}


		var bullShit:Int = 0;
		for (i in 0...grpInputs.length) {
			grpInputs[i].alpha = 0.6;
		}

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
					for (i in 0...grpInputs.length) {
						if(grpInputs[i].sprTracker == item && grpInputs[i].isAlt == curAlt) {
							grpInputs[i].alpha = 1;
						}
					}
				}
			}
		}
	}
}
