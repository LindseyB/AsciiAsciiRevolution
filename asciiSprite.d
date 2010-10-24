module asciiSprite;

import tango.stdc.stringz;
public import ncurses;
import tango.io.Stdout;
import tango.io.stream.TextFile;

class AsciiSprite {
	int _x, _y;
	char[][] _sprite;
	bool _transparent;
	WINDOW* _win;

	this(){}
	
	this(char[] filePath){
		auto _spriteFile = new TextFileInput(filePath);
		_x = 0;
		_y = 0;
		_transparent = false;

		foreach(line; _spriteFile){
			_sprite ~= line;
		}

		_spriteFile.close();


	}

	this(char[] filePath, WINDOW* win, bool transparent = false, int x=0, int y=0) {
		auto _spriteFile = new TextFileInput(filePath);
		_x = x;
		_y = y;
		_transparent = transparent;

		foreach(line; _spriteFile){
			_sprite ~= line;
		}

		_spriteFile.close();

	}
	
	void setXY(int x, int y){
		_x = x;
		_y = y;
	}

	void setY(int y){
		_y = y;
	}
	
	void drawSprite() {
		int y = _y;
		int x = _x;
		
			foreach(line; _sprite){
				foreach(wchar chr; line){
					move(y,x);

					if((chr != ' ' && chr != '$') || !_transparent){
						addch(chr);
					}

					if(chr == '$'){
						addch(' ');
					}

					x++;
				}
				x = _x;
				y++;
			}

	}

}
