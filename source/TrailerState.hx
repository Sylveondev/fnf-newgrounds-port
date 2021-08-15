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

		#if web
		Main.cutscene.visible = true;
		Main.cutsceneStream.play('assets/music/kickstarterTrailer.mp4');
		new FlxTimer().start(130, function(tmr:FlxTimer)
		{
			trace("cutscene finished");
			Main.cutscene.visible = false;
			FlxG.switchState(new TitleState());
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		});
		#else
		FlxG.switchState(new TitleState());
		#end
	}
}