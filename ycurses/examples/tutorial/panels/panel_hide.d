import panel;
version(Tango)
{
  import tango.stdc.stdio:sprintf;
}
else
{
  import std.c.stdio:sprintf;
}

struct PANEL_DATA {
	int hide;	/* true if panel is hidden */
}

const int NLINES = 10;
const int NCOLS = 40;

int main()
{	WINDOW*[3] my_wins;
	PANEL*[3]  my_panels;
	PANEL_DATA[3] panel_datas;
	PANEL_DATA* temp;
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

	/* Initialize panel datas saying that nothing is hidden */
	panel_datas[0].hide = false;
	panel_datas[1].hide = false;
	panel_datas[2].hide = false;

	set_panel_userptr(my_panels[0], &panel_datas[0]);
	set_panel_userptr(my_panels[1], &panel_datas[1]);
	set_panel_userptr(my_panels[2], &panel_datas[2]);

	/* Update the stacking order. 2nd panel will be on top */
	update_panels();

	/* Show it on the screen */
	attron(COLOR_PAIR(4));
	mvprintw(LINES - 3, 0, "Show or Hide a window with 'a'(first window)  'b'(Second Window)  'c'(Third Window)");
	mvprintw(LINES - 2, 0, "F1 to Exit");

	attroff(COLOR_PAIR(4));
	doupdate();
	
	while((ch = getch()) != KEY_F(1))
	{	switch(ch)
		{	case 'a':			
				temp = cast(PANEL_DATA*)panel_userptr(my_panels[0]);
				if(temp.hide == false)
				{	hide_panel(my_panels[0]);
					temp.hide = true;
				}
				else
				{	show_panel(my_panels[0]);
					temp.hide = false;
				}
				break;
			case 'b':
				temp = cast(PANEL_DATA*)panel_userptr(my_panels[1]);
				if(temp.hide == false)
				{	hide_panel(my_panels[1]);
					temp.hide = true;
				}
				else
				{	show_panel(my_panels[1]);
					temp.hide = false;
				}
				break;
			case 'c':
				temp = cast(PANEL_DATA*)panel_userptr(my_panels[2]);
				if(temp.hide == false)
				{	hide_panel(my_panels[2]);
					temp.hide = true;
				}
				else
				{	show_panel(my_panels[2]);
					temp.hide = false;
				}
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

	y = 2;
	x = 10;
	for(i = 0; i < n; ++i)
	{	size_t label_length;
		wins[i] = newwin(NLINES, NCOLS, y, x);
		label_length=sprintf(label.ptr, "Window Number %d", i + 1);
		win_show(wins[i], label[0..label_length], i + 1);
		y += 3;
		x += 7;
	}
}

/* Show the window with a border and a label */
void win_show(WINDOW *win, char[] label, int label_color)
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
