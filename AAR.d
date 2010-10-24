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

	keypad(win, true);

	Thread.sleep(5);
	
	AnimatedAsciiSprite narwhal = new AnimatedAsciiSprite("graphics/man-moonwalk.txt", win, true, true, 16, 9);	
	AsciiSprite light = new AsciiSprite("graphics/spotlight.txt", win, false, 0, 5);
	
	sc = new SoundClip("music/ID__Baobinga_-_10_-_Raise_Riddim.mp3");
	sc.start();
	if(!levelInput(selectS, win)){endwin();}
	sc.stop();
	
	currentLevel = selectS._levels[selectS._selectedLevel];
	levelS = new LevelScreen(currentLevel._name);
	
	Shitz shitzShitty = new Shitz(levelS, win);
	Thread inputThread = new Thread(&shitzShitty.callMyShit);
	inputThread.start();

	drawLevelScreen();

	endwin();
}

void drawLevelScreen() {
	clear();

	sc = new SoundClip("music/" ~ currentLevel._audio);
	sc.start();	

	int count = 0;
	while(levelS._playing){
		clear();
		if(count%5 == 0){
			levelS.draw(false);
		} else {
			levelS.draw(true);
		}
		refresh();
		Thread.sleep(levelS._arrowSect.sleep/5.0);
		count++;
	}
	
	sc.stop();

}
