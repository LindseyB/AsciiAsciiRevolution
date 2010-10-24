module animatedAsciiSprite;

import tango.io.Stdout;
import tango.io.stream.TextFile;
import tango.text.Util;

import asciiSprite;

class AnimatedAsciiSprite : AsciiSprite {
	char[][][] _animation;
	int _frame;
	bool _loop;
	bool _animate;

	this(char[] filePath, WINDOW* win, bool transparent = false, bool loop = false, int x=0, int y=0){
		_frame = 0;
		auto _spriteFile = new TextFileInput(filePath);
		super._x = x;
		super._y = y;
		super._win = win;
		super._transparent = transparent;
		_animate = true;

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
		if(_animate){
				int before = _frame++;
				_frame %= _animation.length;

				if(before == _animation.length && _frame == 0){
					_animate = false;
				}

				super._sprite = _animation[_frame];
		}
	}
}
