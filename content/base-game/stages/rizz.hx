function onLoad() {
	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/rizzy/RizzBG'));
	bg.antialiasing = true;
	bg.active = false;
	add(bg);

	var front:FlxSprite = new FlxSprite().loadGraphic(Paths.image('stages/rizzy/FG'));
	front.antialiasing = true;
	front.alpha = 0.5;
	front.scrollFactor.set(0.9, 0.9);
	front.active = false;
	add(front);
}