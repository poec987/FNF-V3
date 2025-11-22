function onLoad() {
	var bg:FlxSprite = new FlxSprite(-950,-1100).loadGraphic(Paths.image('stages/rizzy/rizzBG'));
	bg.antialiasing = true;
	bg.updateHitbox();
	bg.active = false;
	add(bg);

	var front:FlxSprite = new FlxSprite(-950,-1100).loadGraphic(Paths.image('stages/rizzy/RizzFG'));
	front.antialiasing = true;
	front.alpha = 0.5;
	front.scrollFactor.set(0.9, 0.9);
	front.active = false;
	foreground.add(front);
}