module asciiSprite;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;
import tango.io.stream.TextFile;

class AsciiSprite {
	int _x, _y;
	char[][] _sprite;

	this(){}

	this(char[] filePath, int x=0, int y=0) {
		auto _spriteFile = new TextFileInput(filePath);
		_x = x;
		_y = y;

		foreach(line; _spriteFile){
			Stdout(line)();
			_sprite ~= line;
		}

		_spriteFile.close();

	}
	
	void setXY(int x, int y){
		_x = x;
		_y = y;
	}
	
	void drawSprite(WINDOW* win) {
		int y = _y;
				
		foreach(line; _sprite){
			move(y,_x);
			waddstr(win,toStringz(line));
			y++;
		}

	}

}
