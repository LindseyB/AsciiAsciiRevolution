/**
 * Authors: Jon "ylixir" Allen, ylixir@gmail.com
 * Copyright: Copyright (c) 2008 ylixir. All rights reserved.
 * License:
    Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.
*/

module ncurses;

version(Tango)
{
  import tango.stdc.stddef, tango.stdc.stdio, tango.stdc.stdarg;
}
else
{
  import std.c.stddef, std.c.stdio, std.c.stdarg;
  version(Win32)
  {
    alias wchar wint_t;
  }
  else
  {
    alias dchar wint_t;
  }
}

extern (C):

/* types */
alias   uint mmask_t;
alias   uint  chtype;
alias   chtype   attr_t;
typedef int OPTIONS;
typedef void  SCREEN;
struct  WINDOW
{
  short   cury,
          curx,
          maxy,
          maxx,
          begy,
          begx,
          flags;
  attr_t  attrs;
  chtype  bkgd;
  bool    notimeout,
          clear,
          leaveok,
          scroll,
          idlok,
          idcok,
          immed,
          sync,
          use_keypad;
  int     delay;
  void*   line;
  short   regtop,
          regbottom;
  int     parx,
          pary;
  WINDOW* parent;

  struct pdat
  {
    short pad_y,      pad_x,
          pad_top,    pad_left,
          pad_bottom, pad_right;
  }
  pdat pad;

  short yoffset;
  cchar_t bkgrnd;
}
const size_t CCHARW_MAX = 5;
struct cchar_t
{
  attr_t attr;
  wchar_t chars[CCHARW_MAX];
}

/* global variables */
extern WINDOW* stdscr;
extern WINDOW* curscr;
extern WINDOW* newscr;

extern int     LINES;
extern int     COLS;
extern int     TABSIZE;

extern int     ESCDELAY;

extern chtype acs_map[256];

/**
 * Add a complex character to a window, and advance the cursor.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * See_also: man curs_add_wch
 */
int add_wch(C:cchar_t)(C* wch)
{
  return wadd_wch(stdscr, wch);
}
int wadd_wch(WINDOW* win, cchar_t* wch);                        ///ditto
int mvadd_wch(N:int, C:cchar_t)(N y, N x, C* wch)               ///ditto
{
  return mvwadd_wch(stdscr, y, x, wch);
}
int mvwadd_wch(W:WINDOW, N:int, C:cchar_t)
      (W* win, N y, N x, C* wch)                                ///ditto
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wadd_wch(win, wch);
}

/**
 * Add a complex character to a window, advance the cursor,
 * and display it immediately.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * See_also: man curs_add_wch
 */
int echo_wchar(C:cchar_t)(C* wch )
{
  return wecho_wchar(stdscr, wch);
}
int wecho_wchar(WINDOW* win, cchar_t* wch);                     ///ditto

/**
 * Dump a string of complex characters out to a window.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * See_also: man curs_add_wchstr
 */
int add_wchstr(C:cchar_t)(C* wchstr)
{
  return wadd_wchstr(stdscr, wchstr);
}
int add_wchnstr(C:cchar_t, N:int)(C* wchstr, N n)       ///ditto
{
  return wadd_wchnstr(stdscr, wchstr, n);
}
int wadd_wchstr(W:WINDOW, C:cchar_t)(W* win, C* wchstr) ///ditto
{
  return wadd_wchnstr(win, wchstr, -1);
}
int wadd_wchnstr(WINDOW* win, cchar_t* wchstr, int n);  ///ditto
int mvadd_wchstr(N:int, C:cchar_t)(N y, N x, C* wchstr) ///ditto
{
  return mvwadd_wchstr(stdscr, y, x, wchstr);
}
int mvadd_wchnstr(N:int,C:cchar_t)(N y, N x, C* wchstr, N n)    ///ditto
{
  return mvwadd_wchnstr(stdscr, y, x, wchstr, n);
}
int mvwadd_wchstr(W:WINDOW, N:int, C:cchar_t)
  (W* win, N y, N x, C* wchstr)                         ///ditto
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wadd_wchstr(win, wchstr);
}
int mvwadd_wchnstr(W:WINDOW, N:int, C:cchar_t)
  (W* win, N y, N x, C* wchstr, N n)                         ///ditto
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wadd_wchnstr(win, wchstr, n);
}

/**
 * Add a character to a window, and advance the cursor.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * See_also: man curs_addch
 */
int addch(C:chtype)(C ch)
{
  return waddch(stdscr, ch);
}
int waddch(WINDOW* win, chtype ch);             ///ditto
int mvaddch(N:int, C:chtype)(N y, N x, C ch)    ///ditto
{
  return mvwaddch(stdscr, y, x, ch);
}
int mvaddch(N:int, C:char)(N y, N x, C ch)      ///ditto
{
  return mvwaddch(stdscr, y, x, ch);
}
int mvwaddch(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C ch) ///ditto
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddch(win, ch);
}
int mvwaddch(W:WINDOW, N:int, C:char)(W* win, N y, N x, C ch) ///ditto
{
  return mvwaddch(stdscr, y, x, cast(chtype)ch);
}

/**
 * Add a character to a window, advance the cursor,
 * and display it immediately.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * See_also: man curs_addch
 */
int echochar(C:chtype)(C ch)
{
  return wechochar(stdscr, ch);
}
int wechochar(WINDOW* win, chtype ch);          ///ditto

/**
 * Dump a string of characters out to a window.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * See_also: man curs_addchstr
 */
int addchstr(C:chtype)(C* chstr)
{
  return waddchstr(stdscr, str);
}
int addchnstr(C:chtype, N:int)(C* chstr, N n)///ditto
{
  return waddchnstr(stdscr, chstr, n);
}
int waddchstr(W:WINDOW, C:chtype)(W* win, C* chstr)///ditto
{
  return waddchnstr(win, chstr, -1);
}
int waddchnstr(WINDOW* win, chtype* chstr, int n);///ditto
int mvaddchstr(N:int, C:chtype)(N y, N x, C* chstr)///ditto
{
  return mvwaddchstr(stdscr, y, x, str);
}
int mvaddchnstr(N:int, C:chtype)(N y, N x, C* chstr, N n)///ditto
{
  return mvwaddchnstr(stdscr, y, x, chstr, n);
}
int mvwaddchstr(W:WINDOW, N:int, C:chtype)
  (W* win, N y, N x, C* chstr)///ditto
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddchnstr(win, chstr, -1);
}
int  mvwaddchnstr(W:WINDOW, N:int, C:chtype)
  (W* win,  N y, N x, C* chstr, N n)///ditto
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddchnstr(win, chstr, n);
}

/**
 * Dump a string of characters out to a window.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * See_also: man curs_addstr
 */
int addstr(C:char)(C* str)
{
  return waddnstr(stdscr, str, -1);
}
///ditto
int addnstr(C:char, N:int)(C* str, N n)
{
  return waddnstr(stdscr, str, n);
}
///ditto
int waddstr(W:WINDOW, C:char)(W* win, C* str)
{
  return waddnstr(win, str, -1);
}
///ditto
int waddnstr(WINDOW* win, char* str, int n);
///ditto
int mvaddstr(N:int, C:char)(N y, N x, C* str)
{
  return mvwaddstr(stdscr, y, x, str);
}
///ditto
int mvaddnstr(N:int, C:char)(N y, N x, C* str, N n)
{
  return mvwaddnstr(stdscr, y, x, str, n);
}
///ditto
int mvwaddstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddnstr(win, str, -1);
}
///ditto
int mvwaddnstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddnstr(win, str, n);
}

/**
 * Dump a string of wide characters out to a window.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * See_also: man curs_addwstr
 */
int addwstr(WC:wchar_t)(WC* wstr)
{
  return waddwstr(stdscr, wstr);
}
///ditto
int addnwstr(WC:wchar_t, N:int)(WC* wstr, N n)
{
  return waddnwstr(stdscr, wstr);
}
///ditto
int waddwstr(W:WINDOW, WC:wchar_t)(W* win, WC* wstr)
{
  return waddnwstr(win, wstr, -1);
}
///ditto
int waddnwstr(WINDOW* win, wchar_t* wstr, int n);
///ditto
int mvaddwstr(N:int, WC:wchar_t)(N y, N x, WC* wstr)
{
  return mvwaddwstr(stdscr, y, x, wstr);
}
///ditto
int mvaddnwstr(N:int, WC:wchar_t)(N y, N x, WC* wstr, N n)
{
  return mvwaddnwstr(stdscr, y, x, wstr, n);
}
///ditto
int mvwaddwstr(W:WINDOW, N:int, WC:wchar_t)(W* win, N y, N x, WC* wstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddwstr(win, wstr);
}
///ditto
int mvwaddnwstr(W:WINDOW, N:int, WC:wchar_t)
  (W* win, N y, N x, WC* wstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddnwstr(win, wstr, n);
}

