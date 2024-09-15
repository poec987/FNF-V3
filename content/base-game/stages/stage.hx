function onLoad() {
    var bg:FlxSprite = new FlxSprite(-600, -200);
    bg.loadGraphic(Paths.image("stages/stage/stageback"));
	add(bg); 

    var stageFront:FlxSprite = new FlxSprite(-600, 600);
    stageFront.loadGraphic(Paths.image("stages/stage/stagefront"));
    add(stageFront);

    var stageCurtains:FlxSprite = new FlxSprite(-600, -300);
    stageCurtains.loadGraphic(Paths.image("stages/stage/stagecurtains"));
    foreground.add(stageCurtains);

    trace("DICK");
}