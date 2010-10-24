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
	Stdout("started playing\n");
	Thread.sleep(1000);
	Stdout("done with sleep\n");
	Stdout.format("{}\n", sc.pause());
	Thread.sleep(1000);
	Stdout.format("{}\n", sc.unpause());
	Thread.sleep(1000);
	Stdout.format("{}\n", sc.stop());*/
	
	initscr();
	noecho();
	cbreak();
	start_color();
	curs_set(0);

	win = newwin(34,127,0,0);
	message = newwin(2,80,0,0);

	wprintw(message, " Welcome to ASCII ASCII Revolution! ");
	wrefresh(message);

	// game loop
	while(1){
		
	}
}



