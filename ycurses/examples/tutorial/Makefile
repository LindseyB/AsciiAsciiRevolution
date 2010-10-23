# The top level Makefile

DC=gdmd
IMPORTS=-I~/code/ycurses/modules/

all:	
#	cd JustForFun 	&& $(MAKE) DC=${DC} IMPORTS="${IMPORTS}"
	cd basics	&& $(MAKE) DC=${DC} IMPORTS="${IMPORTS}"
	cd forms	&& $(MAKE) DC=${DC} IMPORTS="${IMPORTS}"
	cd menus	&& $(MAKE) DC=${DC} IMPORTS="${IMPORTS}"
	cd panels	&& $(MAKE) DC=${DC} IMPORTS="${IMPORTS}"
	@echo 
	@echo "*********************************************"
	@echo "All files Built"
	@echo "Please move to demo/exe directory"
	@echo "Execute each file to see examples in action"
	@echo "*********************************************"
	@echo
clean:
#	cd JustForFun 	&& $(MAKE) clean
	cd basics	&& $(MAKE) clean
	cd forms	&& $(MAKE) clean
	cd menus	&& $(MAKE) clean
	cd panels	&& $(MAKE) clean
