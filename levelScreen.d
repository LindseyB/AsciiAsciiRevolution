module levelScreen;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout; 

import dataScore;

class LevelScreen {
	DataScore _score;
	bool _playing;

	this(char[] title) {
		_score = new DataScore(title);
		_playing = true;
	}

	void draw() {
		move(0,0);
		_score.draw();
	}	
}
