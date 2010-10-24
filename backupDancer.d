module backupDancer;

import tango.math.random.Random;

import animatedAsciiSprite;

class BackupDancer {
	enum Animate { DOWN, JUMP, LEFT, MOONWALK, RIGHT, UP, YMCA }
	AnimatedAsciiSprite[7] _animations;
	Animate _curAnimation;

	this(int x, int y) {
		_animations[Animate.DOWN] = new AnimatedAsciiSprite("graphics/man-down.txt", null, true, true, x, y);
		_animations[Animate.JUMP] = new AnimatedAsciiSprite("graphics/man-jump.txt", null, true, true, x, y);
		_animations[Animate.LEFT] = new AnimatedAsciiSprite("graphics/man-left.txt", null, true, true, x, y);
		_animations[Animate.MOONWALK] = new AnimatedAsciiSprite("graphics/man-moonwalk.txt", null, true, true, x, y);
		_animations[Animate.RIGHT] = new AnimatedAsciiSprite("graphics/man-right.txt", null, true, true, x, y);
		_animations[Animate.UP] = new AnimatedAsciiSprite("graphics/man-up.txt", null, true, true, x, y);
		_animations[Animate.YMCA] = new AnimatedAsciiSprite("graphics/man-ymca.txt", null, true, true, x, y);
	}

	void setCurAnimation(Animate animation) {
		_curAnimation = animation;
	}

	void animate() {
		if(_animations[_curAnimation]._frame == _animations[_curAnimation]._animation.length - 1){
			int random = rand.uniformR(7);
			
			switch(random) {
				case 0: _curAnimation = Animate.DOWN;
						break;
				case 1: _curAnimation = Animate.JUMP;
						break;
				case 2: _curAnimation = Animate.MOONWALK;
						break;
				case 3: _curAnimation = Animate.RIGHT;
						break;
				case 4: _curAnimation = Animate.UP;
						break;
				default: _curAnimation = Animate.YMCA;
			}	
		}

		_animations[_curAnimation].drawSprite();
		_animations[_curAnimation].nextFrame();
	}
}
