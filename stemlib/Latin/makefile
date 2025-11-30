LSDIR=/local/text/ls

all: ends deriv noms vbs

ends: nends vends

nends:
	buildend -L nom
	indendtables -L nom

vends:
	buildend -L verb
	indendtables -L verb

compnoms:
	cat stemsrc/nom.* stemsrc/nom[0-9]* > nommorph
	indexcomps < nommorph | sort | compcomps > nom.heads

deriv:
	mkdir -p derivs/ascii derivs/indices derivs/out
	buildderiv -L all
	touch derivs/out/perfstem.out  # stub: do_conj expects this but perfstem needs no derivation
	indderivtables -L

noms:	stemsrc/nom.irreg stemind/nomind 

vbs:	stemsrc/vbs.irreg stemind/vbind

VBFILES=stemsrc/vbs.latin.bas stemsrc/vbs.latin.irreg stemsrc/vbs.latin \
	stemsrc/vbs.irreg

stemind/vbind:	stemsrc/vbs.latin
	mkdir -p steminds
	cat ${VBFILES} | \
	    perl -pe 's/([a-z])([aei])_v[ \t]+perfstem/$$1\t$$2vperf/g;' > \
	    conjfile
	do_conj -L
	mv conjfile.short vbmorph
	indexvbs -L

stemsrc/nom.irreg: stemsrc/irreg.nom.src
	buildword -L < stemsrc/irreg.nom.src > stemsrc/nom.irreg

stemsrc/vbs.irreg: stemsrc/irreg.vbs.src
	buildword -L < stemsrc/irreg.vbs.src > stemsrc/vbs.irreg

stemsrc/lemlist:
	cat stemsrc/nom.* stemsrc/nom[0-9]* stemsrc/vbs.irreg \
	    stemsrc/vbs.simp.ml stemsrc/vbs.simp.02.new | fgrep ":le:" | \
	    cut -d":" -f 3 | sort | awk '{print $$1 " "}' > stemsrc/lemlist

stemind/nomind:	stemsrc/ls.nom ../Greek/getentities.pl
	mkdir -p steminds
	cat stemsrc/nom.* stemsrc/ls.nom > nommorph
	../Greek/getentities.pl nommorph  > steminds/entitylist.txt
	indexnoms -L

ia.noms:
	echo "[aehuwo]i h_hs" > skip.ia
	echo ":wd:" >> skip.ia
	cat stemsrc/nom0[1-6] | fgrep "i h_hs" | \
	    egrep -v -f skip.ia > ia.noms
	findbase < ia.noms > ia.base
	fgrep 0 ia.base | awk '{print $$1}' | rev | sort -d | \
	    rev > ia.failed

# these files are now stable
#stemsrc/ls.nom stemsrc/vbs.latin:
#	-[ -f ${LSDIR}/lemmata ] && ${MAKE} ls.morph

ls.morph:	${LSDIR}/lemmata
	fgrep ":le:" stemsrc/vbs.latin.bas | cut -d: -f3 | \
	    sort > stemsrc/lemmata
#	sed -e 's/\-//' ${LSDIR}/lemmata |  combitype | splitlat | conj1 | \
#	    fgrep -f vtags | latvb > ls.vbs
#	cat ${LSDIR}/lemmata |  combitype | splitlat | conj1 | \
#	    fgrep -f vtags | latvb | \
#	    perl -pe 's/(^\:le\:[A-Za-z]+)\-([A-Za-z])/$1$2/g' > ls.vbs
	cat ${LSDIR}/lemmata |  combitype | splitlat | conj1 | \
	    fgrep -f vtags | latvb > ls.vbs
	splitlems < ${LSDIR}/lemmata |  fixhesc | fgrep -v -f vtags | \
	    fgrep -v "<pos>P. a.</pos>" |  fixgend | latnom > ls.morph
	egrep -e "^:" ls.vbs > stemsrc/vbs.latin
	fgrep -v "0:" ls.morph > stemsrc/ls.nom

simp.vbs:
#	sed -e 's/\-//' ${LSDIR}/lemmata |  combitype | splitlat | conj1 | fgrep -f vtags | fgrep -f hyph -v | latvb > ls.simp.vbs
#	sed -e 's/\-//' ${LSDIR}/lemmata |  combitype | splitlat | conj1 | fgrep -f vtags | fgrep -f hyph | latvb | filtcomp > ls.cvbs.words
	sed -e 's/\-//' ${LSDIR}/lemmata |  combitype | splitlat | awk '{print $$1}' > ls.cvbs.words
	rm -f stemsrc/vbs.cmp.ml
	cruncher -LV ls.cvbs
	cvblink < ls.cvbs.morph | sort -u > stemsrc/vbs.cmp.ml

nt: latnom splitlems
	splitlems < /local/text/ls/lemmata | latnom > lat
	getitype < lat | sort | uniq -c | sort -rn > nt

clean:
	rm -f steminds/* derivs/ascii/* derivs/indices/* derivs/out/*
	rm -f endtables/ascii/* endtables/indices/* endtables/out/*
	rm -f stemsrc/nom.irreg stemsrc/vbs.irreg conjfile*
	rm -f nommorph nom.heads vbmorph skip.ia ia.noms ia.base ia.failed ls.morph ls.vbs ls.cvbs.words ls.cvbs.morph lat nt
