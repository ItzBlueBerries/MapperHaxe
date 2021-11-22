package mapper;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.util.FlxColor;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import lime.app.Application;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

class NoticeState extends FlxState
{

    var noticeText:FlxText;

	override public function create():Void
    {

		#if sys
		if (!sys.FileSystem.exists(Sys.getCwd() + "/assets/replays"))
			sys.FileSystem.createDirectory(Sys.getCwd() + "/assets/replays");
		#end

		@:privateAccess
		{
			trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");
		}

		PlayerSettings.init();

		#if windows
		DiscordClient.initialize();

		Application.current.onExit.add (function (exitCode) {
			DiscordClient.shutdown();
		 });
		 
		#end

		FlxG.save.bind('funkin', 'ninjamuffin99');

		ChartData.initSave();

		Highscore.load();

        var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
        diamond.persist = true;
        diamond.destroyOnNoUse = false;

        FlxTransitionableState.defaultTransIn = new TransitionData(FADE, FlxColor.BLACK, 1, new FlxPoint(0, -1), {asset: diamond, width: 32, height: 32},
            new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
        FlxTransitionableState.defaultTransOut = new TransitionData(FADE, FlxColor.BLACK, 0.7, new FlxPoint(0, 1),
            {asset: diamond, width: 32, height: 32}, new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));

        FlxG.mouse.visible = false;

        noticeText = new FlxText(0, 0);
		noticeText.borderColor = FlxColor.WHITE;
        noticeText.text = "
       
                        Welcome to MapperHaxe Editor.
        \nThis is personalized for Friday Night Funkin' Charting only, nothing else.
           \nYou will be immediately added to the Chart Editor, the song is automatically set to test.
                Change the song name to your song to chart it.
                        \nPress ENTER to start.

        ";
        noticeText.screenCenter();
        noticeText.size = 15;
        noticeText.x -= 150;
        noticeText.y -= 150;

        add(noticeText);
    }

	override public function update(elapsed:Float):Void
    {
        if (FlxG.keys.justPressed.ENTER)
            FlxG.switchState(new ChartingState());
        super.update(elapsed);
    }

}