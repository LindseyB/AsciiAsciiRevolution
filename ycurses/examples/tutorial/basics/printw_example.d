import ncurses;			/* ncurses.h includes stdio.h */  
 
int main()
{
 char mesg[]="Just a string\0";		/* message to be appeared on the screen */
 int row,col;				/* to store the number of rows and *
					 * the number of colums of the screen */
 initscr();				/* start the curses mode */
 getmaxyx(stdscr,row,col);		/* get the number of rows and columns */
 mvprintw(row/2,(col-mesg.length+1)/2,"%s",mesg.ptr);
                                	/* print the message at the center of the screen */
 mvprintw(row-2,0,"This screen has %d rows and %d columns\n",row+1,col+1);
 printw("Try resizing your window(if possible) and then run this program again");
 refresh();
 getch();
 endwin();

 return 0;
}
