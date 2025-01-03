var heyTimer:Float;
var upperBoppers:BGSprite;
var bottomBoppers:BGSprite;
var santa:BGSprite;
var dieded:Bool = false;

function onLoad(){
    var bg:BGSprite = new BGSprite('stages/christmas/bgWalls', -1000, -500, 0.2, 0.2);
    bg.setGraphicSize(Std.int(bg.width * 0.8));
    bg.updateHitbox();
    add(bg);

    if(!ClientPrefs.lowQuality) {
        upperBoppers = new BGSprite('stages/christmas/upperBop', -240, -90, 0.33, 0.33, ['Upper Crowd Bob']);
        upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
        upperBoppers.updateHitbox();
        add(upperBoppers);

        var bgEscalator:BGSprite = new BGSprite('stages/christmas/bgEscalator', -1100, -600, 0.3, 0.3);
        bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
        bgEscalator.updateHitbox();
        add(bgEscalator);
    }

    var tree:BGSprite = new BGSprite('stages/christmas/christmasTree', 370, -250, 0.40, 0.40);
    add(tree);

    bottomBoppers = new BGSprite('stages/christmas/bottomBop', -300, 140, 0.9, 0.9, ['Bottom Level Boppers']);
    bottomBoppers.animation.addByPrefix('hey', 'Bottom Level Boppers HEY', 24, false);
    bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
    bottomBoppers.updateHitbox();
    add(bottomBoppers);

    var fgSnow:BGSprite = new BGSprite('stages/christmas/fgSnow', -600, 700);
    add(fgSnow);

    santa = new BGSprite('stages/christmas/santa', -840, 150, 1, 1, ['santa idle in fear']);
    santa.animation.addByPrefix('die', 'santa DIE', 24, false);
    add(santa);
}

function onCountdownTick(){
    if(!ClientPrefs.lowQuality) {
        upperBoppers.dance(true);
    }

    bottomBoppers.dance(true);
    santa.dance(true);
}

function onBeatHit(){
    if (curBeat == 96) {
        santa.playAnim("die");
        dieded = true;
    }
    if(!ClientPrefs.lowQuality) {
        upperBoppers.dance(true);
    }

    bottomBoppers.dance(true);
    if (!dieded) santa.dance(true);
}