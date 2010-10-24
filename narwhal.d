module narwhal;

import tango.math.random.Random;

import animatedAsciiSprite;


class Narwhal {
	enum Animate { DANCE, BREAKDANCE }
	AnimatedAsciiSprite[2] _animations;
	Animate _curAnimation;

	this() {
		// init animations
		_animations[Animate.BREAKDANCE] = new AnimatedAsciiSprite("graphics/narwhal-breakdance.txt", null, true, 10, 5);
		_animations[Animate.DANCE] = new AnimatedAsciiSprite("graphics/narwhal-dance.txt", null, true, 10, 5);
	}

	void setCurAnimation(Animate animation) {
		_curAnimation = animation;
	}

	void animate() {
		if(_animations[_curAnimation]._frame == _animations[_curAnimation]._animation.length - 1){
			// switch animations?
			if(_curAnimation == Animate.BREAKDANCE){
				_curAnimation = Animate.DANCE;
			} else {
				int random = rand.uniformR(10);

				if(random == 5){
					_curAnimation = Animate.BREAKDANCE;
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
