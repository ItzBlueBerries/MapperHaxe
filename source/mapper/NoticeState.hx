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
import flixel.tweens.FlxEase;
import flixel.tweens.FlxEase.EaseFunction;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.util.FlxTimer;

#if windows
import Discord.DiscordClient;
#end

#if cpp
import sys.thread.Thread;
#end

class NoticeState extends FlxState
{

    var noticeText:FlxText;
    var options:TweenOptions = {type: PINGPONG};
    var notice:String;

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

        #if windows
        // Updating Discord Rich Presence
        DiscordClient.changePresence("Notice! Notice!", null);
        #end

         notice = 
            "                           Welcome to MapperHaxe Editor.             
            \n\nThis is personalized for Friday Night Funkin' Charting mostly, nothing else mainly.
            \nWhen you continue, you will be prompted to select a song, then you will be added to the chart editor directly.
            \nThis engine was created by FruitsyOG, more credits listed in the credits menu.
            \n\nPress ENTER to continue. | Press R to check for new releases.
            \nPress W for the WIKI Support. | Press C for the credits menu.
            ";

        FlxG.mouse.visible = false;

        noticeText = new FlxText(0, 0);
		noticeText.borderColor = FlxColor.WHITE;
        noticeText.text = notice;
        noticeText.screenCenter();
        noticeText.size = 15;
        noticeText.x -= 150;
        noticeText.y -= 100;

        add(noticeText);

        FlxTween.color(noticeText, 1.3, FlxColor.WHITE, FlxColor.BLACK, options);
		FlxTween.angle(noticeText, noticeText.angle, -4, 1, {ease: FlxEase.quartInOut});
		
		new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			if(noticeText.angle == -4) FlxTween.angle(noticeText, noticeText.angle, 4, 1, {ease: FlxEase.quartInOut});
			else FlxTween.angle(noticeText, noticeText.angle, -4, 1, {ease: FlxEase.quartInOut});
		}, 0);
    }

	override public function update(elapsed:Float):Void
    {
        if (FlxG.keys.justPressed.ENTER)
            FlxG.switchState(new SelectorState());

        if (FlxG.keys.justPressed.R)
            FlxG.openURL('https://github.com/ItzBlueBerries/MapperHaxe/releases');

        if (FlxG.keys.justPressed.W)
            FlxG.openURL('https://github.com/ItzBlueBerries/MapperHaxe/wiki');

        if (FlxG.keys.justPressed.C)
            FlxG.switchState(new CreditsState());

        // FlxTween.tween(noticeText, { alpha: 0 }, 0.7, options);

        super.update(elapsed);
    }
}