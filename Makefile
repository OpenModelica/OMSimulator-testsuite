.PHONY: all OMSimulator difftool

all: OMSimulator

OMSimulator:
	@$(MAKE) -C OMSimulator > OMSimulator.log
	@grep == OMSimulator.log

difftool:
	@$(MAKE) -C difftool
