package;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;

class CreditsState extends MusicBeatState {
    var curSelected:Int = 0;

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

    var grpCredits:Array<Alphabet> = [];

    public override function create() {
        super.create();
        
        for (i in 0...credits.length) {
            var thing:Alphabet = new Alphabet(64, 150 + (i*64), credits[i].name);
            thing.targetY = i;
            grpCredits.push(thing);
            add(thing);
        }

        scroll(0);
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

    function scroll(change:Int) {
    }
}

typedef CreditsCredit = {
    var name:String;
    var description:String;
}