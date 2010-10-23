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


Description: This module contains a set of constant error codes used by
parts of the ncurses package.
*/
module eti;

enum :int
{
  ///Success
  E_OK                  = 0,
  ///Incorrect/out of range argument
  E_BAD_ARGUMENT        = -2,
  ///Routine called from initialization or termination function
  E_BAD_STATE           = -5,
  ///Character match fail
  E_NO_MATCH            = -9,
  ///Menu too large for window
  E_NO_ROOM             = -6,
  ///No items in menu
  E_NOT_CONNECTED       = -11,
  ///Menu hasn't been posted
  E_NOT_POSTED          = -7,
  ///Item can't be selected
  E_NOT_SELECTABLE      = -10,
  ///Menu already posted
  E_POSTED              = -3,
  ///Menu driver couldn't process request
  E_REQUEST_DENIED      = -12,
  ///System error
  E_SYSTEM_ERROR        = -1,
  ///Menu driver saw an unknown request code
  E_UNKNOWN_COMMAND     = -8,
  ///undocumented
  E_CONNECTED           = -4,
  ///ditto
  E_INVALID_FIELD       = -13,
  ///ditto
  E_CURRENT             = -14
}
