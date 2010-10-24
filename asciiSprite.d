module asciiSprite;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;
import tango.io.stream.TextFile;

class asciiSprite {
	int _x, _y;
	char[][] _sprite;

	this(char[] filePath, int x=0, int y=0) {
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

	}



}
