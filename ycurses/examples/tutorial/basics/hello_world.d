import ncurses;

int main()
{
  initscr();
  printw("Hello World!!!");
  refresh();
  getch();
  endwin();

  return 0;
}
