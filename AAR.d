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

	message = newwin(2,80,0,0);

	wprintw(message, " Welcome to ASCII ASCII Revolution! ");
	wrefresh(message);
	
	AsciiSprite logo = new AsciiSprite("graphics/logo.txt");	
	logo.drawSprite(win);
	
	clear();

	AnimatedAsciiSprite narwhal = new AnimatedAsciiSprite("graphics/narwhal-dance.txt");

	// game loop
	while(1){
		clear();
		refresh();
		narwhal.drawSprite(win);
		narwhal.nextFrame();
		refresh();
		Thread.sleep(1);
	}
}



