var explosion:FlxSprite;
var fortnitecard:FlxSprite;

function onLoad() {
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
			
	explosion = new FlxSprite(-200, 300);
	explosion.frames = Paths.getSparrowAtlas('stages/bopcity/explosion');
	explosion.animation.addByPrefix('idle', 'settle', 24, true);
	explosion.animation.addByPrefix('boom', 'boom', 30, false);
	explosion.updateHitbox();
	explosion.antialiasing = false;
	explosion.scale.set(2,2.4);
	explosion.cameras = [camHUD];
	foreground.add(explosion);
	explosion.animation.play('idle', true);
			
	fortnitecard = new FlxSprite( -650, 600).loadGraphic(Paths.image('stages/bopcity/card'));
			
	fortnitecard.cameras = [camHUD];
	fortnitecard.screenCenter();
	fortnitecard.updateHitbox();
	fortnitecard.alpha = 0;
	add(fortnitecard);
}

function onBeatHit() {
    switch (curBeat)
	{
		case 111:
			explosion.animation.play('boom', true);
		case 112:
            PlayState.instance.triggerEventNote('Change Character', 'dad', 'evilblocku');
		case 220:
            PlayState.instance.triggerEventNote('Change Character', 'dad', 'niceblocku');
	}
}

function onStepHit() {
    if (curStep == 1071) {
        PlayState.instance.triggerEventNote('Change Character', 'bf', 'nuggetdance');
    }
    if (curStep == 1011) {
        fortnitecard.alpha = 1;
		FlxTween.tween(fortnitecard, {'alpha': 0}, 1.5, {ease: FlxEase.quadOut});
    }
}