import ncurses;			/* ncurses.h includes stdio.h */  
 
int main()
{
 char mesg[]="Enter a string: \0";		/* message to be appeared on the screen */
 char str[80];
 int row,col;				/* to store the number of rows and *
					 * the number of colums of the screen */
 initscr();				/* start the curses mode */
 getmaxyx(stdscr,row,col);		/* get the number of rows and columns */
 mvprintw(row/2,(col-(mesg.length-1))/2,"%s",mesg.ptr);
                     		/* print the message at the center of the screen */
 getstr(str.ptr);
 mvprintw(LINES - 2, 0, "You Entered: %s", str.ptr);
 getch();
 endwin();

 return 0;
}
