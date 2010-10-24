module levelScreen;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout; 

import level;
import dataScore;
import arrowSection;
import dancingMan;
import asciiSprite;
import narwhal;

class LevelScreen {
	DataScore _score;
	ArrowSection _arrowSect;
	DancingMan _dancingMan;
	AsciiSprite _spotlight;
	Narwhal _narwhal;

	bool _playing;

	this(Level currentLevel) {
		_score = new DataScore(currentLevel._name);
		_arrowSect = new ArrowSection(currentLevel._arrowChart);
		_dancingMan = new DancingMan();
		_playing = true;
		_spotlight = new AsciiSprite("graphics/spotlight.txt", null, false, 10, 18);
		_narwhal = new Narwhal();
	}

	void draw(bool fast) {
		move(0,0);
		_score.draw();
		_spotlight.drawSprite();
		_arrowSect.draw(fast);
		_dancingMan.draw();
		_narwhal.animate();
		_dancingMan.animate();
	}

}
