all:
	rebuild AAR.d -oqobj -I~/tango/ -Iycurses/modules -L-lncursesw -dc=ldc-posix-tango -version=Tango

clean:
	rm *.o
