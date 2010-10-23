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
module form;

version(Tango)
{
  import tango.stdc.stdarg;
}
else
{
  import std.c.stdarg;
}

public import ncurses, eti;

extern(C):

typedef void FIELD;
typedef void FORM;
typedef void FIELDTYPE;

/**
Restores the cursor to the position required by the forms driver.

See_also: man form_cursor
*/
int pos_form_cursor(FORM* form);

/**
Check and see if there is offscreen data ahead/behind in the form.

See_also: man form_data
*/
bool data_ahead(FORM* form);
///ditto
bool data_behind(FORM* form);

/**
Routine to funnel input events for the form though.

See_also: man form_driver
*/
int form_driver(FORM* form, int c);
//driver requests
enum :int
{
  ///move to the given page
  REQ_NEXT_PAGE         = 0x200,
  ///ditto
  REQ_PREV_PAGE         = 0x201,
  ///ditto
  REQ_FIRST_PAGE        = 0x202,
  ///ditto
  REQ_LAST_PAGE         = 0x203,

  ///move to the specified field
  REQ_NEXT_FIELD        = 0x204,
  ///ditto
  REQ_PREV_FIELD        = 0x205,
  ///ditto
  REQ_FIRST_FIELD       = 0x206,
  ///ditto
  REQ_LAST_FIELD        = 0x207,
  ///ditto
  REQ_SNEXT_FIELD       = 0x208,
  ///ditto
  REQ_SPREV_FIELD       = 0x209,
  ///ditto
  REQ_SFIRST_FIELD      = 0x20A,
  ///ditto
  REQ_SLAST_FIELD       = 0x20B,
  ///ditto
  REQ_LEFT_FIELD        = 0x20C,
  ///ditto
  REQ_RIGHT_FIELD       = 0x20D,
  ///ditto
  REQ_UP_FIELD          = 0x20E,
  ///ditto
  REQ_DOWN_FIELD        = 0x20F,

  ///move to the specified place
  REQ_NEXT_CHAR         = 0x210,
  ///ditto
  REQ_PREV_CHAR         = 0x211,
  ///ditto
  REQ_NEXT_LINE         = 0x212,
  ///ditto
  REQ_PREV_LINE         = 0x213,
  ///ditto
  REQ_NEXT_WORD         = 0x214,
  ///ditto
  REQ_PREV_WORD         = 0x215,
  ///ditto
  REQ_BEG_FIELD         = 0x216,
  ///ditto
  REQ_END_FIELD         = 0x217,
  ///ditto
  REQ_BEG_LINE          = 0x218,
  ///ditto
  REQ_END_LINE          = 0x219,
  ///ditto
  REQ_LEFT_CHAR         = 0x21A,
  ///ditto
  REQ_RIGHT_CHAR        = 0x21B,
  ///ditto
  REQ_UP_CHAR           = 0x21C,
  ///ditto
  REQ_DOWN_CHAR         = 0x21D,

  ///insert/overlay a new line
  REQ_NEW_LINE          = 0x21E,
  ///insert a blank char/line at the cursor
  REQ_INS_CHAR          = 0x21F,
  ///ditto
  REQ_INS_LINE          = 0x220,
  ///delete the specified item
  REQ_DEL_CHAR          = 0x221,
  ///ditto
  REQ_DEL_PREV          = 0x222,
  ///ditto
  REQ_DEL_LINE          = 0x223,
  ///ditto
  REQ_DEL_WORD          = 0x224,
  ///clear as specified
  REQ_CLR_EOL           = 0x225,
  ///ditto
  REQ_CLR_EOF           = 0x226,
  ///ditto
  REQ_CLR_FIELD         = 0x227,
  ///enter the specified mode
  REQ_OVL_MODE          = 0x228,
  ///ditto
  REQ_INS_MODE          = 0x229,
  ///scroll the given amount
  REQ_SCR_FLINE         = 0x22A,
  ///ditto
  REQ_SCR_BLINE         = 0x22B,
  ///ditto
  REQ_SCR_FPAGE         = 0x22C,
  ///ditto
  REQ_SCR_BPAGE         = 0x22D,
  ///ditto
  REQ_SCR_FHPAGE        = 0x22E,
  ///ditto
  REQ_SCR_BHPAGE        = 0x22F,
  ///ditto
  REQ_SCR_FCHAR         = 0x230,
  ///ditto
  REQ_SCR_BCHAR         = 0x231,
  ///ditto
  REQ_SCR_HFLINE        = 0x232,
  ///ditto
  REQ_SCR_HBLINE        = 0x233,
  ///ditto
  REQ_SCR_HFHALF        = 0x234,
  ///ditto
  REQ_SCR_HBHALF        = 0x235,

  ///validate a field
  REQ_VALIDATION        = 0x236,
  ///display next/previous choice
  REQ_NEXT_CHOICE       = 0x237,
  ///ditto
  REQ_PREV_CHOICE       = 0x238,

