all:
	rebuild AAR.d -oqobj -I~/tango/ -Iycurses/modules -L -lncurses -L -lncursesw -dc=ldc-posix-tango -version=Tango

clean:
	rm *.o
