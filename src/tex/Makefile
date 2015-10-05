.PHONY: all clean 

TEX_FILES	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.tex)
PDF_FILES	= $(TEX_FILES:%.tex=%.pdf)

all: $(TEX_FILES:%.tex=%.pdf)

SRCDIR = $(realpath $(dir $<))
DEST = $(abspath ../../output)

#
# perhaps we could cd into the directory and avoid this openout_any=a nonsense.
# 
PDFLATEX = "pdflatex -shell-escape -file-line-error -interaction=nonstopmode -synctex=1"

%.pdf: %.tex
	@mkdir -p $(DEST)
	@cd $(DEST)
	@openout_any=a latexmk -recorder -pdf -bibtex -pdflatex="$(PDFLATEX)"\
		-jobname=$(DEST)/$(<:%.tex=%)\
		-use-make\
		$(realpath $<)

clean:
	# TODO: get rid of *.synctex.gz files in output dir
	@cd $(DEST) && latexmk -C -bibtex ${PDF_FILES}
 
