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
import backupDancer;
import warningBar;

class LevelScreen {
	DataScore _score;
	ArrowSection _arrowSect;
	DancingMan _dancingMan;
	AsciiSprite _spotlight;
	Narwhal _narwhal;
	BackupDancer _backup1;
	BackupDancer _backup2;
	WarningBar _warningBar;

	bool _playing;

	this(Level currentLevel) {
		_score = new DataScore(currentLevel._name);
		_arrowSect = new ArrowSection(currentLevel._arrowChart);
		_dancingMan = new DancingMan();
		_backup1 = new BackupDancer(20, 20);
		_backup2 = new BackupDancer(32, 20);
		_playing = true;
		_spotlight = new AsciiSprite("graphics/spotlight.txt", null, false, 10, 18);
		_narwhal = new Narwhal();
		_warningBar = new WarningBar();
	}

	void draw(bool fast) {
		_score.setScore((-50*_arrowSect.misses) + (100*_arrowSect.good) + (200*_arrowSect.great)); 
		_warningBar.updateWarningBar(_arrowSect.misses, (_arrowSect.good + _arrowSect.great));

		if(_warningBar._level >= 32){
			endGame(false);
		}

		if(_arrowSect.noMoreBeats){
			endGame(true);
		}

		move(0,0);
		_score.draw();
		_warningBar.draw();
		_spotlight.drawSprite();
		_arrowSect.draw(fast);
		_dancingMan.draw();
		_narwhal.animate();
		_dancingMan.animate();
		_backup1.animate();
		_backup2.animate();
	}

	void endGame(bool win) {
		_playing = false;
		AsciiSprite winText = new AsciiSprite("graphics/victory.txt", null, false, 62, 15); 		
		AsciiSprite loseText = new AsciiSprite("graphics/failure.txt", null, false, 62, 15); 		
		
		if(win){
			winText.drawSprite();
		} else {
			loseText.drawSprite();
		}

	}

}
