var thankBoppers:FlxSprite;

function onLoad() {
    var bg:FlxSprite = new FlxSprite(-600, -800).loadGraphic(Paths.image('stages/thanksgiving/evilBG'));
	bg.antialiasing = true;
	bg.scrollFactor.set(0.9, 0.9);
	bg.active = false;
	bg.updateHitbox();
	add(bg);

	thankBoppers = new FlxSprite(-550, -160);
	thankBoppers.frames = Paths.getSparrowAtlas('stages/thanksgiving/scaredboppers');
	thankBoppers.animation.addByPrefix('bop', 'bop', 24, false);
	thankBoppers.antialiasing = true;
	thankBoppers.updateHitbox();

	var fg:FlxSprite = new FlxSprite(-600, 330).loadGraphic(Paths.image('stages/thanksgiving/evilfront'));
	fg.active = false;
	fg.antialiasing = true;
	add(fg);
	add(thankBoppers);
}

function onBeatHit() {
    thankBoppers.animation.play('bop', true);

	if (curBeat == 544) FlxTween.tween(dad, {alpha: 0}, 1.5, {ease: FlxEase.linear});
}