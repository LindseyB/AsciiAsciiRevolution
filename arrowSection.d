module arrowSection;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;
import tango.util.Convert;

import tango.math.random.Random;

import asciiSprite;

class ArrowSection {
	AsciiSprite _frame, l, r, u, d;
	
	double sleep;
	
	this() {
		_frame = new AsciiSprite("graphics/arrow-frame.txt", null, true, 60, 0);
		//l = new AsciiSprite("graphics/arrow-frame.txt", null, true, 60, 0);
	}
	
	void draw() {
		_frame.drawSprite();
		// draw arrows and shit
		
		if(offset == 0){
			// parse shite frum file, appendto arrows and drop top if required
			Beat* beat = new Beat;

			beat.arrows = randomArrows();
			beat.period = 1.0;

			beats ~= beat;

			if(beats.length > beatsOnScreen){
				beats = beats[1..$];
			}

			sleep = beats[0].period;
		}

		offset++;
		offset %= 4;


		// Draw
		for(int i = 0; i < beats.length; i++){

			ubyte arrows = beats[i].arrows;
		
			// draw left arrow
			if(arrows & 1){
				
			}

			// draw right arrow
			if(arrows & 2){

			}

			// draw up arrow
			if(arrows & 4){

			}

			// draw down arrow
			if(arrows & 8){

			}
		}
	}

private:
	Beat*[] beats;
	int beatsOnScreen = 5, offset;

	ubyte randomArrows(){
		return rand.uniformR(16);
	}
}

struct Beat{
	ubyte arrows;	//lrud
	double period;
}