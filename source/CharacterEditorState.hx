package;

import lime.tools.Platform;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.util.FlxColor;
import haxe.Json;
import lime.utils.Assets;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.events.IOErrorEvent;
import openfl.events.IOErrorEvent;
import openfl.media.Sound;
import openfl.net.FileReference;
import openfl.utils.ByteArray;

import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;

using StringTools;

class CharacterEditorState extends MusicBeatState
{
    var _file:FileReference;

    var UI_box:FlxUITabMenu;

    var char:Character;

    override function create() {

        var tabs = [
			{name: "Character", label: 'Character'},
			{name: "Animations", label: 'Animations'},
			{name: "Offsets", label: 'Offsets'},
			{name: "Options", label: 'Options'}
		];

        char = new Character(0, 0);

        FlxG.mouse.visible = true;

        add(char);

        UI_box = new FlxUITabMenu(null, tabs, true);

        UI_box.resize(300, 400);
		UI_box.x = FlxG.width / 2;
		UI_box.y = 20;
		add(UI_box);

        addCharacterUI();
        addAnimationsUI();
        addOffsetsUI();
        addOptionsUI();

        super.create();

    }

	function addCharacterUI():Void
    {
        var tab_group_character = new FlxUI(null, UI_box);
        tab_group_character.name = 'Character';

        UI_box.addGroup(tab_group_character);
    }

    function addAnimationsUI():Void
    {
        var tab_group_animations = new FlxUI(null, UI_box);
        tab_group_animations.name = 'Animations';

        UI_box.addGroup(tab_group_animations);
    }

    function addOffsetsUI():Void
    {
        var tab_group_offsets = new FlxUI(null, UI_box);
        tab_group_offsets.name = 'Offsets';

        UI_box.addGroup(tab_group_offsets);
    }

    function addOptionsUI():Void
    {
        var tab_group_options = new FlxUI(null, UI_box);
        tab_group_options.name = 'Options';

        UI_box.addGroup(tab_group_options);
    }

    override function update(elapsed:Float) {

        if (controls.BACK)
            FlxG.switchState(new MainMenuState());

        super.update(elapsed);
    }
}