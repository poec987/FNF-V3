function onLoad() {
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
}