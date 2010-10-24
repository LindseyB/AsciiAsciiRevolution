module animatedAsciiSprite;

import tango.io.Stdout;
import tango.io.stream.TextFile;

import asciiSprite;

class animatedAsciiSprite : asciiSprite {
	char[][][] _animation;
	int _frame;

	this(char[] filePath, int x=0, int y=0){
		_frame = 0;
		auto _spriteFile = new TextFileInput(filePath);
		super._x = x;
		super._y = y;
		
		int i = 0;

		foreach(line; _spriteFile){
			if(line == "%"){
				i++;
			} else {
				_animation[i] ~= line;
			}	
		}

		super._sprite = _animation[0];
	}

	void nextFrame() {
		_frame++;
		_frame %= _animation.length;
		super._sprite = _animation[_frame];
	}
}
