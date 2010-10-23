import ncurses;

int main()
{
    initscr();

    printw("Upper left corner           ");addch(acs_map[ACS.ULCORNER]);printw("\n");
    printw("Lower left corner           ");addch(acs_map[ACS.LLCORNER]);printw("\n");
    printw("Lower right corner          ");addch(acs_map[ACS.LRCORNER]);printw("\n");
    printw("Tee pointing right          ");addch(acs_map[ACS.LTEE]);printw("\n");
    printw("Tee pointing left           ");addch(acs_map[ACS.RTEE]);printw("\n");
    printw("Tee pointing up             ");addch(acs_map[ACS.BTEE]);printw("\n");
    printw("Tee pointing down           ");addch(acs_map[ACS.TTEE]);printw("\n");
    printw("Horizontal line             ");addch(acs_map[ACS.HLINE]);printw("\n");
    printw("Vertical line               ");addch(acs_map[ACS.VLINE]);printw("\n");
    printw("Large Plus or cross over    ");addch(acs_map[ACS.PLUS]);printw("\n");
    printw("Scan Line 1                 ");addch(acs_map[ACS.S1]);printw("\n");
    printw("Scan Line 3                 ");addch(acs_map[ACS.S3]);printw("\n");
    printw("Scan Line 7                 ");addch(acs_map[ACS.S7]);printw("\n");
    printw("Scan Line 9                 ");addch(acs_map[ACS.S9]);printw("\n");
    printw("Diamond                     ");addch(acs_map[ACS.DIAMOND]);printw("\n");
    printw("Checker board (stipple)     ");addch(acs_map[ACS.CKBOARD]);printw("\n");
    printw("Degree Symbol               ");addch(acs_map[ACS.DEGREE]);printw("\n");
    printw("Plus/Minus Symbol           ");addch(acs_map[ACS.PLMINUS]);printw("\n");
    printw("Bullet                      ");addch(acs_map[ACS.BULLET]);printw("\n");
    printw("Arrow Pointing Left         ");addch(acs_map[ACS.LARROW]);printw("\n");
    printw("Arrow Pointing Right        ");addch(acs_map[ACS.RARROW]);printw("\n");
    printw("Arrow Pointing Down         ");addch(acs_map[ACS.DARROW]);printw("\n");
    printw("Arrow Pointing Up           ");addch(acs_map[ACS.UARROW]);printw("\n");
    printw("Board of squares            ");addch(acs_map[ACS.BOARD]);printw("\n");
    printw("Lantern Symbol              ");addch(acs_map[ACS.LANTERN]);printw("\n");
    printw("Solid Square Block          ");addch(acs_map[ACS.BLOCK]);printw("\n");
    printw("Less/Equal sign             ");addch(acs_map[ACS.LEQUAL]);printw("\n");
    printw("Greater/Equal sign          ");addch(acs_map[ACS.GEQUAL]);printw("\n");
    printw("Pi                          ");addch(acs_map[ACS.PI]);printw("\n");
    printw("Not equal                   ");addch(acs_map[ACS.NEQUAL]);printw("\n");
    printw("UK pound sign               ");addch(acs_map[ACS.STERLING]);printw("\n");

    refresh();
    getch();
    endwin();

	return 0;
}
