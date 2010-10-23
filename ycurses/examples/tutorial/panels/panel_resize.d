import panel;
version(Tango)
{
  import tango.stdc.stdio: sprintf;
}
else
{
  import std.c.stdio:sprintf;
}

struct PANEL_DATA {
	int x, y, w, h;
	char label[80]; 
	int label_color;
	PANEL *next;
}

const int NLINES = 10;
const int NCOLS = 40;

int main()
{	WINDOW*[3] my_wins;
	PANEL*[3]  my_panels;
	PANEL_DATA*  top;
	PANEL* stack_top;
	WINDOW* temp_win, old_win;
	int ch;
	int newx, newy, neww, newh;
	bool size = false, pan_move = false;

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

	set_user_ptrs(my_panels, 3);
	/* Update the stacking order. 2nd panel will be on top */
	update_panels();

	/* Show it on the screen */
	attron(COLOR_PAIR(4));
	mvprintw(LINES - 3, 0, "Use 'm' for moving, 'r' for resizing");
	mvprintw(LINES - 2, 0, "Use tab to browse through the windows (F1 to Exit)");
	attroff(COLOR_PAIR(4));
	doupdate();

	stack_top = my_panels[2];
	top = cast(PANEL_DATA*)panel_userptr(stack_top);
	newx = top.x;
	newy = top.y;
	neww = top.w;
	newh = top.h;
	while((ch = getch()) != KEY_F(1))
	{	switch(ch)
		{	case 9:		/* Tab */
				top = cast(PANEL_DATA*)panel_userptr(stack_top);
				top_panel(top.next);
				stack_top = top.next;
				top = cast(PANEL_DATA*)panel_userptr(stack_top);
				newx = top.x;
				newy = top.y;
				neww = top.w;
				newh = top.h;
				break;
			case 'r':	/* Re-Size*/
				size = true;
				attron(COLOR_PAIR(4));
				mvprintw(LINES - 4, 0, "Entered Resizing :Use Arrow Keys to resize and press <ENTER> to end resizing");
				refresh();
				attroff(COLOR_PAIR(4));
				break;
			case 'm':	/* Move */
				attron(COLOR_PAIR(4));
				mvprintw(LINES - 4, 0, "Entered Moving: Use Arrow Keys to Move and press <ENTER> to end moving");
				refresh();
				attroff(COLOR_PAIR(4));
				pan_move = true;
				break;
			case KEY_LEFT:
				if(size == true)
				{	--newx;
					++neww;
				}
				if(pan_move == true)
					--newx;
				break;
			case KEY_RIGHT:
				if(size == true)
				{	++newx;
					--neww;
				}
				if(pan_move == true)
					++newx;
				break;
			case KEY_UP:
				if(size == true)
				{	--newy;
					++newh;
				}
				if(pan_move == true)
					--newy;
				break;
			case KEY_DOWN:
				if(size == true)
				{	++newy;
					--newh;
				}
				if(pan_move == true)
					++newy;
				break;
			case 10:	/* Enter */
				move(LINES - 4, 0);
				clrtoeol();
				refresh();
				if(size == true)
				{	old_win = panel_window(stack_top);
					temp_win = newwin(newh, neww, newy, newx);
					replace_panel(stack_top, temp_win);
					win_show(temp_win, top.label.ptr, top.label_color); 
					delwin(old_win);
					size = false;
				}
				if(pan_move == true)
				{	move_panel(stack_top, newy, newx);
					pan_move = false;
				}
				break;
                        default:
                                break;
			
		}
		attron(COLOR_PAIR(4));
		mvprintw(LINES - 3, 0, "Use 'm' for moving, 'r' for resizing");
	    	mvprintw(LINES - 2, 0, "Use tab to browse through the windows (F1 to Exit)");
	    	attroff(COLOR_PAIR(4));
	        refresh();	
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
	{	wins[i] = newwin(NLINES, NCOLS, y, x);
		sprintf(label.ptr, "Window Number %d", i + 1);
		win_show(wins[i], label.ptr, i + 1);
		y += 3;
		x += 7;
	}
}

/* Set the PANEL_DATA structures for individual panels */
void set_user_ptrs(PANEL*[] panels, int n)
{	PANEL_DATA[] ptrs;
	WINDOW* win;
	int x, y, w, h, i;
	char temp[80];
	
	ptrs = new PANEL_DATA[n];
        //cast(PANEL_DATA*)calloc(n, sizeof(PANEL_DATA));

	for(i = 0;i < n; ++i)
	{	win = panel_window(panels[i]);
		getbegyx(win, y, x);
		getmaxyx(win, h, w);
		ptrs[i].x = x;
		ptrs[i].y = y;
		ptrs[i].w = w;
		ptrs[i].h = h;
		sprintf(temp.ptr, "Window Number %d", i + 1);
                for(int j=0; (ptrs[i].label[j] = temp[j]) != '\0'; j++){}
		//strcpy(ptrs[i].label, temp);
		ptrs[i].label_color = i + 1;
		if(i + 1 == n)
			ptrs[i].next = panels[0];
		else
			ptrs[i].next = panels[i + 1];
		set_panel_userptr(panels[i], &ptrs[i]);
	}
}

/* Show the window with a border and a label */
void win_show(WINDOW* win, char *label, int label_color)
{	int startx, starty, height, width;

	getbegyx(win, starty, startx);
	getmaxyx(win, height, width);

	box(win, 0, 0);
	mvwaddch(win, 2, 0, acs_map[ACS.LTEE]); 
	mvwhline(win, 2, 1, acs_map[ACS.HLINE], width - 2); 
	mvwaddch(win, 2, width - 1, acs_map[ACS.RTEE]); 
	
	print_in_middle(win, 1, 0, width, label, COLOR_PAIR(label_color));
}

void print_in_middle(WINDOW *win, int starty, int startx, int width, char *string, chtype color)
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

        for(length=0; string[length] != '\0'; length++){}
	//length = strlen(string);
	temp = (width - length)/ 2;
	x = startx + cast(int)temp;
	wattron(win, color);
	mvwprintw(win, y, x, "%s", string);
	wattroff(win, color);
	refresh();
}
