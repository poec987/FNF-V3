package;

import flixel.util.FlxTimer;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxSprite;

typedef FunkinResults = {
    var sick:Int;
    var good:Int;
    var bad:Int;
    var shit:Int;
    var miss:Int;
    var score:Int;
    var accuracy:Float;
    var rating:String;
}

class ResultsSubState extends MusicBeatSubstate {
    var sickText:FlxText;
    var goodText:FlxText;
    var badText:FlxText;
    var shitText:FlxText;
    var missText:FlxText;
    var scoreText:FlxText;
    var accText:FlxText;
    var ratingText:FlxText;

    var texts:FlxTypedGroup<FlxText>;
    var playState:PlayState;
    
    public function new(x:Float, y:Float, results:FunkinResults, playState:PlayState) {
        super();

        this.playState = playState;

        texts = new FlxTypedGroup<FlxText>();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.stage.stageWidth, FlxG.stage.stageHeight, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

        var exitText = new FlxText(-150, FlxG.height - 150, 0, "Press ENTER to finish", 24, false);
        exitText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, FlxTextAlign.LEFT);

        sickText = new FlxText(-150, 150, 0, "Sicks: " + results.sick, 32, false);
        goodText = new FlxText(-150, 185, 0, "Goods: " + results.good, 32, false);
        badText = new FlxText(-150, 215, 0, "Bads: " + results.bad, 32, false);
        shitText = new FlxText(-150, 245, 0, "Shits: " + results.shit, 32, false);
        missText = new FlxText(-150, 275, 0, "Misses: " + results.miss, 32, false);
        scoreText = new FlxText(-150, 25, 0, "Score: " + results.score, 64, false);
        accText = new FlxText(-150, 450, 0, "Accuracy: " + results.accuracy, 48, false);
        ratingText = new FlxText(-150, 500, 0, "Rating: " + results.rating, 48, false);

        sickText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        goodText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        badText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        shitText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        missText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        scoreText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, FlxTextAlign.LEFT);
        accText.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, FlxTextAlign.LEFT);
        ratingText.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, FlxTextAlign.LEFT);

        texts.add(sickText);
        texts.add(goodText);
        texts.add(badText);
        texts.add(shitText);
        texts.add(missText);
        texts.add(scoreText);
        texts.add(accText);
        texts.add(ratingText);
        texts.add(exitText);

        texts.forEach((t:FlxText) -> {
            t.alpha = 0;
        });

        add(texts);

        for (i in 0... texts.length) {
            new FlxTimer().start(0.1 * (i+1), (timer:FlxTimer) -> {
                FlxTween.tween(texts.members[i], {alpha: 1, x: 50}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
            });
            new FlxTimer().start(0.3 + (0.1*(i + 1)), (timer:FlxTimer) -> {
                FlxG.sound.play(Paths.sound('scrollMenu'));
            });
        };

        FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});

    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.ENTER) {
            playState.wakeTheFuckUp();
            close();
        }
    }
}