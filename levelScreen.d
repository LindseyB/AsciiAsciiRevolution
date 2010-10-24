module levelScreen;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout; 
import tango.core.Thread;

import level;
import dataScore;
import arrowSection;
import dancingMan;
import asciiSprite;
import animatedAsciiSprite;
import narwhal;
import backupDancer;
import warningBar;
import util.soundclip;

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
		_warningBar.updateWarningBar(_arrowSect.misses, _arrowSect.great);

		if(_warningBar._level >= 32 && _arrowSect.misses > 10){
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
		SoundClip sc;
		_playing = false;
		AsciiSprite winText = new AsciiSprite("graphics/victory.txt", null, false, 62, 15); 		
		AsciiSprite loseText = new AsciiSprite("graphics/failure.txt", null, false, 62, 15); 		
		double grade;

	   	if (_arrowSect.great + _arrowSect.good + _arrowSect.actualMisses != 0){
			grade = 50 * ((_arrowSect.great*2 + _arrowSect.good)/(_arrowSect.great + _arrowSect.good + _arrowSect.actualMisses));  
		} else {
			grade = 0;
		}

		AsciiSprite gradeSprite = new AsciiSprite("graphics/" ~ getLetterGrade(grade) ~ ".txt", null, false, 73, 20); 

		if(win){
			sc = new SoundClip("sounds/win.mp3");
			sc.start();
			winText.drawSprite();
			gradeSprite.drawSprite();
			AnimatedAsciiSprite popcorn = new AnimatedAsciiSprite("graphics/cron-popcron.txt", null, false, false, 20, 20);

			for(int i=0; i<popcorn._animation.length; i++){
				popcorn.drawSprite();
				popcorn.nextFrame();
				refresh();
				Thread.sleep(0.3);
			}

		} else {
			sc = new SoundClip("sounds/fail.mp3");
			sc.start();
			loseText.drawSprite();
		}

	}

	char getLetterGrade(double percent){
		if(percent > 90.0) {
			return 'A';
		} else if(percent > 80.0) {
			return 'B';
		} else if(percent > 70.0) {
			return 'C';
		} else if(percent > 60.0) {
			return 'D';
		} else {
			return 'F';
		}
	}

}
