var bgFucks:BGSprite;
var pissedSigma:Bool = false;

function onLoad(){
    GameOverSubstate.deathSoundName = 'pixel/fnf_loss_sfx-pixel';
    GameOverSubstate.loopSoundName = 'pixel/gameOver-pixel';
    GameOverSubstate.endSoundName = 'pixel/gameOverEnd-pixel';
    GameOverSubstate.characterName = 'pixel/bf-pixel-dead';

    if (PlayState.SONG.song == "Roses") pissedSigma = true;

    var bgSky:BGSprite = new BGSprite('stages/weeb/weebSky', 0, 0, 0.1, 0.1);
    add(bgSky);
    bgSky.antialiasing = false;

    var repositionShit = -200;

    var bgSchool:BGSprite = new BGSprite('stages/weeb/weebSchool', repositionShit, 0, 0.6, 0.90);
    add(bgSchool);
    bgSchool.antialiasing = false;

    var bgStreet:BGSprite = new BGSprite('stages/weeb/weebStreet', repositionShit, 0, 0.95, 0.95);
    add(bgStreet);
    bgStreet.antialiasing = false;

    var widShit = Std.int(bgSky.width * 6);
    if(!ClientPrefs.lowQuality) {
        var fgTrees:BGSprite = new BGSprite('stages/weeb/weebTreesBack', repositionShit + 170, 130, 0.9, 0.9);
        fgTrees.setGraphicSize(Std.int(widShit * 0.8));
        fgTrees.updateHitbox();
        add(fgTrees);
        fgTrees.antialiasing = false;
    }

    var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
    bgTrees.frames = Paths.getPackerAtlas('stages/weeb/weebTrees');
    bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
    bgTrees.animation.play('treeLoop');
    bgTrees.scrollFactor.set(0.85, 0.85);
    add(bgTrees);
    bgTrees.antialiasing = false;

    if(!ClientPrefs.lowQuality) {
        var treeLeaves:BGSprite = new BGSprite('stages/weeb/petals', repositionShit, -40, 0.85, 0.85, ['PETALS ALL'], true);
        treeLeaves.setGraphicSize(widShit);
        treeLeaves.updateHitbox();
        add(treeLeaves);
        treeLeaves.antialiasing = false;
    }

    bgSky.setGraphicSize(widShit);
    bgSchool.setGraphicSize(widShit);
    bgStreet.setGraphicSize(widShit);
    bgTrees.setGraphicSize(Std.int(widShit * 1.4));

    bgSky.updateHitbox();
    bgSchool.updateHitbox();
    bgStreet.updateHitbox();
    bgTrees.updateHitbox();

    if(!ClientPrefs.lowQuality) {
        bgFucks = new BGSprite('stages/weeb/bgFreaks', -100, 190, 1, 1, ['BG girls group', 'BG fangirls dissuaded']);
        bgFucks.scrollFactor.set(0.9, 0.9);

        // bgGirls.setGraphicSize(Std.int(bgGirls.width * game.daPixelZoom));
        bgFucks.scale.set(6,6);

        if (pissedSigma) bgFucks.playAnim('BG fangirls dissuaded', true);
        else bgFucks.playAnim('BG girls group', true);
        
        bgFucks.updateHitbox();
        add(bgFucks);
    }
}

function onEvent(eventName, value1, value2){ 
    if(eventName == 'BG Freaks Expression') pissedSigma = true;
}

function onCountdownTick(){
    if(!ClientPrefs.lowQuality) {
        if (pissedSigma) bgFucks.playAnim('BG fangirls dissuaded', true);
        else bgFucks.playAnim('BG girls group', true);
    }
}

function onBeatHit(){
    if(!ClientPrefs.lowQuality) {
        if (pissedSigma) bgFucks.playAnim('BG fangirls dissuaded', true);
        else bgFucks.playAnim('BG girls group', true);
    }
}

// function popupNumScore(rating, comboSpr, note){
//     rating.scale.set(6,6);
//     rating.updateHitbox();
//     comboSpr.scale.set(6,6);
//     comboSpr.updateHitbox();
// }