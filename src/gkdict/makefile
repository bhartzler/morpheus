LEX=flex
INCLUDE=../includes
MORPHLIB= ../morphlib/morphlib.a
GREEKLIB= ../greeklib/greeklib.a
GKENDS=../gkends/gkends.a
DICTLIB=gkdict.a

DICTOBJ=dictio.o derivio.o compnoun.o

CC=cc
RM=/bin/rm -f
LINTFLAGS= -I${INCLUDE} -DDEBUG

# Compiler-specific warning flags
ifeq ($(shell $(CC) --version 2>&1 | grep -c clang),1)
    WARN_FLAGS = -Wno-deprecated-non-prototype
else
    WARN_FLAGS = -Wno-stringop-overflow -Wno-format-overflow -Wno-unused-result
endif

CFLAGS= -std=gnu89 -O3 -march=native -funroll-loops -I${INCLUDE} -fcommon $(WARN_FLAGS) -Wno-implicit-function-declaration -Wno-incompatible-pointer-types -Wno-return-type

LOADLIBES=

ALL=gkdict.a indexcomps indexnoms indexvbs  newlems newlems2 setquant splitlems splitlat latvb conj1 combitype latnom fixhesc fixgend

lexer= combitype fixhesc latnom setquant splitlems conj1 getitype latvb splitlat fixgend

all: ${ALL}

install: ${ALL}
	cp  ${ALL} ../../bin

indexcomps:  indcomps.o  ${MORPHLIB} ${GREEKLIB}
	${CC} -o indexcomps  indcomps.o  ${MORPHLIB} ${GREEKLIB}

indexnoms:	indexnoms.main.o indexstems.o  ${MORPHLIB} ${GREEKLIB}
	${CC} ${CFLAGS} -o indexnoms indexnoms.main.o indexstems.o ${MORPHLIB} ${GREEKLIB}

indexvbs:	indexvbs.main.o indexstems.o ${MORPHLIB} ${GREEKLIB}
	${CC} -o indexvbs indexvbs.main.o indexstems.o ${MORPHLIB} ${GREEKLIB}

newlats:	newlats.o  ${MORPHLIB} ${GREEKLIB} ${GKENDS}
	${CC} -o newlats newlats.o  ${GKENDS} ${MORPHLIB} ${GREEKLIB} 

newlems:	newlems.o  ${MORPHLIB} ${GREEKLIB} ${GKENDS}
	${CC} -o newlems newlems.o  ${GKENDS} ${MORPHLIB} ${GREEKLIB} 

newlems2:	newlems2.o  ${MORPHLIB} ${GREEKLIB}
	${CC} -o newlems2 newlems2.o  ${MORPHLIB} ${GREEKLIB}

xx:	x.o  ${MORPHLIB} ${GREEKLIB}
	${CC} -o xx x.o  ${MORPHLIB} ${GREEKLIB}

${DICTLIB}: ${DICTOBJ}
	ar r ${DICTLIB} ${DICTOBJ} 2>/dev/null
	ranlib ${DICTLIB}

clean:
	rm -f *.o ${ALL}

/tmp/nt: latnom splitlems
	splitlems < /local/text/ls/lemmata | fixhesc | fgrep -v vtags  | latnom > /tmp/lat
	getitype < /tmp/lat | sort | uniq -c | sort -rn > /tmp/nt

