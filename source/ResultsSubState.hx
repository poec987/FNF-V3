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
}

class ResultsSubState extends MusicBeatSubstate {
    var sickText:FlxText;
    var goodText:FlxText;
    var badText:FlxText;
    var shitText:FlxText;
    var missText:FlxText;
    var scoreText:FlxText;
    var accText:FlxText;

    var texts:FlxTypedGroup<FlxText>;

    var playState:PlayState;
    
    public function new(x:Float, y:Float, results:FunkinResults, playState:PlayState) {
        super();

        this.playState = playState;

        texts = new FlxTypedGroup<FlxText>();

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

        var exitText = new FlxText(20, FlxG.height - 150, 0, "Press ENTER to finish", 24, false);
        exitText.setFormat(Paths.font("vcr.ttf"), 24, FlxColor.WHITE, FlxTextAlign.LEFT);

        sickText = new FlxText(20, 150, 0, "Sicks: " + results.sick, 32, false);
        goodText = new FlxText(20, 185, 0, "Goods: " + results.good, 32, false);
        badText = new FlxText(20, 215, 0, "Bads: " + results.bad, 32, false);
        shitText = new FlxText(20, 245, 0, "Shits: " + results.shit, 32, false);
        missText = new FlxText(20, 275, 0, "Misses: " + results.miss, 32, false);
        scoreText = new FlxText(20, 25, 0, "Score: " + results.score, 64, false);
        accText = new FlxText(20, 450, 0, "Accuracy: " + results.accuracy + "%", 48, false);

        sickText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        goodText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        badText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        shitText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        missText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, FlxTextAlign.LEFT);
        scoreText.setFormat(Paths.font("vcr.ttf"), 64, FlxColor.WHITE, FlxTextAlign.LEFT);
        accText.setFormat(Paths.font("vcr.ttf"), 48, FlxColor.WHITE, FlxTextAlign.LEFT);

        texts.add(sickText);
        texts.add(goodText);
        texts.add(badText);
        texts.add(shitText);
        texts.add(missText);
        texts.add(scoreText);
        texts.add(accText);
        texts.add(exitText);

        texts.forEach((t:FlxText) -> {
            t.alpha = 0;
            t.x = -150;
        });

        add(texts);

        for (i in 0... texts.length) {
            new FlxTimer().start(0.1 * (i+1), (timer:FlxTimer) -> {
                FlxTween.tween(texts.members[i], {alpha: 1, x: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
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