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

#
# the *_line variables will (hopefully) stop unnecessary linebreaks in
# the pdflatex output.  such linebreaks can break error message parsing.
#
%.pdf: %.tex
	@mkdir -p $(DEST)
	@cd $(DEST)
	@max_print_line=1000 error_line=254 half_error_line=238 openout_any=a\
  							 latexmk -pdf -bibtex -pdflatex=$(PDFLATEX)\
		-jobname=$(DEST)/$(<:%.tex=%)\
		-use-make\
		$(realpath $<)

clean:
	# TODO: get rid of *.synctex.gz files in output dir
	@cd $(DEST) && latexmk -C -bibtex ${PDF_FILES}
 
