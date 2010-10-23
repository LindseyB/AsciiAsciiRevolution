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

	ch = getch();
	endwin();
	printf("The key pressed is %d\n", ch);
}
