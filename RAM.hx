import openfl.text.TextFormat;
import openfl.system.System;
import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;

class RAM extends TextField {
    public var curRAM:Float;
    private var times:Array<Float>;

    public function new(x:Float, y:Float) {
        super();
        this.x = x;
        this.y = y;

        defaultTextFormat = new TextFormat("_sans", 12, 0xFFFFFF);
        selectable = false;
		mouseEnabled = false;
        autoSize = LEFT;

        times = [];

        addEventListener(Event.ENTER_FRAME, onEnter);
    }
    private function onEnter(_) {
        var now = Timer.stamp();
        times.push(now);

        while(times[0] < now - 1)
            times.shift();

        var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100)/100;

        if (visible)
            text = "Memory: " + mem + "MB";
    }
}