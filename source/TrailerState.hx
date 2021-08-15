package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;

using StringTools;

class TrailerState extends MusicBeatState
{
	override public function create():Void
	{
		super.create();

		FlxG.sound.music.stop();

		TitleState.initialized = false;
		#if web
		Main.cutscene.visible = true;
		Main.cutsceneStream.play('assets/music/kickstarterTrailer.mp4');
		new FlxTimer().start(130, function(tmr:FlxTimer)
		{
			trace("cutscene finished");
			Main.cutscene.visible = false;
			FlxG.switchState(new TitleState());
		});
		#else
		// This is to be fixed with newer code once cutscenes are implemented for other platforms
		FlxG.switchState(new TitleState());
		#end
	}

	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			trace("cutscene skipped");
			Main.cutsceneStream.pause();
			Main.cutscene.visible = false;
			TitleState.initialized = false;
			FlxG.switchState(new TitleState());
		}

		super.update(elapsed);
	}
}