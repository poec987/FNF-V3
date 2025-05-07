addHaxeLibrary("GlitchEffect", "gameObjects.shader");
addHaxeLibrary("FlxStringUtil", "flixel.util");
addHaxeLibrary("FlxTrail", "flixel.addons.effects");
var unfairJbg:FlxSprite;
var thornbg:FlxSprite;
var sigmioreveal:Bool = false;
var unfairJevents:Array<Bool> = [false, false];
var blackShitJ:FlxSprite;
var whiteShitJ:FlxSprite;
var lol:FlxSprite;
var bfTrailJ:FlxTrail;
var dadTrailJ:FlxTrail;

var endTime:Float = 66857;


function onLoad() {
    unfairjShader = new GlitchEffect();
	unfairjShader.waveAmplitude = 0.1;
	unfairjShader.waveFrequency = 5;
	unfairjShader.waveSpeed = 1;

	unfairJbg = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/ikea/jo'));
	unfairJbg.antialiasing = false;
	unfairJbg.shader = unfairjShader.shader;
	unfairJbg.scrollFactor.set(0.9, 0.9);
	unfairJbg.alpha = 0;
	add(unfairJbg);

	thornbg = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/ikea/thorn'));
	thornbg.antialiasing = false;
	thornbg.alpha = 1;
	add(thornbg);

    blackShitJ = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
	whiteShitJ = new FlxSprite( -1280, -720).makeGraphic(FlxG.width * 3, FlxG.height * 3, FlxColor.WHITE);
	whiteShitJ.alpha = 0;
	foreground.add(whiteShitJ);

    PlayState.instance.updateTime = false;
}

function onMoveCamera(who:String) {
    if (who == "dad") {
        if (sigmioreveal == true)
        {
            if (unfairJevents[1] == false) { 
                if (unfairJevents[0] == false) {
                    game.camFollow.y = dad.getMidpoint().y - 225;
                    game.camFollow.x = dad.getMidpoint().x + 150;
                }
                else {
                    game.camFollow.y = dad.getMidpoint().y - 225;
                    game.camFollow.x = dad.getMidpoint().x + 150;
                }
                // FlxTween.tween(FlxG.camera, {zoom: 0.95}, (Conductor.stepCrochet * 4 / 1000), {ease: FlxEase.linear});
            }
            else
            {
                game.camFollow.y = dad.getMidpoint().y - 290;
                game.camFollow.x = dad.getMidpoint().x - 300;
            }
        }
        else
        {
            game.camFollow.x = boyfriend.getMidpoint().x - 550;
            game.camFollow.y = boyfriend.getMidpoint().y - 220;
        }
    }
    else {
        if (unfairJevents[1] == false) { 
            if (unfairJevents[0] == false) {
                game.camFollow.x = boyfriend.getMidpoint().x - 400;
                game.camFollow.y = boyfriend.getMidpoint().y - 200;
            }
            else {
                game.camFollow.x = boyfriend.getMidpoint().x - 300;
                game.camFollow.y = boyfriend.getMidpoint().y - 100;
            }
        }
        else
        {
            game.camFollow.y = dad.getMidpoint().y - 290;
            game.camFollow.x = dad.getMidpoint().x - 300;
        }
    }
}

function onUpdatePost() {
    if (Conductor.songPosition < 66857) {
        game.songPercent = ((Conductor.songPosition - ClientPrefs.noteOffset) / (66857));
		timeTxt.text = FlxStringUtil.formatTime(Math.floor(((66857) - (Conductor.songPosition - ClientPrefs.noteOffset)) / 1000), false);
    }
    else if (endTime > 66857) {
        game.songPercent = ((Conductor.songPosition - ClientPrefs.noteOffset) / (endTime));
		timeTxt.text = FlxStringUtil.formatTime(Math.floor(((endTime) - (Conductor.songPosition - ClientPrefs.noteOffset)) / 1000), false);
    }
    else {
        game.songPercent = 1;
        timeTxt.text = "0:00";
    }
}

