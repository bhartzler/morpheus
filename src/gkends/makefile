INCLUDE=../includes
RM=rm
ENDLIB=gkends.a
CC=cc

# Compiler-specific warning flags
ifeq ($(shell $(CC) --version 2>&1 | grep -c clang),1)
    WARN_FLAGS = -Wno-deprecated-non-prototype
else
    WARN_FLAGS = -Wno-stringop-overflow -Wno-format-overflow -Wno-unused-result
endif

CFLAGS= -std=gnu89 -O3 -march=native -funroll-loops -I${INCLUDE} -fcommon $(WARN_FLAGS) -Wno-implicit-function-declaration -Wno-incompatible-pointer-types -Wno-return-type


GREEKLIB=../greeklib/greeklib.a
MORPHLIB=../morphlib/morphlib.a
LIBS=${ENDLIB} ${MORPHLIB} ${GREEKLIB} 
ENDOBJ= acccompos.o \
checkforbreath.o \
contract.o \
countendtables.o \
endindex.o \
euphend.o \
expendtable.o \
fixeta.o \
getcurrend.o \
indexendtables.o \
lcontr.o \
merge.o \
mkend.o \
nextsufftab.o \
retrends.o \
stor.o 

${ENDLIB}: ${ENDOBJ}
	ar r ${ENDLIB} ${ENDOBJ} 2>/dev/null
	ranlib ${ENDLIB}

ALL=buildword buildend indderivtables indendtables buildderiv ${ENDLIB}

all: ${ALL}

install: all
	cp ${ALL} ../../bin


buildword: expwordmain.o ${ENDOBJ} ${LIBS}
	${CC} -o buildword expwordmain.o ${ENDOBJ} ${LIBS}

buildend: expendmain.o ${ENDOBJ} ${LIBS}
	${CC} -o buildend expendmain.o ${ENDOBJ} ${LIBS}

indderivtables: smain.o ${ENDOBJ} ${LIBS}
	${CC} -o indderivtables smain.o ${ENDOBJ} ${LIBS}

indendtables: imain.o ${ENDOBJ} ${LIBS}
	${CC} -o indendtables imain.o ${ENDOBJ} ${LIBS}

buildderiv: expsuffmain.o ${ENDOBJ} ${LIBS}
	${CC} -o buildderiv expsuffmain.o ${ENDOBJ} ${LIBS}

clean:
	rm -f ${ALL} *.o
