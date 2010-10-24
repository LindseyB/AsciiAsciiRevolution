module level; 

class Level {
	char[] _audio;
	char[] _name;
	int _difficulty;

	this(char[] audio, char[] name, int difficulty) {
		_audio = audio;
		_name = name;
		_difficulty = difficulty; 
	}
	
	char[] getAudio() {
		return _audio;
	}

	char[] getName() {
		return _name;
	}	

	int getDifficulty() {
		return _difficulty;
	}
}	
