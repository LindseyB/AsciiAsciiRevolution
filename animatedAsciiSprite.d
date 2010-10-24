module animatedAsciiSprite;

import tango.io.Stdout;
import tango.io.stream.TextFile;
import tango.text.Util;

import asciiSprite;

class AnimatedAsciiSprite : AsciiSprite {
	char[][][] _animation;
	int _frame;

	this(char[] filePath, WINDOW* win, bool transparent = false, int x=0, int y=0){
		_frame = 0;
		auto _spriteFile = new TextFileInput(filePath);
		super._x = x;
		super._y = y;
		super._win = win;
		super._transparent = transparent;
		
		bool firstLine = true;
		char[][] newFrame;

		foreach(line; _spriteFile){
			if(contains(line, '%')){
				firstLine = true;
			} else {
				if(firstLine){
					if(newFrame !is null){
						_animation ~= newFrame;
					}

					firstLine = false;
					newFrame = null;
				}
				
				newFrame ~= line;
			}	
		}

		_animation ~= newFrame;

		super._sprite = _animation[0];
	}

	void nextFrame() {
		_frame++;
		_frame %= _animation.length;
		super._sprite = _animation[_frame];
	}
}
