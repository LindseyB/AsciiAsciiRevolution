module arrowSection;

import ldc.intrinsics;

import tango.stdc.stringz;
import ncurses;
import tango.io.Stdout;
import tango.util.Convert;

import tango.math.random.Random;

import tango.io.stream.TextFile;

import tango.stdc.posix.unistd;



import asciiSprite;

class ArrowSection {
	AsciiSprite _frame, hit, l, r, u, d;
	
	double sleep;
	
	ubyte _input;

	TextFileInput chartFile;

	long misses, good, great;
	
	bool noMoreBeats;

	this(char[] arrowFile) {
		chartFile = new TextFileInput("arrow_charts/" ~ arrowFile);

		if(chartFile is null){ assert(false);_exit(1);}

		auto bpm = chartFile.next;
	
		//if(bpm[0..4] == "BPM:"){
		sleep = 60.0 / to!(double)(bpm);
			/*}else{
			assert(false, "BAD arrowchart!");
			_exit(1);
			}*/

		// burn the second line -- how long the song is
		bpm = chartFile.next;
		
		_frame = new AsciiSprite("graphics/arrow-frame.txt", null, true, 60, 0);
		hit = new AsciiSprite("graphics/hit_it_now_bar.txt", null, true, 62, 5);

		l = new AsciiSprite("graphics/arrow-left.txt", null, true, 63, 0);
		d = new AsciiSprite("graphics/arrow-down.txt", null, true, 71, 0);
		u = new AsciiSprite("graphics/arrow-up.txt", null, true, 79, 0);
		r = new AsciiSprite("graphics/arrow-right.txt", null, true, 87, 0);

		for(int i = 0; i < beatsOnScreen; i++){
			beats ~= new Beat;
		}
	}
	
	void draw(bool fast) {
		_frame.drawSprite();
		// draw arrows and shit

		hit.drawSprite();

		if(!fast){	
			// XXX: atomic swap on _input
			ubyte diff, cacheInput;// = _input; 
			//_input = 0;

			cacheInput = llvm_atomic_swap!(ubyte)(&_input, 0);

			//cacheInput = _input;
			//_input = 0;
			/*
			asm{
				push EDX;
				push ECX;

				mov EDX, 0;
				mov ECX, input;
				lock;
				xchg [ECX], EDX;
				mov ECX, cacheInput;
				mov [ECX], EDX;

				pop ECX;
				pop EDX;
				}*/

			if(offset > 1){
				//beats[0] arrows - inputs
				diff = beats[0].arrows & (~beats[0].inputs);
				
				// diff & _input
				diff &= cacheInput;
				good += lut[diff];


				// mark as not missed
				beats[0].inputs |= diff;
			}

			if(offset < 3){
				// _input - diff ==> inputs that counted above don't count twice
				ubyte diff2 = cacheInput & (~diff);
				
				// diff2 & beats[1].arrows
				diff2 &= beats[1].arrows;
				
				if(offset == 0){
					// beat[1] is on target at offset 0
					great += lut[diff2];
				}else{
					good += lut[diff2];
				}

				beats[1].inputs |= diff2;
			}

			if(offset == 0){
				// parse shite frum file, appendto arrows and drop top if required
				Beat* beat = new Beat;

				char[] line = chartFile.next;

				if(line is null){beat.end = true;}

				foreach(ch; line){
					switch(ch){
					case 'l': beat.arrows |= 1; break;
					case 'r': beat.arrows |= 2; break;
					case 'u': beat.arrows |= 4; break;
					case 'd': beat.arrows |= 8; break;
					case 'x': beat.arrows |= randomArrow(); break;
					}
				}
					
				beats ~= beat;
					
				if(beats.length > beatsOnScreen){
					// score Misses on dis
					ubyte temp = beats[0].arrows & (~beats[0].inputs);
					
					misses += lut[temp];
					
					if(beat[0].end){noMoreBeats = true;}

					beats = beats[1..$];
				}
			}

			offset--;
			if(offset < 0){offset = 4;}
		}

		// Draw
		for(int i = 0; i < beats.length; i++){
			ubyte arrows = beats[i].arrows;

			int row = 1 + offset + 5*i;

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
	int beatsOnScreen = 6, offset;

	ubyte randomArrows(){
		return rand.uniformR(16);
	}

	ubyte randomArrow(){
		return (1 << rand.uniformR(4));
	}

	int[] lut = [0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4]; 
}

struct Beat{
	bool end;
	ubyte arrows;	//lrud
	ubyte inputs;
	double period;
}
