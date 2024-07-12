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

#if desktop
import Discord.DiscordClient;
#end

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];
	var pages:Array<FreeplayPage> = [];

	var selector:FlxText;
	var curSelected:Int = 0;

	var scoreText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	var pageText:FlxText;
	var page:Int = 0;

	var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	var iconArray:Array<HealthIcon> = [];

	override function create()
	{
		pages[0] = new FreeplayPage([
			newSong("Tutorial", 1, "gf"),

			newSong("Bopeebo", 1, "dad"),
			newSong("Fresh", 1, "dad"),
			newSong("Dadbattle", 1, "dad"),

			newSong("Spookeez", 2, "spooky"),
			newSong("South", 2, "spooky"),
			newSong("Monster", 2, "monster"),

			newSong("Pico", 3, "pico"),
			newSong("Philly", 3, "pico"),
			newSong("Blammed", 3, "pico"),

			newSong("Satin-Panties", 4, "pico"),
			newSong("High", 4, "pico"),
			newSong("MILF", 4, "pico"),

			newSong("Cocoa", 5, "parents-christmas"),
			newSong("Eggnog", 5, "parents-christmas"),
			newSong("Winter-Horrorland", 5, "monster-christmas"),

			newSong("Senpai", 6, "sigmio"),
			newSong("Roses", 6, "sigmio"),
			newSong("Thorns", 6, "spirit"),
			newSong("Unfairness-Jside", 6, "spirit",true),
		],
		"Funkin");

		pages[1] = new FreeplayPage([
			newSong("Tutorial-BSide", 1, "gf"),
			newSong("Tutorial-Erect", 1, "gf"),
			newSong("Spookeez-Erect", 1, "spooky"),
			newSong("Blammed-alt", 1, "pico"),
			newSong("Senpai-Impossible-Ver", 1, "sigmio")
		],
		"Remixes");

		pages[2] = new FreeplayPage([
			newSong("Do-You-Get-The-Refrance", 1, "impostor", true),
			newSong("dotdotdot", 1, "sonicexe")
		],
		"Extras");

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end
		trace(FlxG.save.data.unlockedSongs);

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

		changeSelection();

		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		super.create();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, ?isLocked:Bool=false)
	{
		if (isLocked) {
			if (FlxG.save.data.unlockedSongs == null)
				FlxG.save.data.unlockedSongs = [];
			if (FlxG.save.data.unlockedSongs.contains(songName.toLowerCase()))
				songs.push(new SongMetadata(songName, weekNum, songCharacter));
			else
				songs.push(new SongMetadata("LOCKED", 1, "lock"));
		} else {
			songs.push(new SongMetadata(songName, weekNum, songCharacter));
		}
	}


	public function newSong(songName:String, weekNum:Int, songCharacter:String, ?isLocked:Bool=false):SongMetadata {
		if (isLocked) {
			#if debug
			trace(FlxG.save.data.unlockedSongs);
			#end
			if (FlxG.save.data.unlockedSongs == null)
				FlxG.save.data.unlockedSongs = [];
			if (FlxG.save.data.unlockedSongs.contains(songName.toLowerCase()))
				return new SongMetadata(songName, weekNum, songCharacter);
			else
				return new SongMetadata("LOCKED", 1, "lock");
		}
		return new SongMetadata(songName, weekNum, songCharacter);
	}

	public function addPageSongs(page:FreeplayPage) {
		for (song in page.songs) {
			songs.push(song);
		}
	}

	public function addWeek(songs:Array<String>, weekNum:Int, ?songCharacters:Array<String>, ?isLocked:Bool=false)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num], isLocked);

			if (songCharacters.length != 1)
				num++;
		}
	}

	// I WANT TO FUCKING SHOOT MYSELF

	public static function playSong(song:String, diff:Int, ?storyWeek:Int=1) {
		var poop:String = Highscore.formatSong(song, diff); // Funny
		PlayState.SONG = Song.loadFromJson(poop, song);
		PlayState.isStoryMode = false;

		PlayState.storyWeek = PlayState.stageDictionary[PlayState.SONG.stage];
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
				var songText:Alphabet = new Alphabet(64, 320, songs[i].songName, true);
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
			try {
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), 1);

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
		intendedScore = Highscore.getScore(songs[curSelected].songName, 1);
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
	public var week:Int = 0;
	public var songCharacter:String = "";

	public function new(song:String, week:Int, songCharacter:String)
	{
		this.songName = song;
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