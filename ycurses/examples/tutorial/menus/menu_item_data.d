import menu;

const int CTRLD = 4;

char[][] choices = [
                        "Choice 1",
                        "Choice 2",
                        "Choice 3",
                        "Choice 4",
                        "Exit"
                  ];

int main()
{	ITEM*[] my_items;
	int c;				
	MENU* my_menu;
        int n_choices, i;
	ITEM* cur_item;
	
	
	initscr();
        cbreak();
        noecho();
	keypad(stdscr, true);
	
        n_choices = choices.length;
        my_items.length = n_choices+1;

        for(i = 0; i < n_choices; ++i)
                my_items[i] = new_item((choices[i]~'\0').ptr, (choices[i]~'\0').ptr);
	my_items[n_choices] = null;

	my_menu = new_menu(my_items.ptr);
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
			case 10:	/* Enter */
				cur_item = current_item(my_menu);
				move(LINES - 2, 0);
				clrtoeol();
				mvprintw(LINES - 2, 0, "You have chosen %d item with name %s and description %s", 
				item_index(cur_item) + 1,  item_name(cur_item), 
				item_description(cur_item));
				
				refresh();
				pos_menu_cursor(my_menu);
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
	
