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
    var creditTxt:FlxText;
    var bg:FlxSprite;

    public function new(cname:String, cauthor:String) {
        super();

        // creditTxt = new FlxText(-1000, 200, 0, "", 28);
        // creditTxt.alignment = FlxTextAlign.LEFT;
        // creditTxt.color = FlxColor.WHITE;
        // creditTxt.textField.background = true;
        // creditTxt.textField.backgroundColor = new FlxColor(FlxColor.BLACK);

        nameTxt = new FlxText(-1000, 185, 0, name, 28);
        nameTxt.alignment = FlxTextAlign.LEFT;

        authorTxt = new FlxText(-1000, 225, 0, author, 20);
        authorTxt.alignment = FlxTextAlign.LEFT;

        bg = new FlxSprite(-325, 175).makeGraphic(0, 0, FlxColor.BLACK);
        bg.origin.x = 0;
        bg.alpha = 0.5;

        add(bg);
        add(nameTxt);
        add(authorTxt);
        // add(creditTxt);

        name = cname;
        author = cauthor;

        setShit();
    }

    public function setName(name:String, author:String) {
        name = name.replace("/n/", "\n");

        nameTxt.text = name;
        authorTxt.text = author;

        bg.setSize(Math.max(nameTxt.textField.width, authorTxt.textField.width) + 10, Math.max(nameTxt.textField.height, authorTxt.textField.height) + 10);
        bg.updateHitbox();
        // creditTxt.text = name+"\nBy: "+author;
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
                setName("Monster V3", "Didgie");
            // Week 3
            case 'pico':
                setName("Pico V3", "thomicfee");
            case 'philly':
                setName("Philly V3", "Didgie");
            case 'blammed':
                setName("Blammed V3", "x8c8r");
            // Week 4
            case 'satin-panties':
                setName("Satin Panties V3", "Didgie");
            case 'high':
                setName("High V3", "jo560hs");
            case 'milf':
                setName("MILF V3", "Xarion");
            // Week 5
            case 'cocoa':
                setName("Cocoa V3", "Didgie");
            case 'eggnog':
                setName("Eggnog V3", "Didgie");
            case 'winter-horrorland':
                setName("the frosted one", "the frosted one");
            // Week 6
            case 'senpai':
                setName("Senpai V3", "x8c8r");
            case 'roses':
                setName("Roses V3", "Xarion");
            case 'thorns':
                setName("Thorns V3", "CobblestoneFace");
            case 'unfairness-jside':
                setName("Unfairness J-Side V3", "Jo560hs");
            // Remixes
            case 'tutorial-erect':
                setName("Tutorial Erect V3", "EarthLiveCountry");
            case 'tutorial-bside':
                setName("Tutorial BSide", "x8c8r");
			case 'tutorial-bside-erect':
                setName("Tutorial BSide Erect", "Didgie");
			case 'blammed-alt':
                setName("Blammed V3 ALT", "x8c8r & Didgie");
            case 'spookeez-erect':
                setName("Spookeez Erect", "Didgie");
            case 'senpai-impossible-ver':
                setName("Senpai Impossible Ver V3", "EarthLiveCountry");
            // Bonus
            case 'dotdotdot':
                setName("Dotdotdot", "Didgie");
            case 'do-you-get-the-refrance':
                setName("Do You Get The Refrance?", "x8c8r");
            case 'stop-right-there-criminal-scum':
                setName("Stop right there criminal scum", "PoeDev");
			case 'bopcityfansong':
                setName("bopcityfansong", "Didgie");
            case 'celebrate':
                setName("Celebrate V3", "Xarion");

            default:
                // setName("keemstar", "bald shadow mario");
                setName(name, author);
        }
    }

    public function show() {
        // FlxTween.tween(creditTxt, {x: 25}, 0.75, {ease: FlxEase.expoOut});
        FlxTween.tween(nameTxt, {x: 25}, 0.75, {ease: FlxEase.expoOut});
        FlxTween.tween(authorTxt, {x: 25}, 0.75, {ease: FlxEase.expoOut});
        FlxTween.tween(bg, {x: 0}, 0.5, {ease: FlxEase.expoOut});
    }

    public function hide() {
        // FlxTween.tween(creditTxt, {x: -1000}, 0.75, {ease: FlxEase.expoIn});
        FlxTween.tween(nameTxt, {x: -1000}, 0.75, {ease: FlxEase.expoIn});
        FlxTween.tween(authorTxt, {x: -1000}, 0.75, {ease: FlxEase.expoIn});
        FlxTween.tween(bg, {x: -1000}, 0.75, {ease: FlxEase.expoIn});
    }
}