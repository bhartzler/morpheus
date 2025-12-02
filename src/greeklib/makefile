INCLUDE=../includes
LIB=greeklib.a
RM=rm
CC=cc

# Compiler-specific warning flags
ifeq ($(shell $(CC) --version 2>&1 | grep -c clang),1)
    WARN_FLAGS = -Wno-deprecated-non-prototype
else
    WARN_FLAGS = -Wno-stringop-overflow -Wno-format-overflow -Wno-unused-result
endif

CFLAGS= -std=gnu89 -O3 -march=native -funroll-loops -I${INCLUDE} -fcommon $(WARN_FLAGS) -Wno-implicit-function-declaration -Wno-incompatible-pointer-types -Wno-return-type

GRKLIBOBJ = Fclose.o \
addaccent.o \
addbreath.o \
aspirate.o \
beta_tolower.o \
binlook.o \
checkaccent.o \
cinsert.o \
do_dissim.o \
endsinstr.o \
getaccent.o \
getaccp.o \
getbreath.o \
getquantity.o \
getsyll.o \
gkstrlen.o \
hasaccent.o \
hasdiaer.o \
hasquant.o \
isblank.o \
isdiphth.o \
issubstring.o \
keyio.o \
longbyposition.o \
naccents.o \
normucase.o \
nsylls.o \
quantprim.o \
shortanalog.o \
standalpha.o \
standword.o \
stripacc.o \
stripacute.o \
stripbreath.o \
stripchar.o \
stripdiaer.o \
stripmeta.o \
stripquant.o \
stripstemsep.o \
stripzeroend.o \
strsqz.o \
subchar.o \
vaxwords.o \
sprntGkflags.o \
xstrings.o \
zap2ndbreath.o 

${LIB}: ${GRKLIBOBJ}
	ar r ${LIB} ${GRKLIBOBJ} 2>/dev/null
	ranlib ${LIB}

clean:
	rm -f ${LIB} *.o


iotest: io.o vaxwords.o
	${CC} -o iotest io.o vaxwords.o
