.PHONY: all clean release

ifeq (${RELEASE_TAG},)
RELEASE_TAG := $(lastword $(shell git tag --points-at HEAD))
endif

all:
	make -C src/org -f Makefile
	make -C src/tex -f Makefile


release:
	@if [ -z "${RELEASE_TAG}" ]; then echo "No tag found at HEAD or specified via RELEASE_TAG"; exit 1; fi
	if [ ! -z "$(shell hub release | grep -x ${RELEASE_TAG})" ]; then hub release delete ${RELEASE_TAG}; fi
	hub release create -p -m "${RELEASE_TAG}" \
		$(addprefix -a , $(wildcard output/*.pdf)) \
		$(addprefix -a , $(wildcard figures/*)) \
		${RELEASE_TAG}

clean:
	for MAKEFILE_DIR in $$(egrep -l '^clean:' src/**/Makefile) ; do \
		make -C $$(dirname $${MAKEFILE_DIR}) -f Makefile clean; \
	done
