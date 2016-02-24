#
# An example Makefile that builds using Pweave and latexmk.
# The tex file are intermediate/temporary files in this setting,
# although some of the commented code could save tex results
# in a separate tex directory (see the R example).
#
# There is also a commented line that compiles Python noweb using
# R's knitr and knitron packages.
#
#

.PHONY: all clean clean-tex clean-pweave clean-html clean-md
#.PRECIOUS: ../tex/%.tex

PNW_FILES = $(wildcard *.pnw) $(wildcard *.Pnw)
TEXW_FILES = $(wildcard *.texw)
PDF_FILES = $(addsuffix .pdf, $(basename $(TEXW_FILES))) 
HTML_FILES = $(addsuffix .html, $(basename $(PNW_FILES)))
 
PANDOC_EXTS = +tex_math_dollars+yaml_metadata_block+autolink_bare_uris+ascii_identifiers+tex_math_single_backslash+latex_macros+footnotes+inline_notes
#+citations
PANDOC_OPTIONS = --smart --toc --self-contained -s --mathjax 
#--filter pandoc-citeproc

HTML_DEPS = $(wildcard _output.yaml) 
ifneq ($(wildcard include/before_body.html),) 
PANDOC_OPTIONS += -H include/before_body.html 
HTML_DEPS += include/before_body.html
endif

ifneq ($(wildcard include/after_body.html),) 
PANDOC_OPTIONS += -A include/after_body.html 
HTML_DEPS += include/after_body.html
endif

#PDF_DEPS = ""
PDFLATEX = "pdflatex -interaction nonstopmode -shell-escape "
SRCDIR = $(realpath $(dir $<))
DEST = $(abspath ../../output)
#TEXDIR = $(abspath ../tex)

# add citations with:
# --biblio file.bib --csl chicago-author-date.csl 

all: $(HTML_FILES) $(PDF_FILES)

%.md: %.Pnw
	Pweave -f pandoc -c $<

%.md: %.tex
	pandoc -f latex -t markdown$(PANDOC_EXTS) $(PANDOC_OPTIONS) -o $@ $<

%.html: %.md $(HTML_DEPS)
	pandoc -f markdown$(PANDOC_EXTS) -t html $(PANDOC_OPTIONS) -o $@ $<

%.tex: %.texw
	Pweave -f texminted -c -d $<
	#Rscript --vanilla --default-packages=stats,base,knitr,knitron -e 'opts_chunk$$set(out.format="latex"); knit("$<", "$(addsuffix .tex, $(basename $<))")'

%.pdf: %.tex
	@max_print_line=1000 error_line=254 half_error_line=238 openout_any=a\
  							 latexmk -pdf -bibtex -pdflatex=$(PDFLATEX)\
		-jobname=$(DEST)/$(<:%.tex=%)\
		-use-make\
		$(realpath $<)

#../tex/%.tex: %.rnw
#	R -e 'library(knitr); knit("$<")'
#	mv -f $(addsuffix .tex, $(basename $<)) $(TEXDIR)

#%.pdf: ../tex/%.tex
#	# in the case that the file was knit'ed outside of this Makefile
#	# and not moved to the tex directory, move it now.
#	-mv -f $(addsuffix .tex, $(basename $<)) $(TEXDIR)
#	make -C $(TEXDIR) -f Makefile $@

clean: clean-tex clean-pweave clean-html clean-md

clean-html:
	-$(RM) *.html

clean-md:
	-$(RM) *.html

clean-tex:
	-cd $(DEST) && latexmk -f -C -bibtex ${PDF_FILES}
	-latexmk -f -C -bibtex ${PDF_FILES} 

clean-pweave:
	-$(RM) -rf cache
	-$(RM) -rf figures