  MIN_FORM_COMMAND      = 0x200,
  MAX_FORM_COMMAND      = 0x238
}

/**
Set the fields in the form to the given null terminated array

See_also: man form_field
*/
int set_form_fields(FORM* form, FIELD** fields);
/**
Get the array of fields in the form.

See_also: man form_field
*/
FIELD** form_fields(FORM* form);
/**
Find out how many fields are in the form.

See_also: man form_field
*/
int field_count(FORM* form);
/**
Move the field to the specified place on the screen.

See_also: man form_field
*/
int move_field(FIELD* field, int frow, int fcol);

/**
Get the attributes passed to a field when it was created.

See_also: man form_field_info
*/
int field_info(FIELD* field, int* rows, int* cols,
   int* frow, int* fcol, int* nrow, int* nbuf);
/**
Get the actual attributes of a field.

See_also: man form_field_info
*/
int  dynamic_field_info(FIELD* field, int* rows, int* cols,
   int* max);

/**
Allocate and initialize a new field.

See_also: man form_field_new
*/
FIELD* new_field(int height, int width,
                int toprow, int leftcol,
                int offscreen, int nbuffers);
/**
Duplicate an existing field

See_also: man form_field_new
*/
FIELD* dup_field(FIELD* field, int toprow, int leftcol);
/**
Duplicate a field, but share buffers with the original field.

See_also: man form_field_new
*/
FIELD* link_field(FIELD* field, int toprow, int leftcol);
/**
Deallocate a field.

See_also: man form_field_new
*/
int free_field(FIELD* field);

/**
Sets/gets a fields foreground attributes.

See_also: man form_field_attributes
*/
int set_field_fore(FIELD* field, chtype attr);
///ditto
chtype field_fore(FIELD* field);
/**
Sets/gets a fields background attributes.

See_also: man form_field_attributes
*/
int set_field_back(FIELD* field, chtype attr);
///ditto
chtype field_back(FIELD* field);
/**
Sets/gets a fields padding character attributes.

See_also: man form_field_attributes
*/
int set_field_pad(FIELD* field, int pad);
///ditto
int field_pad(FIELD* field);

/**
Set the buffer of a field to contain a given string

See_also: man form_field_buffer
*/
int set_field_buffer(FIELD* field, int buf, char* value);
/**
Get a pointer to a fields buffer

See_also: man form_field_buffer
*/
char *field_buffer(FIELD* field, int buffer);
/**
Get/set a fields status.  True if changed.

See_also: man form_field_buffer
*/
int set_field_status(FIELD* field, bool status);
///ditto
bool field_status(FIELD* field);
/**
Set the max size of a dynamic field.

See_also: man form_field_buffer
*/
int set_max_field(FIELD* field, int max);

/**
Get/set a fields justification.

See_also: man form_field_just
*/
int set_field_just(FIELD* field, int justification);
///ditto
int field_just(FIELD* field);
enum :int
{
  ///Justification constants
  NO_JUSTIFICATION = 0,
  ///ditto
  JUSTIFY_LEFT     = 1,
  ///ditto
  JUSTIFY_CENTER   = 2,
  ///ditto
  JUSTIFY_RIGHT    = 3
}

/**
Set all of a fields option bits.

See_also: man form_field_opts
*/
int set_field_opts(FIELD* field, OPTIONS opts);
/**
Turn on a fields given option bits.

See_also: man form_field_opts
*/
int field_opts_on(FIELD* field, OPTIONS opts);
/**
Turn off a fields given option bits.

See_also: man form_field_opts
*/
int field_opts_off(FIELD* field, OPTIONS opts);
/**
Get a fields option bits.

See_also: man form_field_opts
*/
OPTIONS field_opts(FIELD* field);

/**
Get/set a fields application specific data.

See_also: man form_field_userptr
*/
int set_field_userptr(FIELD* field, void* userptr);
///ditto
void* field_userptr(FIELD* field);

/**
Set/get a field type.

See_also: man form_field_validation
*/
int set_field_type(FIELD* field, FIELDTYPE* type, ...);
///ditto
FIELDTYPE* field_type(FIELD* field);
///ditto
void* field_arg(FIELD* field);

/**
Valid field types.

See_also: man form_field_validation
*/
extern FIELDTYPE* TYPE_ALNUM;
///ditto
extern FIELDTYPE* TYPE_ALPHA;
///ditto
extern FIELDTYPE* TYPE_ENUM;
///ditto
extern FIELDTYPE* TYPE_INTEGER;
///ditto
extern FIELDTYPE* TYPE_NUMERIC;
///ditto
extern FIELDTYPE* TYPE_REGEXP;
///ditto
extern FIELDTYPE* TYPE_IPV4;