function onBeatHit() {
    switch (curBeat) {
        case 156: //156
            dad.animation.play('die', true);
            FlxTween.tween(whiteShitJ, {alpha: 1}, 1.5, {ease: FlxEase.linear});
        case 160: //160
            PlayState.instance.triggerEventNote('Change Character', 'dad', 'sigmio-final');
            sigmioreveal = true;
            unfairJbg.alpha = 1;
            thornbg.alpha = 0;
            FlxTween.tween(whiteShitJ, {alpha: 0}, 1, {ease: FlxEase.linear});
            FlxTween.num(endTime, songLength, 27, {ease: FlxEase.expoIn}, (v) -> {endTime = v;});
            // FlxTween.tween(songTimer, {"endTime": Math.round(songLength/1000)}, 27, {ease:FlxEase.expoIn});
        case 492: // 492
            lol = new FlxSprite(boyfriend.x-200, boyfriend.y - 50).loadGraphic(Paths.image('stages/ikea/cobble'));
            lol.alpha = 0;
            foreground.add(lol);

            FlxTween.tween(lol, {alpha: 1}, 1);
        case 496: // 496
            FlxTween.tween(lol, {alpha: 0}, 1, { onComplete: (twn:FlxTween) -> {
                lol.destroy();
            }});
            
        case 676: // 676
            boyfriend.visible = false;
            unfairJevents[0] = false;
            unfairJevents[1] = true;
            unfairJbg.alpha = 0;

            unfairjShader.waveAmplitude = 0.3;
            unfairjShader.waveFrequency = 4.5;
            unfairjShader.waveSpeed = 1.5;

            // dad = new Character(oldDad.x + 500, oldDad.y+200, 'sigmiofinalalt');
            PlayState.instance.triggerEventNote('Change Character', 'dad', 'sigmiofinalalt');
            dad.x += 500;
            dad.y += 200;

            whiteShitJ.alpha = 1;
            
            FlxTween.tween(whiteShitJ, {alpha: 0}, 1, {ease: FlxEase.linear});
        case 708: // 708
            FlxTween.tween(unfairJbg, {"alpha": 0.5}, 2, {ease: FlxEase.linear});
        case 804: // 804
            dadTrailJ = new FlxTrail(dad, null, 3, 24, 0.3, 0.05);
            
            add(dadTrailJ);
            
    }
}

function onStepHit() {
    switch (curStep) {
        case 1918: // 1918
            unfairJevents[0] = true;

            blackShitJ.scrollFactor.set();
            foreground.add(blackShitJ);
            camHUD.visible = false;

            dad.setGraphicSize(0.75);
            dad.x += 200;
            dad.y -= 150;

            PlayState.instance.triggerEventNote('Change Character', 'bf', 'unfairJo');
            boyfriend.y += 200;

            unfairjShader.waveAmplitude = 0.2;
            unfairjShader.waveSpeed = 1.5;
        case 1936: // 1936
            blackShitJ.destroy();
            camHUD.visible = true;
        case 3470: // 3470

            PlayState.instance.triggerEventNote('Change Character', 'dad', 'sigmio-final');

            boyfriend.visible = true;
            unfairJevents[0] = true;
            unfairJevents[1] = false;
            unfairJbg.alpha = 1;
            whiteShitJ.alpha = 1;
            FlxTween.tween(whiteShitJ, {alpha: 0}, 1, {ease: FlxEase.linear});

            unfairjShader.waveFrequency = 4;
            unfairjShader.waveSpeed = 2;

            dadTrailJ.destroy();
            bfTrailJ = new FlxTrail(boyfriend, null, 3, 24, 0.3, 0.05);
            dadTrailJ = new FlxTrail(dad, null, 3, 24, 0.3, 0.05);
            add(bfTrailJ);
            add(dadTrailJ);
            
    }
}