module warningBar;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;

class WarningBar {
	int _level;

	this() {
		_level = 0;
	}

	void updateWarningBar(int misses, int successes){
		_level += misses - successes;

		if(_level > 32){
			_level = 32;
		}
	}

	void draw() {
		move(0,120);

		for(int i=0; i<_level; i++){
			addstr(toStringz("---"));
			move(i,120);
		}
	}
}
