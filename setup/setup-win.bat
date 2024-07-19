@echo off
color 0a
cd ..
@echo on
echo I stole this from Psych Engine. Not sorry.
echo Installing dependencies.
haxelib install lime 8.1.3
haxelib install openfl 9.3.3
haxelib install flixel 5.5.0
haxelib install flixel-addons 3.2.3
haxelib install flixel-ui 2.6.1
haxelib install flixel-tools 3.2.3
haxelib install hscript
haxelib git hxCodec https://github.com/polybiusproxy/hxCodec
haxelib git hxdiscord_rpc https://github.com/MAJigsaw77/hxdiscord_rpc
echo Finished!
pause