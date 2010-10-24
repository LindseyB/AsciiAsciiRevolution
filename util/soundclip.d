module util.soundclip;

import tango.stdc.posix.unistd;
import tango.stdc.posix.signal;
import tango.stdc.stringz;
//import tango.std.posix.stdlib;

class SoundClip{
private:
	char[] exe;
	char[] filename;
	pid_t pid;
	bool paused;

public:
	this(char[] fn){
		exe = "cvlc";
		filename = fn;
		pid = 0;
	}

	bool start(){
		if(pid != 0){return false;}

		if((pid = fork()) == 0){
			char[] temp = exe ~ filename;
			
			execlp(toStringz(exe), toStringz(exe), toStringz(filename), cast(void*)null);

		}else{
			// ???
			if(pid > 0){
			
				return true;
			}else{
				return false;
			}
		}
	}

	bool stop(){
		if(pid == 0){return false;}

		if(kill(pid, SIGKILL) != 0){return false;}

		//XXX: wait for child zombie

		return true;
	}

	bool pause(){
		if(pid == 0 || paused){return false;}
		return signal(SIGSTOP);
	}

	bool unpause(){
		if((pid == 0) || !paused){return false;}
		return signal(SIGCONT);
	}


	bool signal(int sig){
		return (kill(pid, sig) == 0);
	}
}
