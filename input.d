module input;

import ncurses;
import selectScreen;
import levelScreen;
import tango.core.Thread;
import types;
import tango.io.stream.TextFile;
import AAR;

bool listenforkey = true;

bool levelInput(SelectScreen screen, WINDOW* win){
	int key;
	
	clear();
	screen.drawScreen();
	refresh();

	
	while((key = getch()) != ERR){
		if(key == Key.Enter){
			screen.selectLevel();
			break;
		}else if(key == Key.UpArrow){
			screen.up();
		}else if(key == Key.DownArrow){
			screen.down();
		}else if(key == 'q'){
			return false;
		}

		clear();
		screen.drawScreen();
		refresh();
	}

	return true;
}

class Shitz {
	LevelScreen _s;
	WINDOW* _win;
	bool _killGame;

	this(LevelScreen s, WINDOW* win){
		_s = s;
		_win = win;
		_killGame = false;
	}

	void callMyShit() {
		levelInput(_s, _win);
	}
}

void levelInput(LevelScreen screen, WINDOW* win){
	int key;
	
	while((key = getch()) != ERR && listenforkey){
		if(key == Key.UpArrow) {
			screen._arrowSect._input |= 4;
			screen._dancingMan.setCurAnimation(Animate.UP);
		} else if (key == Key.DownArrow) {
			screen._arrowSect._input |= 8;
			screen._dancingMan.setCurAnimation(Animate.DOWN);
		} else if (key == Key.LeftArrow) {
			screen._arrowSect._input |= 1;
			screen._dancingMan.setCurAnimation(Animate.LEFT);
		} else if (key == Key.RightArrow) {
			screen._arrowSect._input |= 2;
			screen._dancingMan.setCurAnimation(Animate.RIGHT);
		} else if (key == 'q') {
			userquit = true;
			// do nothing.
		}

	}
}
