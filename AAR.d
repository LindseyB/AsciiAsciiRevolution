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

void main(){
	selectS = new SelectScreen("levels.txt");
	/*SoundClip sc = new SoundClip("music/ID__Baobinga_-_10_-_Raise_Riddim.mp3");
	sc.start();
	Thread.sleep(5);
	sc.stop();*/
	
	win = initscr();
	noecho();
	cbreak();
	start_color();
	curs_set(0);
	
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
	
	AnimatedAsciiSprite narwhal = new AnimatedAsciiSprite("graphics/man-moonwalk.txt", win, true, 16, 9);	
	AsciiSprite light = new AsciiSprite("graphics/spotlight.txt", win, false, 0, 5);

	if(!levelInput(selectS, win)){goto ragequite;}

	currentLevel = screen._levels[screen._levelSelected];

	while(1){
		drawLevelSelect();
		drawLevelScreen();
	}	

	clear();

	// game loop
	for(int i=0; i<50; i++){
		//clear();
		refresh();
		light.drawSprite();
		narwhal.drawSprite();
		narwhal.nextFrame();
		refresh();
		Thread.sleep(1);
	}

 ragequite:
	endwin();
}

void drawLevelSelect() {
	while(!selectS._levelSelected){
		clear();
		selectS.drawScreen();
		Thread.sleep(1);
		refresh();

		// temporary until the keyboard commands are listened to.
		selectS._levelSelected = true;
	}
	
	currentLevel = selectS._levels[selectS._levelSelected];
	levelS = new LevelScreen(currentLevel._name);
}

void drawLevelScreen() {
	while(levelS._playing){
		clear();
		levelS.draw();
		Thread.sleep(0.3);
		refresh();
	}
}
