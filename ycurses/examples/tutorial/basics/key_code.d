import ncurses;
version(Tango)
{
  import tango.stdc.stdio: printf;
}
else
{
  import std.c.stdio: printf;
}
void main()
{	int ch;

	initscr();
	cbreak();
	noecho();
	keypad(stdscr, true);

	while(1){
		ch = getch();
		
		printw("The key pressed is %d\n", ch);
		refresh();
		if(ch == 'q'){
			break;
		}
	}
	endwin();
}
