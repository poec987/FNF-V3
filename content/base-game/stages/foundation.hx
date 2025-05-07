function onLoad() {
    var bg:FlxSprite = new FlxSprite(0, 0);
    bg.scale.set(2, 2);
    bg.updateHitbox();
    bg.loadGraphic(Paths.image("stages/foundation/bg"));
	add(bg); 
}