/**
 * Turn off specific window attributes.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * Params:
 *     opts = reserved for future use.  Always use null.
 * See_also: man curs_attr
 */
int attroff(N:chtype)(N attrs)
{
  return wattroff(stdscr, attrs);
}
///ditto
int wattroff(W:WINDOW, N:chtype)(W* win, N attrs)
{
  return wattr_off(win, attrs, null);
}
///ditto
int attr_off(A:attr_t, V:void)(A attrs, V* opts)
{
  return wattr_off(stdscr, attrs, opts);
}
///ditto
int wattr_off(WINDOW* win, attr_t attrs, void* opts);
/**
 * Turn on specific window attributes.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * Params:
 *     opts = reserved for future use.  Always use null.
 * See_also: man curs_attr
 */
int attron(N:chtype)(N attrs)
{
  return wattron(stdscr, attrs);
}
///ditto
int wattron(W:WINDOW, N:chtype)(W* win, N attrs)
{
  return wattr_on(win, cast(attr_t)attrs, null);
}
///ditto
int attr_on(A:attr_t, V:void)(A attrs, V* opts)
{
  return wattr_on(stdscr, attrs, opts);
}
///ditto
int wattr_on(WINDOW* win, attr_t attrs, void* opts);
/**
 * Sets all window attributes.
 *
 * Returns: The new set of attributes.
 * Params:
 *     opts = reserved for future use.  Always use null.
 * See_also: man curs_attr
 */
int attrset(N:chtype)(N attrs)
{
  return wattrset(stdscr, attrs);
}
///ditto
int wattrset(W:WINDOW, N:chtype)(W* win, N attrs)
{
  return win.attrs = attrs;
}
///ditto
int attr_set(A:attr_t, S:short, V:void)(A attrs, S pair, V* opts)
{
  return wattr_set(stdscr, attrs, pair, opts);
}
///ditto
int wattr_set(W:WINDOW, A:attr_t, S:short, V:void)
  (W* win, A attrs, S pair, V* opts)
{
  return win.attrs = (attrs & ~A_COLOR) | COLOR_PAIR(pair);
}
/**
 * Sets the window's fore/back color attributes.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * Params:
 *      color_pair_number = the color_pair that represents
 *                          what the new attributes are to be.
 *                   opts = reserved for future use.  Always use null.
 * See_also: man curs_attr
 */
int color_set(N:short, V:void)(N color_pair_number, V* opts)
{
  return wcolor_set(stdscr, color_pair_number, opts);
}
///ditto
int wcolor_set(WINDOW* win, short color_pair_number, void* opts);
/**
 * Turns off all attributes.
 *
 * Returns: A_NORMAL.
 * See_also: man curs_attr
 */
int standend()()
{
  return wstandend(stdscr);
}
///ditto
int wstandend(W:WINDOW)(W* win)
{
  return wattrset(win, A_NORMAL);
}
/**
 * Sets the standout window attribute eg. attrset(A_STANDOUT).
 *
 * Returns: A_STANDOUT.
 * See_also: man curs_attr
 */
int standout()()
{
  return wstandout(stdscr);
}
///ditto
int wstandout(W:WINDOW)(W* win)
{
  return wattrset(win, A_STANDOUT);
}
/**
 * Gets the current attributes and color pair.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * Params:
 *       pair = this will hold the color pair.
 *      attrs = this will hold the attributes.
 *       opts = reserved for future use.  Always use null.
 * See_also: man curs_attr
 */
int attr_get(A:attr_t, S:short, V:void)(A* attrs, S* pair, V* opts)
{
  return wattr_get(stdscr, attrs, pair, opts);
}
///ditto
int wattr_get(W:WINDOW, A:attr_t, S:short, V:void)
  (W* win, A* attrs, S* pair, V* opts)
{
  if(attrs == null || pair == null)
    return ERR;

  *attrs = win.attrs;
  *pair = PAIR_NUMBER(win.attrs);
  return OK;
}
/**
 * Changes attributes for n characters.
 *
 * Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
 * Params:
 *          n = number of characters to change
 *       pair = this will hold the color pair.
 *       attr = this will hold the attributes.
 *       opts = reserved for future use.  Always use null.
 * See_also: man curs_attr
 */
int chgat(N:int, A:attr_t, S:short, V:void)(N n, A attr, S color, V* opts)
{
  return wchgat(stdscr, n, attr, color, opts);
}
///ditto
int wchgat(WINDOW* win, int n, attr_t attr, short color, void* opts);
///ditto
int mvchgat(N:int, A:attr_t, S:short, V:void)
  (N y, N x, N n, A attr, S color, V* opts)
{
  return mvwchgat(stdscr, y, x, n, attr, color, opts);
}
///ditto
int mvwchgat(W:WINDOW, N:int, A:attr_t, S:short, V:void)
  (W* win, N y, N x, N n, A attr, S color, V* opts)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wchgat(win, n, attr, color, opts);
}
/**
  Returns color pair n.
  */
chtype COLOR_PAIR(N:int)(N n)
{
  return cast(chtype)(n<<8);
}
/**
  Inverse of COLOR_PAIR
  */
short PAIR_NUMBER(A:attr_t)(A attrs)
{
  return (attrs & A_COLOR) >> 8;
}
/**
  Attributes that can be passed to attron, attrset, attroff or OR'd with
  the characters passed to addch.
  */
enum :chtype
{
///Normal
  A_NORMAL      = 0x0,
///ditto
  WA_NORMAL     = A_NORMAL,
///Best highlighting
  A_STANDOUT    = 0x10000,
///ditto
  WA_STANDOUT   = A_STANDOUT,
///Underlined
  A_UNDERLINE   = 0x20000,
///ditto
  WA_UNDERLINE  = A_UNDERLINE,
///Reverse Video
  A_REVERSE     = 0x40000,
///ditto
  WA_REVERSE    = A_REVERSE,
///Blinking
  A_BLINK       = 0x80000,
///ditto
  WA_BLINK      = A_BLINK,
///Half as bright
  A_DIM         = 0x100000,
///ditto
  WA_DIM        = A_DIM,
///Bold
  A_BOLD        = 0x200000,
///ditto
  WA_BOLD       = A_BOLD,
///Protected
  A_PROTECT     = 0x1000000,
///ditto
  WA_PROTECT    = A_PROTECT,
///Invisible/Blank
  A_INVIS       = 0x800000,
///ditto
  WA_INVIS      = A_INVIS,
///Alternate character set
  A_ALTCHARSET  = 0x400000,
///ditto
  WA_ALTCHARSET = A_ALTCHARSET,
///Bitmask to get only the character
  A_CHARTEXT    = 0xFF,
///Bitmask to get everything but the character
  A_ATTRIBUTES  = 0xFFFFFF00,
///ditto
  WA_ATTRIBUTES = A_ATTRIBUTES,
///Bitmask to get the color
  A_COLOR       = 0xFF00,
///Unimplemented?
  A_HORIZONTAL  = 0x2000000,
///ditto
  WA_HORIZONTAL = A_HORIZONTAL,
///ditto
  A_LEFT        = 0x4000000,
///ditto
  WA_LEFT       = A_LEFT,
///ditto
  A_LOW         = 0x8000000,
///ditto
  WA_LOW        = A_LOW,
///ditto
  A_RIGHT       = 0x10000000,
///ditto
  WA_RIGHT      = A_RIGHT,
///ditto
  A_TOP         = 0x20000000,
///ditto
  WA_TOP        = A_TOP,
///ditto
  A_VERTICAL    = 0x40000000,
///ditto
  WA_VERTICAL   = A_VERTICAL
}
/**
Routines to ring bell, or flash screen

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_beep
  */
int beep();
///ditto
int flash();

/**
Manipulate the background characters of a window. The bkgd routines
apply the setting to every character on the screen.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_bkgd
  */
void bkgdset(C:chtype)(C ch)
{
  return wbkgdset(stdscr, ch);
}
///ditto
void wbkgdset(WINDOW* win, chtype ch);
///ditto
int bkgd(C:chtype)(C ch)
{
  return wbkgd(stdscr, ch);
}
///ditto
int wbkgd(WINDOW* win, chtype ch);
///ditto
chtype getbkgd(W:WINDOW)(W* win)
{
  return win.bkgd;
}

/**
Manipulate the complex background characters of a window. The bkgrnd
routines apply the setting to every character on the screen.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_bkgrnd
  */
int bkgrnd(C:cchar_t)(C* wch)
{
  return wbkgrnd(stdscr, wch);
}
///ditto
int wbkgrnd(WINDOW* win, cchar_t* wch);
///ditto
void bkgrndset(C:cchar_t)(C* wch )
{
  wbkgrndset(stdscr, wch);
}
///ditto
void wbkgrndset(WINDOW* win, cchar_t* wch);
///ditto
int getbkgrnd(C:cchar_t)(C* wch)
{
  return wgetbkgrnd(stdscr, wch);
}
///ditto
int wgetbkgrnd(W:WINDOW, C:cchar_t)(W* win, C* wch)
{
  *wch=win.bkgrnd;
  return OK;
}

