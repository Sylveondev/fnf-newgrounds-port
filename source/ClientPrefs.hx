package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import Controls;

class ClientPrefs {
	public static var naughtyness:Bool = true;
	public static var downScroll:Bool = false;
	public static var flashingMenu:Bool = true;
	public static var cameraZoomingOnBeat:Bool = true;
	public static var fpsCounter:Bool = true;
	public static var autoPause:Bool = false;

	public static var defaultKeys:Array<FlxKey> = [
		A, LEFT,			//Note Left
		S, DOWN,			//Note Down
		W, UP,				//Note Up
		D, RIGHT,			//Note Right

		W, UP,				//UI Up
		A, LEFT,			//UI Left
		D, RIGHT,			//UI Right
		S, DOWN,			//UI Down
		R, NONE,			//Reset
		Z, SPACE,			//Accept
		X, BACKSPACE,		//Back
		P, ENTER			//Pause
	];
	public static var lastControls:Array<FlxKey> = defaultKeys.copy();

	public static function saveSettings() {
		var gsave:FlxSave = new FlxSave();
		gsave.bind('gamedata', 'newgrounds');
		gsave.data.naughtyness = naughtyness;
		gsave.data.downScroll = downScroll;
		gsave.data.fpsCounter = fpsCounter;
		gsave.data.flashingMenu = flashingMenu;
		gsave.data.cameraZoomingOnBeat = cameraZoomingOnBeat;
		gsave.data.autoPause = autoPause;
		gsave.flush();

		var csave:FlxSave = new FlxSave();
		csave.bind('controls', 'newgrounds');
		csave.data.customControls = lastControls;
		csave.flush();
		FlxG.log.add("Settings saved!");
	}

	public static function loadPrefs() {
		var gsave:FlxSave = new FlxSave();
		gsave.bind('gamedata', 'newgrounds');

		if(gsave.data.naughtyness != null) {
			naughtyness = gsave.data.naughtyness;
		}
		if(gsave.data.downScroll != null) {
			downScroll = gsave.data.downScroll;
		}
		if(gsave.data.fpsCounter != null) {
			fpsCounter = gsave.data.fpsCounter;
			if(Main.fpsVar != null) {
				if(fpsCounter) {
					Main.fpsVar.x = 10;
				} else {
					Main.fpsVar.x = -100;
				}
			}
		}
		if(gsave.data.flashingMenu != null) {
			flashingMenu = gsave.data.flashingMenu;
		}
		if(gsave.data.cameraZoomingOnBeat != null) {
			cameraZoomingOnBeat = gsave.data.cameraZoomingOnBeat;
		}
		if(gsave.data.autoPause != null) {
			autoPause = gsave.data.autoPause;
			FlxG.autoPause = autoPause;
		}

		var csave:FlxSave = new FlxSave();
		csave.bind('controls', 'newgrounds');
		if(csave != null && csave.data.customControls != null) {
			removeControls(lastControls);
			lastControls = csave.data.customControls;
			loadControls(lastControls);
		}
	}

	public static function removeControls(controlArray:Array<FlxKey>) {
		PlayerSettings.player1.controls.unbindKeys(Control.NOTE_LEFT, [controlArray[0], controlArray[1]]);
		PlayerSettings.player1.controls.unbindKeys(Control.NOTE_DOWN, [controlArray[2], controlArray[3]]);
		PlayerSettings.player1.controls.unbindKeys(Control.NOTE_UP, [controlArray[4], controlArray[5]]);
		PlayerSettings.player1.controls.unbindKeys(Control.NOTE_RIGHT, [controlArray[6], controlArray[7]]);

		PlayerSettings.player1.controls.unbindKeys(Control.UI_UP, [controlArray[8], controlArray[9]]);
		PlayerSettings.player1.controls.unbindKeys(Control.UI_LEFT, [controlArray[10], controlArray[11]]);
		PlayerSettings.player1.controls.unbindKeys(Control.UI_RIGHT, [controlArray[12], controlArray[13]]);
		PlayerSettings.player1.controls.unbindKeys(Control.UI_DOWN, [controlArray[14], controlArray[15]]);
		PlayerSettings.player1.controls.unbindKeys(Control.RESET, [controlArray[16], controlArray[17]]);
		PlayerSettings.player1.controls.unbindKeys(Control.ACCEPT, [controlArray[18], controlArray[19]]);
		PlayerSettings.player1.controls.unbindKeys(Control.BACK, [controlArray[20], controlArray[21]]);
		PlayerSettings.player1.controls.unbindKeys(Control.PAUSE, [controlArray[22], controlArray[23]]);
	}

	public static function loadControls(controlArray:Array<FlxKey>) {
		PlayerSettings.player1.controls.bindKeys(Control.NOTE_LEFT, [controlArray[0], controlArray[1]]);
		PlayerSettings.player1.controls.bindKeys(Control.NOTE_DOWN, [controlArray[2], controlArray[3]]);
		PlayerSettings.player1.controls.bindKeys(Control.NOTE_UP, [controlArray[4], controlArray[5]]);
		PlayerSettings.player1.controls.bindKeys(Control.NOTE_RIGHT, [controlArray[6], controlArray[7]]);

		PlayerSettings.player1.controls.bindKeys(Control.UI_UP, [controlArray[8], controlArray[9]]);
		PlayerSettings.player1.controls.bindKeys(Control.UI_LEFT, [controlArray[10], controlArray[11]]);
		PlayerSettings.player1.controls.bindKeys(Control.UI_RIGHT, [controlArray[12], controlArray[13]]);
		PlayerSettings.player1.controls.bindKeys(Control.UI_DOWN, [controlArray[14], controlArray[15]]);
		PlayerSettings.player1.controls.bindKeys(Control.RESET, [controlArray[16], controlArray[17]]);
		PlayerSettings.player1.controls.bindKeys(Control.ACCEPT, [controlArray[18], controlArray[19]]);
		PlayerSettings.player1.controls.bindKeys(Control.BACK, [controlArray[20], controlArray[21]]);
		PlayerSettings.player1.controls.bindKeys(Control.PAUSE, [controlArray[22], controlArray[23]]);
	}
}