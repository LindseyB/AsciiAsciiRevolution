/**
 * A simple example how to use D binding to the CURSES library, with support
 * for both Phobos and Tango frameworks.
 *
 * Copyright (c) 2007 Dejan Lekic , http://dejan.lekic.org
 *                    dejan.lekic @ (gmail.com || kcl.ac.uk)
 */

version(Tango) {
  import tango.io.Stdout;
  import tango.stdc.stringz;
} else {
  import std.string;
  import std.stdio;
}

import ncurses;

void createBox(int y, int x, int w, int h) {
  mvaddch(y, x, acs_map[ACS.ULCORNER]); // ACS_ULCORNER == acs_map['l']
  mvaddch(y, x + w, acs_map[ACS.URCORNER]); // ACS_URCORNER == acs_map['k']
  mvaddch(y + h, x, acs_map[ACS.LLCORNER]); // or acs_map['m']
  mvaddch(y + h, x + w, acs_map[ACS.LRCORNER]); // ACS_LRCORNER == acs_map['j']
  mvhline(y, x + 1, acs_map[ACS.HLINE], w - 1); // ACS_HLINE == acs_map['q']
  mvhline(y + h, x + 1, acs_map[ACS.HLINE], w - 1);
  mvvline(y + 1, x, acs_map[ACS.VLINE], h - 1);
  mvvline(y + 1, x + w, acs_map[ACS.VLINE], h - 1); // ACS_VLINE == acs_map['x']
} // createBox() function

int main(char[][] args) {
  int startx, starty, height, width;
  int x, y;

  // initialize CURSES
  initscr();
  // initialize D CURSES module
  //init_();
  // we want colors, so we need to initialize then in CURSES...
  start_color();
  // let's disable line-buffering
  cbreak();
  // let's enable the keypad in the application (using function keys)
  keypad(stdscr, true);
  // we do not want echoing
  noecho();
  // we change color pair with number 1 to black foreground and blue background.
  init_pair(1, COLOR_BLACK, COLOR_CYAN);
  // some properties of our box that we are going to draw
  height = 2;
  width = 30;
  starty = (LINES - height)/2;
  startx = (COLS - width)/2;
  // let's activate our attribute (color pair No1) initiated above
  attron(COLOR_PAIR(1));
  // let's make a box with some text
  createBox(starty, startx, width, height);
  mvprintw(starty, startx + 3, toStringz(" Hello world! "));
  mvprintw(starty+1,startx+1, toStringz(" Type any char to exit       "));

  mvprintw(0,0,"");
  /* In old CURSES nothing in previous 4 lines will be shown until
   * the execution of the line below. You can skip it, but it is better if you
   * use it.
   */
  refresh();
  // wait for a keypress
  wgetch(stdscr);
  // delete the screen
  clear();
  // print something else again, at upper left corner
  mvprintw(0,0,"End!");
  // wait for keypress again
  ncurses.getch(); // same as wgetch(stdscr)
  // When we are done with CURSES we must call endwin() to finish everything:
  endwin();
  // Let's check if alternate character set works...
  version(Tango) {
    Stdout(cast(char)acs_map[ACS.SSSS]).newline;
  } else {
    writefln(cast(char)acs_map[ACS.SSSS]);
  }
  return 0;
} // main() function
