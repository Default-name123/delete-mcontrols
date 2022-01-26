package;

import flixel.FlxG;
import openfl.utils.Assets;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import openfl.utils.Assets;

using StringTools;

class CoolUtil
{
	// [Difficulty name, Chart file suffix]
	public static var difficultyStuff:Array<Dynamic> = [
		['Easy', '-easy'],
		['Normal', ''],
		['Hard', '-hard']
	];

	public static function difficultyString():String
	{
		return difficultyStuff[PlayState.storyDifficulty][0].toUpperCase();
	}

	public static function boundTo(value:Float, min:Float, max:Float):Float {
		var newValue:Float = value;
		if(newValue < min) newValue = min;
		else if(newValue > max) newValue = max;
		return newValue;
	}

	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = [];
		if(Assets.exists(path)) daList = Assets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}

	//uhhhh does this even work at all? i'm starting to doubt
	public static function precacheSound(sound:String, ?library:String = null):Void {
		if(!Assets.cache.hasSound(Paths.sound(sound, library))) {
			FlxG.sound.cache(Paths.sound(sound, library));
		}
	}

	public static function browserLoad(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}
	
	public static function bindCheck(mania:Int)
	{
		var keysMap = ClientPrefs.keyBinds;

		var binds:Array<Int> = [keysMap.get('note_left')[0],keysMap.get('note_down')[0], keysMap.get('note_up')[0], keysMap.get('note_right')[0]];
		switch(mania)
		{
			case 0: 
				binds = [keysMap.get('note_left')[0],keysMap.get('note_down')[0], keysMap.get('note_up')[0], keysMap.get('note_right')[0]];
			case 1: 
				binds = [keysMap.get('s0')[0], keysMap.get('s1')[0], keysMap.get('s2')[0], keysMap.get('s4')[0], keysMap.get('s5')[0], keysMap.get('s6')[0]];
			case 2: 
				if (PlayState.maniaToChange	!= 2)
				{
					switch (PlayState.maniaToChange)
					{
						case 0: 
							binds = [keysMap.get('note_left')[0],keysMap.get('note_down')[0], keysMap.get('note_up')[0], keysMap.get('note_right')[0], -1, -1, -1, -1, -1];
						case 1: 
							binds = [keysMap.get('s0')[0], keysMap.get('s5')[0], keysMap.get('s1')[0], keysMap.get('s2')[0],-1, keysMap.get('s4')[0],-1, -1,keysMap.get('s6')[0]];
						case 3: 
							binds = [keysMap.get('note_left')[0],keysMap.get('note_down')[0], keysMap.get('note_up')[0], keysMap.get('note_right')[0], keysMap.get('s3')[0], -1, -1, -1, -1];
						case 4: 
							binds = [keysMap.get('s0')[0], keysMap.get('s5')[0], keysMap.get('s1')[0], keysMap.get('s2')[0],keysMap.get('s3')[0], keysMap.get('s4')[0],-1, -1,keysMap.get('s6')[0]];
						case 5: 
							binds = [keysMap.get('n0')[0], keysMap.get('n1')[0], keysMap.get('n2')[0], keysMap.get('n3')[0], -1, keysMap.get('n5')[0], keysMap.get('n6')[0], keysMap.get('n7')[0], keysMap.get('n8')[0]];
						case 6: 
							binds = [-1,-1,-1,-1,keysMap.get('s3')[0],-1,-1,-1,-1];
						case 7:
							binds = [keysMap.get('note_left')[0],-1,-1, keysMap.get('note_right')[0],-1,-1,-1,-1,-1];
						case 8: 
							binds = [keysMap.get('note_left')[0],-1,-1, keysMap.get('note_right')[0],keysMap.get('s3')[0],-1,-1,-1,-1];
					}
				}
				else
					binds = [keysMap.get('n0')[0], keysMap.get('n1')[0], keysMap.get('n2')[0], keysMap.get('n3')[0], keysMap.get('n4')[0], keysMap.get('n5')[0], keysMap.get('n6')[0], keysMap.get('n7')[0], keysMap.get('n8')[0]];
			case 3: 
				binds = [keysMap.get('note_left')[0],keysMap.get('note_down')[0], keysMap.get('s3')[0], keysMap.get('note_up')[0], keysMap.get('note_right')[0]];
			case 4: 
				binds = [keysMap.get('s0')[0], keysMap.get('s1')[0], keysMap.get('s2')[0], keysMap.get('s3')[0], keysMap.get('s4')[0], keysMap.get('s5')[0], keysMap.get('s6')[0]];
			case 5: 
				binds = [keysMap.get('n0')[0], keysMap.get('n1')[0], keysMap.get('n2')[0], keysMap.get('n3')[0], keysMap.get('n5')[0], keysMap.get('n6')[0], keysMap.get('n7')[0], keysMap.get('n8')[0]];
			case 6: 
				binds = [keysMap.get('s3')[0]];
			case 7:
				binds = [keysMap.get('note_left')[0], keysMap.get('note_right')[0]];
			case 8: 
				binds = [keysMap.get('note_left')[0], keysMap.get('s3')[0], keysMap.get('note_right')[0]];
		}
		return binds;
	}
	public static function altbindCheck(mania:Int)
		{
			var keysMap = ClientPrefs.keyBinds;

			var binds:Array<Int> = [keysMap.get('note_left')[1],keysMap.get('note_down')[1], keysMap.get('note_up')[1], keysMap.get('note_right')[1]];
			switch(mania)
			{
				case 0: 
					binds = [keysMap.get('note_left')[1],keysMap.get('note_down')[1], keysMap.get('note_up')[1], keysMap.get('note_right')[1]];
				case 1: 
					binds = [keysMap.get('s0')[1], keysMap.get('s1')[1], keysMap.get('s2')[1], keysMap.get('s4')[1], keysMap.get('s5')[1], keysMap.get('s6')[1]];
				case 2: 
					if (PlayState.maniaToChange	!= 2)
					{
						switch (PlayState.maniaToChange)
						{
							case 0: 
								binds = [keysMap.get('note_left')[1],keysMap.get('note_down')[1], keysMap.get('note_up')[1], keysMap.get('note_right')[1], -1, -1, -1, -1, -1];
							case 1: 
								binds = [keysMap.get('s0')[1], keysMap.get('s5')[1], keysMap.get('s1')[1], keysMap.get('s2')[1],-1, keysMap.get('s4')[1],-1, -1,keysMap.get('s6')[0]];
							case 3: 
								binds = [keysMap.get('note_left')[1],keysMap.get('note_down')[1], keysMap.get('note_up')[1], keysMap.get('note_right')[1], keysMap.get('s3')[1], -1, -1, -1, -1];
							case 4: 
								binds = [keysMap.get('s0')[1], keysMap.get('s5')[1], keysMap.get('s1')[1], keysMap.get('s2')[1],keysMap.get('s3')[1], keysMap.get('s4')[1],-1, -1,keysMap.get('s6')[1]];
							case 5: 
								binds = [keysMap.get('n0')[1], keysMap.get('n1')[1], keysMap.get('n2')[1], keysMap.get('n3')[1], -1, keysMap.get('n5')[1], keysMap.get('n6')[1], keysMap.get('n7')[1], keysMap.get('n8')[1]];
							case 6: 
								binds = [-1,-1,-1,-1,keysMap.get('s3')[1],-1,-1,-1,-1];
							case 7:
								binds = [keysMap.get('note_left')[1],-1,-1, keysMap.get('note_right')[1],-1,-1,-1,-1,-1];
							case 8: 
								binds = [keysMap.get('note_left')[1],-1,-1, keysMap.get('note_right')[1],keysMap.get('s3')[1],-1,-1,-1,-1];
						}
					}
					else
						binds = [keysMap.get('n0')[1], keysMap.get('n1')[1], keysMap.get('n2')[1], keysMap.get('n3')[1], keysMap.get('n4')[1], keysMap.get('n5')[1], keysMap.get('n6')[1], keysMap.get('n7')[1], keysMap.get('n8')[1]];
				case 3: 
					binds = [keysMap.get('note_left')[1],keysMap.get('note_down')[1], keysMap.get('s3')[1], keysMap.get('note_up')[1], keysMap.get('note_right')[1]];
				case 4: 
					binds = [keysMap.get('s0')[1], keysMap.get('s1')[1], keysMap.get('s2')[1], keysMap.get('s3')[1], keysMap.get('s4')[1], keysMap.get('s5')[1], keysMap.get('s6')[1]];
				case 5: 
					binds = [keysMap.get('n0')[1], keysMap.get('n1')[1], keysMap.get('n2')[1], keysMap.get('n3')[1], keysMap.get('n5')[1], keysMap.get('n6')[1], keysMap.get('n7')[1], keysMap.get('n8')[1]];
				case 6: 
					binds = [keysMap.get('s3')[1]];
				case 7:
					binds = [keysMap.get('note_left')[1], keysMap.get('note_right')[1]];
				case 8: 
					binds = [keysMap.get('note_left')[1], keysMap.get('s3')[1], keysMap.get('note_right')[1]];
			}
			return binds;
		}
}
