module input;

import ncurses;
import selectScreen;
import levelScreen;
import tango.core.Thread;
import types;


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

bool levelInput(LevelScreen screen, WINDOW* win){
	int key;

	clear();
	
	while((key = getch()) != ERR){
		if(key == Key.UpArrow) {
			screen._dancingMan.setCurAnimation(Animate.UP);
		} else if (key == Key.DownArrow) {
			screen._dancingMan.setCurAnimation(Animate.DOWN);
		} else if (key == Key.LeftArrow) {
			screen._dancingMan.setCurAnimation(Animate.LEFT);
		} else if (key == Key.RightArrow) {
			screen._dancingMan.setCurAnimation(Animate.RIGHT);
		} else if (key == 'q') {
			return false;
		}

		return true;
	}	
}
