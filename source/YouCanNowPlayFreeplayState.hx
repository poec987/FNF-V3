import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.FlxState;

class YouCanNowPlayFreeplayState extends FlxState {

    override function create() {
        FlxG.sound.music.destroy();

        var img:FlxSprite = new FlxSprite().loadGraphic(Paths.image("stages/yay"));
        add(img);
        img.alpha = 0;
        FlxTween.tween(img, {"alpha": 1}, 1, {ease: FlxEase.expoInOut});

        super.create();
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.ENTER)
            FlxG.switchState(new MainMenuState());
        super.update(elapsed);
    }
}