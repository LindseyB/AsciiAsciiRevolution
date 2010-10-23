# Makefile for JustForFun Files

# A few variables

LIBS=-L-lform -L-lncurses

SRC_DIR=.
EXE_DIR=../demo/exe

EXES = \
	${EXE_DIR}/form_attrib\
	${EXE_DIR}/form_options\
	${EXE_DIR}/form_simple\
	${EXE_DIR}/form_win \

${EXE_DIR}/%: %.o
	${DC} -of$@ $< ${LIBS}

%.o: ${SRC_DIR}/%.d
	${DC} -of$@ -c $< ${IMPORTS}

all:    ${EXES}


clean:
	@rm -f ${EXES}