/**
Draw a box around the window. A zero parameter for any of the character
parameters will draw with the default ACS character for a line/corner.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
Params:
ls = left side,
rs = right side,
ts = top side,
bs = bottom side,
tl = top left-hand corner,
tr = top right-hand corner,
bl = bottom left-hand corner, and
br = bottom right-hand corner.

See_also: man curs_border
  */
int border(C:chtype)(C ls, C rs, C ts, C bs, C tl, C tr, C bl, C br)
{
  return wborder(stdscr, ls, rs, ts, bs, tl, tr, bl, br);
}
///ditto
int wborder(WINDOW* win, chtype ls, chtype rs,
  chtype ts, chtype bs, chtype tl, chtype tr,
  chtype bl, chtype br);
/**
Same as wborder(win, verch, verch, horch, horch, 0, 0, 0, 0)

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_border
*/
int box(W:WINDOW, C:chtype)(W* win, C verch, C horch)
{
  return wborder(win, verch, verch, horch, horch, 0, 0, 0, 0);
}
///ditto
int box(W:WINDOW, C:int)(W* win, C verch, C horch)
{
  return wborder(win, verch, verch, horch, horch, 0, 0, 0, 0);
}
/**
Draw a horizontal or vertical line in the window.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_border
*/
int hline(C:chtype, N:int)(C ch, N n)
{
  return whline(stdscr, ch, n);
}
///ditto
int whline(WINDOW* win, chtype ch, int n);
///ditto
int vline(C:chtype, N:int)(C ch, N n)
{
  return wvline(stdscr, ch, n);
}
///ditto
int wvline(WINDOW* win, chtype ch, int n);
///ditto
int mvhline(N:int, C:chtype)(N y, N x, C ch, N n)
{
  return mvwhline(stdscr, y, x, ch, n);
}
///ditto
int mvwhline(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C ch, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return whline(win, ch, n);
}
///ditto
int mvvline(N:int, C:chtype)(N y, N x, C ch, N n)
{
  return mvwvline(stdscr, y, x, ch, n);
}
///ditto
int mvwvline(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C ch, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wvline(win, ch, n);
}

/**
Draw a box around the window. A null parameter for any of the character
parameters will draw with the default ACS character for a line/corner.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
Params:
ls = left side,
rs = right side,
ts = top side,
bs = bottom side,
tl = top left-hand corner,
tr = top right-hand corner,
bl = bottom left-hand corner, and
br = bottom right-hand corner.

See_also: man curs_border_set
  */
int border_set(C:cchar_t)
  (C* ls, C* rs, C* ts, C* bs, C* tl, C* tr, C* bl, C* br)
{
  return wborder_set(stdscr, ls, rs, ts, bs, tl, tr, bl, br);
}
///ditto
int wborder_set(
  WINDOW* win,
  cchar_t* ls, cchar_t* rs, cchar_t* ts, cchar_t* bs,
  cchar_t* tl, cchar_t* tr, cchar_t* bl, cchar_t* br);
/**
Same as wborder_set(win, verch, verch, horch, horch, null, null, null,
null)

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_border_set
*/int box_set(W:WINDOW, C:cchar_t)(W* win, C* verch, C* horch)
{
  return wborder_set
    (win, verch, verch, horch, horch, null, null, null, null);
}
/**
Draw a horizontal or vertical line in the window.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_border_set
*/
int hline_set(C:cchar_t, N:int)(C* wch, N n)
{
  return whline_set(stdscr, wch, n);
}
///ditto
int whline_set(WINDOW* win, cchar_t* wch, int n);
///ditto
int mvhline_set(N:int, C:cchar_t)(N y, N x, C* wch, N n)
{
  return mvwhline_set(stdscr, y, x, wch, n);
}
///ditto
int mvwhline_set(W:WINDOW, N:int, C:cchar_t)
  (W* win, N y, N x, C* wch, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return whline_set(win, wch, n);
}
///ditto
int vline_set(C:cchar_t, N:int)(C* wch, N n)
{
  return wvline_set(stdscr, wch, n);
}
///ditto
int wvline_set(WINDOW* win, cchar_t* wch, int n);
///ditto
int mvvline_set(N:int, C:cchar_t)(N y, N x, C* wch, N n)
{
  return mvwvline_set(stdscr, y, x, wch, n);
}
///ditto
int mvwvline_set(W:WINDOW, N:int, C:cchar_t)
  (W* win, N y, N x, C* wch, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wvline_set(win, wch, n);
}

/**
Write blanks to the whole window.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_clear
*/
int erase()()
{
  return werase(stdscr);
}
///ditto
int werase(WINDOW* win);
/**
Similar to erase, but also forces the window to repaint from scratch on
the next refresh.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_clear
*/
int clear()()
{
  return wclear(stdscr);
}
///ditto
int wclear(WINDOW* win);
/**
Clears from cursor to bottom of the screen.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_clear
*/
int clrtobot()()
{
  return wclrtobot(stdscr);
}
///ditto
int wclrtobot(WINDOW* win);
/**
Clears from cursor to end of the line.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_clear
*/
int clrtoeol()()
{
  return wclrtoeol(stdscr);
}
///ditto
int wclrtoeol(WINDOW* win);

///Maximum number of colors supported
extern int COLORS;
///Maximum number of color pairs supported
extern int COLOR_PAIRS;
/**
Call before using any other color manipulation routines.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_color
*/
int start_color();
/**
Initialize a new color pair.

Params:
pair=index of the new pair
f=foreground color
b=background color

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_color
*/
int init_pair(short pair, short f, short b);
/**
Changes the definition of a color.  When used all colors on the
screen with that color change to the new definition.

Params:
color=the color to define ranged 0..COLORS
r=red component ranged 0..1000
g=green component ranged 0..1000
b=blue component ranged 0..1000

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_color
*/
int init_color(short color, short r, short g, short b);
/**
Check to see whether the terminal can manipulate colors.

See_also: man curs_color
*/
bool has_colors();
/**
Check to see whether you can change the color definitions.

See_also: man curs_color
*/
bool can_change_color();
/**
Get the color components for the specified color.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_color
*/
int color_content(short color, short* r, short* g, short* b);
/**
Get the foreground and background colors of the specified pair.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_color
*/
int pair_content(short pair, short* f, short* b);
enum :chtype
{
///Predefined colors
  COLOR_BLACK   = 0,
///ditto
  COLOR_RED     = 1,
///ditto
  COLOR_GREEN   = 2,
///ditto
  COLOR_YELLOW  = 3,
///ditto
  COLOR_BLUE    = 4,
///ditto
  COLOR_MAGENTA = 5,
///ditto
  COLOR_CYAN    = 6,
///ditto
  COLOR_WHITE   = 7
}

/**
Delete a character. Shifts characters to the right of the character over.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_delch
*/
int delch()()
{
  return wdelch(stdscr);
}
///ditto
int wdelch(WINDOW* win);
///ditto
int mvdelch(N:int)(N y, N x)
{
  return mvwdelch(stdscr, y, x);
}
///ditto
int mvwdelch(W:WINDOW, N:int)(W* win, N y, N x)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wdelch(win);
}

/**
Delete line, moving lines below up.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_deleteln
*/
int deleteln()()
{
  return winsdelln(stdscr, -1);
}
///ditto
int wdeleteln(W:WINDOW)(W* win)
{
  return winsdelln(win, -1);
}
/**
For n>0, insert n lines above the current line. For n<0 delete n lines
and move the remaining lines up.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_deleteln
*/
int insdelln(N:int)(N n)
{
  return winsdelln(stdscr, n);
}
///ditto
int winsdelln(WINDOW* win, int n);
/**
Insert a blank line above the current line.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_deleteln
*/
int insertln()()
{
  return winsdelln(stdscr, 1);
}
///ditto
int winsertln(W:WINDOW)(W* win)
{
  return winsdelln(win, 1);
}

/**
Get the version number of the ncurses library.

See_also: man curs_extend
*/
char* curses_version();
/**
Controls whether the calling app can use nonstandard names from terminfo.

See_also: man curs_extend;
*/
int use_extended_names(bool enable);

