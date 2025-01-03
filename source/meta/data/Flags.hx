package source.meta.data;

class Flags {
    public static var flags:Array<Dynamic> = [
        "frosted_one_encountered",
        "got_19_dollar_card",
        "unfairness_beat"
    ];

    public static var flagMap:Map<String, Bool> = new Map<String, Bool>();

    public static function init() {
		if(FlxG.save.data != null) {
			if(FlxG.save.data.flagMap != null) {
				flagMap = FlxG.save.data.flagMap;
			}
        }

        for (flag in flags) {
            if (!flagMap.exists(flag)) flagMap.set(flag, false);
        }
    }

    public static function getKey(flag:String): Bool {
        if (flagMap.exists(flag) && flagMap.get(flag)) {
            return true;
        }
        return false;
    }

    public static function setFlag(flag:String, value:Bool) {
        flagMap.set(flag, value);
    }
}