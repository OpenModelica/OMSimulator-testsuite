.PHONY: all difftool

all: difftool test

test: API.log OMSimulator.log OMFit.log

partest: difftool
	cd partest && time ./runtests.pl -nocolour -with-xml

OMSimulator.log: difftool
	$(MAKE) -C OMSimulator -f Makefile test > $@
	grep == OMSimulator.log

API.log: difftool
	$(MAKE) -C API -f Makefile test > $@
	grep == API.log

OMFit.log: difftool
	$(MAKE) -C OMFit -f Makefile test > $@
	grep == OMFit.log

difftool:
	$(MAKE) -C difftool