/**
Read a character from the terminal.

Returns: $(D_PARAM KEY_CODE_YES) when a function key is pressed. $(D_PARAM OK) when a wide character is reported. $(D_PARAM ERR) otherwise.

See_also: man curs_get_wch
*/
int get_wch(WN:wint_t)(WN* wch)
{
  return wget_wch(stdscr, wch);
}
///ditto
int wget_wch(WINDOW* win, wint_t* wch);
///ditto
int mvget_wch(N:int, WN:wint_t)(N y, N x, WN* wch)
{
  return mvwget_wch(stdscr, y, x, wch);
}
///ditto
int mvwget_wch(W:WINDOW, N:int, WN:wint_t)(W* win, N y, N x, WN* wch)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wget_wch(win, wch);
}
/**
Pushes a character back onto the input queue. Only one push back is
guaranteed.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_get_wch
*/
int unget_wch(wchar_t wch);

/**
Read input into a string until a newline, end of line, or end of file
is reached. Functions that take an n parameter read at most n characters.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_get_wstr
*/
int get_wstr(WN:wint_t)(WN* wstr)
{
  return wget_wstr(stdscr, wstr);
}
///ditto
int getn_wstr(WN:wint_t, N:int)(WN* wstr, N n)
{
  return wgetn_wstr(stdscr, wstr, n);
}
///ditto
int wget_wstr(W:WINDOW, WN:wint_t)(W* win, WN* wstr)
{
  return wgetn_wstr(win, wstr, -1);
}
///ditto
int wgetn_wstr(WINDOW* win, wint_t* wstr, int n);
///ditto
int mvget_wstr(N:int, WN:wint_t)(N y, N x, WN* wstr)
{
  return mvwget_wstr(stdscr, y, x, wstr);
}
///ditto
int mvgetn_wstr(N:int, WN:wint_t)(N y, N x, WN* wstr, N n)
{
  return mvwgetn_wstr(stdscr, y, x, wstr, n);
}
///ditto
int mvwget_wstr(W:WINDOW, N:int, WN:wint_t)(W* win, N y, N x, WN* wstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wget_wstr(win, wstr);
}
///ditto
int mvwgetn_wstr(W:WINDOW, N:int, WN:wint_t)
  (W* win, N y, N x, WN* wstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wgetn_wstr(win, wstr, n);
}

/**
Gets a wide character string and rendering data from a cchar_t.
If wch is not null getcchar fills out the other parameters.
If wch is null, getcchar doesn't fill anything out, but returns
the number of characters in the cchar_t

Params:
opts=Reserved for future use. Always null.

Returns: $(D_PARAM OK) or length of string when successful and $(D_PARAM ERR) when not.

See_also: man curs_getcchar
*/
int getcchar(cchar_t* wcval, wchar_t* wch, attr_t* attrs,
    short* color_pair, void* opts);
/**
Fills out a cchar_t with color, attribute, and string data. The string
needs to be null terminated

Params:
opts=Reserver for future use. Use null.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_getcchar
*/
int setcchar(cchar_t *wcval, wchar_t* wch, attr_t attrs,
    short color_pair, void* opts );

/**
Reads a character from a window.

Returns: $(D_PARAM ERR) on failure, or a number representing a
key on success.
See_also: man curs_getch
*/
int getch()()
{
  return wgetch(stdscr);
}
///ditto
int wgetch(WINDOW* win);
///ditto
int mvgetch(N:int)(N y, N x)
{
  return mvwgetch(stdscr, y, x);
}
///ditto
int mvwgetch(W:WINDOW, N:int)(W* win, N y, N x)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wgetch(win);
}
/**
Puts a character back onto the input queue.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man curs_getch
*/
int ungetch(int ch);
/**
Checks to see of the current terminal has support for a given key.

Returns: Zero if the key isn't supported, or non-zero if it is.
See_also: man curs_getch
*/
int has_key(int ch);

/**
Codes that might be returned by getch if keypad is enabled.
See_also: man curs_getch
*/
enum :int
{
  KEY_CODE_YES  = 0x100,
  KEY_MIN       = 0x101,
/**
Codes that might be returned by getch if keypad is enabled.
See_also: man curs_getch
*/
  KEY_BREAK     = 0x101,
  ///ditto
  KEY_DOWN      = 0x102,
  ///ditto
  KEY_UP        = 0x103,
  ///ditto
  KEY_LEFT      = 0x104,
  ///ditto
  KEY_RIGHT     = 0x105,
  ///ditto
  KEY_HOME      = 0x106,
  ///ditto
  KEY_BACKSPACE = 0x107,
  KEY_F0        = 0x108,
  ///ditto
  KEY_DL        = 0x148,
  ///ditto
  KEY_IL        = 0x149,
  ///ditto
  KEY_DC        = 0x14A,
  ///ditto
  KEY_IC        = 0x14B,
  ///ditto
  KEY_EIC       = 0x14C,
  ///ditto
  KEY_CLEAR     = 0x14D,
  ///ditto
  KEY_EOS       = 0x14E,
  ///ditto
  KEY_EOL       = 0x14F,
  ///ditto
  KEY_SF        = 0x150,
  ///ditto
  KEY_SR        = 0x151,
  ///ditto
  KEY_NPAGE     = 0x152,
  ///ditto
  KEY_PPAGE     = 0x153,
  ///ditto
  KEY_STAB      = 0x154,
  ///ditto
  KEY_CTAB      = 0x155,
  ///ditto
  KEY_CATAB     = 0x156,
  ///ditto
  KEY_ENTER     = 0x157,
  ///ditto
  KEY_SRESET    = 0x158,
  ///ditto
  KEY_RESET     = 0x159,
  ///ditto
  KEY_PRINT     = 0x15A,
  ///ditto
  KEY_LL        = 0x15B,
  ///ditto
  KEY_A1        = 0x15C,
  ///ditto
  KEY_A3        = 0x15D,
  ///ditto
  KEY_B2        = 0x15E,
  ///ditto
  KEY_C1        = 0x15F,
  ///ditto
  KEY_C3        = 0x160,
  ///ditto
  KEY_BTAB      = 0x161,
  ///ditto
  KEY_BEG       = 0x162,
  ///ditto
  KEY_CANCEL    = 0x163,
  ///ditto
  KEY_CLOSE     = 0x164,
  ///ditto
  KEY_COMMAND   = 0x165,
  ///ditto
  KEY_COPY      = 0x166,
  ///ditto
  KEY_CREATE    = 0x167,
  ///ditto
  KEY_END       = 0x168,
  ///ditto
  KEY_EXIT      = 0x169,
  ///ditto
  KEY_FIND      = 0x16A,
  ///ditto
  KEY_HELP      = 0x16B,
  ///ditto
  KEY_MARK      = 0x16C,
  ///ditto
  KEY_MESSAGE   = 0x16D,
  ///ditto
  KEY_MOVE      = 0x16E,
  ///ditto
  KEY_NEXT      = 0x16F,
  ///ditto
  KEY_OPEN      = 0x170,
  ///ditto
  KEY_OPTIONS   = 0x171,
  ///ditto
  KEY_PREVIOUS  = 0x172,
  ///ditto
  KEY_REDO      = 0x173,
  ///ditto
  KEY_REFERENCE = 0x174,
  ///ditto
  KEY_REFRESH   = 0x175,
  ///ditto
  KEY_REPLACE   = 0x176,
  ///ditto
  KEY_RESTART   = 0x177,
  ///ditto
  KEY_RESUME    = 0x178,
  ///ditto
  KEY_SAVE      = 0x179,
  ///ditto
  KEY_SBEG      = 0x17A,
  ///ditto
  KEY_SCANCEL   = 0x17B,
  ///ditto
  KEY_SCOMMAND  = 0x17C,
  ///ditto
  KEY_SCOPY     = 0x17D,
  ///ditto
  KEY_SCREATE   = 0x17E,
  ///ditto
  KEY_SDC       = 0x17F,
  ///ditto
  KEY_SDL       = 0x180,
  ///ditto
  KEY_SELECT    = 0x181,
  ///ditto
  KEY_SEND      = 0x182,
  ///ditto
  KEY_SEOL      = 0x183,
  ///ditto
  KEY_SEXIT     = 0x184,
  ///ditto
  KEY_SFIND     = 0x185,
  ///ditto
  KEY_SHELP     = 0x186,
  ///ditto
  KEY_SHOME     = 0x187,
  ///ditto
  KEY_SIC       = 0x188,
  ///ditto
  KEY_SLEFT     = 0x189,
  ///ditto
  KEY_SMESSAGE  = 0x18A,
  ///ditto
  KEY_SMOVE     = 0x18B,
  ///ditto
  KEY_SNEXT     = 0x18C,
  ///ditto
  KEY_SOPTIONS  = 0x18D,
  ///ditto
  KEY_SPREVIOUS = 0x18E,
  ///ditto
  KEY_SPRINT    = 0x18F,
  ///ditto
  KEY_SREDO     = 0x190,
  ///ditto
  KEY_SREPLACE  = 0x191,
  ///ditto
  KEY_SRIGHT    = 0x192,
  ///ditto
  KEY_SRSUME    = 0x193,
  ///ditto
  KEY_SSAVE     = 0x194,
  ///ditto
  KEY_SSUSPEND  = 0x195,
  ///ditto
  KEY_SUNDO     = 0x196,
  ///ditto
  KEY_SUSPEND   = 0x197,
  ///ditto
  KEY_UNDO      = 0x198,
  ///ditto
  KEY_MOUSE     = 0x199,
  ///ditto
  KEY_RESIZE    = 0x19A,
  ///ditto
  KEY_EVENT     = 0x19B,
  ///ditto
  KEY_MAX       = 0x1FF
}
/**
Macro to that returns the value of the appropriate function key that
getch may return if keypad is enabled.

Params:
n=min 0. max 63.

See_also: man curs_getch
*/
int KEY_F(N:int)(N n)
in
{
  assert (n>=0, "Invalid value for KEY_F(n)");
  assert (n<=63, "Invalid value for KEY_F(n)");
}
out (result)
{
  assert (result < KEY_DL, "Invalid value for KEY_F(n)");
}
body
{
  return KEY_F0 + n;
}

