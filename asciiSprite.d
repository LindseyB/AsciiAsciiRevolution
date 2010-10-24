module asciiSprite;

import tango.stdc.stringz;
public import ncurses;
import tango.io.Stdout;
import tango.io.stream.TextFile;

class AsciiSprite {
	int _x, _y;
	char[][] _sprite;
	WINDOW* _win;

	this(){}

	this(char[] filePath, WINDOW* win, int x=0, int y=0) {
		auto _spriteFile = new TextFileInput(filePath);
		_x = x;
		_y = y;

		foreach(line; _spriteFile){
			_sprite ~= line;
		}

		_spriteFile.close();

	}
	
	void setXY(int x, int y){
		_x = x;
		_y = y;
	}
	
	void drawSprite() {
		int y = _y;
				
		foreach(line; _sprite){
			move(y,_x);
			addstr(toStringz(line));
			y++;
		}

	}

}
