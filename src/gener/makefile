INCLUDE=../includes
MORPHLIB= ../morphlib/morphlib.a
GREEKLIB= ../greeklib/greeklib.a
ENDLIB= ../gkends/gkends.a
GENERLIB= gener.a

GENEROBJ= genwd.o

CC=cc
RM=/bin/rm
LINTFLAGS= -I${INCLUDE} -DDEBUG

# Compiler-specific warning flags
ifeq ($(shell $(CC) --version 2>&1 | grep -c clang),1)
    WARN_FLAGS = -Wno-deprecated-non-prototype
else
    WARN_FLAGS = -Wno-stringop-overflow -Wno-format-overflow -Wno-unused-result
endif

CFLAGS= -std=gnu89 -O3 -march=native -funroll-loops -I${INCLUDE} -fcommon $(WARN_FLAGS) -Wno-implicit-function-declaration -Wno-incompatible-pointer-types -Wno-return-type
CONJOBJ= conjmain.o conjsys.o combconj.o ppasstype.o

ALL=do_conj gener checkstype ${GENERLIB}

all: ${ALL}

install: all
	cp ${ALL} ../../bin

${GENERLIB}: ${GENEROBJ}
	ar r ${GENERLIB} ${GENEROBJ} 2>/dev/null
	ranlib ${GENERLIB}

do_conj: ${CONJOBJ} ${ENDLIB} ${MORPHLIB} ${GREEKLIB} 
	${CC} -o do_conj ${CONJOBJ} ${ENDLIB} ${MORPHLIB} ${GREEKLIB}

checkstype: stypemain.o  ${MORPHLIB} ${GREEKLIB}
	${CC} -o checkstype stypemain.o ${MORPHLIB} ${GREEKLIB}

genstem: genstmain.o genstemform.o gensynform.o  genwd.o genmisc.o  ${ENDLIB} ${MORPHLIB} ${GREEKLIB}
	${CC} -o genstem genstmain.o genstemform.o gensynform.o genwd.o genmisc.o  ${ENDLIB} ${MORPHLIB} ${GREEKLIB}

gener: genermain.o gensynform.o  genwd.o genmisc.o  ${ENDLIB} ${MORPHLIB} ${GREEKLIB}
	${CC} -o gener genermain.o gensynform.o genwd.o genmisc.o  ${ENDLIB} ${MORPHLIB} ${GREEKLIB}

clean:
	rm -f ${ALL} *.o

