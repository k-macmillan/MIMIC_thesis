SUFFIXES =  .tex .pdf
.SUFFIXES: $(SUFFIXES)

TEXFILES = $(wildcard *.tex)

STYLEFILES = $(wildcard *.sty) $(wildcard *.cls)

BIBFILES = $(wildcard *.bib) 

CLASS=thesis.cls
CITESTYLE=thesiscitations.sty

MAIN = macmillan

MAINTEX=${MAIN}.tex
MAINPDF=${MAIN}.pdf
MAINAUX=${MAIN}.aux
MAINTOC=${MAIN}.toc
MAINLOG=${MAIN}.log
MAINIDX=${MAIN}.idx
MAININD=${MAIN}.ind
MAINBBL=${MAIN}.bbl 

SRC=$(TEXFILES) $(BIBFILES) $(STYLEFILES)

WCLOGFILE = ${MAIN}.wc
REBIBFLAG = ${MAIN}.remake_bbl.flag
REINDFLAG = ${MAIN}.remake_ind.flag

all: $(MAINPDF)

$(MAINPDF) : $(CITESTYLE) $(CLASS) $(SRC) bib123 docs
	pdflatex $(MAIN)
	pdflatex $(MAIN)
	rm -f bib123 *.aux *.bbl *.blg *.lof *.log *.lot *.toc *.idx *.ind *.ilg

bib123: $(SRC) 
	touch bib123
	pdflatex $(MAIN)
	bibtex $(MAIN)
	if [ -f macmillan.idx ]; then makeindex $(MAIN);  fi

$(CLASS): thesis.dtx thesis.drv
	latex thesis.drv

$(CITESTYLE): thesiscitations.dtx thesiscitations.drv
	latex thesiscitations.drv

package:
	cd .. ; tar cfz MIMIC_thesis.tgz MIMIC_thesis/thesis.dtx MIMIC_thesis/thesis.cls MIMIC_thesis/thesis.drv MIMIC_thesis/thesis.bst MIMIC_thesis/README.md MIMIC_thesis/macmillan.tex MIMIC_thesis/macmillan.bib MIMIC_thesis/images/gnu.pdf MIMIC_thesis/images/gnat.pdf MIMIC_thesis/Makefile MIMIC_thesis/thesiscitations.dtx MIMIC_thesis/thesiscitations.sty MIMIC_thesis/thesiscitations.drv MIMIC_thesis/setup.bat MIMIC_thesis/thesis.pdf MIMIC_thesis/thesiscitations.pdf MIMIC_thesis/macmillan.pdf
	mv ../MIMIC_thesis.tgz .
	cd .. ; rm -f MIMIC_thesis.zip ; zip -r  MIMIC_thesis.zip MIMIC_thesis/thesis.dtx MIMIC_thesis/thesis.cls MIMIC_thesis/thesis.drv MIMIC_thesis/thesis.bst MIMIC_thesis/README.md MIMIC_thesis/macmillan.tex MIMIC_thesis/macmillan.bib MIMIC_thesis/images/gnu.pdf MIMIC_thesis/images/gnat.pdf MIMIC_thesis/Makefile MIMIC_thesis/thesiscitations.dtx MIMIC_thesis/thesiscitations.cls MIMIC_thesis/thesiscitations.sty MIMIC_thesis/setup.bat MIMIC_thesis/thesis.pdf MIMIC_thesis/thesiscitations.pdf MIMIC_thesis/macmillan.pdf
	mv ../MIMIC_thesis.zip .

docs: thesis.dtx thesiscitations.dtx
	pdflatex thesis.dtx
	pdflatex thesiscitations.dtx

class: $(CLASS) $(CITESTYLE)

clean:
	rm -f *~
	rm -f bib123 *.aux *.bbl *.blg *.lof *.log *.lot macmillan.pdf *.toc *.idx *.ind *.ilg

realclean:
	rm -f *~
	rm -f bib123 *.aux *.bbl *.blg *.lof *.log *.lot macmillan.pdf *.toc *.idx *.ind *.ilg *.pdf *.sty *.cls


