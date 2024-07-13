import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;

class SongTimer extends FlxTypedGroup<FlxText>{
    public var curTime:Int;
    public var endTime:Int;

    private var _display:FlxText;

    public function new(endTime:Int) {
        super();

        this.endTime = endTime;

        var timerY:Int;
        if (SaveManagement.getOption("Scroll Direction") == "Down")
			timerY = Std.int(FlxG.height * 0.8);
		else
            timerY = 100;

        _display = new FlxText(FlxG.width/2-150, timerY);
        _display.size = 32;

        add(_display);
    }

    public function getEndTimeFormatted():String {
        var min = Math.floor(endTime/60);
        var sec = endTime - (min*60);

        var secDis = Std.string(sec);
        if (sec < 10)
            secDis = Std.string("0"+secDis);

        return min+":"+secDis;
    }

    public function getCurTimeFormatted():String {
        var min = Math.floor(curTime/60);
        var sec = curTime - (min*60);

        var secDis = Std.string(sec);
        if (sec < 10)
            secDis = Std.string("0"+secDis);

        return min+":"+secDis;
    }

    public function updateDisplay():Void {
        _display.text = getCurTimeFormatted()+"/"+getEndTimeFormatted();
    }
}