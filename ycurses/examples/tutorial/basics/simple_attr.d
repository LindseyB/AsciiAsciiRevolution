/* pager functionality by Joseph Spainhour" <spainhou@bellsouth.net> */
import ncurses;
//#include <stdlib.h>
version(Tango)
{
  import tango.stdc.stdio;
}
else
{
  import std.c.stdio;
}

int main(char[][] args)
{ 
  int ch, prev, row, col;
  prev = EOF;
  FILE *fp;
  int y, x;

  if(args.length != 2)
  {
    printf("Usage: %s <a c file name>\n", (args[0]~'\0').ptr);
    return 1;
  }
  fp = fopen((args[1]~'\0').ptr, "r");
  if(fp == null)
  {
    perror("Cannot open input file");
    return 1;
  }
  initscr();				/* start curses mode */
  getmaxyx(stdscr, row, col);		/* find the boundaries of the screeen */
  while((ch = fgetc(fp)) != EOF)	/* read the file till we reach the end */
  {
    getyx(stdscr, y, x);		/* get the current curser position */
    if(y == (row - 1))			/* are we are at the end of the screen */
    {
      printw("<-press any key->");	/* tell the user to press a key */
      ncurses.getch();
      clear();				/* clear the screen */
      move(0, 0);			/* start at the beginning of the screen */
    }
    if(prev == '/' && ch == '*')    	/* if it is / and * then only
                                     	 * switch bold on */    
    {
      attron(A_BOLD);			/* cut bold on */
      getyx(stdscr, y, x);		/* get the current curser position */
      move(y, x - 1);			/* back up one space */
      printw("%c%c", '/', ch); 		/* the actual printing is done here */
    }
    else
      printw("%c", ch);
    refresh();
    if(prev == '*' && ch == '/')
      attroff(A_BOLD);        		/* switch it off once we got *
                                 	 * and then / */
    prev = ch;
  }
  ncurses.getch();
  endwin();                       	/* end curses mode */
  fclose(fp);
  return 0;
}
