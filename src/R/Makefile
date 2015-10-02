
.PHONY: all clean 
#.PRECIOUS: %.tex %.pdf

TEX_FILES	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
RNW_FILES	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.rnw)
PDF_FILES = $(addsuffix .pdf, $(basename $(TEX_FILES) $(RNW_FILES))) 

all: $(PDF_FILES)

SRCDIR = $(realpath $(dir $<))
DEST = $(abspath ../../output)

PDFLATEX = "pdflatex -interaction nonstopmode -shell-escape"

%.pdf: %.tex
	@echo "dest: $(DEST)"
	@echo "src: $(SRCDIR)"
	mkdir -p $(DEST)
	cd $(DEST)
	openout_any=a latexmk -pdf -bibtex -pdflatex=$(PDFLATEX)\
		-jobname=$(DEST)/$(<:%.tex=%)\
		-use-make\
		$(realpath $<)

%.tex: %.rnw
	R -e 'library(knitr); knit("$<")'
	-cp -f $@ $(abspath $(SRCDIR)/../tex)

clean: clean-tex clean-knitr

clean-tex:
	-cd $(DEST) && latexmk -f -C -bibtex ${PDF_FILES}
	-latexmk -f -C -bibtex ${PDF_FILES} 

clean-knitr:
	-$(RM) -rf cache
	-$(RM) -rf figure
	-$(RM) *.html

