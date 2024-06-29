import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class SongCard extends FlxTypedGroup<FlxSprite>{
    var name:String = "";
    var author:String = "";

    var nameTxt:FlxText;
    var authorTxt:FlxText;
    var bg:FlxSprite;

    public function new() {
        super();

        nameTxt = new FlxText(-300, 185, 0, name, 28);
        nameTxt.alignment = FlxTextAlign.LEFT;

        authorTxt = new FlxText(-300, 225, 0, author, 20);
        authorTxt.alignment = FlxTextAlign.LEFT;

        bg = new FlxSprite(-325, 175).makeGraphic(300, 100, FlxColor.BLACK);
        bg.origin.x = 0;
        bg.alpha = 0.5;

        add(bg);
        add(nameTxt);
        add(authorTxt);

        setShit();
    }

    public function setName(name:String, author:String) {
        name = name.replace("/n/", "\n");

        nameTxt.text = name;
        authorTxt.text = author;
    }

    private function setShit() {
        switch (PlayState.SONG.song.toLowerCase()) {
            // Tutorial
            case 'tutorial':
                setName("Tutorial V3", "Didgie");
            // Week 1
            case 'bopeebo':
                setName("Bopeebo V3", "Didgie");
            case 'fresh':
                setName("Fresh V3", "Didgie");
            case 'dadbattle':
                setName("Dadbattle V3", "Didgie");
            // Week 2
            case 'spookeez':
                setName("Spookeez V3", "Didgie");
            case 'south':
                setName("South V3", "Didgie");
            case 'monster':
                setName("Monster V3", "NOT DIDGIE (ft PoeDev)");
            // Week 3
            case 'pico':
                setName("Pico V3", "");
            case 'philly':
                setName("Philly Nice V3", "Didgie");
            case 'blammed':
                setName("Blammed V3", "x8c8r");
            // Week 4
            case 'satin-panties':
                setName("Satin Panties V3", "");
            case 'high':
                setName("High V3", "jo560hs");
            case 'milf':
                setName("M.I.L.F. V3", "Xarion");
            // Week 5
            case 'cocoa':
                setName("Cocoa V3", "Didgie");
            case 'eggnog':
                setName("Eggnog V3", "Didgie");
            case 'winter-horrorland':
                setName("the frosted one", "the frosted one");
            // Week 6
            case 'senpai':
                setName("Senpai V3", "");
            case 'roses':
                setName("Roses V3", "");
            case 'thorns':
                setName("Thorns V3", "");
            case 'unfairness-jside':
                setName("Unfairness J-Side V3", "jo560hs");
            // Remixes
            case 'tutorial-erect':
                setName("Tutorial Erect V3", "EarthLiveCountry");
            case 'tutorial-bside':
                setName("Tutorial BSide", "x8c8r");
			case 'blammed-alt':
                setName("Blammed V3 ALT", "x8c8r & Didgie");
            case 'spookeez-erect':
                setName("Spookeez Erect", "Didgie");
            // Bonus
            case 'dotdotdot':
                setName("Dotdotdot", "Didgie");
            case 'do-you-get-the-refrance':
                setName("do you get the refrance", "x8c8r");
            case 'stop-right-there-criminal-scum':
                setName("Stop right there criminal scum", "PoeDev");

            default:
                setName("keemstar", "bald shadow mario");
        }
    }

    public function show() {
        FlxTween.tween(nameTxt, {x: 25}, 0.75, {ease: FlxEase.expoIn});
        FlxTween.tween(authorTxt, {x: 25}, 0.75, {ease: FlxEase.expoIn});
        FlxTween.tween(bg, {x: 0}, 0.5, {ease: FlxEase.expoIn});
    }

    public function hide() {
        FlxTween.tween(nameTxt, {x: -300}, 0.75, {ease: FlxEase.expoIn});
        FlxTween.tween(authorTxt, {x: -300}, 0.75, {ease: FlxEase.expoIn});
        FlxTween.tween(bg, {x: -300}, 0.75, {ease: FlxEase.expoIn});
    }
}