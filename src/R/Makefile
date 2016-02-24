#
# Compiles noweb file to tex, moves to tex directory, then
# (if requested) makes pdf in output directory (using the
# Makefile from tex directory).
#
# Comment out the .PRECIOUS... line if you don't want to keep
# the resulting tex file in the tex directory.
#
# -brandonwillard@gmail.com
#

.PHONY: all clean clean-tex clean-knitr
.PRECIOUS: ../tex/%.tex

RNW_FILES	:= $(shell egrep -l '^[^%]*\\begin\{document\}' *.rnw)
PDF_FILES = $(addsuffix .pdf, $(basename $(RNW_FILES))) 
TEX_FILES = $(addsuffix .tex, $(basename $(RNW_FILES))) 

all: $(PDF_FILES)

TEXDIR = $(abspath ../tex)
DEST = $(abspath ../../output)

%.pdf: ../tex/%.tex
	# in the case that the file was knit'ed outside of this Makefile
	# and not moved to the tex directory, move it now.
	-mv -f $(addsuffix .tex, $(basename $<)) $(TEXDIR)
	make -C $(TEXDIR) -f Makefile $@

../tex/%.tex: %.rnw
	Rscript --vanilla --default-packages=stats,base,knitr -e 'opts_chunk$$set(out.format="latex"); knit("$<", "$(addsuffix .tex, $(basename $<))")'
	mv -f $(addsuffix .tex, $(basename $<)) $(TEXDIR)

clean: clean-tex clean-knitr

# TODO: get rid of *.synctex.gz files in output dir

clean-tex:
	-rm -f $(TEXDIR)/$(TEX_FILES)
	-cd $(DEST) && latexmk -f -C -bibtex ${PDF_FILES}

clean-knitr:
	-$(RM) -rf cache
	-$(RM) -rf figure
	-$(RM) *.html

