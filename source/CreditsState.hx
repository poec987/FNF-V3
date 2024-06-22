package;

import flixel.FlxObject;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;

class CreditsState extends MusicBeatState {
    var curSelected:Int = 0;
    var camFollow:FlxObject;

    var credits:Array<CreditsCredit> = [
        {name: "Le devs", description: ""},
        {name: "", description: ""},
        {name: "x8c8r", description: "Coded a bunch of shit, made a few songs, redrew some graphics. i coded this menu i get to be first"},
        {name: "didgie", description: "Also coded a bunch of shit, made almost every song, made sprites"},
        {name: "poedev", description: "Also also coded a bunch of shit, also made a lot of sprites"},
        {name: "jo560hs", description: "He was there i guess, provided some sprites for weeks 4 and 6"},
        {name: "", description: ""},
        {name: "Special Thanks", description: ""},
        {name: "", description: ""},
        {name: "earthlivecountry", description: "made fnf v2, goated"},
        {name: "shadowmario", description: "thanks for being an inspiration mr mario"},
        {name: "KadeDev", description: "Made Kade Engine lol"}
    ];

    var grpCredits:FlxTypedGroup<Alphabet>;

    public override function create() {
        super.create();

        camFollow = new FlxObject(0, 0, 0, 1);
        add(camFollow);

        FlxG.camera.follow(camFollow, null, 10);
        
        grpCredits = new FlxTypedGroup<Alphabet>();

        for (i in 0...credits.length) {
            var thing:Alphabet = new Alphabet(64, 150 + (i*32), credits[i].name);
            thing.isMenuItem = true;
            thing.targetY = i;
            grpCredits.add(thing);
            add(thing);
        }

        scroll();
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        
		if (controls.BACK)
		{
			FlxG.switchState(new MainMenuState());
		}

        if (FlxG.keys.justPressed.DOWN)
            scroll(1);
        if (FlxG.keys.justPressed.UP)
            scroll(-1);
    }

    function scroll(change:Int = 0) {
        FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

        
		if (curSelected < 0)
			curSelected = grpCredits.length - 1;
		if (curSelected >= grpCredits.length)
			curSelected = 0;

        var bulshite:Int = 0;

        for (item in grpCredits.members){
            item.targetY = bulshite - curSelected;
            bulshite++;
        }

        camFollow.setPosition(0, grpCredits.members[curSelected].getGraphicMidpoint().y - grpCredits.length * 8);
    }
}

typedef CreditsCredit = {
    var name:String;
    var description:String;
}