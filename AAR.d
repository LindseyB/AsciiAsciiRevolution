module AAR;

import tango.io.Stdout;
import tango.core.Thread;
import ncurses;
import tango.stdc.stringz;

import asciiSprite;
import animatedAsciiSprite;
import util.soundclip;

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


	AnimatedAsciiSprite narwhal = new AnimatedAsciiSprite("graphics/narwhal-dance.txt", win);
	
	// game loop
	for(int i=0; i<5; i++){
		clear();
		refresh();
		narwhal.drawSprite();
		narwhal.nextFrame();
		refresh();
		Thread.sleep(1);
	}

	endwin();
}



