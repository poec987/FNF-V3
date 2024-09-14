package;

import flixel.FlxG;
import flixel.FlxState;

#if (hxCodec >= "3.0.0") import hxcodec.flixel.FlxVideo as VideoHandler;
#elseif (hxCodec >= "2.6.1") import hxcodec.VideoHandler as VideoHandler;
#elseif (hxCodec == "2.6.0") import VideoHandler;
#else import vlc.MP4Handler as VideoHandler; #end

#if desktop
import sys.FileSystem;
#end

class VideoCutsceneState extends MusicBeatState {

    public static var videoFile:String;
    public static var targetState:flixel.FlxState;

    public override function create() {
        super.create();

        startVideo(videoFile);
    }

    public function startVideo(name:String)
	{
		var filepath:String = Paths.video(name);
		#if sys
		if(!FileSystem.exists(filepath))
		#else
		if(!OpenFlAssets.exists(filepath))
		#end
		{
			FlxG.log.warn('Couldnt find video file: ' + name);
			return;
		}
	
		var video:VideoHandler = new VideoHandler();
			#if (hxCodec >= "3.0.0")
			// Recent versions
			video.play(filepath);
			video.onEndReached.add(function()
			{
				video.dispose();
                FlxG.switchState(targetState);
				return;
			}, true);
			#else
			// Older versions
			video.playVideo(filepath);
			video.finishCallback = function()
			{
                FlxG.switchState(targetState);
				return;
			}
			#end
	}
}