import flixel.FlxG;

using StringTools;

class SaveManagement {
    public static function init() {
        // Songs
        if (FlxG.save.data.unlockedSongs == null) // shhhhhhh
			FlxG.save.data.unlockedSongs = [];

        // Sound
		if(FlxG.save.data.volume != null)
			FlxG.sound.volume = FlxG.save.data.volume;
		
		if (FlxG.save.data.mute != null)
			FlxG.sound.muted = FlxG.save.data.mute;

        // Options
        if (FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = true;

		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.dfjk == null)
			FlxG.save.data.dfjk = false;

		if (FlxG.save.data.freaky == null)
			FlxG.save.data.freaky = false;
    }

    public static function unlockSong(song:String) {
        trace(song.toLowerCase().trim());
        trace(FlxG.save.data.unlockedSongs.contains(song.toLowerCase().trim()));
        if (FlxG.save.data.unlockedSongs != null) {
            if (!FlxG.save.data.unlockedSongs.contains(song.toLowerCase().trim())) FlxG.save.data.unlockedSongs.push(song.toLowerCase().trim());
            FlxG.save.flush();
        }
    }
}