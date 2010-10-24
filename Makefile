FILES = asciiSprite.d


all:
	ldc $(FILES) -I~/tango/ -Iycurses/modules -d-version=Tango

clean:
	rm *.o
