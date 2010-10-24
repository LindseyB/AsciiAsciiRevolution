module levelScreen;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout; 

import dataScore;
import arrowSection;

class LevelScreen {
	DataScore _score;
	ArrowSection _arrowSect;
	bool _playing;

	this(char[] title) {
		_score = new DataScore(title);
		_arrowSect = new ArrowSection();
		_playing = true;
	}

	void draw() {
		move(0,0);
		_score.draw();
		_arrowSect.draw();
	}	
}
