package;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;
	var versionShit:FlxText;

	/*
	DOCS KINDA

	ENTRY STRUCTURE
	name => [
		Universal:
		type - 2Type,
		name,

		2Type:
		values = [val1, val2]
		currently selected value
		writtenValues = [textForVal1, textForVal2]
		function that runs on change
	]
	*/

	var options:Array<Array<Dynamic>> = [
		[ // Keybinds
			"2Type",
			"Keybinds",
			"DFJK",
			["DFJK", "WASD"],
			() -> {
				if (SaveManagement.getOption("Keybinds") == "DFJK")
					controls.setKeyboardScheme(KeyboardScheme.Solo, true);
				else
					controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);
			}
		],
		[ // Inputs
			"2Type",
			"Input System",
			"New",
			["New", "Old"],
			null
		],
		[ // Scroll Dir
			"2Type",
			"Scroll Direction",
			"Up",
			["Up", "Down"],
			null
		],
		[ // Hitsounds
			"2Type",
			"Hitsounds",
			"Off",
			["Off", "On"],
			null
		]
	];

	function restoreOptionValues() {
 		var it = 0;
		for (option in options.iterator()) {
			var type:String = option[0];
			var name:String = option[1];

			switch (type) {
				case "2Type":
					if (SaveManagement.getOption(name) != null)
						option[2] = SaveManagement.getOption(name);
				default:
					trace("Invalid option type");
			}
			it++;
		}
	}

	override function create()
	{
		/*var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		controlsStrings = CoolUtil.coolStringFile(
			(FlxG.save.data.dfjk ? 'DFJK' : 'WASD') + "\n" +
		 	(FlxG.save.data.newInput ? "New input" : "Old Input") + "\n" + 
			(FlxG.save.data.downscroll ? 'Downscroll' : 'Upscroll') + "\n" + 
			(FlxG.save.data.hitsounds ? 'Hitsounds: On' : 'Hitsounds: Off') + "\n" + 
			(FlxG.save.data.freaky ? 'Freaky' : 'Normal') + "\nLoad replays" );

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);*/

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		restoreOptionValues();
		
		var it = 0;
		for (option in options.iterator()) {
			var thing:Alphabet = new Alphabet(64, 320, option[1], true);
			thing.isMenuItem = true;
			thing.targetY = it;
			grpControls.add(thing);

			changeOption(option, it, false);
			it++;
		}

		for (i in 0...controlsStrings.length)
		{
				var controlLabel:Alphabet = new Alphabet(64, 320, controlsStrings[i], true);
				controlLabel.isMenuItem = true;
				controlLabel.targetY = i;
				grpControls.add(controlLabel);
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
		}


		versionShit = new FlxText(5, FlxG.height - 18, 0, "Offset (Left, Right): " + FlxG.save.data.offset, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

			if (controls.BACK)
				FlxG.switchState(new MainMenuState());
			if (controls.UP_P)
				changeSelection(-1);
			if (controls.DOWN_P)
				changeSelection(1);
			if (FlxG.keys.justPressed.DELETE)
				SaveManagement.resetSaveData();
			
			if (controls.RIGHT_R)
			{
				FlxG.save.data.offset++;
				versionShit.text = "Offset (Left, Right): " + FlxG.save.data.offset;
			}

			if (controls.LEFT_R)
				{
					FlxG.save.data.offset--;
					versionShit.text = "Offset (Left, Right): " + FlxG.save.data.offset;
				}
	

			if (controls.ACCEPT)
			{
				changeOption(options[curSelected], curSelected);
				/*if (curSelected != grpControls.length-1)
					grpControls.remove(grpControls.members[curSelected]);
				switch(curSelected)
				{
					case 0:
						FlxG.save.data.dfjk = !FlxG.save.data.dfjk;
						var ctrl:Alphabet = new Alphabet(64, 320, (FlxG.save.data.dfjk ? 'DFJK' : 'WASD'), true);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected;
						grpControls.add(ctrl);
						if (FlxG.save.data.dfjk)
							controls.setKeyboardScheme(KeyboardScheme.Solo, true);
						else
							controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);
						
					case 1:
						FlxG.save.data.newInput = !FlxG.save.data.newInput;
						var ctrl:Alphabet = new Alphabet(64, 320, (FlxG.save.data.newInput ? "New input" : "Old Input"), true);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 1;
						grpControls.add(ctrl);
					case 2:
						FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
						var ctrl:Alphabet = new Alphabet(64, 320, (FlxG.save.data.downscroll ? 'Downscroll' : 'Upscroll'), true);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 2;
						grpControls.add(ctrl);
					case 3:
						FlxG.save.data.hitsounds = !FlxG.save.data.hitsounds;
						var ctrl:Alphabet = new Alphabet(64, 320, (FlxG.save.data.hitsounds ? 'Hitsounds: On' : 'Hitsounds: Off'), true);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 3;
						grpControls.add(ctrl);	
					case 4:
						FlxG.save.data.freaky = !FlxG.save.data.freaky;
						var ctrl:Alphabet = new Alphabet(64, 320, (FlxG.save.data.freaky ? 'Freaky' : 'Normal'), true);
						ctrl.isMenuItem = true;
						ctrl.targetY = curSelected - 4;
						grpControls.add(ctrl);
				}*/
			}
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end
		
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}

	function changeOption(option:Array<Dynamic>, selectNumber:Int, update:Bool = true):Void {
		var type:String = option[0];
		var name:String = option[1];

		switch (type) {
			case "2Type":
				var curValue:String = option[2];
				var values:Array<String> = option[3];

				if (update) {
					var cur = values.indexOf(curValue)+1;
					option[2] = values[cur] == null ? values[0] : values[cur];

					SaveManagement.setOption(name, option[2]);

					if (option[5] != null) option[5]();
				}

				grpControls.members[selectNumber].text = name+": " + Std.string(option[2]);
			default:
				trace("Incorrect option type");
		}
	}
}