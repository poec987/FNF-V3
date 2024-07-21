package;

import FreeplayState.FreeplayPage;
import flixel.FlxG;
import flash.system.System;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.keyboard.FlxKey;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import io.newgrounds.NG;
import lime.app.Application;

using StringTools;

#if desktop
import Discord.DiscordClient;
#end

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'donate', 'credits', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end
	
	var penKey:Array<FlxKey> = [FlxKey.P, FlxKey.E, FlxKey.N, FlxKey.K, FlxKey.A, FlxKey.R, FlxKey.U];
	var lastKeysPressed:Array<FlxKey> = [];

	var newGaming:FlxText;
	var newGaming2:FlxText;
	var newInput:Bool = true;

	public static var gameVer:String = "0.2.7.1";
	public static var cinemaEngineVer = "1.0";

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	override function create()
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
		}

		if (!FlxG.save.data.unlockedFreeplay)
			optionShit.remove("freeplay");

		persistentUpdate = persistentDraw = true;

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.18;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = Paths.getSparrowAtlas('FNF_main_menu_assets');

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140) + offset);
			menuItem.antialiasing = true;
			menuItem.ID = i;
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.updateHitbox();
			menuItem.screenCenter(X);
		}

		FlxG.camera.follow(camFollow, null, 0.06);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, gameVer + " FNF - " + cinemaEngineVer + " Cinema Engine", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();


		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;
	var bopCount:Int = 0;
	
	var isDifferent:Bool = false;

	override function update(elapsed:Float)
	{			

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
		
		var finalKey:FlxKey = FlxG.keys.firstJustPressed();
		if(finalKey != FlxKey.NONE) {
			lastKeysPressed.push(finalKey); //Convert int to FlxKey
			if(lastKeysPressed.length > penKey.length)
			{
				lastKeysPressed.shift();
			}
				
			if(lastKeysPressed.length == penKey.length)
			{
				
				for (i in 0...lastKeysPressed.length) {
					if(lastKeysPressed[i] != penKey[i]) {
						isDifferent = true;
						break;
					}
				}

				if(!isDifferent) {
					FlxG.sound.play(Paths.sound('fuckingidiot', "shared"), 1.5);
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						System.exit(0);
					});
				}
			}
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (FlxG.keys.justPressed.B && bopCount == 0) {
				var b = new FlxSprite(150).loadGraphic(Paths.image("B"));
				add(b);
				bopCount++;
			}
				
			if (FlxG.keys.justPressed.O && bopCount == 1) {
				var o = new FlxSprite(300).loadGraphic(Paths.image("O"));
				add(o);
				bopCount++;
			}

			if (FlxG.keys.justPressed.P && bopCount == 2) {
				var p = new FlxSprite(450).loadGraphic(Paths.image("P"));
				add(p);
				bopCount = 0;
				FreeplayState.playSong("bopcityfansong", 1);
			}

			if (FlxG.keys.justPressed.SEVEN) {
				PlayState.devMode = !PlayState.devMode;
			}

			if (PlayState.devMode) {
				menuItems.getFirstExisting().alpha = 0.5;
			} else {
				menuItems.getFirstExisting().alpha = 1;
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					FreeplayState.playSong("do-you-get-the-refrance", 1);
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 1.3, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story mode':
										FlxG.switchState(new StoryMenuState());
										trace("Story Menu Selected");
									case 'freeplay':
										FlxG.switchState(new FreeplayState());

										trace("Freeplay Menu Selected");
									case 'credits':
										FlxG.switchState(new CreditsState());

									case 'options':
										FlxG.switchState(new OptionsMenu());
								}
							});
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
