var stupidFuckingSpotlight1:FlxSprite;
var stupidFuckingSpotlight2:FlxSprite;

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
}

function onCreate() { // God forbid the lights be created on onLoad
    stupidFuckingSpotlight1 = new FlxSprite(boyfriend.x, -50);
    stupidFuckingSpotlight1.loadGraphic(Paths.image('stages/stage/spotlight'));
    foreground.add(stupidFuckingSpotlight1);

    stupidFuckingSpotlight2 = new FlxSprite(dad.x, -50);
    stupidFuckingSpotlight2.loadGraphic(Paths.image('stages/stage/spotlight'));    
    foreground.add(stupidFuckingSpotlight2);

    stupidFuckingSpotlight1.visible = false;
    stupidFuckingSpotlight2.visible = false;
}

function onBeatHit() {
    if (PlayState.SONG.song.toLowerCase() == 'dadbattle') {
        if (curBeat == 96) {
            stupidFuckingSpotlight1.visible = true;
            stupidFuckingSpotlight2.visible = true;
        }
        if (curBeat == 160) {
            stupidFuckingSpotlight1.visible = false;
            stupidFuckingSpotlight2.visible = false;
        }
    }
}