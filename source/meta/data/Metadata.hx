package meta.data;

import haxe.Json;
import sys.io.File;
import openfl.utils.Assets as OpenFlAssets;

typedef SongMetadata = {
    var dialogues:Array<String>;
}

class Metadata {
    public static function load(song:String):SongMetadata {
        try {
            var rawJson = null;
            
            var formattedSong:String = Paths.formatToSongPath(song);
            var path:String = formattedSong + '/info';
            #if MODS_ALLOWED
            var moddyFile:String = Paths.modsJson(path);
            
            if(OpenFlAssets.exists(moddyFile)) {
                rawJson = File.getContent(moddyFile).trim();
            }
            #end

            if(rawJson == null) {
                #if sys
                rawJson = File.getContent(Paths.json(path)).trim();
                #else
                rawJson = OpenFlAssets.getText(Paths.json(path)).trim();
                #end	
            }

            while (!rawJson.endsWith("}"))
            {
                rawJson = rawJson.substr(0, rawJson.length - 1);
                // LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
            }

            var f =cast Json.parse(rawJson);

            trace('Loaded metadata!');
            trace(f);

            return f;
        }
        catch(e) {
            trace(e);
            return null;
        }
    }
}