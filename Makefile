.PHONY: all OMSimulator.log difftool

all: difftool test

test: OMSimulator.log

partest: difftool
	cd partest && time ./runtests.pl -nocolour -with-xml

OMSimulator.log: difftool
	$(MAKE) -C OMSimulator -f Makefile test > $@
	grep == OMSimulator.log

OMFit.log: difftool
	$(MAKE) -C OMFit -f Makefile test > $@

difftool:
	$(MAKE) -C difftool
