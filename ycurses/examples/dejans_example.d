import ncurses;

version(Tango) {
  import tango.stdc.stringz;
} else {
  import std.string;
  //import std.stdio;
}

void create_box(int y, int x, int w, int h) {
  mvaddch(y, x, cast(chtype)'+');
  mvaddch(y, x + w, cast(chtype)'+');
  mvaddch(y + h, x, cast(chtype)'+');
  mvaddch(y + h, x + w, cast(chtype)'+');
  mvhline(y, x + 1, cast(chtype)'-', w - 1);
  mvhline(y + h, x + 1, cast(chtype)'-', w - 1);
  mvvline(y + 1, x, cast(chtype)'|', h - 1);
  mvvline(y + 1, x + w, cast(chtype)'|', h - 1);
}

int main(char[][] args) {
  int startx, starty, height, width;
  int x, y;

  initscr();
  start_color();
  cbreak();
  keypad(stdscr, true);
  noecho();

  init_pair(1, COLOR_BLACK, COLOR_CYAN);

  height = 2;
  width = 30;
  starty = (LINES - height)/2;
  startx = (COLS - width)/2;

  attron(COLOR_PAIR(1));

  create_box(starty, startx, width, height);

  mvprintw(starty, startx + 3, toStringz(" Hello world! "));
  mvprintw(starty+1,startx+1, toStringz(" Type any char to exit       "));

  mvprintw(0,0,"");
  refresh();
  x = stdscr.maxx;
  y = stdscr.maxy;
  getch();

  endwin();
  return 0;
} // main() function

