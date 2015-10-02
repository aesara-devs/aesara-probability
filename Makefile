
.PHONY: all clean 

DEP_FILES = $(wildcard ./output/*.dep)

all: 
	mkdir -p figures
	mkdir -p output
	make -C src/tex -f Makefile

clean:
	rm -rf output
	rm -rf figures
 
bundle: $(DEP_FILES) 
	make -C src/tex -f Makefile
	TEXINPUTS=${TEXINPUTS}:./src/tex:./figures:./output bundledoc --verbose --localonly --nokeepdirs --include="output/*.bbl" --texfile=./src/tex/$(notdir $(<:%.dep=%.tex)) $<


