package;

import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;

class CreditsState extends MusicBeatState {
    var curSelected:Int = 0;

    var grpCredits:Array<String> = ["poe","x8c8r","didgie","jo560hs","xario","roborecona","artsy","cobblestoneface","earthlivecountry","thomicfee"];
    var grpCreditsPics:FlxTypedGroup<FlxSprite>;

    var devCreditImage:FlxSprite;

    public override function create() {
        super.create();

        grpCreditsPics = new FlxTypedGroup<FlxSprite>();
        add(grpCreditsPics);

        for (i in 0...grpCredits.length) {
            var pic:FlxSprite = new FlxSprite(i * 1280).loadGraphic(Paths.image("credits/"+grpCredits[i]));
            grpCreditsPics.add(pic);
        }

        scroll();
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        
		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

        if (FlxG.keys.justPressed.RIGHT)
            scroll(1);
        if (FlxG.keys.justPressed.LEFT)
            scroll(-1);
    }

    function scroll(change:Int = 0) {
        FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

        curSelected += change;
        
		if (curSelected < 0)
			curSelected = grpCredits.length - 1;
		if (curSelected >= grpCredits.length)
			curSelected = 0;

        for (i in 0...grpCreditsPics.length) {
            var p = grpCreditsPics.members[i];
            FlxTween.tween(p, { "x": (i - curSelected) * 1280}, 0.1, { ease: FlxEase.expoInOut});
        }
    }
}