/**
Get a string from the keyboard.  Input is terminated with newline/carriage
return, or when the specified maximum number is reached.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_getstr
*/
int getstr(C:char)(C* str)
{
  return wgetstr(stdscr, str);
}
///ditto
int getnstr(C:char, N:int)(C* str, N n)
{
  return wgetnstr(stdscr, str, n);
}
///ditto
int wgetstr(W:WINDOW, C:char)(W* win, C* str)
{
  return wgetnstr(win, str, -1);
}
///ditto
int wgetnstr(WINDOW* win, char* str, int n);
///ditto
int mvgetstr(N:int, C:char)(N y, N x, C* str)
{
  return mvwgetstr(stdscr, y, x, str);
}
///ditto
int mvwgetstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wgetstr(win, str);
}
///ditto
int mvgetnstr(N:int, C:char)(N y, N x, C* str, N n)
{
  return mvwgetnstr(stdscr, y, x, str, n);
}
///ditto
int mvwgetnstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wgetnstr(win, str, n);
}

/**
Get the coordinates of the cursor in the given window.

See_also: man_getyx
*/
void getyx(U:WINDOW*, T: int)(U win, ref T y, ref T x)
{
  y = getcury(win);
  x = getcurx(win);
}
///ditto
int getcurx(U:WINDOW*)(U win)
{
  return win ? win.curx : ERR;
}
///ditto
int getcury(U:WINDOW*)(U win)
{
  return win ? win.cury : ERR;
}
/**
Get the coordinates of subwindow win relative to the parent window.
If it's not, $(D_PARAM ERR) is placed in the coordinates.

See_also: man_getyx
*/
void getparyx(U:WINDOW*, T: int)(U win, ref T y, ref T x)
{
  y = getpary(win);
  x = getparx(win);
}
///ditto
int getpary(U:WINDOW*)(U win)
{
  return win ? win.pary : ERR;
}
///ditto
int getparx(U:WINDOW*)(U win)
{
  return win ? win.parx : ERR;
}
/**
Get the beginning coordinates and the size of a window.

See_also: man_getyx
*/
void getbegyx(U:WINDOW*, T: int)(U win, ref T y, ref T x)
{
  y = getbegy(win);
  x = getbegx(win);
}
///ditto
int getbegy(U:WINDOW*)(U win)
{
  return win ? win.begy : ERR;
}
///ditto
int getbegx(U:WINDOW*)(U win)
{
  return win ? win.begx : ERR;
}
///ditto
void getmaxyx(U:WINDOW*, T: int)(U win, ref T y, ref T x)
{
  y = getmaxy(win);
  x = getmaxx(win);
}
///ditto
int getmaxy(U:WINDOW*)(U win)
{
  return win ? win.maxy : ERR;
}
///ditto
int getmaxx(U:WINDOW*)(U win)
{
  return win ? win.maxx : ERR;
}

/**
Extract a complex character and rendition from a window

Returns: $(D_PARAM ERR) for null parameters or invalid coordinates.
$(D_PARAM OK) on success.

See_also: man curs_in_wch
*/
int in_wch(CC:cchar_t)(CC* wcval)
{
  return win_wch(stdscr, wcval);
}
///ditto
int mvin_wch(N:int, CC:cchar_t)(N y, N x, CC* wcval)
{
  return mvwin_wch(stdscr, y, x, wcval);
}
///ditto
int mvwin_wch(W:WINDOW, N:int, CC:cchar_t)(W* win, N y, N x, CC* wcval)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return win_wch(win, wcval);
}
///ditto
int win_wch(WINDOW* win, cchar_t* wcval);

/**
Get a string of complex characters and renditions from a window

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_in_wchstr
*/
int in_wchstr(CC:cchar_t)(CC* wchstr)
{
  return win_wchstr(stdscr, wchstr);
}
///ditto
int in_wchnstr(CC:cchar_t, N:int)(CC* wchstr, N n)
{
  return win_wchnstr(stdscr, wchstr, n);
}
///ditto
int win_wchstr(W:WINDOW, CC:cchar_t)(W* win, CC* wchstr)
{
  return win_wchnstr(win, wchstr, -1);
}
///ditto
int win_wchnstr(WINDOW* win, cchar_t* wchstr, int n);
///ditto
int mvin_wchstr(N:int, CC:cchar_t)(N y, N x, CC* wchstr)
{
  return mvwin_wchstr(stdscr, y, x, wchstr);
}
///ditto
int mvin_wchnstr(N:int, CC:cchar_t)(N y, N x, CC* wchstr, N n)
{
  return mvwin_wchnstr(stdscr, y, x, wchstr, n);
}
///ditto
int mvwin_wchstr(W:WINDOW, N:int, CC:cchar_t)
  (W* win, N y, N x, CC* wchstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return win_wchstr(win, wchstr);
}
///ditto
int mvwin_wchnstr(W:WINDOW, N:int, CC:cchar_t)
  (W* win, N y, N x, CC* wchstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return win_wchnstr(win, wchstr, n);
}

/**
Get a character and attributes from a window.

See_also: man curs_inch
*/
chtype inch()()
{
  return winch(stdscr);
}
///ditto
chtype winch(WINDOW* win);
///ditto
chtype mvinch(N:int)(N y, N x)
{
  return mvwinch(stdscr, y, x);
}
///ditto
chtype mvwinch(W:WINDOW, N:int)(W* win, N y, N x)
{
  if(wmove(win, y, x) == ERR)
    return cast(chtype)ERR;
  return winch(win);
}

/**
Get a string of characters and attributes from a window.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inchstr
*/
int inchstr(C:chtype)(C* chstr)
{
  return winchstr(stdscr, chstr);
}
///ditto
int inchnstr(C:chtype, N:int)(C* chstr, N n)
{
  return winchnstr(stdscr, chstr, n);
}
///ditto
int winchstr(W:WINDOW, C:chtype)(W* win, C* chstr)
{
  return winchnstr(win, chstr, -1);
}
///ditto
int winchnstr(WINDOW* win, chtype* chstr, int n);
///ditto
int mvinchstr(N:int, C:chtype)(N y, N x, C* chstr)
{
  return mvwinchstr(stdscr, y, x, chstr);
}
///ditto
int mvinchnstr(N:int, C:chtype)(N y, N x, C* chstr, N n)
{
  return mvwinchnstr(stdscr, y, x, chstr, n);
}
///ditto
int mvwinchstr(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C* chstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winchstr(win, chstr);
}
///ditto
int mvwinchnstr(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C* chstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winchnstr(win, chstr, n);
}

/**
Determines terminal type and initializes data structures.

Returns: A pointer to stdscr

See_also: man curs_initscr
*/
WINDOW* initscr();
/**
Routine to call before exitting, or leaving curses mode temporarily

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_initscr
*/
int endwin();
/**
Determines whether or not endwin has been called sinze the last refresh

See_also: man curs_initscr
*/
bool isendwin();
/**
Initializes a terminal.

Returns: A reference to the terminal

See_also: man curs_initscr
*/
SCREEN* newterm(char* type, FILE* outfd, FILE* infd);
/**
Sets the current terminal. The only routine to manipulate screens.

Returns: A reference to the terminal

See_also: man curs_initscr
*/
SCREEN* set_term(SCREEN* newscreen);
/**
Frees SCREEN data storage.

Returns: A reference to the terminal

See_also: man curs_initscr
*/
void delscreen(SCREEN* sp);

