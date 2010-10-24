module arrowSection;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;
import tango.util.Convert;

import tango.math.random.Random;

import asciiSprite;

class ArrowSection {
	AsciiSprite _frame, hit, l, r, u, d;
	
	double sleep;
	
	ubyte _input;

	this() {
		_frame = new AsciiSprite("graphics/arrow-frame.txt", null, true, 60, 0);
		hit = new AsciiSprite("graphics/hit_it_now_bar.txt", null, true, 62, 5);

		l = new AsciiSprite("graphics/arrow-left.txt", null, true, 63, 0);
		d = new AsciiSprite("graphics/arrow-down.txt", null, true, 71, 0);
		u = new AsciiSprite("graphics/arrow-up.txt", null, true, 79, 0);
		r = new AsciiSprite("graphics/arrow-right.txt", null, true, 87, 0);
	}
	
	void draw() {
		_frame.drawSprite();
		// draw arrows and shit

		hit.drawSprite();

		
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

		offset--;
		if(offset < 0){offset = 3;}


		// Draw
		for(int i = 0; i < beats.length; i++){

			ubyte arrows = beats[i].arrows;

			int row = 1 + offset + 4*i;

			// draw left arrow
			if(arrows & 1){
				l.setY(row);
				l.drawSprite();
			}

			// draw right arrow
			if(arrows & 2){
				r.setY(row);
				r.drawSprite();
			}

			// draw up arrow
			if(arrows & 4){
				u.setY(row);
				u.drawSprite();
			}

			// draw down arrow
			if(arrows & 8){
				d.setY(row);
				d.drawSprite();

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