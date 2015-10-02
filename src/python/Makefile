.PHONY: all clean

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
	#R -e 'library(knitr); opts_chunk$$set(engine="python", out.format="latex"); Sweave2knitr("$<", output="$<.rnw"); knit("$<.rnw")'

%.pdf: %.tex
	openout_any=a latexmk -pdf -bibtex -pdflatex=$(PDFLATEX)\
		-jobname=$(DEST)/$(<:%.tex=%)\
		-use-make\
		$(realpath $<)

clean:
	-cd $(DEST) && latexmk -f -C -bibtex ${PDF_FILES}
	-latexmk -f -C -bibtex ${PDF_FILES} 
	-$(RM) -rf cache
	-$(RM) -rf figures
	-$(RM) *.html


