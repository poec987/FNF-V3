package;

import flixel.FlxSprite; // TEST

class StageSprite extends FlxSprite {
    public var spriteTag:String = "";

    public function new(x:Float, y:Float, spriteTag:String) {
        super(x, y);
        this.spriteTag = spriteTag;
    }
}