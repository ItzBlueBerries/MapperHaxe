package mapper;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.addons.ui.FlxUIInputText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxTween.TweenOptions;
import flixel.ui.FlxButton;

class SelectorState extends MusicBeatState
{

    var songSelectBox:FlxUIInputText;
    var instructions:FlxText;
    var options:TweenOptions = {type: PINGPONG};
    var selectConfirm:FlxButton;

    override public function create():Void
        {
            FlxG.mouse.visible = true;

            instructions = new FlxText(0, 0);
            instructions.borderColor = FlxColor.WHITE;
            instructions.text = "Enter your song name below.";
            instructions.screenCenter();
            instructions.size = 15;
            instructions.x -= 150;
            instructions.y -= 50;

            // FlxTween.color(instructions, 1.3, FlxColor.WHITE, FlxColor.BLACK, options);

            // When chart state code LOL
            songSelectBox = new FlxUIInputText(0, 0, 450, null, 32, FlxColor.BLACK, FlxColor.WHITE);
            songSelectBox.screenCenter();

            selectConfirm = new FlxButton(0, songSelectBox.y + 50, "Continue", function()
                {
                    // trace(songSelectBox.text);
                    FlxG.save.data.chosenSong = songSelectBox.text;
                    FlxG.switchState(new ChartingState());
                 });
            selectConfirm.screenCenter(X);

            add(instructions);
            add(songSelectBox);
            add(selectConfirm);
        }

}