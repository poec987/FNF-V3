function onLoad() {
    var bg:FlxSprite = new FlxSprite(0, 0);
    bg.scale.set(1.2, 1.2);
    bg.updateHitbox();
    bg.loadGraphic(Paths.image("stages/andy/andy"));
	add(bg); 
}