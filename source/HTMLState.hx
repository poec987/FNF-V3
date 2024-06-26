import flixel.FlxG;
import flixel.FlxState;

class HTMLState extends FlxState {
    override function create() {
        var a:Alphabet = new Alphabet(FlxG.width/2,FlxG.height/2,"STOP USING THIS SHIT\n\nWE DIDNT ACCOUNT\nFOR THE WEB VERSION\n\nPLAY DESKTOP INSTEAD", true);
        a.screenCenter(XY);
        add(a);
    }
}