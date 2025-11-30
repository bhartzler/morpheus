CC= gcc
CFLAGS= -O2
LSJDIR=/local/text/lsj

STEMPROG= stemsrc/stripref stemsrc/zapfirstf stemsrc/headnolen \
	stemsrc/goodstem stemsrc/flatlems

# Get all noms files, but without emacs backups
nomsrc= $(filter-out %~,$(wildcard stemsrc/nom.* stemsrc/nom[0-9]*))

all: $(STEMPROG) ends deriv noms vbs 

ends: nends vends

nends:
	buildend nom
	indendtables nom

vends:
	buildend verb
	indendtables verb

compnoms:
	cat $(nomsrc) > nommorph
	indexcomps < nommorph | sort | compcomps > nom.heads

deriv:
	buildderiv all
	indderivtables

noms:	stemsrc/nom.irreg stemind/nomind 

vbs:	stemsrc/lsj.vbs stemsrc/vbs.irreg stemind/vbind

enclitics:  
	cat stemsrc/vbs.irreg stemsrc/nom* | fgrep enclitic > enclitics

stemind/vbind:
	cat stemsrc/vbs.irreg stemsrc/vbs.simp.ml stemsrc/vbs.simp.02.new stemsrc/lsj.vbs \
	    > conjfile
	do_conj
	mv conjfile.short vbmorph
	indexvbs

stemsrc/nom.irreg:	stemsrc/irreg.nom.src
	buildword < stemsrc/irreg.nom.src > stemsrc/nom.irreg

stemsrc/vbs.irreg:	stemsrc/irreg.vbs.src
	buildword < stemsrc/irreg.vbs.src > stemsrc/vbs.irreg

stemsrc/lemlist:
	cat $(nomsrc) stemsrc/vbs.irreg \
	    stemsrc/vbs.simp.ml stemsrc/vbs.simp.02.new | fgrep ":le:" | \
	    cut -d":" -f 3 | sort | awk '{print $$1 " "}' > stemsrc/lemlist

stemind/nomind:	stemsrc/lsj.nom getentities.pl
	./addconstraints.pl $(nomsrc) stemsrc/lsj.nom \
	    stemsrc/lsj.byhand > nommorph
	./getentities.pl nommorph  > steminds/entitylist.txt
	indexnoms

entities: stemsrc/entitylist-byhand.txt
	./getentities.pl stemsrc/entitylist-byhand.txt  $(nomsrc) stemsrc/lsj.nom stemsrc/lsj.byhand > steminds/entitylist.txt
	

ia.noms:
	echo "[aehuwo]i h_hs" > skip.ia
	echo ":wd:" >> skip.ia
	cat stemsrc/nom0[1-6] | fgrep "i h_hs" | \
	    egrep -v -f skip.ia > ia.noms
	findbase < ia.noms > ia.base
	fgrep 0 ia.base | awk '{print $$1}' | rev | sort -d | \
	    rev > ia.failed

stemsrc/lsj.nom stemsrc/lsj.vbs:
	[ -f ${LSJDIR}/lemmata ] && ${MAKE} lsj.morph

lsj.morph:	${LSJDIR}/lemmata
	sed -e 's/\-//' ${LSJDIR}/lemmata | setquant | splitlems | newlems | \
	    fgrep -v "1 " | fgrep -v ": " | newlems2 > lsj.morph
	cp lsj.vbs stemsrc
	fgrep -v "0:" lsj.morph > stemsrc/lsj.nom


clean:
	rm -f $(STEMPROG) conjfile
	rm -f steminds/* derivs/ascii/* derivs/indices/* derivs/out/*
	rm -f endtables/ascii/* endtables/indices/* endtables/out/*
	rm -f nommorph nom.heads vbmorph skip.ia ia.noms ia.base ia.failed lsj.morph lsj.vbs
