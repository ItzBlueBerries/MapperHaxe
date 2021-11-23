package mapper;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.util.FlxColor;
import MusicBeatState;

#if windows
import Discord.DiscordClient;
#end

class CreditsState extends MusicBeatState
{

    var credits:String;
    var creditsText:FlxText;
    var border:FlxText;
    var borderSecond:FlxText;

    var options:TweenOptions = {type: PINGPONG};
    var logo:FlxSprite;

    override public function create():Void
    {

        #if windows
        // Updating Discord Rich Presence
        DiscordClient.changePresence("Credits Menu", null);
        #end

        credits = 
            "FruitsyOG (Coder) - Press F
            \n\nNLD-Dev (Coding Help) - Press N
            \n\nPJ9D (Playtester) - Press P
            \n\nMekaZeff111 (Playtester) - Press M
            ";
        
        creditsText = new FlxText(0, 0);
        creditsText.borderColor = FlxColor.WHITE;
        creditsText.text = credits;
        creditsText.screenCenter();
        creditsText.size = 30;
        creditsText.x -= 550;
        creditsText.y -= 150;

        FlxTween.color(creditsText, 1.3, FlxColor.WHITE, FlxColor.CYAN, options);

        border = new FlxText(0, 0);
        border.borderColor = FlxColor.WHITE;
        border.text = "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
        border.screenCenter();
        border.size = 20;
        border.x -= 150;
        border.y -= 365;

        FlxTween.color(border, 1.3, FlxColor.WHITE, FlxColor.CYAN, options);

        borderSecond = new FlxText(0, 0);
        borderSecond.borderColor = FlxColor.WHITE;
        borderSecond.text = "----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
        borderSecond.screenCenter();
        borderSecond.size = 20;
        borderSecond.x -= 150;
        borderSecond.y += 350;

        FlxTween.color(borderSecond, 1.3, FlxColor.WHITE, FlxColor.CYAN, options);

        add(creditsText);
        add(border);
        add(borderSecond);

   }

   override public function update(elapsed:Float):Void
    {

        if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.BACKSPACE)
            FlxG.switchState(new NoticeState());

        // Credits Redirection Easy way Lol

        if (FlxG.keys.justPressed.F) // That's me lol FruitsyOG
            FlxG.openURL("https://www.youtube.com/channel/UCpEq_oqCkhos6IQqYNy39BA");
        
        if (FlxG.keys.justPressed.N) // NLD-Dev
            FlxG.openURL("https://twitter.com/LocalizedDeku");

        if (FlxG.keys.justPressed.P) // PJ9D
            FlxG.openURL("https://www.youtube.com/channel/UCkJvqtijU9JG57x7KLcjqqw");

        if (FlxG.keys.justPressed.M) // MekaZeff111
            FlxG.openURL("https://twitter.com/MZeff111");

        super.update(elapsed);
    }

}