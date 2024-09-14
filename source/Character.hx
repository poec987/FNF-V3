package;

import lime.math.Vector2;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var charPos:Vector2;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false, ?characterArray:Array<String>)
	{
		super(x, y);

		charPos = new Vector2(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'bf':
				frames = Paths.getSparrowAtlas('characters/BOYFRIEND');
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'bf-bside':
				var tex = Paths.getSparrowAtlas('characters/bside/BOYFRIEND-BSIDE');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
	
				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
	
				playAnim('idle');
	
				flipX = true;
			case 'bf-christmas':
				var tex = Paths.getSparrowAtlas('characters/christmas/bfChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);

				playAnim('idle');

				flipX = true;
			case 'bf-car':
				var tex = Paths.getSparrowAtlas('characters/limo/bfCar');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				playAnim('idle');

				flipX = true;
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('characters/weeb/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'ogbf-pixel':
				var tex = Paths.getSparrowAtlas('characters/weeb/ogbf-pixel');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				setGraphicSize(Std.int(width));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;	
			case 'bf-pixel-good':
				frames = Paths.getSparrowAtlas('characters/weeb/bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);
	
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
				addOffset("singUPmiss");
				addOffset("singRIGHTmiss");
				addOffset("singLEFTmiss");
				addOffset("singDOWNmiss");
	
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
	
				playAnim('idle');
	
				width -= 100;
				height -= 100;
	
				antialiasing = false;
	
				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('characters/weeb/bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				addOffset('firstDeath');
				addOffset('deathLoop', -37);
				addOffset('deathConfirm', -37);
				playAnim('firstDeath');
				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;
			case 'scpboyfriend':
				frames = Paths.getSparrowAtlas('characters/foundation/SCPBOYFRIEND');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				animation.addByPrefix('scared', 'BF idle shaking', 24);

				addOffset('idle', -5);
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -38, -7);
				addOffset("singLEFT", 12, -6);
				addOffset("singDOWN", -10, -50);
				addOffset("singUPmiss", -29, 27);
				addOffset("singRIGHTmiss", -30, 21);
				addOffset("singLEFTmiss", 12, 24);
				addOffset("singDOWNmiss", -11, -19);
				addOffset("hey", 7, 4);
				addOffset('firstDeath', 37, 11);
				addOffset('deathLoop', 37, 5);
				addOffset('deathConfirm', 37, 69);
				addOffset('scared', -4);

				playAnim('idle');

				flipX = true;
			case 'gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/GF_assets');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');			
			case 'vyst-gf':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/foundation/VYST_GF_assets');
				frames = tex;
				animation.addByPrefix('idle', 'VYST IDLE DANCE', 24, false);
				animation.addByPrefix('meow', 'VYST MEOW', 24, false);
		
				addOffset('meow');
				addOffset('idle');

				playAnim('idle');			
			case 'gogfgo':
				// GIRLFRIEND CODE
				tex = Paths.getSparrowAtlas('characters/gogirlfriendgo');
				frames = tex;
				animation.addByPrefix('idle', 'dance', 30, true);

				addOffset("idle", -200, -400);

				playAnim('idle');
				
				setGraphicSize(Std.int(width * 2));
				updateHitbox();
			case 'gf-christmas':
				tex = Paths.getSparrowAtlas('characters/christmas/gfChristmas');
				frames = tex;
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				addOffset('cheer');
				addOffset('sad', -2, -2);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);

				addOffset("singUP", 0, 4);
				addOffset("singRIGHT", 0, -20);
				addOffset("singLEFT", 0, -19);
				addOffset("singDOWN", 0, -20);
				addOffset('hairBlow', 45, -8);
				addOffset('hairFall', 0, -9);

				addOffset('scared', -2, -17);

				playAnim('danceRight');
			case 'gf-car':
				tex = Paths.getSparrowAtlas('characters/limo/gfCar');
				frames = tex;
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');
			case 'gf-pixel':
				tex = Paths.getSparrowAtlas('characters/weeb/gfPixel');
				frames = tex;
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				addOffset('danceLeft', 0);
				addOffset('danceRight', 0);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;				
			case 'gf-pixelgroove':
				tex = Paths.getSparrowAtlas('characters/weeb/gfPixelgroove');
				frames = tex;
				animation.addByPrefix('idle', 'dance', 30, true);

				addOffset('idle', 0);

				playAnim('idle');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = true;
			case 'dad':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/stage/DADDY_DEAREST');
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				addOffset('idle');
				addOffset("singUP", -6, 50);
				addOffset("singRIGHT", 0, 27);
				addOffset("singLEFT", -10, 10);
				addOffset("singDOWN", 0, -30);

				playAnim('idle');
			case 'spooky':
				tex = Paths.getSparrowAtlas('characters/spooky/spooky_kids_assets');
				frames = tex;
				animation.addByPrefix('singUP', 'spooky UP NOTE', 30, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 30, false);
				animation.addByPrefix('singLEFT', 'spooky LEFT note', 30, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 30, false);
				animation.addByPrefix('idle', 'spooky dance idle', 30, true);
	
				addOffset('idle');
	
				addOffset("singUP", -20, 26);
				addOffset("singRIGHT", -130, -14);
				addOffset("singLEFT", 130, -10);
				addOffset("singDOWN", -50, -130);
	
				playAnim('idle');				
			case 'mom':
				tex = Paths.getSparrowAtlas('characters/limo/Mom_Assets');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 30, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 30, false);
				animation.addByPrefix('singDOWN', "Mom DOWN POSE", 30, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 30, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 30, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');
			case 'mom-car':
				tex = Paths.getSparrowAtlas('characters/limo/momCar');
				frames = tex;

				animation.addByPrefix('idle', "Mom Idle", 24, false);
				animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
				animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
				animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

				addOffset('idle');
				addOffset("singUP", 14, 71);
				addOffset("singRIGHT", 10, -60);
				addOffset("singLEFT", 250, -23);
				addOffset("singDOWN", 20, -160);

				playAnim('idle');
			case 'monster':
				tex = Paths.getSparrowAtlas('characters/spooky/Monster_Assets');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				addOffset('idle');
				addOffset("singUP", -20, 50);
				addOffset("singRIGHT", -51);
				addOffset("singLEFT", -30);
				addOffset("singDOWN", -30, -40);
				playAnim('idle');
			case 'monster-christmas':
				tex = Paths.getSparrowAtlas('characters/christmas/monsterChristmas');
				frames = tex;
				animation.addByPrefix('idle', 'monster idle', 60, true);
				animation.addByPrefix('singUP', 'monster up note', 60, false);
				animation.addByPrefix('singDOWN', 'monster down', 60, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 60, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 60, false);

				addOffset('idle');
				addOffset('singUP');
				addOffset('singRIGHT');
				addOffset('singLEFT');
				addOffset('singDOWN');
				playAnim('idle');
				setGraphicSize(Std.int(width * 1.5));
				updateHitbox();

				antialiasing = false;
			case 'pico':
				tex = Paths.getSparrowAtlas('characters/pico/Pico_FNF_assetss');
				frames = tex;
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				if (isPlayer)
				{
					animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				addOffset('idle');
				addOffset("singUP", -29, 27);
				addOffset("singRIGHT", -68, -7);
				addOffset("singLEFT", 65, 9);
				addOffset("singDOWN", 200, -70);
				addOffset("singUPmiss", -19, 67);
				addOffset("singRIGHTmiss", -60, 41);
				addOffset("singLEFTmiss", 62, 64);
				addOffset("singDOWNmiss", 210, -28);

				playAnim('idle');

				flipX = true;
			case 'parents-christmas':
				frames = Paths.getSparrowAtlas('characters/christmas/mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);
	
				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);
	
				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);
	
				addOffset('idle');
				addOffset("singUP", -47, 24);
				addOffset("singRIGHT", -1, -23);
				addOffset("singLEFT", -30, 16);
				addOffset("singDOWN", -31, -29);
				addOffset("singUP-alt", -47, 24);
				addOffset("singRIGHT-alt", -1, -24);
				addOffset("singLEFT-alt", -30, 15);
				addOffset("singDOWN-alt", -30, -27);
	
				playAnim('idle');
			case 'sigmio':
				frames = Paths.getSparrowAtlas('characters/weeb/sigmio');
				animation.addByPrefix('danceLeft', 'danceLeft', 30, false);
				animation.addByPrefix('danceRight', 'danceRight', 30, false);
				animation.addByPrefix('singUP', 'Right', 30, false);
				animation.addByPrefix('singLEFT', 'Left', 30, false);
				animation.addByPrefix('singRIGHT', 'Up', 30, false);
				animation.addByPrefix('singDOWN', 'Down', 30, false);

				addOffset('danceLeft');
				addOffset('danceRight');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('danceRight');

				setGraphicSize(Std.int(width * 3));
				updateHitbox();

				antialiasing = false;
			case 'sigmio-evil':
				frames = Paths.getSparrowAtlas('characters/weeb/sigmioEVIL');
				animation.addByPrefix('idle', 'dance', 30, true);
				animation.addByPrefix('singUP', 'Right', 30, false);
				animation.addByPrefix('singLEFT', 'Left', 30, false);
				animation.addByPrefix('singRIGHT', 'Up', 30, false);
				animation.addByPrefix('singDOWN', 'Down', 30, false);

				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");

				playAnim('idle');

				setGraphicSize(Std.int(width * 3));
				updateHitbox();

				antialiasing = false;
			case 'spirit':
				frames = Paths.getPackerAtlas('characters/weeb/spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				addOffset('idle', -220, -280);
				addOffset('singUP', -220, -240);
				addOffset("singRIGHT", -220, -280);
				addOffset("singLEFT", -200, -280);
				addOffset("singDOWN", 170, 110);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;
			case 'sigmio-final':
				frames = Paths.getSparrowAtlas('characters/unfair/sigmioFONIALFORM');
				animation.addByPrefix('idle', "idle", 24, true);
				animation.addByPrefix('singUP', "up", 24, false);
				animation.addByPrefix('singRIGHT', "right", 24, false);
				animation.addByPrefix('singLEFT', "left", 24, false);
				animation.addByPrefix('singDOWN', "down", 24, false);

				addOffset('idle');
				addOffset('singUP', 0, 150);
				addOffset("singRIGHT");
				addOffset("singLEFT", 100);
				addOffset("singDOWN", 0, 100);

				setGraphicSize(Std.int(width * 1.5));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;
			case 'spiritfakeout':
				frames = Paths.getSparrowAtlas('characters/unfair/thornsfakeout');
				animation.addByPrefix('idle', "Idle instance ", 24, false);
				animation.addByPrefix('singUP', "Up instance ", 24, false);
				animation.addByPrefix('singRIGHT', "Right instance ", 24, false);
				animation.addByPrefix('singLEFT', "Left instance ", 24, false);
				animation.addByPrefix('singDOWN', "Down instance ", 24, false);
				animation.addByPrefix('die', "die instance ", 24, false);
	
				addOffset('idle', -550, -300);
				addOffset("singUP", -550, -300);
				addOffset("singRIGHT", -550, -300);
				addOffset("singLEFT", -550, -300);
				addOffset("singDOWN", -550, -300);
				addOffset("die", -550, -300);
	
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
	
				playAnim('idle');
			case 'unfairJo':
				tex = Paths.getSparrowAtlas('characters/unfair/unfairJo');
				frames = tex;
				animation.addByPrefix('idle', 'Idle instance ', 24,false);
				animation.addByPrefix('singUP', 'Up instance ', 24,false);
				animation.addByPrefix('singRIGHT', 'Left instance ', 24,false);
				animation.addByPrefix('singDOWN', 'Down instance ', 24,false);
				animation.addByPrefix('singLEFT', 'Right instance ', 24,false);
	
				addOffset('idle');
				addOffset("singUP");
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
	
				playAnim('idle');
	
				setGraphicSize(Std.int(width * 2.5));
					
				antialiasing = false;
	
				flipX = true;
			case 'sigmiofinalalt':
				frames = Paths.getSparrowAtlas('characters/unfair/sigmiofinale');
				animation.addByPrefix('idle', "Idle instance ", 10, true);
				animation.addByPrefix('singUP', "Up instance ", 24, false);
				animation.addByPrefix('singRIGHT', "Right instance ", 24, false);
				animation.addByPrefix('singLEFT', "Left instance ", 24, false);
				animation.addByPrefix('singDOWN', "Down instance ", 24, false);
	
				addOffset('idle');
				addOffset('singUP');
				addOffset("singRIGHT");
				addOffset("singLEFT");
				addOffset("singDOWN");
	
				setGraphicSize(Std.int(width * 9));
				updateHitbox();
	
				playAnim('idle');
	
				antialiasing = false;				
			case 'sonicexe':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/exe/sonicexe');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 30, false);
				animation.addByPrefix('singUP', 'Up', 30, false);
				animation.addByPrefix('singRIGHT', 'Right', 30, false);
				animation.addByPrefix('singDOWN', 'Down', 30, false);
				animation.addByPrefix('singLEFT', 'Left', 30, false);
				animation.addByPrefix('laugh', 'Laugh', 30, false);
	
				addOffset('idle');
				addOffset("singUP", 176, 90);
				addOffset("singRIGHT", -120, 10);
				addOffset("singLEFT", 190, 0);
				addOffset("singDOWN", 0, -100);
					
				setGraphicSize(Std.int(width * 1.25));
	
				playAnim('idle');							
			case 'Nugget':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/bopcity/Nugget');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 16, false);
				animation.addByPrefix('singUP', 'Up', 30, false);
				animation.addByPrefix('singRIGHT', 'Right', 30, false);
				animation.addByPrefix('singDOWN', 'Down', 30, false);
				animation.addByPrefix('singLEFT', 'Left', 30, false);
				
				addOffset("idle",77,0);
				addOffset("singUP", 68, 50);
				addOffset("singRIGHT", 20, 0);
				addOffset("singLEFT", 500, 0);
				addOffset("singDOWN", 58, -30);
				
				scale.set(0.6, 0.6);
				
				updateHitbox();
				
				playAnim('idle');	
			case 'nuggetdance':
				tex = Paths.getSparrowAtlas('characters/bopcity/nuggetdance');
				frames = tex;
				animation.addByPrefix('idle', 'dance', 24, true);
				animation.addByPrefix('singUP', 'dance', 30, false);
				animation.addByPrefix('singRIGHT', 'dance', 30, false);
				animation.addByPrefix('singDOWN', 'dance', 30, false);
				animation.addByPrefix('singLEFT', 'dance', 30, false);

				addOffset('idle');
				addOffset('singUP');
				addOffset('singRIGHT');
				addOffset('singDOWN');
				addOffset('singLEFT');

				playAnim('idle');				
			case 'blocku':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/bopcity/blocku');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 16, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				
				addOffset('idle');
				addOffset("singUP", 10, 210);
				addOffset("singRIGHT", -50, -20);
				addOffset("singLEFT", 90, -20);
				addOffset("singDOWN", 188, -180);
				
				scale.set(1.2, 1.2);
				
				updateHitbox();
				
				
				playAnim('idle');	
			case 'evilblocku':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/bopcity/evilblocku');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 16, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				
				addOffset('idle');
				addOffset("singUP", 10, 210);
				addOffset("singRIGHT", -50, -20);
				addOffset("singLEFT", 90, -20);
				addOffset("singDOWN", 188, -180);
				
				scale.set(1.2, 1.2);
				
				updateHitbox();
				
				
				playAnim('idle');	
			case 'niceblocku':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/bopcity/niceblocku');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 16, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				
				addOffset('idle');
				addOffset("singUP", 10, 210);
				addOffset("singRIGHT", -50, -20);
				addOffset("singLEFT", 90, -20);
				addOffset("singDOWN", 188, -180);
				
				scale.set(1.2, 1.2);
				
				updateHitbox();
				
				
				playAnim('idle');	
			case 'afton':
				// DAD ANIMATION LOADING CODE
				tex = Paths.getSparrowAtlas('characters/fnaf/afton');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 16, true);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
				
				addOffset('idle', 0, -200);
				addOffset("singUP", 0, -200);
				addOffset("singRIGHT", 0, -200);
				addOffset("singLEFT", 0, -200);
				addOffset("singDOWN", 0, -200);
				
				setGraphicSize(Std.int(width * 2.5));
				
				updateHitbox();
				
				
				playAnim('idle');	
			case 'bean':
				tex = Paths.getSparrowAtlas('characters/sussy/bean');
				frames = tex;
				animation.addByPrefix('idle', 'amogus idle instance ', 24);
				animation.addByPrefix('singUP', 'amogus up instance ', 24);
				animation.addByPrefix('singRIGHT', 'rightt instance ', 24);
				animation.addByPrefix('singDOWN', 'down instance ', 24);
				animation.addByPrefix('singLEFT', 'Mogus left instance ', 24);

				addOffset('idle');
				addOffset("singUP",0,180);
				addOffset("singRIGHT");
				addOffset("singLEFT",230,-30);
				addOffset("singDOWN",50,-40);

				playAnim('idle');
			case 'andy':
				tex = Paths.getSparrowAtlas('characters/andy/andy');
				frames = tex;
				animation.addByPrefix('singUP', 'Up', 30, false);
				animation.addByPrefix('singDOWN', 'Down', 30, false);
				animation.addByPrefix('singLEFT', 'Left', 30, false);
				animation.addByPrefix('singRIGHT', 'Right', 30, false);
				animation.addByPrefix('idle', 'Idle', 30, true);
	
				addOffset('idle');
	
				addOffset("singUP", 119, 44);
				addOffset("singRIGHT", 32, 0);
				addOffset("singLEFT", 27, 0);
				addOffset("singDOWN", 4, -10);
	
				playAnim('idle');
			case 'picy':
				frames = Paths.getSparrowAtlas('characters/andy/picy');
				animation.addByPrefix('idle', 'Idle', 30, true);
				animation.addByPrefix('singUP', 'Up', 30, false);
				animation.addByPrefix('singLEFT', 'Left', 30, false);
				animation.addByPrefix('singRIGHT', 'Right', 30, false);
				animation.addByPrefix('singDOWN', 'Down', 30, false);
				animation.addByPrefix('singUPmiss', 'MISSUp', 30, false);
				animation.addByPrefix('singLEFTmiss', 'MISSLeft', 30, false);
				animation.addByPrefix('singRIGHTmiss', 'MISSRight', 30, false);
				animation.addByPrefix('singDOWNmiss', 'MISSDown', 30, false);


				addOffset('idle');
				addOffset("singUP", 36, 55);
				addOffset("singRIGHT", -50, 2);
				addOffset("singLEFT", 146, -10);
				addOffset("singDOWN", 20, -41);
				addOffset("singUPmiss", 36, 55);
				addOffset("singRIGHTmiss", -50, 2);
				addOffset("singLEFTmiss", 146, -10);
				addOffset("singDOWNmiss", 20, -41);

				playAnim('idle');

				flipX = false;
			case 'scopguy':
				frames = Paths.getSparrowAtlas('characters/foundation/scopguy');

				animation.addByPrefix('idle', "Idle", 10, true);
				animation.addByPrefix('singUP', "Up", 24, false);
				animation.addByPrefix('singRIGHT', "Right", 24, false);
				animation.addByPrefix('singLEFT', "Left", 24, false);
				animation.addByPrefix('singDOWN', "Down", 24, false);

				addOffset('idle', 0, -200);
				addOffset('singUP', 0, -200);
				addOffset("singRIGHT", 0, -200);
				addOffset("singLEFT", 0, -200);
				addOffset("singDOWN", 0, -200);

				updateHitbox();

				playAnim('idle');
			default:
				trace('couldnt get case');
				var charFile:String;
				var charFileParams:Array<String> = [];

				if (characterArray != null) {
					charFileParams = characterArray;
				}
				else {
					charFile = Paths.txt("characters/"+curCharacter);
					charFileParams = CoolUtil.coolTextFile(charFile);
				}

				for (i in 0...charFileParams.length) {
					charFileParams[i].trim();
					var line:Array<String> = charFileParams[i].split("::");
					switch (line[0]) {
						case 'sprite':
							frames = Paths.getSparrowAtlasShared('characters/'+line[1]);
						case 'anim':
							var loopa:Bool = false;
							var flipXa:Bool = false;
							var flipYa:Bool = false;

							if (line[4] == "true")
								loopa = true;
							if (line[5] == "true")
								flipXa = true;
							if (line[6] == "true")
								flipYa = true;

							animation.addByPrefix(line[1], line[2], Std.parseFloat(line[3]), loopa, flipXa, flipYa);
						case 'offset':
							addOffset(line[1], Std.parseFloat(line[2]), Std.parseFloat(line[3]));
						case 'pixel':
							setGraphicSize(Std.int(width * 6));
							updateHitbox();
							antialiasing = false;
						case 'flipX':
							flipX = true;
						case 'flipY':
							flipY = true;
						case 'size':
							setGraphicSize(Std.parseFloat(line[1]), Std.parseFloat(line[2]));
					}
				}

				playAnim('idle');
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'sigmio':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
