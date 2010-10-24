module AAR;

import tango.io.Stdout;
import tango.core.Thread;

import asciiSprite;
import animatedAsciiSprite;
import util.soundclip;

void main(){
	SoundClip sc = new SoundClip("music/ID__Baobinga_-_10_-_Raise_Riddim.mp3");
	sc.start();
	Stdout("started playing\n");
	Thread.sleep(1000);
	Stdout("done with sleep\n");
	Stdout.format("{}\n", sc.pause());
	Thread.sleep(1000);
	Stdout.format("{}\n", sc.unpause());
	Thread.sleep(1000);
	Stdout.format("{}\n", sc.stop());

}
