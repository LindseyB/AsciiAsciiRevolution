module dataScore;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;
import tango.util.Convert;

class DataScore {
	int _score;
	char[] _title;

	this(char[] title) {
		_score = 0;
		_title = title;
	}

	void increaseScore(int value) {
		_score += value;
	}

	void setScore(int value) {
		_score = value;
	}

	void draw() {
		int x = 0;
		int y = 0;

		for(int i=0; i<60; i++){
			move(y,i);
			addch('#');
		}

		y++;
		
		move(y,x);
		
		addstr(toStringz("#  Song: " ~ _title));

		move(y,59);
		addch('#');

		y++;

		move(y,x);

		addstr(toStringz(("#  Score: " ~ to!(char[])(_score))));

		move(y,59);
		addch('#');

		for(int i=0; i<3; i++){
			y++;
			move(y,0);
			addch('#');
			move(y,59);
			addch('#');
		}
	
		for(int i=0; i<60; i++){
			move(5,i);
			addch('#');
		}
	}
}
