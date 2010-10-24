module level; 

class Level {
	char[] _audio;
	char[] _name;
	char[] _arrowChart;
	int _difficulty;

	this(char[] audio, char[] name, int difficulty, char[] arrowChart) {
		_audio = audio;
		_name = name;
		_difficulty = difficulty;
		_arrowChart = arrowChart;
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
