package;

import flixel.FlxSprite;

using StringTools;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('ogbf-pixel', [0, 1], 0, false, isPlayer);
		animation.add('bf-bside', [0, 1], 0, false, isPlayer);
		animation.add('bf-car', [0, 1], 0, false, isPlayer);
		animation.add('bf-christmas', [0, 1], 0, false, isPlayer);
		animation.add('bf-pixel', [21, 21], 0, false, isPlayer);
		animation.add('bf-pixel-good', [28, 28], 0, false, isPlayer);
		animation.add('spooky', [2, 3], 0, false, isPlayer);
		animation.add('pico', [4, 5], 0, false, isPlayer);
		animation.add('mom', [6, 7], 0, false, isPlayer);
		animation.add('mom-car', [6, 7], 0, false, isPlayer);
		animation.add('tankman', [8, 9], 0, false, isPlayer);
		animation.add('face', [10, 11], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		animation.add('sigmio', [22, 22], 0, false, isPlayer);
		animation.add('sigmio-evil', [22, 22], 0, false, isPlayer);
		animation.add('sigmio-final', [22, 22], 0, false, isPlayer); // TODO: replace with final sigma icon when done
		animation.add('spirit', [23, 23], 0, false, isPlayer);
		animation.add('bf-old', [14, 15], 0, false, isPlayer);
		animation.add('gf', [16], 0, false, isPlayer);
		animation.add('parents-christmas', [17], 0, false, isPlayer);
		animation.add('monster', [19, 20], 0, false, isPlayer);
		animation.add('monster-christmas', [59, 59], 0, false, isPlayer);
		animation.add('dickhead', [24, 25], 0, false, isPlayer);
		animation.add('dave', [26, 27], 0, false, isPlayer);
		animation.add('bean', [29, 30], 0, false, isPlayer);
		animation.add('sonicexe', [31, 32], 0, false, isPlayer);
		animation.add('Nugget', [34, 35], 0, false, isPlayer);
		animation.add('nuggetdance', [34, 35], 0, false, isPlayer);
		animation.add('blocku', [36, 37], 0, false, isPlayer);
		animation.add('evilblocku', [36, 37], 0, false, isPlayer);
		animation.add('niceblocku', [36, 37], 0, false, isPlayer);
		animation.add('afton', [38, 39], 0, false, isPlayer);
		animation.add('lock', [33, 33], 0, false, isPlayer);

		if (!animation.exists(char)) {
			var charFile:String = Paths.txtImages("characters/"+char);
			var charFileParams:Array<String> = CoolUtil.coolTextFile(charFile);

			for (i in 0...charFileParams.length) {
				charFileParams[i].trim();
				var line:Array<String> = charFileParams[i].split("::");
				
				if (line[0] == "icon") {
					animation.add(char, [Std.parseInt(line[1]), Std.parseInt(line[2])], 0, false, isPlayer);
				}
			}
		}

		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
