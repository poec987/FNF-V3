import flixel.sound.FlxSound;
import flixel.util.FlxTimer;
import LoadingState.MultiCallback;
import openfl.Assets;
import flixel.FlxG;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.FlxState;
import lime.utils.Assets as LimeAssets;

class YouCanNowPlayFreeplayState extends FlxState {
    var canQuit:Bool = false;
    override function create() {
        FlxG.save.data.unlockedFreeplay = true;
        FlxG.sound.music.destroy();

        var img:FlxSprite = new FlxSprite().loadGraphic(Paths.image("yay"));
        add(img);
        img.alpha = 0;
        new FlxTimer().start(0.5, (tmr:FlxTimer) -> {
            FlxG.sound.play(Paths.sound("yay"));
            FlxTween.tween(img, {"alpha": 1}, 1, {ease: FlxEase.expoInOut, onComplete: (twn:FlxTween) -> {
                var supah:FlxSound;
                supah = new FlxSound().loadEmbedded(Paths.sound("supahfreeplay"));
                supah.play();
                supah.onComplete = () -> {
                    canQuit = true;
                };
            }});
        });

        super.create();
    }

    override function update(elapsed:Float) {
        if (FlxG.keys.justPressed.ANY && canQuit) {
            PlayState.isStoryMode = true;
            PlayState.SONG = Song.loadFromJson('unfairness-jside', 'unfairness-jside');
            PlayState.storyWeek = PlayState.stageDictionary[PlayState.SONG.stage];
            LoadingState.loadAndSwitchState(new PlayState());
        }
        super.update(elapsed);
    }
}