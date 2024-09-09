package;

import openfl.utils.Dictionary;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];
	var pages:Array<FreeplayPage> = [];

	var selector:FlxText;
	static var curSelected:Int = 0;

	var scoreText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	var pageText:FlxText;
	static var page:Int = 0;

	var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	var iconArray:Array<HealthIcon> = [];

	public static var lastSelected:Int = -1;
	public static var lastPage:Int = -1;

	override function create()
	{
		pages[0] = new FreeplayPage([
			newSong("Tutorial", "Tutorial", 1, "gf"),

			newSong("Bopeebo", "Bopeebo", 1, "dad"),
			newSong("Fresh", "Fresh", 1, "dad"),
			newSong("Dadbattle", "Dadbattle", 1, "dad"),

			newSong("Spookeez", "Spookeez", 2, "spooky"),
			newSong("South", "South", 2, "spooky"),
			newSong("Monster", "Monster", 2, "monster"),

			newSong("Pico", "Pico", 3, "pico"),
			newSong("Philly", "Philly", 3, "pico"),
			newSong("Blammed", "Blammed", 3, "pico"),

			newSong("Satin-Panties", "Satin Panties", 4, "mom"),
			newSong("High", "High", 4, "pico"),
			newSong("MILF", "MILF", 4, "pico"),

			newSong("Cocoa", "Cocoa", 5, "parents-christmas"),
			newSong("Eggnog", "Eggnog", 5, "parents-christmas"),
			newSong("Winter-Horrorland", "Winter Horrorland", 5, "monster-christmas"),

			newSong("Senpai", "Senpai", 6, "sigmio"),
			newSong("Roses", "Roses", 6, "sigmio"),
			newSong("Thorns", "Thorns", 6, "spirit"),
			newSong("Unfairness-Jside", "Unfairness J-Side", 6, "sigmio-final",true)
		],
		"Funkin");

		pages[1] = new FreeplayPage([
			newSong("Tutorial-BSide", "Tutorial B-Side", 1, "gf"),
			newSong("Tutorial-Erect", "Tutorial Erect", 1, "gf"),
			newSong("Tutorial-BSide-Erect", "Tutorial B-Side Erect", 1, "gf"),
			newSong("Spookeez-Erect", "Spookeez Erect", 1, "spooky"),
			newSong("Blammed-alt", "Blammed (Alt)", 1, "pico"),
			newSong("Senpai-Impossible-Ver", "Senpai Impossible Ver.", 1, "sigmio")
		],
		"Remixes");

		pages[2] = new FreeplayPage([
			newSong("Do-You-Get-The-Refrance", "Do You Get The Refrance?", 1, "bean", true),
			newSong("dotdotdot", "dotdotdot", 1, "sonicexe", true),
			newSong("bopcityfansong", "bopcityfansong", 1, "blocku", true),
			newSong("celebrate", "Celebrate", 1, "afton")
		],
		"Extras");

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end
		
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuBGBlue'));
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 24);
		if (SaveManagement.getOption("Freaky Mode") == "On")
			scoreText.setFormat(Paths.font("papyrus.ttf"), 24, FlxColor.WHITE, RIGHT);
		else
			scoreText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, RIGHT);

		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 75, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		pageText = new FlxText(FlxG.width * 0.7, 42, 0 , "", 16);
		if (SaveManagement.getOption("Freaky Mode") == "On")
			pageText.setFormat(Paths.font("papyrus.ttf"), 16, FlxColor.WHITE, RIGHT);
		else
			pageText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT);
		add(pageText);

		addPageSongs(pages[page]);

		refreshSongList(true);

		add(scoreText);

		if (lastSelected != -1)
			curSelected = lastSelected;

		if (lastPage != -1) {
			songs = [];
			addPageSongs(pages[lastPage]);
			refreshSongList();
		}
			
		changeSelection();

		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		super.create();
	}

	public function newSong(songName:String, displayName:String, weekNum:Int, songCharacter:String, ?isLocked:Bool=false):SongMetadata {
		if (isLocked) {
			#if debug
			trace(FlxG.save.data.unlockedSongs);
			#end
			if (FlxG.save.data.unlockedSongs == null)
				FlxG.save.data.unlockedSongs = [];
			if (FlxG.save.data.unlockedSongs.contains(songName.toLowerCase()))
				return new SongMetadata(songName, displayName, weekNum, songCharacter);
			else
				return new SongMetadata(songName, "Locked", 1, "lock");
		}
		return new SongMetadata(songName, displayName, weekNum, songCharacter);
	}

	public function addPageSongs(page:FreeplayPage) {
		for (song in page.songs) {
			songs.push(song);
		}
	}

	// I WANT TO FUCKING SHOOT MYSELF

	public static function playSong(song:String, diff:Int, ?storyWeek:Int=1) {
		PlayState.SONG = Song.loadFromJson(song, song);
		PlayState.isStoryMode = false;

		PlayState.storyWeek = PlayState.stageDictionary[PlayState.SONG.stage];

		PlayState.lastFPpage = page;
		PlayState.lastFPselect = curSelected;
		LoadingState.loadAndSwitchState(new PlayState());
	}

	public function refreshSongList(skipDestroy:Bool=false) {
		if (!skipDestroy) {
			for (i in 0...grpSongs.length) {
				grpSongs.members[i].destroy();
			}

			for (i in 0...iconArray.length) {
				iconArray[i].destroy();
			}

			iconArray = [];
			grpSongs.clear();
		}

		for (i in 0...songs.length)
			{
				var songText:Alphabet = new Alphabet(64, 320, songs[i].displayName, true);
				songText.isMenuItem = true;
				songText.targetY = i;
				grpSongs.add(songText);
	
				var icon:HealthIcon = new HealthIcon(songs[i].songCharacter);
				icon.sprTracker = songText;
	
				iconArray.push(icon);
				add(icon);
			}


			pageText.text = "Page " + Std.string(page+1) + " (of " + Std.string(pages.length) + ") - " + pages[page].name + " (Arrows to scroll)";
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;
		var rightP = controls.RIGHT_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (rightP) // Page Switching
		{
			if (page != pages.length-1)
				page++;
			else
				page = 0;

			songs = [];
			addPageSongs(pages[page]);
			refreshSongList();
			changeSelection();
		}
		
		if (leftP) // Page Switching
		{
			if (page != 0)
				page--;
			else
				page = pages.length-1;

			songs = [];
			addPageSongs(pages[page]);
			refreshSongList();
			changeSelection();
		}
		
		if (controls.RESET)
			FlxG.sound.playMusic(Paths.inst(songs[curSelected].songName), 0);

		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

		if (FlxG.keys.justPressed.ONE) { // Clear beat songs data key for testing purposes. (Also for exterminating your pesky memory leaks :3)
			FlxG.save.data.unlockedSongs = [];
		}

		if (accepted)
		{
			if (songs[curSelected].displayName != "Locked")
			{
				try {
					var poop:String = songs[curSelected].songName.toLowerCase();

					trace(poop);

					PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
					PlayState.isStoryMode = false;

					PlayState.storyWeek = PlayState.stageDictionary[PlayState.SONG.stage];
					LoadingState.loadAndSwitchState(new PlayState());
				}
				catch(e) {
					trace(e);
				}
			}
			else
			{
				FlxG.sound.play(Paths.sound('flashbang', "shared"), 0.4);
				var flashbang:FlxSprite = new FlxSprite().loadGraphic(Paths.image('hints/' + songs[curSelected].songName, "shared"));
				flashbang.screenCenter();
				add(flashbang);
				FlxTween.tween(flashbang, {alpha: 0}, 3, {ease: FlxEase.linear});
			}
		}
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName);
		#end

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var displayName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, displayName:String, week:Int, songCharacter:String)
	{
		this.songName = song;
		this.displayName = displayName;
		this.week = week;
		this.songCharacter = songCharacter;
	}
}

class FreeplayPage {
	public var songs:Array<SongMetadata> = [];
	public var name:String = "";

	public function new(songs:Array<SongMetadata>, name:String) {
		this.songs = songs;
		this.name = name;
	}
}