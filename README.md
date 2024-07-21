# FNF v3
> Hottest mod ever made -michael yiik

Have you played Friday Night Funkin' and thought "hmm, i wonder when they will update the gaem?" or maybe you played [FNF V2](https://gamebanana.com/wips/84226) and wanted more? We gotchu

This mod is everything your heart could possibly desire - New and improved sprites, songs, engine.

![KadeEngineLogo](https://raw.githubusercontent.com/poec987/FNF-V3/main/KadeEngineLogo.png)

# Friday Night Funkin Cinema Engine

# Features
## Chart Editor (Peak)

*Hate the UGLY and UNUSABLE kade engine chart editor?*
> WHAT DO YOU MEAN YOU USE PSYCH ENGINE?!

- You can have custom notes with parameters for maximum customization.

- Also, clear chart button (so cool)

- You can like set song to be pixel, good (good option only makes sense for FNF V3 lol, gonna prob be replaced with "ui skins" in standalone) and set whether or not the song has dialogue (that classic pixel dialogue shit frfr) and uhh you can set the stage and gf (not implemented lolllol)*

## Custom Dialogue Shits

All controlled by txt files and pngs and xmls, you can customize your dialogue for some cool dialogue. 

You can make custom character portraits and boxes. What makes shit unique is you can have as many dialogues txts in one song for randomized dialogue!! (woo!)

## Character Editor

Self explanatory. BUTTTT!!! you can make specific animations be flipped on either x, y or both axises!!!! You can also flip the characters on x and y axis as a whole, scale them, set pixel and icons!
## Stage Editor

Basically character editor, but for stages, idk what to say lmao

# Note

This is a **MOD**. This is not Vanilla and should be treated as a **MODIFICATION**. This will probably never be official, so dont get confused.

## Acknowledging stolen code

[DNB Background Generator](https://github.com/silkycell/DNB-Background-Generator) - The shader code (shaders come from [Vs. Dave and Bambi](https://gamebanana.com/mods/43201))

[Psych Engine](https://github.com/ShadowMario/FNF-PsychEngine) - Alphabet, Setup files, and other shit I prob wouldn't be able to remember.

### Compiling game

To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run 'lime test linux -debug' and then run the executible file in export/release/linux/bin. For Windows, you need to install Visual Studio Community 2019. While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)
* C++ Profiling tools
* C++ CMake tools for windows
* C++ ATL for v142 build tools (x86 & x64)
* C++ MFC for v142 build tools (x86 & x64)
* C++/CLI support for v142 build tools (14.21)
* C++ Modules for v142 build tools (x64/x86)
* Clang Compiler for Windows
* Windows 10 SDK (10.0.17134.0)
* Windows 10 SDK (10.0.16299.0)
* MSVC v141 - VS 2017 C++ x64/x86 build tools
* MSVC v140 - VS 2015 C++ build tools (v14.00)

This will install about 22GB of crap, but once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.

### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)
