module warningBar;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;

class WarningBar {
	int _level;

	this() {
		_level = 0;
	}

	void updateWarningBar(int misses, int succeses){
		_level = _level - misses + successes;
	}

	void draw() {
		move(127, 0);

		for(int i=0; i<_level; i++){
			addstr("---");
			move(127, i);
		}
	}
}
