module arrowSection;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;
import tango.util.Convert;

import asciiSprite;

class ArrowSection {
	AsciiSprite _frame;

	this() {
		_frame = new AsciiSprite("graphics/arrow-frame.txt", null, true, 60, 0);
	}
	
	void draw() {
		_frame.drawSprite();
		// draw arrows and shit
	}
}
