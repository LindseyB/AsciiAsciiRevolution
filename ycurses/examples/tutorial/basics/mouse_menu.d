import ncurses;

const int WIDTH = 30;
const int HEIGHT = 10;

int startx = 0;
int starty = 0;

char[][] choices = [    "Choice 1",
                        "Choice 2",
                        "Choice 3",
                        "Choice 4",
                        "Exit"
                   ];

int main()
{
  int c;
  WINDOW* menu_win;
  MEVENT event;

  initscr();
  clear();
  noecho();
  cbreak();
  keypad(stdscr, true);
  scope(exit) endwin();

  startx = (80 - WIDTH) / 2;
  starty = (24 - HEIGHT) / 2;

  attron(A_REVERSE);
  mvprintw(23, 1, "Click on Exit to quit");
  attroff(A_REVERSE);
  refresh();

  menu_win = newwin(HEIGHT, WIDTH, starty, startx);
  keypad(menu_win, true);
  mousemask(ALL_MOUSE_EVENTS, null);

  print_menu(menu_win, 1);

while_loop:
  while((c = wgetch(menu_win)) != 'q')
  {
    switch(c)
    {
      case KEY_MOUSE:
        if(getmouse(&event) == OK)
        {
          mvprintw(21, 1, "x=%d y=%d bstate=%x         ",
              event.x, event.y, event.bstate);
          refresh();

          if(event.bstate & BUTTON1_CLICKED)
          {
            int choice = report_choice(event.x+1, event.y+1);
            if(choice == -1)
              break while_loop;

            mvprintw(22,1,"Choice made is: %d String Chosen is \"%10s\"",
               choice, (choices[choice]~'\0').ptr);
            refresh();
            print_menu(menu_win, choice+1);
          }
        }
        break;
            
      default:
        break;
    }
  }

  return 0;
}

void print_menu(WINDOW* menu_win, int highlight)
{
  int x, y;
  x = y = 2;

  box(menu_win, 0, 0);

  foreach(i, choice; choices)
  {
    if(highlight == i + 1)
      wattron(menu_win, A_REVERSE);

    mvwprintw(menu_win, y + i, x, "%s", (choice ~ '\0').ptr);
    wattroff(menu_win, A_REVERSE);
  }
  wrefresh(menu_win);
}

int report_choice(int mouse_x, int mouse_y)
{
  int i, j;
  i = startx + 2;
  j = starty + 3;

  foreach(choice, str; choices)
  {
    if((mouse_y == j + choice) &&
        (mouse_x >= i) && (mouse_x <= i+str.length))
    {
      if(choice == choices.length - 1)
        return -1;
      else
        return choice;
    }
  }
  return 0;
}
