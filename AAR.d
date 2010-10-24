module AAR;

import tango.io.Stdout;
import tango.core.Thread;
import ncurses;
import tango.stdc.stringz;

import asciiSprite;
import animatedAsciiSprite;
import util.soundclip;
import level;
import selectScreen;
import input;
import levelScreen;

WINDOW* win;

Level currentLevel;
SelectScreen selectS;
LevelScreen levelS;
SoundClip sc;

bool userquit = false;
bool playgame = true;
void main(){
	selectS = new SelectScreen("levels.txt");
	sc = new SoundClip("sounds/title.mp3");	

	win = initscr();
	noecho();
	cbreak();
	start_color();
	curs_set(0);
	
	sc.start();
	clear();
	refresh();
	AsciiSprite logo = new AsciiSprite("graphics/logo.txt", win);	
	logo.drawSprite();
	refresh();
	clear();
	refresh();
	logo.drawSprite();
	refresh();
	
	Thread.sleep(5);

		
	while(1){
		keypad(win, true);
		sc = new SoundClip("music/ID__Baobinga_-_10_-_Raise_Riddim.mp3");
		sc.start();
		//clear();
		//refresh();
		playgame = levelInput(selectS, win);
		sc.stop();
		if(!playgame){
			break;
		}
			
		currentLevel = selectS._levels[selectS._selectedLevel];
		levelS = new LevelScreen(currentLevel);
			
		Shitz shitzShitty = new Shitz(levelS, win);
		Thread inputThread = new Thread(&shitzShitty.callMyShit);
		inputThread.start();

		drawLevelScreen();

		listenforkey = false;

	}

	endwin();
}

void drawLevelScreen() {
	clear();

	sc = new SoundClip("music/" ~ currentLevel._audio);
	sc.start();	

	int count = 0;
	while(levelS._playing && !userquit){
		clear();
		if(count%2 == 0){
			levelS.draw(false);
		} else {
			levelS.draw(true);
		}
		refresh();
		Thread.sleep(levelS._arrowSect.sleep/10.0);
		count++;
	}
	
	sc.stop();
	
	if(!userquit){
		Thread.sleep(5);
	}
	clear();
	refresh();

}
