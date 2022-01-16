<p align="center">⚠️ <strong>WARNING: DEPRECATION!</strong> ⚠️<br>This repository has been marked deprecated, as it's going to be rebuilt from the ground up as a direct port on a new branch.<br>This branch is here for legacy purposes and will no longer be receiving updates!<br>Please don't use this branch, as it was more of a shitty recreation rather than a direct port.<br>See more info on the new branch below.</p>
<br>
<p align="center">ℹ️ <strong>INFO: REPLACEMENT BRANCH!</strong> ℹ️<br>The new branch <strong><i>will be a direct port</i></strong> done via reverse engineering.<br>Please check <a href="https://github.com/AngelDTF/FNF-NewgroundsPort/tree/remaster">AngelDTF/FNF-NewgroundsPort:remaster</a> to see if the direct port is finished!</p>
<br>
<p align="center">ℹ️ <strong>INFO: DELETED TAGS!</strong> ℹ️<br>This branch contains the following tags that were removed as to not confuse people from newer branches.<br><code>v0.2.8-p1</code>: <a href="https://github.com/AngelDTF/FNF-NewgroundsPort/commit/87fb97227f9d6a24aad720762b80ea3552ebfa0e">commit 87fb972</a></p>

# Friday Night Funkin Newgrounds Port

This is the repository for the Friday Night Funkin Newgrounds Port, based on the vanilla repository, ported Newgrounds content, and filled holes in the code. It isn't the most direct port, but it'll be the best we have until v0.2.8 actually releases.

## Asset Info
All of the assets were dumped from the Newgrounds site. Any pre-existing OGG files were reused to ensure higher quality when building for PC. Any new sounds without pre-existing OGGs were converted for PC builds. All videos were also converted and saved as an additional WEBM file for PC compatibility with cutscenes.

## Credits

- [AngelDTF (me!)](https://github.com/AngelDTF) - Programmer: `Filling in the missing holes / Reverse engineering`
- [ShadowMario](https://github.com/ShadowMario) - Creator of the Psychic Engine, which includes open source v0.2.8 code: `UI Elements from v0.2.8`
- [BulbyVR](https://github.com/TheDrawingCoder-Gamer) - Creator of FNF Modding Plus, which also includes open source v0.2.8 code: `Week 7 Elements`

(side-note: I did not work with the above 2 people)

# (Original Friday Night Funkin Description)

This is the repository for Friday Night Funkin, a game originally made for Ludum Dare 47 "Stuck In a Loop".

Play the Ludum Dare prototype here: https://ninja-muffin24.itch.io/friday-night-funkin
Play the Newgrounds one here: https://www.newgrounds.com/portal/view/770371
Support the project on the itch.io page: https://ninja-muffin24.itch.io/funkin

IF YOU MAKE A MOD AND DISTRIBUTE A MODIFIED / RECOMIPLED VERSION, YOU MUST OPEN SOURCE YOUR MOD AS WELL

## Credits / shoutouts

- [ninjamuffin99 (me!)](https://twitter.com/ninja_muffin99) - Programmer
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r) - Art
- [Kawaisprite](https://twitter.com/kawaisprite) - Musician

This game was made with love to Newgrounds and it's community. Extra love to Tom Fulp.

## Build instructions

THESE INSTRUCTIONS ARE FOR COMPILING THE GAME'S SOURCE CODE!!!

IF YOU WANT TO JUST DOWNLOAD AND INSTALL AND PLAY THE GAME NORMALLY, GO TO ITCH.IO TO DOWNLOAD THE GAME FOR PC, MAC, AND LINUX!!

https://ninja-muffin24.itch.io/funkin

IF YOU WANT TO COMPILE THE GAME YOURSELF, CONTINUE READING!!!

### Installing the Required Programs

First you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple). 
1. [Install Haxe 4.1.5](https://haxe.org/download/version/4.1.5/) (Download 4.1.5 instead of 4.2.0 because 4.2.0 is broken and is not working with gits properly...)
2. [Install HaxeFlixel](https://haxeflixel.com/documentation/install-haxeflixel/) after downloading Haxe

Other installations you'd need is the additional libraries, a fully updated list will be in `Project.xml` in the project root. Currently, these are all of the things you need to install:
```
flixel
flixel-addons
flixel-ui
hscript
newgrounds
```
So for each of those type `haxelib install [library]` so shit like `haxelib install newgrounds`

You'll also need to install a couple things that involve Gits. To do this, you need to do a few things first.
1. Download [git-scm](https://git-scm.com/downloads). Works for Windows, Mac, and Linux, just select your build.
2. Follow instructions to install the application properly.
3. Run `haxelib git polymod https://github.com/larsiusprime/polymod.git` to install Polymod.
4. Run `haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc` to install Discord RPC.

You should have everything ready for compiling the game! Follow the guide below to continue!

At the moment, you can optionally fix the transition bug in songs with zoomed out cameras.
- Run `haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons` in the terminal/command-prompt.

### Ignored files

I gitignore the API keys for the game, so that no one can nab them and post fake highscores on the leaderboards. But because of that the game
doesn't compile without it.

Just make a file in `/source` and call it `APIStuff.hx`, and copy paste this into it

```haxe
package;

class APIStuff
{
	public static var API:String = "";
	public static var EncKey:String = "";
}

```

and you should be good to go there.

### Compiling game

Once you have all those installed, it's pretty easy to compile the game. You just need to run 'lime test html5 -debug' in the root of the project to build and run the HTML5 version. (command prompt navigation guide can be found here: [https://ninjamuffin99.newgrounds.com/news/post/1090480](https://ninjamuffin99.newgrounds.com/news/post/1090480))

To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run 'lime test linux -debug' and then run the executable file in export/release/linux/bin. For Windows, you need to install Visual Studio Community 2019. While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)
* C++ Profiling tools
* C++ CMake tools for windows
* C++ ATL for v142 build tools (x86 & x64)
* C++ MFC for v142 build tools (x86 & x64)
* C++/CLI support for v142 build tools (14.21)
* C++ Modules for v142 build tools (x64/x86)
* Clang Compiler for Windows
* Windows 10 SDK (10.0.17134.0)
* Windows 10 SDK (10.0.16299.0)
* MSVC v141 - VS 2017 C++ x64/x86 build tools
* MSVC v140 - VS 2015 C++ build tools (v14.00)

This will install about 22GB of crap, but once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)
