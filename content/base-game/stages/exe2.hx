var glow:FlxSprite;

function onLoad() {
	game.precacheList.set('stages/exetwo/exe2back', 'image');
	game.precacheList.set('stages/exetwo/exe2glow', 'image');
	game.precacheList.set('stages/exetwo/exe2front', 'image');
	game.precacheList.set('characters/EXETWO', 'image');
	game.precacheList.set('characters/bfNervous', 'image');

    var bg:FlxSprite = new FlxSprite(-400, -700).loadGraphic(Paths.image('stages/exetwo/exe2back'));
	bg.antialiasing = true;
	bg.scrollFactor.set(0.9, 0.9);
	bg.scale.set(0.8,0.8);
	bg.active = false;
	bg.updateHitbox();
	add(bg);
	
	glow = new FlxSprite(-400, -700).loadGraphic(Paths.image('stages/exetwo/exe2glow'));
	glow.antialiasing = true;
	glow.scale.set(0.8,0.8);
	glow.alpha = 0;
	glow.updateHitbox();
	add(glow);

	var fg:FlxSprite = new FlxSprite(-400, -700).loadGraphic(Paths.image('stages/exetwo/exe2front'));
	fg.scale.set(0.8,0.8);
	fg.active = false;
	fg.antialiasing = true;
	fg.updateHitbox();
	add(fg);
}


function onBeatHit() {
	if (curBeat >= 72)
	{
		glow.alpha = 1;
		FlxTween.tween(glow, {alpha: 0}, 0.3);
	}
}