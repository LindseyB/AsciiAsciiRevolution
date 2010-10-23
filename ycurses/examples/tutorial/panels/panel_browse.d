import panel;
version(Tango)
{
  import tango.stdc.stdio: sprintf;
}
else
{
  import std.c.stdio:sprintf;
}

const int NLINES = 10;
const int NCOLS = 40;


int main()
{	WINDOW*[3] my_wins;
	PANEL*[3]  my_panels;
	PANEL*  top;
	int ch;

	/* Initialize curses */
	initscr();
	start_color();
	cbreak();
	noecho();
	keypad(stdscr, true);
	scope(exit) endwin();

	/* Initialize all the colors */
	init_pair(1, COLOR_RED, COLOR_BLACK);
	init_pair(2, COLOR_GREEN, COLOR_BLACK);
	init_pair(3, COLOR_BLUE, COLOR_BLACK);
	init_pair(4, COLOR_CYAN, COLOR_BLACK);

	init_wins(my_wins.ptr, 3);
	
	/* Attach a panel to each window */ 	/* Order is bottom up */
	my_panels[0] = new_panel(my_wins[0]); 	/* Push 0, order: stdscr-0 */
	my_panels[1] = new_panel(my_wins[1]); 	/* Push 1, order: stdscr-0-1 */
	my_panels[2] = new_panel(my_wins[2]); 	/* Push 2, order: stdscr-0-1-2 */

	/* Set up the user pointers to the next panel */
	set_panel_userptr(my_panels[0], my_panels[1]);
	set_panel_userptr(my_panels[1], my_panels[2]);
	set_panel_userptr(my_panels[2], my_panels[0]);

	/* Update the stacking order. 2nd panel will be on top */
	update_panels();

	/* Show it on the screen */
	attron(COLOR_PAIR(4));
	mvprintw(LINES - 2, 0, "Use tab to browse through the windows (F1 to Exit)");
	attroff(COLOR_PAIR(4));
	doupdate();

	top = my_panels[2];
	while((ch = getch()) != KEY_F(1))
	{	switch(ch)
		{	case 9:
				top = cast(PANEL*)panel_userptr(top);
				top_panel(top);
				break;
                  default:
                                break;
		}
		update_panels();
		doupdate();
	}
	return 0;
}

/* Put all the windows */
void init_wins(WINDOW **wins, int n)
{	int x, y, i;
	char label[80];
        size_t label_length;

	y = 2;
	x = 10;
	for(i = 0; i < n; ++i)
	{	wins[i] = newwin(NLINES, NCOLS, y, x);
		label_length = sprintf(label.ptr, "Window Number %d", i + 1);
		win_show(wins[i], label[0..label_length], i + 1);
		y += 3;
		x += 7;
	}
}

/* Show the window with a border and a label */
void win_show(WINDOW* win, char[] label, int label_color)
{	int startx, starty, height, width;

	getbegyx(win, starty, startx);
	getmaxyx(win, height, width);

	box(win, 0, 0);
	mvwaddch(win, 2, 0, acs_map[ACS.LTEE]); 
	mvwhline(win, 2, 1, acs_map[ACS.HLINE], width - 2); 
	mvwaddch(win, 2, width - 1, acs_map[ACS.RTEE]); 
	
	print_in_middle(win, 1, 0, width, label, COLOR_PAIR(label_color));
}

void print_in_middle(WINDOW *win, int starty, int startx, int width, char[] string, chtype color)
{	int length, x, y;
	float temp;

	if(win == null)
		win = stdscr;
	getyx(win, y, x);
	if(startx != 0)
		x = startx;
	if(starty != 0)
		y = starty;
	if(width == 0)
		width = 80;

        length = string.length;
	temp = (width - length)/ 2;
	x = startx + cast(int)temp;
	wattron(win, color);
	mvwprintw(win, y, x, "%s", (string~'\0').ptr);
	wattroff(win, color);
	refresh();
}
