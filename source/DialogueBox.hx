package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	var leftChar:String = "sigmio";

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		var hasDialog = false;

		if (PlayState.hasDialogue)
		{
			hasDialog = true;
			var songConfig:Array<String> = CoolUtil.coolTextFile(Paths.txtImages("dialogue/boxes/songDBDefine"));
			var songToDBMap:Map<String, String> = [];
			for (i in 0...songConfig.length)
			{
				var sussyMap = songConfig[i].trim().split('::');
				songToDBMap.set(sussyMap[0].toLowerCase().trim(), sussyMap[1]);
			}
			var configFile:Array<String> = CoolUtil.coolTextFile(Paths.txtImages("dialogue/boxes/" + songToDBMap[PlayState.SONG.song.toLowerCase().trim()]));
			box.frames = Paths.getSparrowAtlas('dialogue/boxes/' + songToDBMap[PlayState.SONG.song.toLowerCase().trim()]);
			box.animation.addByPrefix('normalOpen', configFile[0], 24, false);
			box.animation.addByIndices('normal', configFile[1], [4], "", 24);
		}

		this.dialogueList = dialogueList;

		if (!hasDialog)
			return;

		try {
			var configFile:Array<String> = CoolUtil.coolTextFile(Paths.txtImages("dialogue/characters/" + PlayState.SONG.player2));
			portraitLeft = new FlxSprite(Std.parseFloat(configFile[3]), Std.parseFloat(configFile[4]));
			portraitLeft.frames = Paths.getSparrowAtlas('dialogue/characters/' + PlayState.SONG.player2);
			portraitLeft.animation.addByPrefix('enter', configFile[0], 24, false);
			if (configFile[5] == "true")
				portraitLeft.flipX = true;
			else
				portraitLeft.flipX = false;
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
		}
		catch(e) {
			trace("Couldn't find left portrait for " + PlayState.SONG.player2);
			portraitLeft = new FlxSprite(0, 0).makeGraphic(0, 0, FlxColor.TRANSPARENT);
			add(portraitLeft);
		}

		try {
			var configFile:Array<String> = CoolUtil.coolTextFile(Paths.txtImages("dialogue/characters/" + PlayState.SONG.player1));
			portraitRight = new FlxSprite(Std.parseFloat(configFile[1]), Std.parseFloat(configFile[2]));
			portraitRight.frames = Paths.getSparrowAtlas('dialogue/characters/' + PlayState.SONG.player1);
			portraitRight.animation.addByPrefix('enter', configFile[0], 24, false);
			if (configFile[5] == "true")
				portraitRight.flipX = true;
			else
				portraitRight.flipX = false;
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}
		catch(e) {
			trace("Couldn't find right portrait for " + PlayState.SONG.player1);
			portraitRight = new FlxSprite(0, 0).makeGraphic(0, 0, FlxColor.TRANSPARENT);
			add(portraitRight);
		}

		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('ui/pixelUI/hand_textbox'));
		handSelect.setGraphicSize(3,3);
		add(handSelect);

		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'thorns' || PlayState.SONG.song.toLowerCase() == 'roses')
		{
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.exists("normalOpen")) {
				if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
				{
					box.animation.play('normal');
					dialogueOpened = true;
				}
			}
			else 
				dialogueOpened = true;
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY && dialogueStarted == true)
		{
			remove(dialogue);

			if (!isEnding)
				FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}

		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