/**
Enables/disables line buffering and kill/erase processing. Makes all characters
typed immediately available to the program.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int cbreak();
///ditto
int nocbreak();
/**
Controls whether typed characters are echoed as they are typed.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int echo();
///ditto
int noecho();
/**
In half delay mode input returns return ERR after blocking for so many
tenths of a second if nothing is typed by the user.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int halfdelay(int tenths);
/**
Enabling interrupt flush, flushes the output when an interrupt occurs.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int intrflush(WINDOW* win, bool bf);
/**
Enables the keypad and the mouse and function keys, etc.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int keypad(WINDOW* win, bool bf);
/**
Force 8 significant bits to be returned on input if passed true,
or 7 if passed false.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int meta(WINDOW* win, bool bf);
/**
Determines whether or not getch blocks.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int nodelay(WINDOW *win, bool bf);
/**
Similar to cbreak, but also controls whether interrupt, quit, suspend,
and and flow control characters are passed through.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int raw();
///ditto
int noraw();
/**
Controls whether or not flushing of input queues is done when INTR, QUIT,
and SUSP keys are sent to the program.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
void noqiflush();
///ditto
void qiflush();
/**
Sets blocking or non blocking read for a given window. If delay is
is negative blocking is used.  If delay is zero then nonblocking is used.
If delay is positive then read blocks for delay milliseconds.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int notimeout(WINDOW *win, bool bf);
///ditto
void timeout(N:int)(N delay)
{
  return wtimeout(stdscr, delay);
}
///ditto
void wtimeout(WINDOW *win, int delay);
/**
Controls whether typeahead checking is enabled, and which file descripter
to use for it.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_inopts
*/
int typeahead(int fd);

/**
Insert a complex character with rendition behind the cursor.
Characters to the right of the cursor are moved right.
Cursor position remains unchanged.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_ins_wch
*/
int ins_wch(CC:cchar_t)(CC* wch)
{
  return wins_wch(stdscr, wch);
}
///ditto
int wins_wch(WINDOW* win, cchar_t* wch);
///ditto
int mvins_wch(N:int, CC:cchar_t)(N y, N x, CC* wch)
{
  return mvwins_wch(stdscr, y, x, wch);
}
///ditto
int mvwins_wch(W:WINDOW, N:int, CC:cchar_t)(W* win, N y, N x, CC* wch)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wins_wch(win, wch);
}

/**
Insert a wide character string behind the cursor.
Characters to the right of the cursor are moved right.
Cursor position remains unchanged.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_ins_wstr
*/
int ins_wstr(WC:wchar_t)(WC* wstr)
{
  return wins_wstr(stdscr, wstr);
}
///ditto
int ins_nwstr(WC:wchar_t, N:int)(WC* wstr, N n)
{
  return wins_nwstr(stdscr, wstr, n);
}
///ditto
int wins_wstr(W:WINDOW, WC:wchar_t)(W* win, WC* wstr)
{
  return wins_nwstr(win, wstr, -1);
}
///ditto
int wins_nwstr(WINDOW* win, wchar_t* wstr, int n);
///ditto
int mvins_wstr(N:int, WC:wchar_t)(N y, N x, WC* wstr)
{
  return mvwins_wstr(stdscr, y, x, wstr);
}
///ditto
int mvins_nwstr(N:int, WC:wchar_t)(N y, N x, WC* wstr, N n)
{
  return mvwins_nwstr(stdscr, y, x, wstr, n);
}
///ditto
int mvwins_wstr(W:WINDOW, N:int, WC:wchar_t)(W* win, N y, N x, WC* wstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wins_wstr(win, wstr);
}
///ditto
int mvwins_nwstr(W:WINDOW, N:int, WC:wchar_t)
  (W* win, N y, N x, WC* wstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wins_nwstr(win, wstr, n);
}

/**
Insert a character behind the cursor, moving characters to the right over.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_insch
*/
int insch(CH:chtype)(CH ch)
{
  return winsch(stdscr, ch);
}
///ditto
int winsch(WINDOW* win, chtype ch);
///ditto
int mvinsch(N:int, CH:chtype)(N y, N x, CH ch)
{
  return mvwinsch(stdscr, y, x, ch);
}
///ditto
int mvwinsch(W:WINDOW, N:int, CH:chtype)(W* win, N y, N x, CH ch)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winsch(win, ch);
}

/**
Insert a string behind the cursor.
Characters to the right of the cursor are moved right.
Cursor position remains unchanged.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_insstr
*/
int insstr(C:char)(C* str)
{
  return winsstr(stdscr, str);
}
///ditto
int insnstr(C:char, N:int)(C* str, N n)
{
  return winsnstr(stdscr, str, n);
}
///ditto
int winsstr(W:WINDOW, C:char)(W* win, C* str)
{
  return winsnstr(win, str, -1);
}
///ditto
int winsnstr(WINDOW* win, char* str, int n);
///ditto
int mvinsstr(N:int, C:char)(N y, N x, C* str)
{
  return mvwinsstr(stdscr, y, x, str);
}
///ditto
int mvinsnstr(N:int, C:char)(N y, N x, C* str, N n)
{
  return mvwinsnstr(stdscr, y, x, str, n);
}
///ditto
int mvwinsstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winsstr(win, str);
}
///ditto
int mvwinsnstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, char* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winsnstr(win, str, n);
}

/**
Get a string of characters in the window.

Returns: $(D_PARAM ERR) on failure, or the number of characters read
into the string.

See_also: man curs_instr
*/
int instr(C:char)(C* str)
{
  return winstr(stdscr, str);
}
///ditto
int innstr(C:char, N:int)(C* str, N n)
{
  return winnstr(stdscr, str, n);
}
///ditto
int winstr(W:WINDOW, C:char)(W* win, C* str)
{
  return winnstr(win, str, -1);
}
///ditto
int winnstr(WINDOW* win, char* str, int n);
///ditto
int mvinstr(N:int, C:char)(N y, N x, C* str)
{
  return mvwinstr(stdscr, y, x, str);
}
///ditto
int mvinnstr(N:int, C:char)(N y, N x, C* str, N n)
{
  return mvwinnstr(stdscr, y, x, str, n);
}
///ditto
int mvwinstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winstr(win, str);
}
///ditto
int mvwinnstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winnstr(win, str, n);
}

/**
Get a string of wide characters in the window.

Returns: $(D_PARAM ERR) on failure, or the number of characters read
into the string.

See_also: man curs_inwstr
*/
int inwstr(WC:wchar_t)(WC* str)
{
  return winwstr(stdscr, str);
}
///ditto
int innwstr(WC:wchar_t, N:int)(WC* str, N n)
{
  return winnwstr(stdscr, str, n);
}
///ditto
int winwstr(W:WINDOW, WC:wchar_t)(W* win, WC* str)
{
  return winnwstr(win, str, -1);
}
///ditto
int winnwstr(WINDOW* win, wchar_t* str, int n);
///ditto
int mvinwstr(N:int, WC:wchar_t)(N y, N x, WC* str)
{
  return mvwinwstr(stdscr, y, x, str);
}
///ditto
int mvinnwstr(N:int, WC:wchar_t)(N y, N x, WC* str, N n)
{
  return mvwinnwstr(stdscr, y, x, str, n);
}
///ditto
int mvwinwstr(W:WINDOW, N:int, WC:wchar_t)(W* win, N y, N x, WC* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winwstr(win, str);
}
///ditto
int mvwinnwstr(W:WINDOW, N:int, WC:wchar_t)(W* win, N y, N x, WC* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winnwstr(win, str, n);
}

/**
Save and restore the program and shell terminal modes.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_kernel
*/
int def_prog_mode();
///ditto
int def_shell_mode();
///ditto
int reset_prog_mode();
///ditto
int reset_shell_mode();
/**
Save and restore the terminal modes.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_kernel
*/
int resetty();
///ditto
int savetty();
/**
Remove a line from the top (positive) or bottom (negative) of the screen.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_kernel
*/
int ripoffline(int line, int (*init)(WINDOW* win, int cols));
/**
Set cursor visibility to invisible (0), normal (1) or very visible (2).

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_kernel
*/
int curs_set(int visibility);
/**
Sleep for a given number of milliseconds.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_kernel
*/
int napms(int ms);
/**
Get and set the location of the virtual screen cursor.

See_also: man curs_kernel
*/
void getsyx(T:int)(ref T y, ref T x)
{
  if(newscr.leaveok)
    y=x=-1;
  else
    getyx(newscr,y,x);
}
///ditto
void setsyx(T:int)(T y, T x)
{
  if((y==-1) && (x==-1))
    newscr.leaveok=true;
  else
  {
    newscr.leaveok=false;
    wmove(newscr, y, x);
  }
}

