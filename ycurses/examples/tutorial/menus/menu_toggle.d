import menu;

const int CTRLD = 4;

char[][] choices = [
                        "Choice 1",
                        "Choice 2",
                        "Choice 3",
                        "Choice 4",
			"Choice 5",
			"Choice 6",
			"Choice 7",
                        "Exit"
                  ];

int main()
{	ITEM*[] my_items;
	int c;				
	MENU* my_menu;
        int n_choices, i;
	ITEM* cur_item;
	
	/* Initialize curses */	
	initscr();
        cbreak();
        noecho();
	keypad(stdscr, true);

	/* Initialize items */
        n_choices = choices.length;
        my_items.length = n_choices + 1;
        for(i = 0; i < n_choices; ++i)
                my_items[i] = new_item((choices[i]~'\0').ptr, (choices[i]~'\0').ptr);
	my_items[n_choices] = null;

	my_menu = new_menu(my_items.ptr);

	/* Make the menu multi valued */
	menu_opts_off(my_menu, O_ONEVALUE);

	mvprintw(LINES - 3, 0, "Use <SPACE> to select or unselect an item.");
	mvprintw(LINES - 2, 0, "<ENTER> to see presently selected items(F1 to Exit)");
	post_menu(my_menu);
	refresh();

	while((c = getch()) != KEY_F(1))
	{       switch(c)
	        {	case KEY_DOWN:
				menu_driver(my_menu, REQ_DOWN_ITEM);
				break;
			case KEY_UP:
				menu_driver(my_menu, REQ_UP_ITEM);
				break;
			case ' ':
				menu_driver(my_menu, REQ_TOGGLE_ITEM);
				break;
			case 10:	/* Enter */
			{	char temp[];
				ITEM **items;

				items = menu_items(my_menu);
                                temp = "";
				for(i = 0; i < item_count(my_menu); ++i)
					if(item_value(items[i]) == true)
					{
                                          char* tmp;
                                          for(tmp = item_name(items[i]);
                                              *tmp != '\0'; tmp++)
                                          {
                                            temp~=*tmp;
                                          }
                                          temp~= " ";
					}
				move(20, 0);
				clrtoeol();
				mvprintw(20, 0, (temp~'\0').ptr);
				refresh();
			}
			break;
                        default:
                        break;
		}
	}	

	free_item(my_items[0]);
        free_item(my_items[1]);
	free_menu(my_menu);
	endwin();
        return 0;
}
	
