all:
	rebuild AAR.d -oqobj -I~/tango/ -Iycurses/modules -L-lncursesw -dc=ldc-posix-tango -version=Tango

james:
	drebuild AAR.d -oqobj -I/usr/include/d/ldc -Iycurses/modules -L-lncursesw -dc=ldc-posix-tango -version=Tango -I~/repos/tango

clean:
	rm AAR obj/*.o
