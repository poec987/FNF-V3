import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Stage extends FlxTypedGroup<Dynamic> {
    var halloweenBG:FlxSprite;
	var isHalloween:Bool = false;

	var phillyCityLights:FlxTypedGroup<FlxSprite>;
	var phillyTrain:FlxSprite;
	var trainSound:FlxSound;

	var picoShoot:FlxSprite;
	var beefSafe:Bool = false;
	var shootSound:FlxSound;

	var limo:FlxSprite;
	var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
	var fastCar:FlxSprite;

	var upperBoppers:FlxSprite;
	var bottomBoppers:FlxSprite;
	var santa:FlxSprite;

	var fc:Bool = true;
	var allowMiss = true;

	var bgGirls:BackgroundGirls;
	var wiggleShit:WiggleEffect = new WiggleEffect();

    public function new(stage:String) {
        super();

        switch (stage) {
            case "spooky":
                PlayState.curStage = "spooky";
    
                var hallowTex = Paths.getSparrowAtlas('stages/halloween_bg');
    
                halloweenBG = new FlxSprite(-200, -100);
                halloweenBG.frames = hallowTex;
                halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
                halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
                halloweenBG.animation.play('idle');
                halloweenBG.antialiasing = true;
                add(halloweenBG);
    
                isHalloween = true;
            case "exe":
                PlayState.curStage = 'exe';
    
                var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/exeback'));
                bg.antialiasing = true;
                bg.scrollFactor.set(0.9, 0.9);
                bg.active = false;
                add(bg);
    
                var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stages/exefront'));
                stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
                stageFront.updateHitbox();
                stageFront.antialiasing = true;
                stageFront.scrollFactor.set(0.9, 0.9);
                stageFront.active = false;
                add(stageFront);
            case "philly":
                PlayState.curStage = 'philly';
    
                var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('stages/philly/sky'));
                bg.scrollFactor.set(0.1, 0.1);
                add(bg);
    
                var city:FlxSprite = new FlxSprite(-10).loadGraphic(Paths.image('stages/philly/city'));
                city.scrollFactor.set(0.3, 0.3);
                city.setGraphicSize(Std.int(city.width * 0.85));
                city.updateHitbox();
                add(city);
    
                phillyCityLights = new FlxTypedGroup<FlxSprite>();
                add(phillyCityLights);
    
                for (i in 0...5)
                {
                    var light:FlxSprite = new FlxSprite(city.x).loadGraphic(Paths.image('stages/philly/win' + i));
                    light.scrollFactor.set(0.3, 0.3);
                    light.visible = false;
                    light.setGraphicSize(Std.int(light.width * 0.85));
                    light.updateHitbox();
                    light.antialiasing = true;
                    phillyCityLights.add(light);
                }
    
                var streetBehind:FlxSprite = new FlxSprite(-40, 50).loadGraphic(Paths.image('stages/philly/behindTrain'));
                add(streetBehind);
    
                phillyTrain = new FlxSprite(2000, 360).loadGraphic(Paths.image('stages/philly/train'));
                add(phillyTrain);
    
                trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes'));
                FlxG.sound.list.add(trainSound);
    
                // var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);
    
                var street:FlxSprite = new FlxSprite(-40, streetBehind.y).loadGraphic(Paths.image('stages/philly/street'));
                add(street);
            case "limo":
                PlayState.curStage = 'limo';
                PlayState.defaultCamZoom = 0.90;
    
                var skyBG:FlxSprite = new FlxSprite(-120, -50).loadGraphic(Paths.image('stages/limo/limoSunset'));
                skyBG.scrollFactor.set(0.1, 0.1);
                add(skyBG);
    
                var bgLimo:FlxSprite = new FlxSprite(-200, 480);
                bgLimo.frames = Paths.getSparrowAtlas('stages/limo/bgLimo');
                bgLimo.animation.addByPrefix('drive', "background limo pink", 24);
                bgLimo.animation.play('drive');
                bgLimo.scrollFactor.set(0.4, 0.4);
                add(bgLimo);
    
                grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
                add(grpLimoDancers);
    
                for (i in 0...5)
                {
                    var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
                    dancer.scrollFactor.set(0.4, 0.4);
                    grpLimoDancers.add(dancer);
                }
    
                var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('stages/limo/limoOverlay'));
                overlayShit.alpha = 0.5;
                // add(overlayShit);
    
                // var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);
    
                // FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);
    
                // overlayShit.shader = shaderBullshit;
    
                var limoTex = Paths.getSparrowAtlas('stages/limo/limoDrive');
    
                limo = new FlxSprite(-120, 550);
                limo.frames = limoTex;
                limo.animation.addByPrefix('drive', "Limo stage", 24);
                limo.animation.play('drive');
                limo.antialiasing = true;
    
                fastCar = new FlxSprite(-300, 160).loadGraphic(Paths.image('stages/limo/fastCarLol'));
                // add(limo);
            case "mall":
                PlayState.curStage = 'mall';
    
                PlayState.defaultCamZoom = 0.80;
    
                var bg:FlxSprite = new FlxSprite(-1000, -500).loadGraphic(Paths.image('stages/christmas/bgWalls'));
                bg.antialiasing = true;
                bg.scrollFactor.set(0.2, 0.2);
                bg.active = false;
                bg.setGraphicSize(Std.int(bg.width * 0.8));
                bg.updateHitbox();
                add(bg);
    
                upperBoppers = new FlxSprite(-240, -90);
                upperBoppers.frames = Paths.getSparrowAtlas('stages/christmas/upperBop');
                upperBoppers.animation.addByPrefix('bop', "Upper Crowd Bob", 24, false);
                upperBoppers.antialiasing = true;
                upperBoppers.scrollFactor.set(0.33, 0.33);
                upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
                upperBoppers.updateHitbox();
                add(upperBoppers);
    
                var bgEscalator:FlxSprite = new FlxSprite(-1100, -600).loadGraphic(Paths.image('stages/christmas/bgEscalator'));
                bgEscalator.antialiasing = true;
                bgEscalator.scrollFactor.set(0.3, 0.3);
                bgEscalator.active = false;
                bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
                bgEscalator.updateHitbox();
                add(bgEscalator);
    
                var tree:FlxSprite = new FlxSprite(370, -250).loadGraphic(Paths.image('stages/christmas/christmasTree'));
                tree.antialiasing = true;
                tree.scrollFactor.set(0.40, 0.40);
                add(tree);
    
                bottomBoppers = new FlxSprite(-300, 140);
                bottomBoppers.frames = Paths.getSparrowAtlas('stages/christmas/bottomBop');
                bottomBoppers.animation.addByPrefix('bop', 'Bottom Level Boppers', 24, false);
                bottomBoppers.antialiasing = true;
                bottomBoppers.scrollFactor.set(0.9, 0.9);
                bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
                bottomBoppers.updateHitbox();
                add(bottomBoppers);
    
                var fgSnow:FlxSprite = new FlxSprite(-600, 700).loadGraphic(Paths.image('stages/christmas/fgSnow'));
                fgSnow.active = false;
                fgSnow.antialiasing = true;
                add(fgSnow);
    
                santa = new FlxSprite(-840, 150);
                santa.frames = Paths.getSparrowAtlas('stages/christmas/santa');
                santa.animation.addByPrefix('idle', 'santa idle in fear', 24, true);
                santa.animation.addByPrefix('DIE', 'santa DIE', 2, false);
                santa.antialiasing = true;
                add(santa);
                santa.animation.play('idle', true);
            case "mallEvil":
                PlayState.curStage = 'mallEvil';
                var bg:FlxSprite = new FlxSprite(-400, -500).loadGraphic(Paths.image('stages/christmas/evilBG'));
                bg.antialiasing = true;
                bg.scrollFactor.set(0.2, 0.2);
                bg.active = false;
                bg.setGraphicSize(Std.int(bg.width * 0.8));
                bg.updateHitbox();
                add(bg);
    
                var evilTree:FlxSprite = new FlxSprite(300, -300).loadGraphic(Paths.image('stages/christmas/evilTree'));
                evilTree.antialiasing = true;
                evilTree.scrollFactor.set(0.2, 0.2);
                add(evilTree);
    
                var evilSnow:FlxSprite = new FlxSprite(-200, 700).loadGraphic(Paths.image("stages/christmas/evilSnow"));
                evilSnow.antialiasing = true;
                add(evilSnow);
            case "school":
                PlayState.curStage = 'school';
    
                // defaultCamZoom = 0.9;
    
                var bgSky = new FlxSprite().loadGraphic(Paths.image('stages/weeb/weebSky'));
                bgSky.scrollFactor.set(0.1, 0.1);
                add(bgSky);
    
                var repositionShit = -200;
    
                var bgSchool:FlxSprite = new FlxSprite(repositionShit, 0).loadGraphic(Paths.image('stages/weeb/weebSchool'));
                bgSchool.scrollFactor.set(0.6, 0.90);
                add(bgSchool);
    
                var bgStreet:FlxSprite = new FlxSprite(repositionShit).loadGraphic(Paths.image('stages/weeb/weebStreet'));
                bgStreet.scrollFactor.set(0.95, 0.95);
                add(bgStreet);
    
                var fgTrees:FlxSprite = new FlxSprite(repositionShit + 170, 130).loadGraphic(Paths.image('stages/weeb/weebTreesBack'));
                fgTrees.scrollFactor.set(0.9, 0.9);
                add(fgTrees);
    
                var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
                var treetex = Paths.getPackerAtlas('stages/weeb/weebTrees');
                bgTrees.frames = treetex;
                bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
                bgTrees.animation.play('treeLoop');
                bgTrees.scrollFactor.set(0.85, 0.85);
                add(bgTrees);
    
                var treeLeaves:FlxSprite = new FlxSprite(repositionShit, -40);
                treeLeaves.frames = Paths.getSparrowAtlas('stages/weeb/petals');
                treeLeaves.animation.addByPrefix('leaves', 'PETALS ALL', 24, true);
                treeLeaves.animation.play('leaves');
                treeLeaves.scrollFactor.set(0.85, 0.85);
                add(treeLeaves);
    
                var widShit = Std.int(bgSky.width * 6);
    
                bgSky.setGraphicSize(widShit);
                bgSchool.setGraphicSize(widShit);
                bgStreet.setGraphicSize(widShit);
                bgTrees.setGraphicSize(Std.int(widShit * 1.4));
                fgTrees.setGraphicSize(Std.int(widShit * 0.8));
                treeLeaves.setGraphicSize(widShit);
    
                fgTrees.updateHitbox();
                bgSky.updateHitbox();
                bgSchool.updateHitbox();
                bgStreet.updateHitbox();
                bgTrees.updateHitbox();
                treeLeaves.updateHitbox();
    
                bgGirls = new BackgroundGirls(-100, 190);
                bgGirls.scrollFactor.set(0.9, 0.9);
    
                if (PlayState.SONG.song.toLowerCase() == 'roses')
                {
                    bgGirls.getScared();
                }
    
                bgGirls.setGraphicSize(Std.int(bgGirls.width * PlayState.daPixelZoom));
                bgGirls.updateHitbox();
                add(bgGirls);
            case "schoolEvil":
                PlayState.curStage = 'schoolEvil';
    
                var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
                var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);
    
                var posX = 400;
                var posY = 200;
    
                var bg:FlxSprite = new FlxSprite(posX, posY);
                bg.frames = Paths.getSparrowAtlas('stages/weeb/animatedEvilSchool');
                bg.animation.addByPrefix('idle', 'background 2', 24);
                bg.animation.play('idle');
                bg.scrollFactor.set(0.8, 0.9);
                bg.scale.set(6, 6);
                add(bg);
            default:
                PlayState.defaultCamZoom = 0.9;
                PlayState.curStage = 'stage';
                var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/stageback'));
                bg.antialiasing = true;
                bg.scrollFactor.set(0.9, 0.9);
                bg.active = false;
                add(bg);
    
                var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stages/stagefront'));
                stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
                stageFront.updateHitbox();
                stageFront.antialiasing = true;
                stageFront.scrollFactor.set(0.9, 0.9);
                stageFront.active = false;
                add(stageFront);
    
                var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stages/stagecurtains'));
                stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
                stageCurtains.updateHitbox();
                stageCurtains.antialiasing = true;
                stageCurtains.scrollFactor.set(1.3, 1.3);
                stageCurtains.active = false;
    
                add(stageCurtains);
        }
    }
}