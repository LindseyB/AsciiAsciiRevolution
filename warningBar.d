module warningBar;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;

class WarningBar {
	int _level;

	this() {
		_level = 0;
	}

	void updateWarningBar(int misses, int great){
		if(great == 0){
			great = 1;
		}

		_level = cast(int)((cast(double)misses/(cast(double)great)) * 32.0);

		if(_level > 32){
			_level = 32;
		}
	}

	void draw() {
		move(0,105);

		for(int i=0; i<_level; i++){
			addstr(toStringz("---"));
			move(i,105);
		}
	}
}
