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
module panel;

public import ncurses;

extern (C):
typedef void PANEL;

/**
Allocates a panel structure, associates it with a window, and places
it at the top of the stack.

Returns: A pointer to a panel when successful and null when not.
See_also: man panel
*/
PANEL* new_panel(WINDOW* win);;
/**
Moves panel to the bottom of the stack.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man panel
*/
int bottom_panel(PANEL* pan);
/**
Moves panel to the top of the stack.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man panel
*/
int top_panel(PANEL* pan);
/**
Makes a panel visible by placeing it on the top of the stack.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man panel
*/
int show_panel(PANEL* pan);
/**
Refreshes the virtual screen, but not the physical screen. Use with
doupdate instead of refresh or wrefresh.

See_also: man panel
*/
void update_panels();
/**
Hides a panel by removing it from the stack.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man panel
*/
int hide_panel(PANEL* pan);
/**
Get the window associated with the panel.

Returns: A pointer to a panel when successful and null when not.
See_also: man panel
*/
WINDOW* panel_window(PANEL* pan);
/**
Replace a panels associated window with another.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man panel
*/
int replace_panel(PANEL* pan, WINDOW* window);
/**
Move a panel along the screens plane, but don't change it's z-order.

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man panel
*/
int move_panel(PANEL* pan, int starty, int startx);
/**
Check and see if the panel is on the stack anywhere.

See_also: man panel
*/
int panel_hidden(PANEL* pan);
/**
Get the panel above the given panel on the stack.

Returns: A pointer to a panel when successful and null when not.
See_also: man panel
*/
PANEL* panel_above(PANEL* pan);
/**
Get the panel below the given panel on the stack.

Returns: A pointer to a panel when successful and null when not.
See_also: man panel
*/
PANEL* panel_below(PANEL* pan);
/**
Retrieve/store the panel user pointer.

See_also: man panel
*/
int set_panel_userptr(PANEL* pan, void* ptr);
///ditto
void* panel_userptr(PANEL* pan);
/**
Remove a panel from the stack and free the memory with it (but not
the associated window).

Returns: $(D_PARAM OK) when successful and $(D_PARAM ERR) when not.
See_also: man panel
*/
int del_panel(PANEL* pan);

