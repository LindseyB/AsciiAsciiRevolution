# Makefile for JustForFun Files

# A few variables

LIBS=-L-lmenu -L-lncurses

SRC_DIR=.
EXE_DIR=../demo/exe

EXES = \
	${EXE_DIR}/menu_attrib\
	${EXE_DIR}/menu_item_data\
	${EXE_DIR}/menu_multi_column \
	${EXE_DIR}/menu_scroll \
	${EXE_DIR}/menu_simple \
	${EXE_DIR}/menu_toggle \
	${EXE_DIR}/menu_userptr \
	${EXE_DIR}/menu_win

${EXE_DIR}/%: %.o
	${DC} -of$@ $< ${LIBS}

%.o: ${SRC_DIR}/%.d
	${DC} -of$@ -c $< ${IMPORTS}

all:    ${EXES}


clean:
	@rm -f ${EXES}
