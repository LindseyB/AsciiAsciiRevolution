module input;

import ncurses;
import selectScreen;
import tango.core.Thread;

enum Key{
	Enter = 10,
		DownArrow = 258,
		UpArrow = 259,
		LeftArrow = 260,
		RightArrow = 261
}

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

