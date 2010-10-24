module util.soundclip;

import tango.stdc.posix.unistd;
import tango.stdc.posix.signal;
import tango.stdc.stringz;
tango.sys.Process;
//import tango.std.posix.stdlib;

class SoundClip{
private:
	char[] exe;
	char[] filename;
	//pid_t pid;
	bool paused;
	Process p;


public:
	this(char[] fn){
		exe = "cvlc";
		filename = fn;
	}

	bool start(){
		if(p !is null){return false;}

		//if((pid = fork()) == 0){
		char[] temp = exe ~ filename;
	
		try{
			p = new Process (temp, null);
			p.copyEnv(true);

			p.setRedirect(7);

			p.execute;
		}
		catch (ProcessException e)
			Stdout.formatln ("Process execution failed: {}", e);

			//execlp(toStringz(exe), toStringz(exe), toStringz(filename), cast(void*)null);

		//}else{
			// ???
			//if(pid > 0){
			
			//	return true;
			//}else{
			//	return false;
			//}
		//}
	}

	bool stop(){
		if(p is null){return false;}

		//if(kill(pid, SIGKILL) != 0){return false;}

		//XXX: wait for child zombie

		p.kill();

		//auto result = p.wait;
		
    //Stdout.formatln ("Process '{}' ({}) exited with reason {}, status {}",
    //                 p.programName, p.pid, cast(int) result.reason, result.status);


		return true;
	}

	bool pause(){
		if(p !is null || paused){return false;}

		return signal(SIGSTOP);
	}

	bool unpause(){
		if((p !is null) || !paused){return false;}

		return signal(SIGCONT);
	}


	bool signal(int sig){
		return (kill(p.pid, sig) == 0);
	}
}