/**
Mouse event data
*/
struct MEVENT
{
  short id;         /// mouse device ID
  int x,            /// event coordinates
      y,            ///ditto
      z;            ///ditto
  mmask_t bstate;   /// button state
}
/**
Call when getch returns KEY_MOUSE to get the mouse event data.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_mouse
*/
int getmouse(MEVENT* event);
/**
Push the mouse event back onto the event stack.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_mouse
*/
int ungetmouse(MEVENT* event);
/**
Decide which mouse events reported to the app.

Returns: The mask of events that will be reported.

See_also: man curs_mouse
*/
mmask_t mousemask(mmask_t newmask, mmask_t* oldmask);
/**
Check to see if given coordinates are enclosed by the given window.

See_also: man curs_mouse
*/
bool wenclose(WINDOW* win, int y, int x);
/**
Convert coordinates from stdscr relative to screen relative.

See_also: man curs_mouse
*/
bool mouse_trafo(N:int, B:bool)(N* pY, N* pX, B to_screen)
{
  return wmouse_trafo(stdscr, pY, pX, to_screen);
}
///ditto
bool wmouse_trafo(WINDOW* win, int* pY, int* pX,
    bool to_screen);
/**
Set the maximum time in milliseconds for a press release to be recognized
as a click.

Returns: The previous interval value.

See_also: man curs_mouse
*/
int mouseinterval(int erval);
/* mouse events */
enum :mmask_t
{
  BUTTON1_RELEASED          = 0x1,      ///button up
  ///ditto
  BUTTON2_RELEASED          = 0x40,
  ///ditto
  BUTTON3_RELEASED          = 0x1000,
  ///ditto
  BUTTON4_RELEASED          = 0x40000,
  BUTTON1_PRESSED           = 0x2,      ///button down
  ///ditto
  BUTTON2_PRESSED           = 0x80,
  ///ditto
  BUTTON3_PRESSED           = 0x2000,
  ///ditto
  BUTTON4_PRESSED           = 0x80000,
  ///button up and down in less then
  ///mouseinterval time
  BUTTON1_CLICKED           = 0x4,
  ///ditto
  BUTTON2_CLICKED           = 0x100,
  ///ditto
  BUTTON3_CLICKED           = 0x4000,
  ///ditto
  BUTTON4_CLICKED           = 0x100000,
  BUTTON1_DOUBLE_CLICKED    = 0x8,      ///double click
  ///ditto
  BUTTON2_DOUBLE_CLICKED    = 0x200,
  ///ditto
  BUTTON3_DOUBLE_CLICKED    = 0x8000,
  ///ditto
  BUTTON4_DOUBLE_CLICKED    = 0x200000,
  BUTTON1_TRIPLE_CLICKED    = 0x10,     ///triple click
  ///ditto
  BUTTON2_TRIPLE_CLICKED    = 0x400,
  ///ditto
  BUTTON3_TRIPLE_CLICKED    = 0x10000,
  ///ditto
  BUTTON4_TRIPLE_CLICKED    = 0x400000,
  ///modifier key down during button state change
  BUTTON_CTRL               = 0x1000000,
  ///ditto
  BUTTON_SHIFT              = 0x2000000,
  ///ditto
  BUTTON_ALT                = 0x4000000,
  ///report movement
  REPORT_MOUSE_POSITION     = 0x8000000,
  ///report all button events
  ALL_MOUSE_EVENTS          = 0x7FFFFFF
}

/**
Move the cursor.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_move
*/
int move(N:int)(N y, N x)
{
  return wmove(stdscr, y, x);
}
///ditto
int wmove(WINDOW* win, int y, int x);

/**
Next refresh draws entire screen from scratch if true is passed.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_outopts
*/
int clearok(WINDOW* win, bool bf);
/**
Determines whether curses should consider using hardware line insertion/
deletion features of terminals.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_outopts
*/
int idlok(WINDOW* win, bool bf);
/**
Determines whether curses should consider using hardware character
insertion/deletion features of terminals.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_outopts
*/
void idcok(WINDOW* win, bool bf);
/**
Determines whether to automatically call refresh every time a window
is changed.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_outopts
*/
void immedok(WINDOW* win, bool bf);
/**
Allow the cursor to be left where it is when the update is finished.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_outopts
*/
int leaveok(WINDOW* win, bool bf);
/**
Set scrolling region.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_outopts
*/
int setscrreg(N:int)(N top, N bot)
{
  return wsetscrreg(stdscr, top, bot);
}
///ditto
int wsetscrreg(WINDOW* win, int top, int bot);
/**
Enable scrolling when cursor reaches edge of terminal.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_outopts
*/
int scrollok(WINDOW* win, bool bf);
/**
Enable/disable newline <-> return+line-feed translations.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_outopts
*/
int nl();
///ditto
int nonl();

/**
Overlay srcwin onto dstwin.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_overlay
*/
int overlay(WINDOW* srcwin, WINDOW* dstwin);
///ditto
int overwrite(WINDOW* srcwin, WINDOW* dstwin);
///ditto
int copywin(WINDOW* srcwin, WINDOW* dstwin, int sminrow,
     int smincol, int dminrow, int dmincol, int dmaxrow,
     int dmaxcol, int overlay);

/**
Create a new pad data structure.

See_also: man curs_pad
*/
WINDOW* newpad(int nlines, int ncols);
/**
Create a new subwindow within a pad.

See_also: man curs_pad
*/
WINDOW* subpad(WINDOW* orig, int nlines, int ncols,
     int begin_y, int begin_x);
/**
Similar to wrefresh and wnoutrefresh, but for pads instead of windows.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_pad
*/
int prefresh(WINDOW* pad, int pminrow, int pmincol,
     int sminrow, int smincol, int smaxrow, int smaxcol);
///ditto
int pnoutrefresh(WINDOW* pad, int pminrow, int pmincol,
     int sminrow, int smincol, int smaxrow, int smaxcol);
/**
Like addch, followed by refresh.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_pad
*/
int pechochar(WINDOW* pad, chtype ch);
///ditto
int pecho_wchar(WINDOW* pad, cchar_t *wch);

/**
Ship data to a printer.

See_also: man curs_print
*/
int mcprint(char *data, int len);

/**
printf for a curses window.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_printw
*/
int printw(char* fmt, ...);
///ditto
int wprintw(WINDOW* win, char* fmt, ...);
///ditto
int mvprintw(int y, int x, char* fmt, ...);
///ditto
int mvwprintw(WINDOW* win, int y, int x, char* fmt, ...);
///ditto
int vwprintw(WINDOW* win, char* fmt, va_list varglist);
///ditto
int vw_printw(W:WINDOW, C:char, V:va_list)(W* win, C* fmt, V varglist)
{
  return vwprintw(win, fmt, varglist);
}

/**
Copy a window to the physical terminal.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_refresh
*/
int refresh()()
{
  return wrefresh(stdscr);
}
///ditto
int wrefresh(WINDOW* win);
/**
Allows multiple updates. More efficient than refresh alone.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_refresh
*/
int wnoutrefresh(WINDOW* win);
///ditto
int doupdate();
/**
Indicates that some lines are corrupted and should be thrown away.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_refresh
*/
int redrawwin(W:WINDOW)(W* win)
{
  return wredrawln(win, 0, win.maxy+1);
}
///ditto
int wredrawln(WINDOW* win, int beg_line, int num_lines);

/**
scanf for a curses window.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_scanf
*/
int scanw(char* fmt, ...);
///ditto
int wscanw(WINDOW* win, char* fmt, ...);
///ditto
int mvscanw(int y, int x, char* fmt, ...);
///ditto
int mvwscanw(WINDOW* win, int y, int x, char* fmt, ...);
///ditto
int vw_scanw(W:WINDOW, C:char, V:va_list)(W* win, C* fmt, V varglist)
{
  return vwscanw(win, fmt, varglist);
}
///ditto
int vwscanw(WINDOW* win, char* fmt, va_list varglist);

/**
Dump/restore the contents of a virtual screen.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_scr_dump
*/
int scr_dump(char *filename);
///ditto
int scr_restore(char *filename);
///ditto
int scr_init(char *filename);
///ditto
int scr_set(char *filename);

/**
Scroll the window up one line

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_scroll
*/
int scroll(W:WINDOW)(W* win)
{
  return wscrl(win, 1);
}
/**
Scroll the window n lines.  Up for positive n, down for negative.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.

See_also: man curs_scroll
*/
int scrl(N:int)(N n)
{
  return wscrl(stdscr, n);
}
///ditto
int wscrl(WINDOW *win, int n);

/**
Routines for manipulating the set of "soft function key labels"

See_also: man curs_slk
*/
int slk_init(int fmt);
///ditto
int slk_set(int labnum, char* label, int fmt);
///ditto
int slk_set(int labnum, wchar_t* label, int fmt);
///ditto
int slk_refresh();
///ditto
int slk_noutrefresh();
///ditto
char* slk_label(int labnum);
///ditto
int slk_clear();
///ditto
int slk_restore();
///ditto
int slk_touch();
///ditto
int slk_attron(chtype attrs);
///ditto
int slk_attroff(chtype attrs);
///ditto
int slk_attrset(chtype attrs);
///ditto
int slk_attr_on(A:attr_t, V:void)(A attrs, V* opts)
{
  if(opts == null)
    return ERR;
  return slk_attron(a);
}
///ditto
int slk_attr_off(A:attr_t, V:void)(A attrs, V* opts)
{
  if(opts == null)
    return ERR;
  return slk_attroff(a);
}
///ditto
int slk_attr_set(attr_t attrs, short color_pair_number, void* opts);
///ditto
attr_t slk_attr();
///ditto
int slk_color(short color_pair_number);

