package;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;

class CreditsState extends MusicBeatState {
    var curSelected:Int = 0;

    var grpCredits:Array<String> = ["poe","x8c8r","didgie","jo560hs","xario","roborecona","artsy","cobblestoneface","earthlivecountry","thomicfee"];

    var devCreditImage:FlxSprite;

    public override function create() {
        super.create();
        devCreditImage = new FlxSprite();
        add(devCreditImage);
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

        devCreditImage.loadGraphic(Paths.image("credits/"+grpCredits[curSelected]));
    }
}

typedef CreditsCredit = {
    var name:String;
    var description:String;
}