package;

import DNBShader.GlitchEffect;
import openfl.Vector;
import lime.math.Vector2;
import ResultsSubState.FunkinResults;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

using StringTools;

#if desktop
import Discord.DiscordClient;
import sys.FileSystem;
#end

#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideo as VideoHandler;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoHandler as VideoHandler;
#elseif (hxCodec == "2.6.0") import VideoHandler;
#else import vlc.MP4Handler as VideoHandler; #end

class PlayState extends MusicBeatState
{
	public static var instance(get,null):PlayState;
	public static function get_instance():PlayState {
		if (instance == null)
			instance = new PlayState();
		return instance;
	}

	public static var lastFPselect:Int = -1;
	public static var lastFPpage:Int = -1;

	public static var curStage:String = '';
	public static var SONG:SwagSong;
	public static var isStoryMode:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var weekSong:Int = 0;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;
	public static var accDisplay:String = "";

	public static var hasDialogue:Bool = false;
	public static var isPixel:Bool = false;
	public static var isGood:Bool = false;

	private var vocals:FlxSound;

	private var dad:Character;
	private var gf:Character;
	private var boyfriend:Boyfriend;

	private var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];

	private var strumLine:FlxSprite;
	private var curSection:Int = 0;

	private var camFollow:FlxObject;

	private static var prevCamFollow:FlxObject;

	private var strumLineNotes:FlxTypedGroup<FlxSprite>;
	private var playerStrums:FlxTypedGroup<FlxSprite>;

	private var camZooming:Bool = false;
	public static var curSong:String = "";

	private var gfSpeed:Int = 1;
	private var health:Float = 1;
	private var combo:Int = 0;
	public static var misses:Int = 0;
	private var accuracy:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalPlayed:Int = 0;
	private var ss:Bool = false;


	private var healthBarBG:FlxSprite;
	private var healthBar:FlxBar;

	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;

	private var iconP1:HealthIcon;
	private var iconP2:HealthIcon;
	private var updateIconP1:Bool = true;
	private var updateIconP2:Bool = true;
	private var camHUD:FlxCamera;
	private var camOther:FlxCamera;
	private var camGame:FlxCamera;

	var dialogue:Array<String> = ['blah blah blah', 'coolswag'];

	var songCard:SongCard;

	var stupidFuckingSpotlight1:FlxSprite;
	var stupidFuckingSpotlight2:FlxSprite;

	var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var picoShoot:FlxSprite;
	var beefSafe:Bool = false;
	var shootSound:FlxSound;

	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;
	
	var evilTrail:FlxTrail;

	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;
	var explosion:FlxSprite;
	var fortnitecard:FlxSprite;
	var whatthe:FlxSprite;

	var unfairJbg:FlxSprite;
	var thornbg:FlxSprite;
	var sigmioreveal:Bool = false;
	var unfairJevents:Array<Bool> = [false, false];
	var blackShitJ:FlxSprite;
	var whiteShitJ:FlxSprite;
	var lol:FlxSprite;
	var bfTrailJ:FlxTrail;
	var dadTrailJ:FlxTrail;

	var fc:Bool = true;
	var allowMiss = true;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();
	var unfairjShader:GlitchEffect;

	var talking:Bool = true;
	var songScore:Int = 0;
	var scoreTxt:FlxText;
	
	var specialgf:Bool = false;
	
	public static var campaignScore:Int = 0;

	public static var defaultCamZoom:Float = 1.05;

	public static var daPixelZoom:Float = 6;

	public static var theFunne:Bool = true;
	var funneEffect:FlxSprite;
	var inCutscene:Bool = false;
	public static var repPresses:Int = 0;
	public static var repReleases:Int = 0;

	public static var timeCurrently:Float = 0;
	public static var timeCurrentlyR:Float = 0;

	public static var stageDictionary:Map<String, Int> = [
		"stage" => 1,
		"spooky" => 2,
		"philly" => 3,
		"limo" => 4,
		"limonormal" => 4,
		"mall" => 5,
		"mallEvil" => 5,
		"school" => 6,
		"schoolEvil" => 6,
		"exe" => -1,
		"bopcity" => -1,
		"fnaf" => -1,
		"ikea" => -1,
		"foundation" => -1
	];

	var songTimer:SongTimer;

	#if desktop
	// Discord RPC variables
	var iconRPC:String = "";
	var songLength:Float = 0;
	var detailsText:String = "";
	var detailsPausedText:String = "";
	#end

	override public function create()
	{
		if (FlxG.random.bool(4))
		{
			specialgf = true;
		}
		
		theFunne = SaveManagement.getOption("Input System") == "New";

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		sicks = 0;
		bads = 0;
		shits = 0;
		goods = 0;
		misses = 0;

		// hasDialogue = SONG.hasDialogue;
		isPixel = SONG.isPixel;
		isGood = SONG.isGood;

		#if desktop

		iconRPC = SONG.player2;

		// To avoid having duplicate images in Discord assets
		switch (iconRPC)
		{
			case 'sigmio-evil':
				iconRPC = 'senpai';
			case 'monster-christmas':
				iconRPC = 'monster';
			case 'mom-car':
				iconRPC = 'mom';
		}

		// String that contains the mode defined here so it isn't necessary to call changePresence for each mode
		if (isStoryMode)
		{
			detailsText = "Story Mode: Week " + storyWeek;
		}
		else
		{
			detailsText = "Freeplay";
		}

		// String for when the game is paused
		detailsPausedText = "Paused - " + detailsText;

		// Updating Discord Rich Presence.
		DiscordClient.changePresence(detailsText + " " + SONG.song, "\nAcc: " + truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end

		// var gameCam:FlxCamera = FlxG.camera;
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camOther = new FlxCamera();
		camOther.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camOther);

		FlxCamera.defaultCameras = [camGame];

		songCard = new SongCard();
		add(songCard);
		songCard.cameras = [camHUD];

		persistentUpdate = true;
		persistentDraw = true;

		if (SONG == null)
			SONG = Song.loadFromJson('tutorial');

		// Unlock songs when you play them, aint fucking no one beating unfairness j after other 3 songs
		SaveManagement.unlockSong(SONG.song);

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);


		#if desktop

		hasDialogue = false;

		var files:Array<String> = sys.FileSystem.readDirectory('assets/data/'+SONG.song.toLowerCase().trim());
		var dialogueFiles:Array<String> = [];
		for (i in 0...files.length) {
			if (files.length != 1) {
				if (files[i].endsWith('.txt')) {
					dialogueFiles.push(files[i].replace('.txt', '').trim());
					hasDialogue = true;
				}
			} else {
				hasDialogue = false;
			}
		}			
		if (hasDialogue)
			dialogue = CoolUtil.coolTextFile(Paths.txt(SONG.song.toLowerCase().trim()+'/'+dialogueFiles[FlxG.random.int(0, dialogueFiles.length-1)]));
		#else
		if (hasDialogue)
			dialogue = [
			":bf:GO FUCK YOURSELF",
			":dad:GO FUCK YOURSELF",
			":bf:GO FUCK YOURSELF",
			":dad:GO FUCK YOURSELF",
			":bf:GO FUCK YOURSELF",
			":dad:GO FUCK YOURSELF",
			":bf:FUCK YOURSELF",
			":dad:GO FUCK YOURSELF",
			":bf:FUCK",
			":dad:FUCK",
			":bf:FUCK",
			":dad:GO FUCK YOURSELF",
			":bf:GO FUCK YOURSELF",
			":dad:GO FUCK YOURSELF",
			":bf:GO FUCK YOURSELF",
			":dad:GO FUCK YOURSELF",
			":bf:GO FUCK YOURSELF"
		];
		#end

		defaultCamZoom = 1.05;
		
		switch(SONG.stage) {
		case "spooky":
			curStage = "spooky";

			var hallowTex = Paths.getSparrowAtlas('stages/spooky/halloween_bg');

			halloweenBG = new FlxSprite(-200, -100);
			halloweenBG.frames = hallowTex;
			halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
			halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
			halloweenBG.animation.play('idle');
			halloweenBG.antialiasing = true;
			add(halloweenBG);

			isHalloween = true;
		case "philly":
			curStage = 'philly';

			var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('stages/philly/sky'));
			bg.scrollFactor.set(0.1, 0.1);
			add(bg);

			var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('stages/philly/city'));
			city.scrollFactor.set(0.3, 0.3);
			city.setGraphicSize(Std.int(city.width * 0.85));
			city.updateHitbox();
			add(city);

			phillyCityLights = new FlxTypedGroup<FlxSprite>();
			add(phillyCityLights);

			for (i in 0...5)
			{
				var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('stages/philly/win' + i));
				light.scrollFactor.set(0.3, 0.3);
				light.visible = false;
				light.setGraphicSize(Std.int(light.width * 0.85));
				light.updateHitbox();
				light.antialiasing = true;
				phillyCityLights.add(light);
			}

			var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('stages/philly/behindTrain'));
			add(streetBehind);

			phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('stages/philly/train'));
			add(phillyTrain);

			trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
			FlxG.sound.list.add(trainSound);

			// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

			var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('stages/philly/street'));
			add(street);
		case "limo":
			curStage = 'limo';
			defaultCamZoom = 0.90;

			var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('stages/limo/limoSunset'));
			skyBG.scrollFactor.set(0.1, 0.1);
			add(skyBG);

			var bgLimo:FlxSprite = new FlxSprite(-200, 480);
			bgLimo.frames = Paths.getSparrowAtlas('stages/limo/bgLimo');
			bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
			bgLimo.animation.play('drive');
			bgLimo.scrollFactor.set(0.4, 0.4);
			add(bgLimo);

			grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
			add(grpLimoDancers);

			for (i in 0...5)
			{
				var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
				dancer.scrollFactor.set(0.4, 0.4);
				grpLimoDancers.add(dancer);
			}

			var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('stages/limo/limoOverlay'));
			overlayShit.alpha = 0.5;
			// add(overlayShit);

			// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

			// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

			// overlayShit.shader = shaderBullshit;

			var limoTex = Paths.getSparrowAtlas('stages/limo/limoDrive');

			limo = new FlxSprite(-120, 550);
			limo.frames = limoTex;
			limo.animation.addByPrefix('drive', "Limo stage", 24);
			limo.animation.play('drive');
			limo.antialiasing = true;

			fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('stages/limo/fastCarLol'));
			// add(limo);
		case "limonormal":
			curStage = 'limonormal';
			defaultCamZoom = 0.90;

			var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('stages/limo/limoSunset'));
			skyBG.scrollFactor.set(0.1, 0.1);
			add(skyBG);

			var bgLimo:FlxSprite = new FlxSprite(-200, 480);
			bgLimo.frames = Paths.getSparrowAtlas('stages/limo/bgLimo');
			bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
			bgLimo.animation.play('drive');
			bgLimo.scrollFactor.set(0.4, 0.4);
			add(bgLimo);

			grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
			add(grpLimoDancers);

			for (i in 0...5)
			{
				var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
				dancer.scrollFactor.set(0.4, 0.4);
				grpLimoDancers.add(dancer);
			}

			var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('stages/limo/limoOverlay'));
			overlayShit.alpha = 0.5;
			// add(overlayShit);

			// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);

			// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);

			// overlayShit.shader = shaderBullshit;

			var limoTex = Paths.getSparrowAtlas('stages/limo/limoDrivenormal');

			limo = new FlxSprite(-120, 550);
			limo.frames = limoTex;
			limo.animation.addByPrefix('drive', "Limo stage", 24);
			limo.animation.play('drive');
			limo.antialiasing = true;

			fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('stages/limo/fastCarLol'));
			// add(limo);
		case "mall":
			curStage = 'mall';

			defaultCamZoom = 0.80;

			var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('stages/christmas/bgWalls'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);

			upperBoppers = new FlxSprite(-240, -90);
			upperBoppers.frames = Paths.getSparrowAtlas('stages/christmas/upperBop');
			upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
			upperBoppers.antialiasing = true;
			upperBoppers.scrollFactor.set(0.33, 0.33);
			upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
			upperBoppers.updateHitbox();
			add(upperBoppers);

			var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('stages/christmas/bgEscalator'));
			bgEscalator.antialiasing = true;
			bgEscalator.scrollFactor.set(0.3, 0.3);
			bgEscalator.active = false;
			bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
			bgEscalator.updateHitbox();
			add(bgEscalator);

			var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('stages/christmas/christmasTree'));
			tree.antialiasing = true;
			tree.scrollFactor.set(0.40, 0.40);
			add(tree);

			bottomBoppers = new FlxSprite(-300, 140);
			bottomBoppers.frames = Paths.getSparrowAtlas('stages/christmas/bottomBop');
			bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
			bottomBoppers.antialiasing = true;
			bottomBoppers.scrollFactor.set(0.9, 0.9);
			bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
			bottomBoppers.updateHitbox();
			add(bottomBoppers);

			var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('stages/christmas/fgSnow'));
			fgSnow.active = false;
			fgSnow.antialiasing = true;
			add(fgSnow);

			santa = new FlxSprite(-840, 150);
			santa.frames = Paths.getSparrowAtlas('stages/christmas/santa');
			santa.animation.addByPrefix('idle', 'santa idle in fear', 24, true);
			santa.animation.addByPrefix('DIE', 'santa DIE', 2, false);
			santa.antialiasing = true;
			add(santa);
			santa.animation.play('idle', true);
		case "mallsuspicious":
			curStage = 'mallsuspicious';

			defaultCamZoom = 0.80;

			var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('stages/christmas/bgWalls'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);
			
			upperBoppers = new FlxSprite(-240, -90);
			upperBoppers.frames = Paths.getSparrowAtlas('stages/christmas/upperBop');
			upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
			upperBoppers.antialiasing = true;
			upperBoppers.scrollFactor.set(0.33, 0.33);
			upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
			upperBoppers.updateHitbox();
			
			whatthe = new FlxSprite(-240, -90).loadGraphic(Paths.image('stages/christmas/what'));
			whatthe.antialiasing = true;
			whatthe.scrollFactor.set(0.33, 0.33);
			whatthe.setGraphicSize(Std.int(whatthe.width * 0.85));
			whatthe.updateHitbox();
			
			add(whatthe);
			add(upperBoppers);
			
			var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('stages/christmas/bgEscalator'));
			bgEscalator.antialiasing = true;
			bgEscalator.scrollFactor.set(0.3, 0.3);
			bgEscalator.active = false;
			bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
			bgEscalator.updateHitbox();
			add(bgEscalator);

			var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('stages/christmas/christmasTree'));
			tree.antialiasing = true;
			tree.scrollFactor.set(0.40, 0.40);
			add(tree);

			bottomBoppers = new FlxSprite(-300, 140);
			bottomBoppers.frames = Paths.getSparrowAtlas('stages/christmas/bottomBop');
			bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
			bottomBoppers.antialiasing = true;
			bottomBoppers.scrollFactor.set(0.9, 0.9);
			bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
			bottomBoppers.updateHitbox();
			add(bottomBoppers);

			var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('stages/christmas/fgSnow'));
			fgSnow.active = false;
			fgSnow.antialiasing = true;
			add(fgSnow);

			santa = new FlxSprite(-840, 150);
			santa.frames = Paths.getSparrowAtlas('stages/christmas/santa');
			santa.animation.addByPrefix('idle', 'santa idle in fear', 24, true);
			santa.animation.addByPrefix('DIE', 'santa DIE', 2, false);
			santa.antialiasing = true;
			add(santa);
			santa.animation.play('idle', true);
		case "mallEvil":
			curStage = 'mallEvil';
			var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('stages/christmas/evilBG'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.2, 0.2);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 0.8));
			bg.updateHitbox();
			add(bg);

			var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('stages/christmas/evilTree'));
			evilTree.antialiasing = true;
			evilTree.scrollFactor.set(0.2, 0.2);
			add(evilTree);

			var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("stages/christmas/evilSnow"));
			evilSnow.antialiasing = true;
			add(evilSnow);
		case "school":
			curStage = 'school';

			// defaultCamZoom = 0.9;

			var bgSky = new FlxSprite().loadGraphic(Paths.image('stages/weeb/weebSky'));
			bgSky.scrollFactor.set(0.1, 0.1);
			add(bgSky);

			var repositionShit = -200;

			var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('stages/weeb/weebSchool'));
			bgSchool.scrollFactor.set(0.6, 0.90);
			add(bgSchool);

			var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('stages/weeb/weebStreet'));
			bgStreet.scrollFactor.set(0.95, 0.95);
			add(bgStreet);

			var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('stages/weeb/weebTreesBack'));
			fgTrees.scrollFactor.set(0.9, 0.9);
			add(fgTrees);

			var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
			var treetex = Paths.getPackerAtlas('stages/weeb/weebTrees');
			bgTrees.frames = treetex;
			bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
			bgTrees.animation.play('treeLoop');
			bgTrees.scrollFactor.set(0.85, 0.85);
			add(bgTrees);

			var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
			treeLeaves.frames = Paths.getSparrowAtlas('stages/weeb/petals');
			treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
			treeLeaves.animation.play('leaves');
			treeLeaves.scrollFactor.set(0.85, 0.85);
			add(treeLeaves);

			var widShit = Std.int(bgSky.width * 6);

			bgSky.setGraphicSize(widShit);
			bgSchool.setGraphicSize(widShit);
			bgStreet.setGraphicSize(widShit);
			bgTrees.setGraphicSize(Std.int(widShit * 1.4));
			fgTrees.setGraphicSize(Std.int(widShit * 0.8));
			treeLeaves.setGraphicSize(widShit);

			fgTrees.updateHitbox();
			bgSky.updateHitbox();
			bgSchool.updateHitbox();
			bgStreet.updateHitbox();
			bgTrees.updateHitbox();
			treeLeaves.updateHitbox();

			bgGirls = new BackgroundGirls(-100, 190);
			bgGirls.scrollFactor.set(0.9, 0.9);

			if (SONG.song.toLowerCase() == 'roses')
			{
				bgGirls.getScared();
			}

			bgGirls.setGraphicSize(Std.int(bgGirls.width * daPixelZoom));
			bgGirls.updateHitbox();
			add(bgGirls);
		case "schoolEvil":
			curStage = 'schoolEvil';

			var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
			var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);

			var posX = 400;
			var posY = 200;

			var bg:FlxSprite = new FlxSprite(posX, posY);
			bg.frames = Paths.getSparrowAtlas('stages/weeb/animatedEvilSchool');
			bg.animation.addByPrefix('idle', 'background 2', 24);
			bg.animation.play('idle');
			bg.scrollFactor.set(0.8, 0.9);
			bg.scale.set(6, 6);
			add(bg);
		case "ikea":
			curStage = 'ikea';
			// Code completely stolen from https://github.com/silkycell/DNB-Background-Generator
			unfairjShader = new GlitchEffect();
			unfairjShader.waveAmplitude = 0.1;
			unfairjShader.waveFrequency = 5;
			unfairjShader.waveSpeed = 1;

			unfairJbg = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/ikea/jo'));
			unfairJbg.antialiasing = false;
			unfairJbg.shader = unfairjShader.shader;
			unfairJbg.scrollFactor.set(0.9, 0.9);
			unfairJbg.alpha = 0;
			add(unfairJbg);
			
			thornbg = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/ikea/thorn'));
			thornbg.antialiasing = false;
			thornbg.alpha = 1;
			add(thornbg);
		case "exe":
			curStage = 'exe';

			var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/exe/exeback'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);

			var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stages/exe/exefront'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
			stageFront.updateHitbox();
			stageFront.antialiasing = true;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);
		case "among":
			curStage = 'among';

			var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/among/amongback'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);

			var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stages/among/amongfront'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
			stageFront.updateHitbox();
			stageFront.antialiasing = true;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);
		case "bopcity":
			curStage = 'bopcity';

			var bg:FlxSprite = new FlxSprite(-600, -400).loadGraphic(Paths.image('stages/bopcity/bopback'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);

			var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stages/bopcity/bopfront'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
			stageFront.updateHitbox();
			stageFront.antialiasing = true;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);
			
			defaultCamZoom = 0.80;
			
			explosion = new FlxSprite( -200, 300);
			explosion.frames = Paths.getSparrowAtlas('stages/bopcity/explosion');
			explosion.animation.addByPrefix('idle', 'settle', 24, true);
			explosion.animation.addByPrefix('boom', 'boom', 30, false);
			explosion.updateHitbox();
			explosion.antialiasing = false;
			explosion.scale.set(2,2.4);
			explosion.cameras = [camHUD];
			add(explosion);
			explosion.animation.play('idle', true);
			
			fortnitecard = new FlxSprite( -650, 600).loadGraphic(Paths.image('stages/bopcity/card'));
			
			fortnitecard.cameras = [camHUD];
			fortnitecard.screenCenter();
			fortnitecard.updateHitbox();
			fortnitecard.alpha = 0;
			add(fortnitecard);
		case "fnaf":
			curStage = 'fnaf';

			defaultCamZoom = 0.9;
			var bg:FlxSprite = new FlxSprite(-300, 200).loadGraphic(Paths.image('stages/fnaf/celebratebgv3'));
			bg.setGraphicSize(Std.int(bg.width * 10), Std.int(bg.height*5));
			bg.antialiasing = false;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);
		case "foundation":
			defaultCamZoom = 0.9;
			curStage = 'foundation';

			var bg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/foundation/bg'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			bg.setGraphicSize(Std.int(bg.width * 1.5));
			bg.updateHitbox();
			add(bg);
		default:
			defaultCamZoom = 0.9;
			curStage = 'stage';
			var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/stage/stageback'));
			bg.antialiasing = true;
			bg.scrollFactor.set(0.9, 0.9);
			bg.active = false;
			add(bg);

			var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stages/stage/stagefront'));
			stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
			stageFront.updateHitbox();
			stageFront.antialiasing = true;
			stageFront.scrollFactor.set(0.9, 0.9);
			stageFront.active = false;
			add(stageFront);

			var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stages/stage/stagecurtains'));
			stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
			stageCurtains.updateHitbox();
			stageCurtains.antialiasing = true;
			stageCurtains.scrollFactor.set(1.3, 1.3);
			stageCurtains.active = false;

			add(stageCurtains);
		}

		var gfVersion:String = 'gf';

		if (specialgf == false || SONG.song.toLowerCase() == 'tutorial' || SONG.song.toLowerCase() == 'senpai' || SONG.song.toLowerCase() == 'roses' || SONG.song.toLowerCase() == 'thorns')
		{
			switch (curStage)
			{
				case 'limo' | 'limonormal':
					gfVersion = 'gf-car';
				case 'mall' | 'mallEvil' | 'mallsuspicious':
					gfVersion = 'gf-christmas';
				case 'school' | 'fnaf':
					gfVersion = 'gf-pixelgroove';
				case 'schoolEvil':
					gfVersion = 'gf-pixel';
				case 'foundation':
					gfVersion = 'vyst-gf';
					
			}
			if (curStage == 'limo')
				gfVersion = 'gf-car';
		}
		else
		{
			gfVersion = 'gogfgo';
		}

		

		gf = new Character(400, 130, gfVersion);
		gf.scrollFactor.set(0.95, 0.95);

		dad = new Character(100, 100, SONG.player2);

		boyfriend = new Boyfriend(770, 450, SONG.player1);

		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

		switch (SONG.player2)
		{
			case 'gf':
				dad.setPosition(gf.x, gf.y);
				gf.visible = false;
				if (isStoryMode)
				{
					camPos.x += 600;
					tweenCamIn();
				}
			case 'ogbf-pixel':
				dad.y += 400;
				dad.x -= 300;
			case "spooky":
				dad.y += 200;
			case "monster":
				dad.y += 100;
			case 'monster-christmas':
				dad.y += 250;
				dad.x += 170;
			case 'dad':
				camPos.x += 400;
			case 'pico':
				camPos.x += 600;
				dad.y += 300;
			case 'parents-christmas':
				dad.x -= 500;
			case 'sigmio':
				dad.y += 250;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'sigmio-evil':
				dad.y += 250;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'spirit':
				dad.x -= 150;
				dad.y += 100;
				camPos.set(dad.getGraphicMidpoint().x + 300, dad.getGraphicMidpoint().y);
			case 'sonicexe':
				dad.x += 100;
				dad.y += 330;
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y - 200);
			case 'blocku':
				dad.y += 150;
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y - 200);
			case 'niceblocku':
				dad.y += 150;
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y - 200);
			case 'evilblocku':
				dad.y += 150;
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y - 200);
			case 'bean':
				dad.y += 300;
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y - 200);
			case 'sigmio-final':
				dad.x -= 450;
				dad.y -= 100;
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y - 200);
			case 'spiritfakeout':
				dad.x -= 450;
				dad.y -= 100;
				camPos.set(dad.getGraphicMidpoint().x + 200, dad.getGraphicMidpoint().y - 200);
			case 'scopguy':
				camPos.y + 500;
		}
		

		// REPOSITIONING PER STAGE
		switch (curStage)
		{
			case 'limo':
				boyfriend.y -= 220;
				boyfriend.x += 260;

				resetFastCar();
				add(fastCar);
			case 'limonormal':
				boyfriend.y -= 220;
				boyfriend.x += 260;

				resetFastCar();
				add(fastCar);


			case 'mall':
				boyfriend.x += 200;

			case 'mallEvil':
				boyfriend.x += 320;
				dad.y -= 80;
			case 'school':
				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'schoolEvil':
				// trailArea.scrollFactor.set();

				evilTrail = new FlxTrail(dad, null, 4, 24, 0.3, 0.069);
				// evilTrail.changeValuesEnabled(false, false, false, false);
				// evilTrail.changeGraphic()
				add(evilTrail);
				// evilTrail.scrollFactor.set(1.1, 1.1);

				boyfriend.x += 200;
				boyfriend.y += 220;
				gf.x += 180;
				gf.y += 300;
			case 'bopcity':
				gf.visible = false;
			case 'ikea':
				// evilTrail = new FlxTrail(dad, null, 3, 24, 0.3, 0.05);
				// add(evilTrail);

				gf.visible = false;
				boyfriend.x += 150;
			case 'foundation':
				boyfriend.x += 200;
				boyfriend.y += 100;

				dad.x += 200;
				dad.y += 100;

				gf.x += 200;
				gf.y += 100;
		}
		
		switch (SONG.player1)
		{
			case 'Nugget':
				boyfriend.y -= 200;
			case 'nuggetdance':
				boyfriend.y -= 300;
		}

		add(gf);

		// Shitty layering but whatev it works LOL
		if (curStage == 'limo' || curStage == 'limonormal')
			add(limo);
		

		add(dad);

		if (SONG.player2 == 'pico') { // PISSY
			shootSound = new FlxSound().loadEmbedded(Paths.sound('shoot'));
			shootSound.autoDestroy = false;

			picoShoot = new FlxSprite(dad.x+30, (dad.y/2)-30);
			picoShoot.frames = Paths.getSparrowAtlas('characters/pico/Pico_Shooting');
			picoShoot.animation.addByPrefix('shoot', "Pico Shoot Hip Full");
			picoShoot.flipX = true;
			add(picoShoot);

			picoShoot.visible = false;
		}

		add(boyfriend);

		stupidFuckingSpotlight1 = new FlxSprite(boyfriend.x, -50).loadGraphic(Paths.image('stages/stage/spotlight'));
		stupidFuckingSpotlight2 = new FlxSprite(dad.x, -50).loadGraphic(Paths.image('stages/stage/spotlight'));

		stupidFuckingSpotlight1.visible = false;
		stupidFuckingSpotlight2.visible = false;

		add(stupidFuckingSpotlight1);
		add(stupidFuckingSpotlight2);

		var doof:DialogueBox = new DialogueBox(false, dialogue);
		// doof.x += 70;
		// doof.y = FlxG.height * 0.5;
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;

		Conductor.songPosition = -5000;

		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();

		if (SaveManagement.getOption("Scroll Direction") == "Down")
			strumLine.y = FlxG.height - 165;

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		add(strumLineNotes);

		playerStrums = new FlxTypedGroup<FlxSprite>();

		// startCountdown();

		generateSong(SONG.song);

		// add(strumLine);

		camFollow = new FlxObject(0, 0, 1, 1);

		camFollow.setPosition(camPos.x, camPos.y);

		if (prevCamFollow != null)
		{
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}

		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.04);
		// FlxG.camera.setScrollBounds(0, FlxG.width, 0, FlxG.height);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());

		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);

		FlxG.fixedTimestep = false;
		
		var healthBarY;
		if (SaveManagement.getOption("Scroll Direction") == "Down")
			healthBarY = 75;
		else
			healthBarY = Std.int(FlxG.height * 0.9);

		if (curSong == "Thorns" || isGood)
			healthBarBG = new FlxSprite(0, healthBarY).loadGraphic(Paths.image('ui/ui/good/healthBar-good'));
		else
			healthBarBG = new FlxSprite(0, healthBarY).loadGraphic(Paths.image('ui/ui/healthBar'));
		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
			'health', 0, 2);
		healthBar.scrollFactor.set();
		healthBar.createFilledBar(0xFFFF0000, 0xFF66FF33);
		// healthBar
		add(healthBar);

		var scoreFont = PlayState.SONG.song.toLowerCase() == "thorns" || isGood ? "vcr.ttf" : SaveManagement.getOption("Freaky Mode") == "On" ? "papyrus.ttf" : "vcr.ttf";
		var scoreFontSize = PlayState.SONG.song.toLowerCase() == "thorns" || isGood ? 20 : SaveManagement.getOption("Freaky Mode") == "On" ? 28 : 20;
		var scorePosOffsetX = PlayState.SONG.song.toLowerCase() == "thorns" || isGood ? 150 : SaveManagement.getOption("Freaky Mode") == "On" ? 600 : 375;
		var scorePosOffsetY = PlayState.SONG.song.toLowerCase() == "thorns" || isGood ? 50 : SaveManagement.getOption("Freaky Mode") == "On" ? 30 : 50;

		// Add Kade Engine watermark
		var kadeEngineWatermark = new FlxText(4,FlxG.height - 4,0,SONG.song + " - CE " + MainMenuState.cinemaEngineVer, 16);
		kadeEngineWatermark.setFormat(Paths.font(scoreFont), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		kadeEngineWatermark.scrollFactor.set();
		add(kadeEngineWatermark);

		scoreTxt = new FlxText(healthBarBG.x + healthBarBG.width / 2 - scorePosOffsetX, healthBarBG.y + scorePosOffsetY, 0, "", scoreFontSize);
		scoreTxt.setFormat(Paths.font(scoreFont), scoreFontSize, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE,FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		add(scoreTxt);

		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);

		songTimer = new SongTimer(0);
		songTimer.cameras = [camHUD];

		if (SONG.song.toLowerCase() == 'thorns')
			songTimer.visible = false;

		add(songTimer);

		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		healthBar.cameras = [camHUD];
		healthBarBG.cameras = [camHUD];
		iconP1.cameras = [camHUD];
		iconP2.cameras = [camHUD];
		scoreTxt.cameras = [camHUD];
		doof.cameras = [camHUD];

		// if (SONG.song == 'South')
		// FlxG.camera.alpha = 0.7;
		// UI_camera.zoom = 1;

		// cameras = [FlxG.cameras.list[1]];
		startingSong = true;

		// THORNS SPECIFIC FPS LOCK
		if (curSong.toLowerCase() == 'thorns')
			FlxG.drawFramerate = 60;

		if (isStoryMode)
		{
			switch (curSong.toLowerCase())
			{
				case "high":
					dad.y -= 1000;
					FlxTween.tween(dad, {y: dad.y + 1000}, 1, {ease: FlxEase.quadOut});
					new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						startDialogue(doof);
					});
				case "winter-horrorland":
					if (FlxG.save.data.frostedonespotted == false) { FlxG.save.data.frostedonespotted = true; }
					var frosted:FlxSprite = new FlxSprite().loadGraphic(Paths.image('thefrostedoneishere'));
					add(frosted);
					frosted.scrollFactor.set();
					frosted.cameras = [camOther];
					camHUD.visible = false;

					new FlxTimer().start(4, function(tmr:FlxTimer)
					{
						remove(frosted);
						camHUD.visible = true;
						startDialogue(doof);
					});
				case 'senpai':
					schoolIntro(doof);
				case 'roses':
					FlxG.sound.play(Paths.sound('ANGRY'));
					schoolIntro(doof);
				case 'thorns':
					schoolIntro(doof);
				default:
					if (!hasDialogue)
						startCountdown();
					else
						startDialogue(doof);
			}
		}
		else
		{
			switch (curSong.toLowerCase())
			{
				default:
					startCountdown();
			}
		}
		
		blackShitJ = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		whiteShitJ = new FlxSprite( -1280, -720).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
		whiteShitJ.alpha = 0;
		add(whiteShitJ);

		super.create();
	}

	function startDialogue(?dialogueBox:DialogueBox):Void {
		if (dialogueBox != null) {
			new FlxTimer().start(0.3, function(tmr:FlxTimer){
				inCutscene = true;

				add(dialogueBox);
			});
		}
		else
			startCountdown();
	}

	function schoolIntro(?dialogueBox:DialogueBox):Void
	{
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		add(black);

		var red:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xFFff1b31);
		red.scrollFactor.set();

		var senpaiEvil:FlxSprite = new FlxSprite();
		senpaiEvil.frames = Paths.getSparrowAtlas('cutscenes/weeb/sigmiofuckingdying');
		senpaiEvil.animation.addByPrefix('dewaeth', 'sigmiofuckingdying dewaeth', 24, false);
		// senpaiEvil.setGraphicSize(Std.int(senpaiEvil.width * 6));
		senpaiEvil.scrollFactor.set();
		senpaiEvil.updateHitbox();
		senpaiEvil.screenCenter();

		if (SONG.song.toLowerCase() == 'roses' || SONG.song.toLowerCase() == 'thorns')
		{
			remove(black);

			if (SONG.song.toLowerCase() == 'thorns')
			{
				add(red);
			}
		}

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			black.alpha -= 0.15;

			if (black.alpha > 0)
			{
				tmr.reset(0.3);
			}
			else
			{
				if (dialogueBox != null)
				{
					inCutscene = true;

					if (SONG.song.toLowerCase() == 'thorns')
					{
						add(senpaiEvil);
						senpaiEvil.alpha = 0;
						new FlxTimer().start(0.3, function(swagTimer:FlxTimer)
						{
							senpaiEvil.alpha += 0.15;
							if (senpaiEvil.alpha < 1)
							{
								swagTimer.reset();
							}
							else
							{
								senpaiEvil.animation.play('dewaeth');
								FlxG.sound.play(Paths.sound('Senpai_Dies'), 1, false, null, true, function()
								{
									remove(senpaiEvil);
									remove(red);
									FlxG.camera.fade(FlxColor.WHITE, 0.01, true, function()
									{
										add(dialogueBox);
									}, true);
								});
								new FlxTimer().start(3.2, function(deadTime:FlxTimer)
								{
									FlxG.camera.fade(FlxColor.WHITE, 1.6, false);
								});
							}
						});
					}
					else
					{
						add(dialogueBox);
					}
				}
				else
					startCountdown();

				remove(black);
			}
		});
	}

	var startTimer:FlxTimer;
	var perfectMode:Bool = false;

	function startCountdown():Void
	{
		inCutscene = false;

		generateStaticArrows(0);
		generateStaticArrows(1);

		talking = false;
		startedCountdown = true;
		Conductor.songPosition = 0;
		Conductor.songPosition -= Conductor.crochet * 5;

		var swagCounter:Int = 0;

		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
		{
			dad.dance();
			gf.dance();
			boyfriend.playAnim('idle');

			var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
			introAssets.set('default', ['ui/ui/ready', "ui/ui/set", "ui/ui/go"]);
			introAssets.set('good', ['ui/ui/good/ready-good', "ui/ui/good/set-good", "ui/ui/good/go-good"]);
			introAssets.set('school', [
				'stages/weeb/pixelUI/ready-pixel',
				'stages/weeb/pixelUI/set-pixel',
				'stages/weeb/pixelUI/date-pixel'
			]);
			introAssets.set('schoolEvil', [
				'stages/weeb/pixelUI/ready-pixel-good',
				'stages/weeb/pixelUI/set-pixel-good',
				'stages/weeb/pixelUI/date-pixel-good'
			]);

			var introAlts:Array<String> = introAssets.get('default');
			var altSuffix:String = "";

			if (isGood)
				introAlts = introAssets.get('good');
				altSuffix = '-good';

			for (value in introAssets.keys())
			{
				if (value == curStage || isPixel)
				{
					introAlts = introAssets.get(value);
					altSuffix = '-pixel';
					if (isGood)
						introAlts = introAssets.get('schoolEvil');
						altSuffix = '-pixel-good';
				}
			}

			switch (swagCounter)

			{
				case 0:
					FlxG.sound.play(Paths.sound('intro3'), 0.6);
				case 1:
					var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
					ready.scrollFactor.set();
					ready.updateHitbox();

					if (curStage.startsWith('school') || isPixel)
						ready.setGraphicSize(Std.int(ready.width * daPixelZoom));

					ready.screenCenter();
					add(ready);
					FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							ready.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro2'), 0.6);
				case 2:
					var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
					set.scrollFactor.set();

					if (curStage.startsWith('school') || isPixel)
						set.setGraphicSize(Std.int(set.width * daPixelZoom));

					set.screenCenter();
					add(set);
					FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							set.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('intro1'), 0.6);
				case 3:
					var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
					go.scrollFactor.set();

					if (curStage.startsWith('school') || isPixel)
						go.setGraphicSize(Std.int(go.width * daPixelZoom));

					go.updateHitbox();

					go.screenCenter();
					add(go);
					FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
						ease: FlxEase.cubeInOut,
						onComplete: function(twn:FlxTween)
						{
							go.destroy();
						}
					});
					FlxG.sound.play(Paths.sound('introGo'), 0.6);
				case 4:
			}

			swagCounter += 1;
			// generateSong('fresh');
		}, 5);
	}

	var previousFrameTime:Int = 0;
	var lastReportedPlayheadPosition:Int = 0;
	var songTime:Float = 0;

	function startSong():Void
	{
		startingSong = false;

		previousFrameTime = FlxG.game.ticks;
		lastReportedPlayheadPosition = 0;

		FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 1, false);
		vocals.play();

		if (paused) {
			FlxG.sound.music.pause();
			vocals.pause();
		}
		FlxG.sound.music.onComplete = endSong;

		songCard.show();
		
		new FlxTimer().start(4, (timer:FlxTimer) -> {
            songCard.hide();
        });

		#if desktop
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		if (SONG.song != 'unfairness-jside')
			songTimer.endTime = Math.round(songLength/1000);
		else 
			songTimer.endTime = 69;
		songTimer.updateDisplay();

		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song, "\nAcc: " + truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	var debugNum:Int = 0;

	private function generateSong(dataPath:String):Void
	{
		// FlxG.log.add(ChartParser.parse());

		var songData = SONG;
		Conductor.changeBPM(songData.bpm);

		curSong = songData.song;

		if (SONG.needsVoices)
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
		else
			vocals = new FlxSound();

		FlxG.sound.list.add(vocals);

		notes = new FlxTypedGroup<Note>();
		add(notes);

		var noteData:Array<SwagSection>;

		// NEW SHIT
		noteData = songData.notes;

		var playerCounter:Int = 0;

		var daBeats:Int = 0; // Not exactly representative of 'daBeats' lol, just how much it has looped
		for (section in noteData)
		{
			var coolSection:Int = Std.int(section.lengthInSteps / 4);

			for (songNotes in section.sectionNotes)
			{
				var daStrumTime:Float = songNotes[0];
				var daNoteData:Int = Std.int(songNotes[1] % 4);
				var noteType = songNotes[3];
				var noteTypeParam = songNotes[4];

				var gottaHitNote:Bool = section.mustHitSection;

				if (songNotes[1] > 3)
				{
					gottaHitNote = !section.mustHitSection;
				}

				var oldNote:Note;
				if (unspawnNotes.length > 0)
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else
					oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, noteType, noteTypeParam);
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;

				susLength = susLength / Conductor.stepCrochet;
				unspawnNotes.push(swagNote);

				for (susNote in 0...Math.floor(susLength))
				{
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];

					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, noteType, noteTypeParam);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);

					sustainNote.mustPress = gottaHitNote;

					if (sustainNote.mustPress)
					{
						sustainNote.x += FlxG.width / 2; // general offset
					}
				}

				swagNote.mustPress = gottaHitNote;

				if (swagNote.mustPress)
				{
					swagNote.x += FlxG.width / 2; // general offset
				}
				else
				{
				}
			}
			daBeats += 1;
		}

		// trace(unspawnNotes.length);
		// playerCounter += 1;

		unspawnNotes.sort(sortByShit);

		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	}

	private function generateStaticArrows(player:Int):Void
	{
		for (i in 0...4)
		{
			// FlxG.log.add(i);
			var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);

			if (curStage == 'school' || curStage == 'schoolEvil' || isPixel) {
				if (curSong == "Thorns" || isGood)
					babyArrow.loadGraphic(Paths.image('stages/weeb/pixelUI/arrows-pixels-good'), true, 17, 17);
				else
					babyArrow.loadGraphic(Paths.image('stages/weeb/pixelUI/arrows-pixels'), true, 17, 17);
				babyArrow.animation.add('green', [6]);
				babyArrow.animation.add('red', [7]);
				babyArrow.animation.add('blue', [5]);
				babyArrow.animation.add('purplel', [4]);

				babyArrow.setGraphicSize(Std.int(babyArrow.width * daPixelZoom));
				babyArrow.updateHitbox();
				babyArrow.antialiasing = false;

				switch (Math.abs(i))
				{
					case 0:
						babyArrow.x += Note.swagWidth * 0;
						babyArrow.animation.add('static', [0]);
						babyArrow.animation.add('pressed', [4, 8], 12, false);
						babyArrow.animation.add('confirm', [12, 16], 24, false);
					case 1:
						babyArrow.x += Note.swagWidth * 1;
						babyArrow.animation.add('static', [1]);
						babyArrow.animation.add('pressed', [5, 9], 12, false);
						babyArrow.animation.add('confirm', [13, 17], 24, false);
					case 2:
						babyArrow.x += Note.swagWidth * 2;
						babyArrow.animation.add('static', [2]);
						babyArrow.animation.add('pressed', [6, 10], 12, false);
						babyArrow.animation.add('confirm', [14, 18], 12, false);
					case 3:
						babyArrow.x += Note.swagWidth * 3;
						babyArrow.animation.add('static', [3]);
						babyArrow.animation.add('pressed', [7, 11], 12, false);
						babyArrow.animation.add('confirm', [15, 19], 24, false);
				}
			} else {
				if (isGood)
					babyArrow.frames = Paths.getSparrowAtlas('ui/ui/goodNOTE_assets-good');
				else
					babyArrow.frames = Paths.getSparrowAtlas('ui/ui/NOTE_assets');
				babyArrow.animation.addByPrefix('green', 'arrowUP');
				babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
				babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
				babyArrow.animation.addByPrefix('red', 'arrowRIGHT');

				babyArrow.antialiasing = true;
				babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

				switch (Math.abs(i))
				{
					case 0:
						babyArrow.x += Note.swagWidth * 0;
						babyArrow.animation.addByPrefix('static', 'arrowLEFT');
						babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
					case 1:
						babyArrow.x += Note.swagWidth * 1;
						babyArrow.animation.addByPrefix('static', 'arrowDOWN');
						babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
					case 2:
						babyArrow.x += Note.swagWidth * 2;
						babyArrow.animation.addByPrefix('static', 'arrowUP');
						babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
					case 3:
						babyArrow.x += Note.swagWidth * 3;
						babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
						babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
						babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
				}
			}
			

			babyArrow.updateHitbox();
			babyArrow.scrollFactor.set();

			if (!isStoryMode)
			{
				babyArrow.y -= 10;
				babyArrow.alpha = 0;
				FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: 1}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			}

			babyArrow.ID = i;

			if (player == 1)
			{
				playerStrums.add(babyArrow);
			}

			babyArrow.animation.play('static');
			babyArrow.x += 50;
			babyArrow.x += ((FlxG.width / 2) * player);

			strumLineNotes.add(babyArrow);
		}
	}

	function tweenCamIn():Void
	{
		FlxTween.tween(FlxG.camera, {zoom: 1.3}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
	}

	override function openSubState(SubState:FlxSubState)
	{
		if (paused)
		{
			if (FlxG.sound.music != null)
			{
				FlxG.sound.music.pause();
				vocals.pause();
			}

			#if desktop
			DiscordClient.changePresence("PAUSED on " + SONG.song, "Acc: " + truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end

			if (!startTimer.finished)
				startTimer.active = false;
		}

		super.openSubState(SubState);
	}

	override function closeSubState()
	{
		if (paused)
		{
			if (FlxG.sound.music != null && !startingSong)
			{
				resyncVocals();
			}

			if (!startTimer.finished)
				startTimer.active = true;
			paused = false;
			
			#if desktop
			if (startTimer.finished)
			{
				DiscordClient.changePresence(detailsText + " " + SONG.song, "\nAcc: " + truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses, iconRPC, true, songLength - Conductor.songPosition);
			}
			else
			{
				DiscordClient.changePresence(detailsText, SONG.song, iconRPC);
			}
			#end
		}

		super.closeSubState();
	}

	function resyncVocals():Void
	{
		vocals.pause();

		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();

		#if desktop
		DiscordClient.changePresence(detailsText + " " + SONG.song, "\nAcc: " + truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
		#end
	}

	private var paused:Bool = false;
	var startedCountdown:Bool = false;
	var canPause:Bool = true;

	function truncateFloat( number : Float, precision : Int): Float {
		var num = number;
		num = num * Math.pow(10, precision);
		num = Math.round( num ) / Math.pow(10, precision);
		return num;
		}

	override public function update(elapsed:Float)
	{
		#if !debug
		perfectMode = false;
		#end

		if (unfairjShader != null)
			unfairjShader.update(elapsed);
		
		if (FlxG.keys.justPressed.NINE)
		{
			if (iconP1.animation.curAnim.name == 'bf-old')
				iconP1.animation.play(SONG.player1);
			else
				iconP1.animation.play('bf-old');
		}

		switch (curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}
				// phillyCityLights.members[curLight].alpha -= (Conductor.crochet / 1000) * FlxG.elapsed;
		}

		super.update(elapsed);
		if (songScore == 0)
			accDisplay = "boowomp";
		else if (accuracy == 100 && fc)
			accDisplay = "PFC";
		else if (misses == 0 && shits == 0 && bads == 0 && fc)
			accDisplay = "Good FC";
		else if (accuracy >= 99)
			accDisplay = "Not an FC smh";
		else if (accuracy >= 95)
			accDisplay = "uhhh i guess its good?";
		else if (accuracy >= 94)
			accDisplay = "not the best";
		else if (accuracy >= 93)
			accDisplay = "93 lollll";
		else if (accuracy >= 90)
			accDisplay = "inaccurate andy";
		else if (accuracy >= 89)
			accDisplay = "kill this guy with hammers";
		else if (accuracy >= 87)
			accDisplay = "WAS THAT THE BI-";
		else if (accuracy >= 85)
			accDisplay = "SFC (stands for shit fuck cake)";
		else if (accuracy >= 84)
			accDisplay = "speechless";
		else if  (accuracy >= 83)
			accDisplay = "83 lollll";
		else if  (accuracy >= 73 && accuracy < 74)
			accDisplay = "73 lollll";
		else if (accuracy >= 69)
			accDisplay = "haha sex";
		else if  (accuracy >= 63 && accuracy < 64)
			accDisplay = "63 lollll";
		else if (accuracy >= 56  && accuracy < 57)
			accDisplay = "jo56hs";
		else if (accuracy >= 55)
			accDisplay = "im gonna leave this one blank in case anyone wants to change it later";
		else if (accuracy >= 54)
			accDisplay = "";
		else if  (accuracy >= 53)
			accDisplay = "53 lollll";
		else if  (accuracy >= 43 && accuracy < 44)
			accDisplay = "43 lollll";
		else if  (accuracy >= 33 && accuracy < 34)
			accDisplay = "33 lollll";
		else if  (accuracy >= 23 && accuracy < 24)
			accDisplay = "23 lollll";
		else if  (accuracy >= 13 && accuracy < 14)
			accDisplay = "13 lollll";
		else if (accuracy >= 10)
			accDisplay = "certain death";
		else if (accuracy >= 5 && accuracy < 6)
			accDisplay = "this is my lucky number";
		else if  (accuracy >= 3 && accuracy < 4)
			accDisplay = "3 lollll";
		else if (accuracy == 0)
			accDisplay = "HOW ARE YOU STILL ALIVE";

		if (isGood || curSong == "Thorns") {
			scoreTxt.text = "Score:" + songScore + " | Misses:" + misses + " | Accuracy:" + truncateFloat(accuracy, 2) + "% " + (fc ? "| FC" : misses == 0 ? "| A" : accuracy <= 75 ? "| BAD" : "");
		} else {
			scoreTxt.text = "Score:" + songScore + " | Misses:" + misses + " | Accuracy:" + accuracy + "% | " + accDisplay;
		}

		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause)
		{
			persistentUpdate = false;
			persistentDraw = true;
			paused = true;

			// 1 / 1000 chance for Gitaroo Man easter egg
			if (FlxG.random.bool(0.1))
			{
				// gitaroo man easter egg
				FlxG.switchState(new GitarooPause());
			}
			else
				openSubState(new PauseSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y, !isStoryMode));
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			#if notRelease
			FlxG.switchState(new ChartingState());
			#else
			FreeplayState.playSong("dotdotdot", 1);
			#end
		}

		if (FlxG.keys.justPressed.EIGHT)
			FlxG.switchState(new CharacterEditorState());

		// FlxG.watch.addQuick('VOL', vocals.amplitudeLeft);
		// FlxG.watch.addQuick('VOLRight', vocals.amplitudeRight);

		iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50)));
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, 0.50)));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 2)
			health = 2;

		if (updateIconP1) {
			if (healthBar.percent < 20)
				iconP1.animation.curAnim.curFrame = 1;
			else
				iconP1.animation.curAnim.curFrame = 0;
		}

		if (updateIconP2) {
			if (healthBar.percent > 80)
				iconP2.animation.curAnim.curFrame = 1;
			else
				iconP2.animation.curAnim.curFrame = 0;
		}

		/* if (FlxG.keys.justPressed.NINE)
			FlxG.switchState(new Charting()); */

		#if debug
		if (FlxG.keys.justPressed.EIGHT)
			FlxG.switchState(new AnimationDebug(SONG.player2));
		#end

		if (startingSong)
		{
			if (startedCountdown)
			{
				Conductor.songPosition += FlxG.elapsed * 1000;
				if (Conductor.songPosition >= 0)
					startSong();
			}
		}
		else
		{
			// Conductor.songPosition = FlxG.sound.music.time;
			Conductor.songPosition += FlxG.elapsed * 1000;

			if (!paused)
			{
				songTime += FlxG.game.ticks - previousFrameTime;
				previousFrameTime = FlxG.game.ticks;

				// Interpolation type beat
				if (Conductor.lastSongPos != Conductor.songPosition)
				{
					songTime = (songTime + Conductor.songPosition) / 2;
					Conductor.lastSongPos = Conductor.songPosition;
					// Conductor.songPosition += FlxG.elapsed * 1000;
					// trace('MISSED FRAME');
				}
			}

			// Conductor.lastSongPos = FlxG.sound.music.time;
		}

		songTimer.curTime = Math.round(Conductor.songPosition/1000);
		songTimer.updateDisplay();

		if (generatedMusic && PlayState.SONG.notes[Std.int(curStep / 16)] != null)
		{
			if (curBeat % 4 == 0)
			{
				// trace(PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection);
			}

			if (camFollow.x != dad.getMidpoint().x + 150 && !PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection)
			{
				camFollow.setPosition(dad.getMidpoint().x + 150, dad.getMidpoint().y - 100);
				// camFollow.setPosition(lucky.getMidpoint().x - 120, lucky.getMidpoint().y + 210);

				switch (curStage) {
					case 'ikea':
						if (sigmioreveal == true)
						{
							if (unfairJevents[1] == false) { 
								if (unfairJevents[0] == false) {
									camFollow.y = dad.getMidpoint().y - 225;
									camFollow.x = dad.getMidpoint().x + 150;
								}
								else {
									camFollow.y = dad.getMidpoint().y - 225;
									camFollow.x = dad.getMidpoint().x + 150;
								}
								// FlxTween.tween(FlxG.camera, {zoom: 0.95}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.linear});
							}
							else
							{
								camFollow.y = dad.getMidpoint().y - 290;
								camFollow.x = dad.getMidpoint().x - 300;
							}
						}
						else
						{
							camFollow.x = boyfriend.getMidpoint().x - 550;
							camFollow.y = boyfriend.getMidpoint().y - 220;
						}
				}

				switch (dad.curCharacter)
				{
					case 'mom':
						camFollow.y = boyfriend.getMidpoint().y - 10;
						camFollow.x = boyfriend.getMidpoint().x - 650;
					case 'sigmio':
						camFollow.y = dad.getMidpoint().y - 200;
						camFollow.x = dad.getMidpoint().x - 100;
					case 'sigmio-evil':
						camFollow.y = dad.getMidpoint().y - 200;
						camFollow.x = dad.getMidpoint().x - 100;
					case 'sonicexe':
						camFollow.y = dad.getMidpoint().y + 30;
					case 'blocku':
						camFollow.y = dad.getMidpoint().y + 30;
					case 'evilblocku':
						camFollow.y = dad.getMidpoint().y + 30;
					case 'niceblocku':
						camFollow.y = dad.getMidpoint().y + 30;
					case 'scopguy':
						camFollow.y = dad.getMidpoint().y + 200;
				}
				

				if (dad.curCharacter == 'mom')
					vocals.volume = 1;

				if (SONG.song.toLowerCase() == 'tutorial')
				{
					tweenCamIn();
				}
			}

			if (PlayState.SONG.notes[Std.int(curStep / 16)].mustHitSection && camFollow.x != boyfriend.getMidpoint().x - 100)
			{
				camFollow.setPosition(boyfriend.getMidpoint().x - 100, boyfriend.getMidpoint().y - 100);

				switch (curStage)
				{
					case 'limo':
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'limonormal':
						camFollow.x = boyfriend.getMidpoint().x - 300;
					case 'mall':
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'school':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'schoolEvil':
						camFollow.x = boyfriend.getMidpoint().x - 200;
						camFollow.y = boyfriend.getMidpoint().y - 200;
					case 'ikea':
						if (unfairJevents[1] == false) { 
							if (unfairJevents[0] == false) {
								camFollow.x = boyfriend.getMidpoint().x - 400;
								camFollow.y = boyfriend.getMidpoint().y - 200;
							}
							else {
								camFollow.x = boyfriend.getMidpoint().x - 300;
								camFollow.y = boyfriend.getMidpoint().y - 100;
							}
						}
						else
						{
							camFollow.y = dad.getMidpoint().y - 290;
							camFollow.x = dad.getMidpoint().x - 300;
						}
						// FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, (Conductor.stepCrochet * 2 / 1000), {ease: FlxEase.linear});
				}
				
				switch (boyfriend.curCharacter)
				{
					case 'Nugget':
						camFollow.y = boyfriend.getMidpoint().y + 30;
					case 'nuggetdance':
						camFollow.y = boyfriend.getMidpoint().y + 30;
				}

				if (SONG.song.toLowerCase() == 'tutorial')
				{
					FlxTween.tween(FlxG.camera, {zoom: 1}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.elasticInOut});
				}
			}
		}

		if (camZooming)
		{
			FlxG.camera.zoom = FlxMath.lerp(defaultCamZoom, FlxG.camera.zoom, 0.95);
			camHUD.zoom = FlxMath.lerp(1, camHUD.zoom, 0.95);
		}

		FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

		if (curSong == 'Fresh')
		{
			switch (curBeat)
			{
				case 16:
					camZooming = true;
					gfSpeed = 2;
				case 48:
					gfSpeed = 1;
				case 80:
					gfSpeed = 2;
				case 112:
					gfSpeed = 1;
				case 163:
					// FlxG.sound.music.stop();
					// FlxG.switchState(new TitleState());
			}
		}

		if (curSong == 'Bopeebo')
		{
			switch (curBeat)
			{
				case 128, 129, 130:
					vocals.volume = 0;
					// FlxG.sound.music.stop();
					// FlxG.switchState(new PlayState());
			}
		}
		// better streaming of shit

		// RESET = Quick Game Over Screen
		if (controls.RESET)
		{

			health = 0;
			trace("RESET = True");
		}

		// CHEAT = brandon's a pussy
		if (controls.CHEAT)
		{
			health += 1;
			trace("User is cheating!");
		}

		if (health <= 0)
		{
			boyfriend.stunned = true;

			persistentUpdate = false;
			persistentDraw = false;
			paused = true;

			vocals.stop();
			FlxG.sound.music.stop();

			openSubState(new GameOverSubstate(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));

			#if desktop
			// Game Over doesn't get his own variable because it's only used here
			DiscordClient.changePresence(detailsText, "GAME OVER -- " + SONG.song + "\nAcc: " + truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC);
			#end

			// FlxG.switchState(new GameOverState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y));
		}

		if (unspawnNotes[0] != null)
		{
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 1500)
			{
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);

				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic)
			{
				notes.forEachAlive(function(daNote:Note)
				{	
					if (daNote.y > FlxG.height)
					{
						daNote.active = false;
						daNote.visible = false;
					}
					else
					{
						daNote.visible = true;
						daNote.active = true;
					}
	
					if (!daNote.mustPress && daNote.wasGoodHit)
					{
						if (SONG.song != 'Tutorial')
							camZooming = true;
	
						var altAnim:String = "";
	
						if (SONG.notes[Math.floor(curStep / 16)] != null)
						{
							if (SONG.notes[Math.floor(curStep / 16)].altAnim)
								altAnim = '-alt';
						}

						noteTypeCheck(daNote, true, true);
						
						if (daNote.noteType != "No Animation" && daNote.noteType != "Laugh" && daNote.noteType != "Play Animation" && daNote.noteType != "Kill Mommy" && daNote.noteType != "Change Character" && daNote.noteType != "Play Video") {
							switch (Math.abs(daNote.noteData))
							{
								case 2:
									dad.playAnim('singUP' + altAnim, true);
								case 3:
									dad.playAnim('singRIGHT' + altAnim, true);
								case 1:
									dad.playAnim('singDOWN' + altAnim, true);
								case 0:
									dad.playAnim('singLEFT' + altAnim, true);
							}
						}
	
						dad.holdTimer = 0;
	
						if (SONG.needsVoices)
							vocals.volume = 1;

						noteTypeCheck(daNote, false, true);
	
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}
	
					if (SaveManagement.getOption("Scroll Direction") == "Down")
						daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (-0.45 * FlxMath.roundDecimal(SONG.speed, 2)));
					else
						daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(SONG.speed, 2)));
					//trace(daNote.y);
					// WIP interpolation shit? Need to fix the pause issue
					// daNote.y = (strumLine.y - (songTime - daNote.strumTime) * (0.45 * PlayState.SONG.speed));
	
					if (daNote.y < -daNote.height && SaveManagement.getOption("Scroll Direction") == "Up" || daNote.y >= strumLine.y + 106 && SaveManagement.getOption("Scroll Direction") == "Down")
					{
						if (daNote.isSustainNote && daNote.wasGoodHit)
						{
							daNote.kill();
							notes.remove(daNote, true);
							daNote.destroy();
						}
						else
						{
							switch (daNote.noteType) { // MISS SHIT
								case "Kill":
									allowMiss = false;
								default:
									allowMiss = true;
							}

							if (allowMiss) {
								health -= 0.075;
								if (SONG.song != 'unfairness-jside') vocals.volume = 0;
								if (theFunne)
									noteTypeCheck(daNote, true, false, true);
									noteMiss(daNote.noteData);
									noteTypeCheck(daNote, false, false, true);
							}
							
						}
	
						daNote.active = false;
						daNote.visible = false;
	
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}
				});
			}

		
		if (!inCutscene)
			keyShit();
		
		#if notRelease
		if (FlxG.keys.justPressed.ONE)
			endSong();
		#end
	}

	public function wakeTheFuckUp():Void {
		if (curSong.toLowerCase() == 'thorns')
			FlxG.drawFramerate = Std.int(SaveManagement.getOption("FPS"));
		if (isStoryMode)
			{
				campaignScore += songScore;
	
				storyPlaylist.remove(storyPlaylist[0]);

				endSongEvents();
	
				if (storyPlaylist.length <= 0)
				{
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
	
					transIn = FlxTransitionableState.defaultTransIn;
					transOut = FlxTransitionableState.defaultTransOut;
	
					checkForCutscene(PlayState.curSong.toLowerCase()+"-end", new StoryMenuState());
	
					// if ()
					StoryMenuState.weekUnlocked[Std.int(Math.min(storyWeek + 1, StoryMenuState.weekUnlocked.length - 1))] = true;
	
					if (SONG.validScore)
					{
						NGio.unlockMedal(60961);
						Highscore.saveWeekScore(storyWeek, campaignScore, 1);
					}
	
					FlxG.save.data.weekUnlocked = StoryMenuState.weekUnlocked;
					FlxG.save.flush();
				}
				else
				{

	
					trace('LOADING NEXT SONG');
					trace(PlayState.storyPlaylist[0].toLowerCase());
	
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;
	
					PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase(), PlayState.storyPlaylist[0]);
					FlxG.sound.music.stop();
	
					checkForCutscene(PlayState.storyPlaylist[0].toLowerCase(), new PlayState());
				}
			}
			else
			{
				returnToFreeplay();
			}
	}

	public static function checkForCutscene(vidName:String, nextState:flixel.FlxState) {
		var files:Array<String> = sys.FileSystem.readDirectory('assets/data/'+SONG.song.toLowerCase().trim());

		if (FileSystem.exists(Paths.video(vidName))) {
			VideoCutsceneState.videoFile = vidName.trim();
			VideoCutsceneState.targetState = nextState;
			LoadingState.loadAndSwitchState(new VideoCutsceneState());
		} else {
			LoadingState.loadAndSwitchState(nextState);
		}
	}

	function returnToFreeplay() {
		trace('WENT BACK TO FREEPLAY??');
		FreeplayState.lastPage = lastFPpage;
		FreeplayState.lastSelected = lastFPselect;
		checkForCutscene(PlayState.curSong.toLowerCase()+"-end", new FreeplayState());
	}

	public function startVideo(name:String)
		{
			var filepath:String = Paths.video(name);
			#if sys
			if(!FileSystem.exists(filepath))
			#else
			if(!OpenFlAssets.exists(filepath))
			#end
			{
				FlxG.log.warn('Couldnt find video file: ' + name);
				return;
			}
	
			var video:VideoHandler = new VideoHandler();
				#if (hxCodec >= "3.0.0")
				// Recent versions
				video.play(filepath);
				video.onEndReached.add(function()
				{
					video.dispose();
					return;
				}, true);
				#else
				// Older versions
				video.playVideo(filepath);
				video.finishCallback = function()
				{
					return;
				}
				#end
		}
	

	function endSong():Void
	{

		canPause = false;
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
		if (SONG.validScore)
		{
			#if !switch
			Highscore.saveScore(SONG.song, songScore);
			#end
		}

		var results:FunkinResults = {
			sick: sicks,
			good: goods,
			bad: bads,
			shit: shits,
			miss: misses,
			score: songScore,
			accuracy: accuracy,
			rating: accDisplay
		};

		persistentUpdate = false;
		persistentDraw = true;
	

		var sub:FlxSubState = new ResultsSubState(boyfriend.getScreenPosition().x, boyfriend.getScreenPosition().y, results, this, !isGood);
		sub.cameras = [camHUD];
		openSubState(sub);	
		
		// wakeTheFuckUp();
	}

	function endSongEvents() {
		switch (SONG.song.toLowerCase()) {
			case 'eggnog':
				var blackShit:FlxSprite = new FlxSprite(-FlxG.width * FlxG.camera.zoom,
					-FlxG.height * FlxG.camera.zoom).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.BLACK);
				blackShit.scrollFactor.set();
				add(blackShit);
				camHUD.visible = false;

				FlxG.sound.play(Paths.sound('Lights_Shut_off'));
			case 'thorns':
				if (!FlxG.save.data.unlockedFreeplay)
					FlxG.switchState(new YouCanNowPlayFreeplayState());
				else {
					FlxTransitionableState.skipNextTransIn = true;
					FlxTransitionableState.skipNextTransOut = true;
					prevCamFollow = camFollow;
	
					PlayState.SONG = Song.loadFromJson('unfairness-jside', 'unfairness-jside');
					PlayState.storyWeek = PlayState.stageDictionary[PlayState.SONG.stage];
					FlxG.sound.music.stop();
	
					LoadingState.loadAndSwitchState(new PlayState());
				}

			default:
				//
		}
	}

	var endingSong:Bool = false;

	private function popUpScore(strumtime:Float):Void
		{
			var noteDiff:Float = Math.abs(strumtime - Conductor.songPosition);
			// boyfriend.playAnim('hey');
			vocals.volume = 1;
	
			var placement:String = Std.string(combo);
	
			var coolText:FlxText = new FlxText(0, 0, 0, placement, 32);
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
			//
	
			var rating:FlxSprite = new FlxSprite();
			var score:Int = 350;
	
			var daRating:String = "sick";
	
			if (noteDiff > Conductor.safeZoneOffset * 2)
				{
					daRating = 'shit';
					totalNotesHit -= 2;
					noteMiss(0);
					score = -3000;
					ss = false;
					shits++;
				}
				else if (noteDiff < Conductor.safeZoneOffset * -2)
				{
					daRating = 'shit';
					totalNotesHit -= 2;
					noteMiss(0);
					score = -3000;
					ss = false;
					shits++;
				}
				else if (noteDiff > Conductor.safeZoneOffset * 0.45)
				{
					daRating = 'bad';
					score = -1000;
					totalNotesHit += 0.2;
					ss = false;
					bads++;
				}
				else if (noteDiff > Conductor.safeZoneOffset * 0.25)
				{
					daRating = 'good';
					totalNotesHit += 0.65;
					score = 200;
					ss = false;
					goods++;
				}
				else if (SaveManagement.getOption("Botplay") == "On") {
					daRating = 'sick';
				}
			if (daRating == 'sick')
			{
				totalNotesHit += 1;
				sicks++;
			}
		
	
			if (daRating != 'shit' || daRating != 'bad')
			{
				if (SaveManagement.getOption("Hitsounds") == "On")
					FlxG.sound.play(Paths.sound('hitsound'));
				songScore += score;
		
				/* if (combo > 60)
						daRating = 'sick';
					else if (combo > 12)
						daRating = 'good'
					else if (combo > 4)
						daRating = 'bad';
				*/
		
				var ratingPart1:String = "";
				var ratingPart2:String = '';
		
				if (curStage.startsWith('school') || isPixel)
				{
					ratingPart1 = 'stages/weeb/pixelUI/';
					if (curSong == "Thorns" || isGood)
						ratingPart2 = '-pixel-good';
					else
						ratingPart2 = '-pixel';
				}
				else if (isGood)
					ratingPart1 = "ui/ui/good/";
				else 
					ratingPart1 = "ui/ui/";
				
				if (!isPixel && isGood) {
					ratingPart2 = '-good';
				}

				var comboPart1:String = "";
				var comboPart2:String = '';
		
				if (curStage.startsWith('school') || isPixel)
				{
					comboPart1 = 'stages/weeb/pixelUI/';
					if (curSong == "Thorns" || isGood)
						comboPart2 = '-pixel-good';
					else
						comboPart2 = '-pixel';
				}
				
				if (!isPixel && isGood) {
					comboPart2 = '-good';
				}
		
				rating.loadGraphic(Paths.image(ratingPart1 + daRating + ratingPart2));
				rating.screenCenter();
				rating.x = coolText.x - 40;
				rating.y -= 60;
				rating.acceleration.y = 550;
				rating.velocity.y -= FlxG.random.int(140, 175);
				rating.velocity.x -= FlxG.random.int(0, 10);
		
				var comboSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image(comboPart1 + 'combo' + comboPart2));
				comboSpr.screenCenter();
				comboSpr.x = coolText.x;
				comboSpr.acceleration.y = 600;
				comboSpr.velocity.y -= 150;
		
				comboSpr.velocity.x += FlxG.random.int(1, 10);
				add(rating);
		
				if (!curStage.startsWith('school') && !isPixel)
				{
					rating.setGraphicSize(Std.int(rating.width * 0.7));
					rating.antialiasing = true;
					comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7));
					comboSpr.antialiasing = true;
				}
				else
				{
					rating.setGraphicSize(Std.int(rating.width * daPixelZoom * 0.7));
					comboSpr.setGraphicSize(Std.int(comboSpr.width * daPixelZoom * 0.7));
				}
		
				comboSpr.updateHitbox();
				rating.updateHitbox();
		
				var seperatedScore:Array<Int> = [];
		
				seperatedScore.push(Math.floor(combo / 100));
				seperatedScore.push(Math.floor((combo - (seperatedScore[0] * 100)) / 10));
				seperatedScore.push(combo % 10);
		
				var daLoop:Int = 0;
				for (i in seperatedScore)
				{
					var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image(comboPart1 + 'num' + Std.int(i) + comboPart2));
					numScore.screenCenter();
					numScore.x = coolText.x + (43 * daLoop) - 90;
					numScore.y += 80;
		
					if (!curStage.startsWith('school') && !isPixel)
					{
						numScore.antialiasing = true;
						numScore.setGraphicSize(Std.int(numScore.width * 0.5));
					}
					else
					{
						numScore.setGraphicSize(Std.int(numScore.width * daPixelZoom));
					}
					numScore.updateHitbox();
		
					numScore.acceleration.y = FlxG.random.int(200, 300);
					numScore.velocity.y -= FlxG.random.int(140, 160);
					numScore.velocity.x = FlxG.random.float(-5, 5);
		
					if (combo >= 10 || combo == 0)
						add(numScore);
		
					FlxTween.tween(numScore, {alpha: 0}, 0.2, {
						onComplete: function(tween:FlxTween)
						{
							numScore.destroy();
						},
						startDelay: Conductor.crochet * 0.002
					});
		
					daLoop++;
				}
				/* 
					trace(combo);
					trace(seperatedScore);
				*/
		
				coolText.text = Std.string(seperatedScore);
				// add(coolText);
		
				FlxTween.tween(rating, {alpha: 0}, 0.2, {
					startDelay: Conductor.crochet * 0.001
				});
		
				FlxTween.tween(comboSpr, {alpha: 0}, 0.2, {
					onComplete: function(tween:FlxTween)
					{
						coolText.destroy();
						comboSpr.destroy();
		
						rating.destroy();
					},
					startDelay: Conductor.crochet * 0.001
				});
		
				curSection += 1;
			}
		}

	public function NearlyEquals(value1:Float, value2:Float, unimportantDifference:Float = 10):Bool
		{
			return Math.abs(FlxMath.roundDecimal(value1, 1) - FlxMath.roundDecimal(value2, 1)) < unimportantDifference;
		}	

	private function keyShit():Void
	{
		// HOLDING
		var up = controls.UP;
		var right = controls.RIGHT;
		var down = controls.DOWN;
		var left = controls.LEFT;

		var upP = controls.UP_P;
		var rightP = controls.RIGHT_P;
		var downP = controls.DOWN_P;
		var leftP = controls.LEFT_P;

		var upR = controls.UP_R;
		var rightR = controls.RIGHT_R;
		var downR = controls.DOWN_R;
		var leftR = controls.LEFT_R;

		var controlArray:Array<Bool> = [leftP, downP, upP, rightP];

		// FlxG.watch.addQuick('asdfa', upP);
		if ((upP || rightP || downP || leftP || SaveManagement.getOption("Botplay") == "On") && !boyfriend.stunned && generatedMusic)
			{
				repPresses++;
				boyfriend.holdTimer = 0;
	
				var possibleNotes:Array<Note> = [];
	
				var ignoreList:Array<Int> = [];
	
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate)
					{
						// the sorting probably doesn't need to be in here? who cares lol
						possibleNotes.push(daNote);
						possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));
	
						ignoreList.push(daNote.noteData);
					}
				});
	
				
				if (possibleNotes.length > 0)
				{
					var daNote = possibleNotes[0];
	
					if (perfectMode)
						noteCheck(true, daNote);
	
					// Jump notes
					if (possibleNotes.length >= 2)
					{
						if (possibleNotes[0].strumTime == possibleNotes[1].strumTime)
						{
							for (coolNote in possibleNotes)
							{
								if (controlArray[coolNote.noteData] || SaveManagement.getOption("Botplay") == "On")
									goodNoteHit(coolNote);
								else
								{
									var inIgnoreList:Bool = false;
									for (shit in 0...ignoreList.length)
									{
										if (controlArray[ignoreList[shit]])
											inIgnoreList = true;
									}
									if (!inIgnoreList && !theFunne)
										badNoteCheck();
								}
							}
						}
						else if (possibleNotes[0].noteData == possibleNotes[1].noteData)
						{
							noteCheck(controlArray[daNote.noteData], daNote);
						}
						else
						{
							for (coolNote in possibleNotes)
							{
								noteCheck(controlArray[coolNote.noteData], coolNote);
							}
						}
					}
					else // regular notes?
					{	
						noteCheck(controlArray[daNote.noteData], daNote);
					}
					
					if (daNote.wasGoodHit)
					{
						daNote.kill();
						notes.remove(daNote, true);
						daNote.destroy();
					}
				}
				else if (!theFunne)
				{
					badNoteCheck();
				}
			}
	
			if ((up || right || down || left) && generatedMusic)
			{
				notes.forEachAlive(function(daNote:Note)
				{
					if (daNote.canBeHit && daNote.mustPress && daNote.isSustainNote)
					{
						switch (daNote.noteData)
						{
							// NOTES YOU ARE HOLDING
							case 2:
								if (up || SaveManagement.getOption("Botplay") == "On")
									goodNoteHit(daNote);
							case 3:
								if (right || SaveManagement.getOption("Botplay") == "On")
									goodNoteHit(daNote);
							case 1:
								if (down || SaveManagement.getOption("Botplay") == "On")
									goodNoteHit(daNote);
							case 0:
								if (left || SaveManagement.getOption("Botplay") == "On")
									goodNoteHit(daNote);
						}
					}
				});
			}
	
			if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && !up && !down && !right && !left)
			{
				if (boyfriend.animation.curAnim.name.startsWith('sing') && !boyfriend.animation.curAnim.name.endsWith('miss'))
				{
					boyfriend.playAnim('idle');
				}
			}
	
			playerStrums.forEach(function(spr:FlxSprite)
			{
				switch (spr.ID)
				{
					case 2:
						if (upP && spr.animation.curAnim.name != 'confirm')
						{
							spr.animation.play('pressed');
						}
						if (upR)
						{
							spr.animation.play('static');
							repReleases++;
						}
					case 3:
						if (rightP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (rightR)
						{
							spr.animation.play('static');
							repReleases++;
						}
					case 1:
						if (downP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (downR)
						{
							spr.animation.play('static');
							repReleases++;
						}
					case 0:
						if (leftP && spr.animation.curAnim.name != 'confirm')
							spr.animation.play('pressed');
						if (leftR)
						{
							spr.animation.play('static');
							repReleases++;
						}
				}
				
				if (spr.animation.curAnim.name == 'confirm' && !curStage.startsWith('school') && !isPixel)
				{
					spr.centerOffsets();
					spr.offset.x -= 13;
					spr.offset.y -= 13;
				}
				else
					spr.centerOffsets();
			});
	}

	function noteMiss(direction:Int = 1):Void
	{
		if (!boyfriend.stunned && allowMiss)
		{
			misses++;
			if (SONG.song != "unfairness-jside")
				health -= 0.04;
			else
				health -= 0.01;
			if (combo > 5 && gf.animOffsets.exists('sad'))
			{
				gf.playAnim('sad');
			}
			combo = 0;

			songScore -= 10;

			if (SONG.song != 'unfairness-jside')
				FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
			// FlxG.sound.play(Paths.sound('missnote1'), 1, false);
			// FlxG.log.add('played imss note');

			switch (direction)
			{
				case 0:
					boyfriend.playAnim('singLEFTmiss', true);
				case 1:
					boyfriend.playAnim('singDOWNmiss', true);
				case 2:
					boyfriend.playAnim('singUPmiss', true);
				case 3:
					boyfriend.playAnim('singRIGHTmiss', true);
			}
		}
	}

	function badNoteCheck()
		{
			// just double pasting this shit cuz fuk u
			// REDO THIS SYSTEM!
			var upP = controls.UP_P;
			var rightP = controls.RIGHT_P;
			var downP = controls.DOWN_P;
			var leftP = controls.LEFT_P;
	
			if (leftP)
				noteMiss(0);
			if (upP)
				noteMiss(2);
			if (rightP)
				noteMiss(3);
			if (downP)
				noteMiss(1);
			updateAccuracy();
		}

	function updateAccuracy()
		{
			if (misses > 0 || accuracy < 96)
				fc = false;
			else
				fc = true;
			totalPlayed += 1;
			accuracy = totalNotesHit / totalPlayed * 100;
		}


	function noteCheck(keyP:Bool, note:Note):Void // sorry lol
		{
			if (keyP || SaveManagement.getOption("Botplay") == "On")
				{
				goodNoteHit(note);
				}
			else if (!theFunne)
			{
				badNoteCheck();
			}
		}

		function goodNoteHit(note:Note):Void
			{
				if (!note.wasGoodHit)
				{
					if (!note.isSustainNote)
					{
						popUpScore(note.strumTime);
						combo += 1;
					}
					else
						totalNotesHit += 1;

					noteTypeCheck(note, true);
		
					if (note.noteData >= 0)
						health += 0.023;
					else
						health += 0.004;

					if (note.noteType != "No Animation" && note.noteType != "Play Animation" && note.noteType != "Change Character" && note.noteType != "Play Video") {
						switch (note.noteData)
						{
							case 2:
								boyfriend.playAnim('singUP', true);
							case 3:
								boyfriend.playAnim('singRIGHT', true);
							case 1:
								boyfriend.playAnim('singDOWN', true);
							case 0:
								boyfriend.playAnim('singLEFT', true);
						}
					}
		
					playerStrums.forEach(function(spr:FlxSprite)
					{
						if (Math.abs(note.noteData) == spr.ID)
						{
							spr.animation.play('confirm', true);
						}
					});
		
					note.wasGoodHit = true;
					vocals.volume = 1;

					noteTypeCheck(note);
		
					note.kill();
					notes.remove(note, true);
					note.destroy();
					
					updateAccuracy();
				}
			}
	
	function noteTypeCheck(notezzz:Note, ?precheck:Bool = false, ?dadHit:Bool = false, ?miss:Bool = false) {
		var zeNoteType:String = notezzz.noteType;
		var noteTypeParam:String = notezzz.noteTypeParam; // Funny little silly parameter in chart editor :P

		//trace("NTParam: "+noteTypeParam);

		if (zeNoteType == null)
			zeNoteType = "Normal";

		if (zeNoteType == "Kill")
			allowMiss = false;
		else
			allowMiss = true;

		if (precheck) { // Before animation & health shit
			switch (zeNoteType) {
				case "Normal":
					// trace("Normal Note Hit");
				case "Shield Note":
					beefSafe = true;
				case "Don't End The World":
					if (miss) {
						vocals.stop();
						FlxG.sound.music.stop();
						FlxG.sound.music.onComplete = null;
						var silly = new FlxSprite().loadGraphic(Paths.image("worldsaved"));
						silly.cameras = [camOther];
						add(silly);
						new FlxTimer().start(3, function(timer:FlxTimer) {
							endSong();
						});
					}
				case "Vyst Meow":
					gf.animation.play("meow", true);
				case "Change Character":
					var params:Array<String> = noteTypeParam.trim().split(",");
					var pos:Vector2;
					if (params[0] == "dad") {
						pos = new Vector2(dad.x, dad.y);
						remove(dad);
						dad = new Character(pos.x, pos.y, params[1]);
						add(dad);
						iconP2.animation.play(params[1]);
						if (evilTrail != null)
						{
							remove(evilTrail);
							evilTrail = new FlxTrail(dad, null, 3, 24, 0.3, 0.05);
							add(evilTrail);
						}
					} else {
						pos = new Vector2(boyfriend.x, boyfriend.y);
						remove(boyfriend);
						boyfriend = new Boyfriend(pos.x, pos.y, params[1]);
						add(boyfriend);
						iconP1.animation.play(params[1]);
					}
				case "Play Video":
					startVideo(noteTypeParam);
				default:
					// trace(zeNoteType + "was HITTTEEEEEEEEEEEEED");
			}
		} else { // AFTER the note shit happened
			switch (zeNoteType) {
				case "Normal":
					// trace("Normal Note Hit");
				case "Test":
					// trace("Test Note POST HIT");
				case "Laugh":
					dad.animation.play('laugh', true);
				case "Play Animation":
					if (dadHit)
						dad.animation.play(noteTypeParam, true);
					else
						boyfriend.animation.play(noteTypeParam, true);
				case "Vyst Meow":
					gf.animation.play("meow", true);
				case "Pico Shoot":
					picoShoot.visible = true;
					dad.visible = false;
					picoShoot.animation.play('shoot', true);
					if (curSong.toLowerCase() != "philly") {
						shootSound.play(true);
					}
					new FlxTimer().start(0.05714285714, function(timer:FlxTimer) {
						picoShoot.visible = false;
						dad.visible = true;
						if (!beefSafe) {
							health -= 0.5;
							if (health <= 0) health = 0.1;
							iconP1.animation.curAnim.curFrame = 1;
							updateIconP1 = false;
							new FlxTimer().start((Conductor.crochet/1000) * 2, (tmr) -> {
								iconP1.animation.curAnim.curFrame = 0;
								updateIconP1 = true;
							});
						}
						beefSafe = false;
					});
				case "Kill Santa":
					santa.animation.play('DIE', true);
				case "Kill Mommy":
					FlxTween.tween(dad, {x: dad.x - 800}, 1.5, {ease: FlxEase.sineOut});
					FlxTween.tween(dad, {angle: -210}, 1, {ease: FlxEase.sineOut});
					FlxTween.tween(dad, {y: dad.y + 550}, 1.2, {ease: FlxEase.sineOut, startDelay: 0.3});
				case "Monster Leave":
					FlxTween.tween(dad, {alpha: 0}, 1.5, {ease: FlxEase.linear});
				case "Give Card":
					fortnitecard.alpha = 1;
					FlxTween.tween(fortnitecard, {alpha: 0}, 1.5, {ease: FlxEase.quadOut});
				case "Lazy Chart":
					var lazyTxt:FlxText = new FlxText(0, 0, FlxG.width, "we didnt want to chart this anymore", 50);
					lazyTxt.setFormat(Paths.font("papyrus.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
					lazyTxt.cameras = [camHUD];
					lazyTxt.screenCenter();
					lazyTxt.alpha = 0;
					add(lazyTxt);
					FlxTween.tween(lazyTxt, {alpha: 1}, 10, {ease: FlxEase.linear, type: PINGPONG});
				case "Kill":
					health = 0;
				default:
					// trace(zeNoteType + "was HITTTEEEEEEEEEEEEED");
			}
		}
	}

	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.y = FlxG.random.int(140, 250);
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	function fastCarDrive()
	{
		FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			resetFastCar();
		});
	}

	var trainMoving:Bool = false;
	var trainFrameTiming:Float = 0;

	var trainCars:Int = 8;
	var trainFinishing:Bool = false;
	var trainCooldown:Int = 0;

	function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset();
		}
	}

	function trainReset():Void
	{
		gf.playAnim('hairFall');
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}


	override function stepHit()
	{
		super.stepHit();
		if (FlxG.sound.music.time > Conductor.songPosition + 20 || FlxG.sound.music.time < Conductor.songPosition - 20)
		{
			resyncVocals();
		}

		if (dad.curCharacter == 'spooky' && curStep % 4 == 2)
		{
			// dad.dance();
		}
		
		if (curSong == 'bopcityfansong') 
		{
			switch (curStep)
			{
				case 1071:
					remove(boyfriend);
					boyfriend = new Boyfriend(770, 150, 'nuggetdance');
					add(boyfriend);
			}
		}
		
		if (curSong == 'unfairness-jside') {
			switch (curStep) {
				case 1918: // 1918
					unfairJevents[0] = true;

					blackShitJ.scrollFactor.set();
					add(blackShitJ);
					camHUD.visible = false;

					dad.setGraphicSize(Std.int(dad.width * 0.5));
					dad.x += 200;
					dad.y -= 150;

					var oldBf = boyfriend;
					remove(boyfriend);
					boyfriend = new Boyfriend(oldBf.x, oldBf.y, "unfairJo");
					add(boyfriend);

					unfairjShader.waveAmplitude = 0.2;
					unfairjShader.waveSpeed = 1.5;
				case 1936: // 1936
					remove(blackShitJ);
					camHUD.visible = true;
				case 3470: // 3470

					var oldDad = dad;
					remove(dad);
					dad = new Character(-350, 0, 'sigmio-final');
					add(dad);

					boyfriend.visible = true;
					unfairJevents[0] = true;
					unfairJevents[1] = false;
					unfairJbg.alpha = 1;
					whiteShitJ.alpha = 1;
					FlxTween.tween(whiteShitJ, {alpha: 0}, 1, {ease: FlxEase.linear});

					unfairjShader.waveFrequency = 4;
					unfairjShader.waveSpeed = 2;

					remove(dadTrailJ);
					bfTrailJ = new FlxTrail(boyfriend, null, 3, 24, 0.3, 0.05);
					dadTrailJ = new FlxTrail(dad, null, 3, 24, 0.3, 0.05);
					add(bfTrailJ);
					add(dadTrailJ);
					
			}
		}

		// yes this updates every step.
		// yes this is bad
		// but i'm doing it to update misses and accuracy
		#if desktop
		// Song duration in a float, useful for the time left feature
		songLength = FlxG.sound.music.length;

		// Updating Discord Rich Presence (with Time Left)
		DiscordClient.changePresence(detailsText + " " + SONG.song , "Acc: " + truncateFloat(accuracy, 2) + "% | Score: " + songScore + " | Misses: " + misses  , iconRPC,true,  songLength - Conductor.songPosition);
		#end
	}

	var lightningStrikeBeat:Int = 0;
	var lightningOffset:Int = 8;

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, FlxSort.DESCENDING);
		}

		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			// Dad doesnt interupt his own notes
			if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
				dad.dance();
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		// HARDCODING FOR MILF ZOOMS!
		if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

		if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));
		if (curSong.toLowerCase() != 'thorns') {
			iconP1.angle = curBeat % 2 == 0 ? 15 : -15;
			iconP2.angle = curBeat % 2 == 0 ? -15 : 15;
		}

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		if (curBeat % gfSpeed == 0)
		{
			gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing"))
		{
			boyfriend.playAnim('idle');
		}

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);

			if (SONG.song == 'Tutorial' && dad.curCharacter == 'gf')
			{
				dad.playAnim('cheer', true);
			}
		}

		if (curSong.toLowerCase() == 'dadbattle') {
			if (curBeat == 96) {
				stupidFuckingSpotlight1.visible = true;
				stupidFuckingSpotlight2.visible = true;
			}
			if (curBeat == 160) {
				stupidFuckingSpotlight1.visible = false;
				stupidFuckingSpotlight2.visible = false;
			}
		}
		
		if (curSong == 'bopcityfansong') 
		{
			switch (curBeat)
			{
				case 111:
					explosion.animation.play('boom', true);
				case 112:
					remove(dad);
					dad = new Character(100, 250, 'evilblocku');
					add(dad);
				case 220:
					remove(dad);
					dad = new Character(100, 250, 'niceblocku');
					add(dad);
			}
		}
		
		// UNFAIRJ EVENTS
		if (curSong == 'unfairness-jside') {
			switch (curBeat) {
				case 156: //156
					dad.animation.play('die', true);
					FlxTween.tween(whiteShitJ, {alpha: 1}, 1.5, {ease: FlxEase.linear});
				case 160: //160
					var oldDad = dad;
					remove(dad);
					dad = new Character(oldDad.x, oldDad.y, 'sigmio-final');
					add(dad);
					iconP2.animation.play('sigmio-final');
					sigmioreveal = true;
					unfairJbg.alpha = 1;
					thornbg.alpha = 0;
					FlxTween.tween(whiteShitJ, {alpha: 0}, 1, {ease: FlxEase.linear});
					FlxTween.tween(songTimer, {"endTime": Math.round(songLength/1000)}, 27, {ease:FlxEase.expoIn});
				case 492: // 492
					lol = new FlxSprite(boyfriend.x-200, boyfriend.y - 50).loadGraphic(Paths.image('stages/ikea/cobble'));
					lol.alpha = 0;
					add(lol);

					FlxTween.tween(lol, {alpha: 1}, 1);
				case 496: // 496
					FlxTween.tween(lol, {alpha: 0}, 1, { onComplete: (twn:FlxTween) -> {
						remove(lol);
					}});
					
				case 676: // 676
					boyfriend.visible = false;
					unfairJevents[0] = false;
					unfairJevents[1] = true;
					unfairJbg.alpha = 0;

					unfairjShader.waveAmplitude = 0.3;
					unfairjShader.waveFrequency = 4.5;
					unfairjShader.waveSpeed = 1.5;

					var oldDad = dad;
					remove(dad);
					dad = new Character(oldDad.x + 500, oldDad.y+200, 'sigmiofinalalt');
					add(dad);

					whiteShitJ.alpha = 1;
					
					FlxTween.tween(whiteShitJ, {alpha: 0}, 1, {ease: FlxEase.linear});
				case 708: // 708
					FlxTween.tween(unfairJbg, {"alpha": 0.5}, 2, {ease: FlxEase.linear});
				case 804: // 804
					dadTrailJ = new FlxTrail(dad, null, 3, 24, 0.3, 0.05);
					
					add(dadTrailJ);
					
			}
		}

		switch (curStage)
		{
			case 'school':
				bgGirls.dance();

			case 'mall':
				upperBoppers.animation.play('bop', true);
				bottomBoppers.animation.play('bop', true);

			case 'limo':
				grpLimoDancers.forEach(function(dancer:BackgroundDancer)
				{
					dancer.dance();
				});

				if (FlxG.random.bool(10) && fastCarCanDrive)
					fastCarDrive();
			case 'limonormal':
				grpLimoDancers.forEach(function(dancer:BackgroundDancer)
				{
					dancer.dance();
				});

				if (FlxG.random.bool(10) && fastCarCanDrive)
					fastCarDrive();
			case "philly":
				if (!trainMoving)
					trainCooldown += 1;

				if (curBeat % 4 == 0)
				{
					phillyCityLights.forEach(function(light:FlxSprite)
					{
						light.visible = false;
					});

					curLight = FlxG.random.int(0, phillyCityLights.length - 1);

					phillyCityLights.members[curLight].visible = true;
					// phillyCityLights.members[curLight].alpha = 1;
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					trainCooldown = FlxG.random.int(-4, 0);
					trainStart();
				}
		}

	}

	var curLight:Int = 0;
}
