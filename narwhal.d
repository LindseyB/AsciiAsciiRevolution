module narwhal;

import animatedAsciiSprite;

class Narwhal {
	enum Animate { BREAKDANCE, DANCE }
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
		_animations[_curAnimation].drawSprite();
		_animations[_curAnimation].nextFrame();
	}

	void draw() {
		_animations[_curAnimation].drawSprite();
	}
}
