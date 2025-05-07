addHaxeLibrary('FuckScorp', 'gameObjects.shader');
addHaxeLibrary('ShaderFilter', 'openfl.filters');

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

    game.allowCamZooming = false;

    stupidFuckingSpotlight1 = new FlxSprite(boyfriend.x, -50);
    stupidFuckingSpotlight1.loadGraphic(Paths.image('stages/stage/spotlight'));
    foreground.add(stupidFuckingSpotlight1);

    stupidFuckingSpotlight2 = new FlxSprite(dad.x, -50);
    stupidFuckingSpotlight2.loadGraphic(Paths.image('stages/stage/spotlight'));    
    foreground.add(stupidFuckingSpotlight2);

    stupidFuckingSpotlight1.visible = false;
    stupidFuckingSpotlight2.visible = false;
}

function onCreatePost() {
    FlxG.resizeWindow(960, 720);
    FlxG.scaleMode.height = 968;
    FlxG.camera.height = 968;
    game.camHUD.height = 968;

    var fuck:FuckScorp = new FuckScorp();

    game.camGame.setFilters([new ShaderFilter(fuck)]);
    game.camHUD.setFilters([new ShaderFilter(fuck)]);
    game.camOther.setFilters([new ShaderFilter(fuck)]);
}

function onBeatHit() {
    
}

function onDestroy(){
    FlxG.resizeWindow(1280, 720);
    FlxG.scaleMode.height = 720;  
    FlxG.camera.height = 720;  
}