/**
Get the output speed of the terminal in bits per second.

See_also: man curs_termattrs
*/
int baudrate();
/**
Get the erase and kill characters.

See_also: man curs_termattrs
*/
char erasechar();
///ditto
int erasewchar(wchar_t* ch);
///ditto
char killchar();
///ditto
int killwchar(wchar_t* ch);
/**
Check to see if the terminal has insert and delete character/line
capabilities.

See_also: man curs_termattrs
*/
bool has_ic();
///ditto
bool has_il();
/**
Get the terminal description.

See_also: man curs_termattrs
*/
char* longname();
///ditto
char* termname();
/**
Find out what attributes are supported by the terminal.

See_also: man curs_termattrs
*/
attr_t term_attrs();
///ditto
chtype termattrs();

/* *****************************************************************
 * The man pages have stuff for emulating the termcap library      *
 * but i don't actually see them on my system, so this is a place  *
 * holder for man curs_termcap, and curs_terminfo                  *
 *******************************************************************/


/**
Touch the window or line, convincing curses that the whole thing needs
to be redrawn.

See_also: man curs_touch
*/
int touchwin(W:WINDOW)(W* win)
{
  return wtouchln(win, 0, getmaxy(win), 1);
}
///ditto
int touchline(W:WINDOW, N:int)(W* win, N start, N count)
{
  return wtouchln(win, start, count, 1);
}
/**
Tell curses nothing has changed since the last refresh.

See_also: man curs_touch
*/
int untouchwin(W:WINDOW)(W* win)
{
  return wtouchln(win, 0, getmaxy(win), 0);
}
/**
Make n lines, starting with y look as if they have been changed or not.

See_also: man curs_touch
*/
int wtouchln(WINDOW* win, int y, int n, int changed);
/**
Check to see if the line/window was modified since the last refresh.

See_also: man curs_touch
*/
bool is_linetouched(WINDOW* win, int line);
///ditto
bool is_wintouched(WINDOW* win);

/**
Debugging features of ncurses.

See_also: man curs_trace
*/
void _tracef(char* format, ...);
///ditto
void _tracedump(char* label, WINDOW* win);
///ditto
char* _traceattr(attr_t attr);
///ditto
char* _traceattr2(int buffer, chtype ch);
///ditto
char* _nc_tracebits();
///ditto
char* _tracechar(ubyte ch);
///ditto
char* _tracechtype(chtype ch);
///ditto
char* _tracechtype2(int buffer, chtype ch);
///ditto
char* _tracemouse(MEVENT* event);
///ditto
void trace(uint param);

/* trace masks */
enum :uint
{
  TRACE_DISABLE  = 0x0000,
  TRACE_TIMES    = 0x0001,
  TRACE_TPUTS    = 0x0002,
  TRACE_UPDATE   = 0x0004,
  TRACE_MOVE     = 0x0008,
  TRACE_CHARPUT  = 0x0010,
  TRACE_ORDINARY = 0x001F,
  TRACE_CALLS    = 0x0020,
  TRACE_VIRTPUT  = 0x0040,
  TRACE_IEVENT   = 0x0080,
  TRACE_BITS     = 0x0100,
  TRACE_ICALLS   = 0x0200,
  TRACE_CCALLS   = 0x0400,
  TRACE_DATABASE = 0x0800,
  TRACE_ATTRS    = 0x1000,

  TRACE_SHIFT    = 13,
  TRACE_MAXIMUM  = ((1 << TRACE_SHIFT) - 1)
}

/**
Get a string that is a printable representation of the character.

See_also: man curs_util
*/
char* unctrl(chtype c);
///ditto
char* wunctrl(cchar_t* c);
/**
Get a string representation of the key.

See_also: man curs_util
*/
char* keyname(int c);
///ditto
char* key_name(wchar_t w);
/**
See_also: man curs_util
*/
void filter();
///ditto
void nofilter();
/**
Tells curses to use or not use actual line and column size of the
terminal.

See_also: man curs_util
*/
void use_env(bool f);
/**
Save and restore window data from a file.

See_also: man curs_util
*/
int putwin(WINDOW* win, FILE* filep);
///ditto
WINDOW* getwin(FILE* filep);
/**
Delay output by writing padding characters.

See_also: man curs_util
*/
int delay_output(int ms);
/**
Flush the input queue.

See_also: man curs_util
*/
int flushinp();

/**
Create a new window with the given size and coordinates.

See_also: curs_window
*/
WINDOW* newwin(int nlines, int ncols, int begin_y, int begin_x);
/**
Free the memory associated with the window.

See_also: curs_window
*/
int delwin(WINDOW* win);
/**
Move the window.

See_also: curs_window
*/
int mvwin(WINDOW* win, int y, int x);
/**
Make a subwindow.

See_also: curs_window
*/
WINDOW* subwin(WINDOW* orig, int nlines, int ncols, int begin_y, int begin_x);
///ditto
WINDOW* derwin(WINDOW* orig, int nlines, int ncols, int begin_y, int begin_x);
/**
Move a subwindow.

See_also: curs_window
*/
int mvderwin(WINDOW* win, int par_y, int par_x);
/**
Create a duplicate window.

See_also: curs_window
*/
WINDOW* dupwin(WINDOW* win);
/**
Touch all ancestors of the window.

See_also: curs_window
*/
void wsyncup(WINDOW* win);
/**
Call wsyncup automatically or not.

See_also: curs_window
*/
int syncok(WINDOW* win, bool bf);
/**
Update cursor position of ancestors of win.

See_also: curs_window
*/
void wcursyncup(WINDOW* win);
/**
Touch each location in win that has been updated in ancestor windows.

See_also: curs_window
*/
void wsyncdown(WINDOW* win);

/**
Assign terminal default colors to color number -1

See_also: man default_colors
*/
int use_default_colors();
/**
Tells curses what colors to use for color pair 0.

See_also: man default_colors
*/
int assume_default_colors(int fg, int bg);

/**
Define a keycode with corresponding control strings

See_also: man define_key
*/
int define_key(char* definition, int keycode);
/**
Check and see if a string is bound to any keycode.

See_also: man key_defined
*/
int key_defined(char* definition);
/**
Determine the string defined for a specific keycode.

See_also: man keybound
*/
char* keybound(int keycode, int count);
/**
Enable/disable specific keycodes.

See_also: man keyok
*/
int keyok(int keycode, bool enable);

/**
Check to see if resize_term would modify the window structures.

See_also: man resizeterm
*/
bool is_term_resized(int lines, int columns);
/**
Resizes the terminal window, and blank fills the extended areas.

See_also: man resizeterm
*/
int resize_term(int lines, int columns);
/**
Add bookkeeping for the SIGWINCH handler.

See_also: man resizeterm
*/
int resizeterm(int lines, int columns);

/**
Reallocate storage for an ncurses window to adjust its dimensions.

See_also: man wresize
*/
int wresize(WINDOW* win, int lines, int columns);

/* error codes */
enum
{
  OK = 0,
  ERR = -1
}



/* acs symbols */
enum ACS
{
  ULCORNER      = 'l',
  LLCORNER      = 'm',
  URCORNER      = 'k',
  LRCORNER      = 'j',
  LTEE          = 't',
  RTEE          = 'u',
  BTEE          = 'v',
  TTEE          = 'w',
  HLINE         = 'q',
  VLINE         = 'x',
  PLUS          = 'n',
  S1            = 'o',
  S9            = 's',
  DIAMOND       = '`',
  CKBOARD       = 'a',
  DEGREE        = 'f',
  PLMINUS       = 'g',
  BULLET        = '~',
  LARROW        = ',',
  RARROW        = '+',
  DARROW        = '.',
  UARROW        = '-',
  BOARD         = 'h',
  LANTERN       = 'i',
  BLOCK         = '0',
  S3            = 'p',
  S7            = 'r',
  LEQUAL        = 'y',
  GEQUAL        = 'z',
  PI            = '{',
  NEQUAL        = '|',
  STERLING      = '}',
  BSSB          = ACS.ULCORNER,
  SSBB          = ACS.LLCORNER,
  BBSS          = ACS.URCORNER,
  SBBS          = ACS.LRCORNER,
  SBSS          = ACS.RTEE,
  SSSB          = ACS.LTEE,
  SSBS          = ACS.BTEE,
  BSSS          = ACS.TTEE,
  BSBS          = ACS.HLINE,
  SBSB          = ACS.VLINE,
  SSSS          = ACS.PLUS
}

