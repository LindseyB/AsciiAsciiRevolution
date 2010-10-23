# Makefile for JustForFun Files

# A few variables

LIBS=-L-lpanel -L-lncurses

SRC_DIR=.
EXE_DIR=../demo/exe

EXES = \
	${EXE_DIR}/panel_browse \
	${EXE_DIR}/panel_hide \
	${EXE_DIR}/panel_resize \
	${EXE_DIR}/panel_simple

${EXE_DIR}/%: %.o
	${DC} -of$@ $< ${LIBS}

%.o: ${SRC_DIR}/%.d
	${DC} -of$@ -c $< ${IMPORTS}

all:    ${EXES}


clean:
	@rm -f ${EXES}