/**
Create a new field type.

See_also: man form_fieldtype
*/
FIELDTYPE* new_fieldtype(
   bool function(FIELD*, void*) field_check,
   bool function(int, void*) char_check);
/**
Free space allocated for a field type.

See_also: man form_fieldtype
*/
int free_fieldtype(FIELDTYPE* fieldtype);
/**
Associate storage management functions with a field type.

See_also: man form_fieldtype
*/
int set_fieldtype_arg(
   FIELDTYPE* fieldtype,
   void* function(va_list*) make_arg,
   void* function(void*) copy_arg,
   void  function(void*) free_arg);
/**
Define successor and predecessor functions for the field type.

See_also: man form_fieldtype
*/
int set_fieldtype_choice(
   FIELDTYPE *fieldtype,
   bool function(FIELD*, void*) next_choice,
   bool function(FIELD*, void*) prev_choice);
/**
Create a new field type from two other types.

See_also: man form_fieldtype
*/
FIELDTYPE* link_fieldtype(FIELDTYPE* type1,
                         FIELDTYPE* type2);

/**
Sets/gets a hook to be called at form post time and after a field changes.

See_also: man form_hook
*/
int set_field_init(FORM* form, void function(FORM*) func);
///ditto
void function(FORM*) field_init(FORM* form);
/**
Sets/gets a hook to be called at form unpost time and before a field change.

See_also: man form_hook
*/
int set_field_term(FORM* form, void function(FORM*) func);
///ditto
void function(FORM*) field_term(FORM* form);
/**
Sets/gets a hook to be called at form post time and after a page change.

See_also: man form_hook
*/
int set_form_init(FORM *form, void function(FORM*) func);
///ditto
void function(FORM*) form_init(FORM* form);
/**
Sets/gets a hook to be called at form unpost time and before a page change.

See_also: man form_hook
*/
int set_form_term(FORM *form, void function(FORM*) func);
///ditto
void function(FORM*) form_term(FORM* form);

/**
Create/destroy a new form.

See_also: man form_new
*/
FORM* new_form(FIELD** fields);
///ditto
int free_form(FORM* form);

/**
Set a field to be the beginning of a new page.

See_also: man form_new_page
*/
int set_new_page(FIELD* field, bool new_page_flag);
/**
Check if a field is the beginning of a new page.

See_also: man form_new_page
*/
bool new_page(FIELD* field);


/**
Set all of a forms option bits.

See_also: man form_form_opts
*/
int set_form_opts(FORM* form, OPTIONS opts);
/**
Turn on a forms given option bits.

See_also: man form_form_opts
*/
int form_opts_on(FORM* form, OPTIONS opts);
/**
Turn off a forms given option bits.

See_also: man form_form_opts
*/
int form_opts_off(FORM* form, OPTIONS opts);
/**
Get a forms option bits.

See_also: man form_form_opts
*/
OPTIONS form_opts(FORM* form);

/**
Set/get the forms current field.

See_also: man form_page
*/
int set_current_field(FORM* form, FIELD* field);
///ditto
FIELD* current_field(FORM* form);
/**
Set/get the forms current page.

See_also: man form_page
*/
int set_form_page(FORM* form, int n);
///ditto
int form_page(FORM* form);
/**
Get a fields index in its form.

See_also: man form_page
*/
int field_index(FIELD* field);

/**
Display/erase a form

See_also: man form_post
*/
int post_form(FORM* form);
///ditto
int unpost_form(FORM* form);

/**
Get the printable name of a form request code

See_also: man form_requestname
*/
char* form_request_name(int request);
/**
Search for a request code by it's printable name

See_also: man form_requestname
*/
int form_request_by_name(char* name);

/**
Set/remove form window associations.

See_also: man form_win
*/
int set_form_win(FORM* form, WINDOW* win);
///ditto
WINDOW* form_win(FORM* form);
///ditto
int set_form_sub(FORM* form, WINDOW* sub);
///ditto
WINDOW* form_sub(FORM* form);
/**
Get the minimum size required for a forms subwindow

See_also: man form_win
*/
int scale_form(FORM* form, int* rows, int* columns);

/**
Get/set a forms application specific data.

See_also: man form_field_userptr
*/
int set_form_userptr(FORM* form, void* userptr);
///ditto
void* form_userptr(FORM* form);

enum :OPTIONS
{
  /* form vals */
  O_VISIBLE  = 0x0001,
  O_ACTIVE   = 0x0002,
  O_PUBLIC   = 0x0004,
  O_EDIT     = 0x0008,
  O_WRAP     = 0x0010,
  O_BLANK    = 0x0020,
  O_AUTOSKIP = 0x0040,
  O_NULLOK   = 0x0080,
  O_PASSOK   = 0x0100,
  O_STATIC   = 0x0200,

  O_NL_OVERLOAD = 0x0001,
  O_BS_OVERLOAD = 0x0002
}


