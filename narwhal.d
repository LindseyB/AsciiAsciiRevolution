module narwhal;

import tango.math.random.Random;

import animatedAsciiSprite;


class Narwhal {
	enum Animate { DANCE, BREAKDANCE, FLYING, SNOOPY }
	AnimatedAsciiSprite[4] _animations;
	Animate _curAnimation;

	this() {
		// init animations
		_animations[Animate.BREAKDANCE] = new AnimatedAsciiSprite("graphics/narwhal-breakdance.txt", null, true, true, 10, 5);
		_animations[Animate.DANCE] = new AnimatedAsciiSprite("graphics/narwhal-dance.txt", null, true, true, 10, 5);
		_animations[Animate.FLYING] = new AnimatedAsciiSprite("graphics/narwhal-flying.txt", null, true, true, 10, 5);
		_animations[Animate.SNOOPY] = new AnimatedAsciiSprite("graphics/narwhal-snoopy.txt", null, true, true, 10, 5);
	}

	void setCurAnimation(Animate animation) {
		_curAnimation = animation;
	}

	void animate() {
		if(_animations[_curAnimation]._frame == _animations[_curAnimation]._animation.length - 1){
			// switch animations?
			if(_curAnimation != Animate.DANCE){
				_curAnimation = Animate.DANCE;
			} else {
				int random = rand.uniformR(20);

				if(random <= 2){
					random = rand.uniformR(3);

					switch(random) {
						case 0: _curAnimation = Animate.BREAKDANCE;
								break;
						case 1: _curAnimation = Animate.FLYING;
								break;
						default: _curAnimation = Animate.SNOOPY;
								 break;
					}
				}
			}

		}

		_animations[_curAnimation].drawSprite();
		_animations[_curAnimation].nextFrame();
	}

	void draw() {
		_animations[_curAnimation].drawSprite();
	}
}
