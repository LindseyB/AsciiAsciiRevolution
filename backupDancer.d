module backupDancer;

import tango.math.random.Random;

import animatedAsciiSprite;

class BackupDancer {
	enum Animate { DOWN, JUMP, LEFT, MOONWALK, RIGHT, UP, YMCA, THRUSTLEFT, THRUSTRIGHT, DISCO }
	AnimatedAsciiSprite[10] _animations;
	Animate _curAnimation;

	this(int x, int y) {
		_animations[Animate.DOWN] = new AnimatedAsciiSprite("graphics/man-down.txt", null, true, true, x, y);
		_animations[Animate.JUMP] = new AnimatedAsciiSprite("graphics/man-jump.txt", null, true, true, x, y);
		_animations[Animate.LEFT] = new AnimatedAsciiSprite("graphics/man-left.txt", null, true, true, x, y);
		_animations[Animate.MOONWALK] = new AnimatedAsciiSprite("graphics/man-moonwalk.txt", null, true, true, x, y);
		_animations[Animate.RIGHT] = new AnimatedAsciiSprite("graphics/man-right.txt", null, true, true, x, y);
		_animations[Animate.UP] = new AnimatedAsciiSprite("graphics/man-up.txt", null, true, true, x, y);
		_animations[Animate.YMCA] = new AnimatedAsciiSprite("graphics/man-ymca.txt", null, true, true, x, y);
		_animations[Animate.THRUSTLEFT] = new AnimatedAsciiSprite("graphics/man-thrust-left.txt", null, true, true, x, y);
		_animations[Animate.THRUSTRIGHT] = new AnimatedAsciiSprite("graphics/man-thrust-right.txt", null, true, true, x, y);
		_animations[Animate.DISCO] = new AnimatedAsciiSprite("graphics/man-disco.txt", null, true, true, x, y);
	}

	void setCurAnimation(Animate animation) {
		_curAnimation = animation;
	}

	void animate() {
		if(_animations[_curAnimation]._frame == _animations[_curAnimation]._animation.length - 1){
			int random = rand.uniformR(10);
			
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
				case 5: _curAnimation = Animate.THRUSTLEFT;
						break;
				case 6: _curAnimation = Animate.THRUSTRIGHT;
						break;
				case 7: _curAnimation = Animate.DISCO;
						break;
				case 8: _curAnimation = Animate.LEFT;
						break;
				default: _curAnimation = Animate.YMCA;
			}	
		}

		_animations[_curAnimation].drawSprite();
		_animations[_curAnimation].nextFrame();
	}
}
