module dancingMan;

import animatedAsciiSprite;
import types;
import ncurses;
import tango.stdc.stringz;

class DancingMan {
	AnimatedAsciiSprite[6] _animations;
	Animate _curAnimation;


	this() {
		// init animations	
		_animations[Animate.DOWN] = new AnimatedAsciiSprite("graphics/man-down.txt", null, true, false, 26, 22);
		_animations[Animate.LEFT] = new AnimatedAsciiSprite("graphics/man-left.txt", null, true, false, 26, 22);
		_animations[Animate.MOONWALK] = new AnimatedAsciiSprite("graphics/man-moonwalk.txt", null, true, false, 26, 22);
		_animations[Animate.RIGHT] = new AnimatedAsciiSprite("graphics/man-right.txt", null, true, false, 26, 22);
		_animations[Animate.UP] = new AnimatedAsciiSprite("graphics/man-up.txt", null, true, false, 26, 20);
		_animations[Animate.YMCA] = new AnimatedAsciiSprite("graphics/man-ymca.txt", null, true, false, 26, 22);
	}

	void setCurAnimation(Animate animation) {
		_curAnimation = animation;
		_animations[_curAnimation]._animate = true;
	}

	void animate() {
		_animations[_curAnimation].drawSprite();
		_animations[_curAnimation].nextFrame();
	}

	void draw() {
		_animations[_curAnimation].drawSprite();
	}
}		
