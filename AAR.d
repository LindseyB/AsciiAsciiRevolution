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

WINDOW* win;
WINDOW* message;

void main(){
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


	Thread.sleep(5);
	

	AnimatedAsciiSprite narwhal = new AnimatedAsciiSprite("graphics/man-moonwalk.txt", win, true, 16, 9);	
	AsciiSprite light = new AsciiSprite("graphics/spotlight.txt", win, false, 0, 5);
	
	SelectScreen screen = new SelectScreen("levels.txt");

	while(1){
		clear();
		screen.drawScreen();
		Thread.sleep(1);
		refresh();
	}

	// game loop
	for(int i=0; i<50; i++){
		clear();
		refresh();
		light.drawSprite();
		narwhal.drawSprite();
		narwhal.nextFrame();
		refresh();
		Thread.sleep(1);
	}

	endwin();
}



