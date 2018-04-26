.PHONY: all difftool

all: difftool test

test: API.log OMSimulator.log OMSysIdent.log OMTLMSimulator.log

partest: difftool
	cd partest && time ./runtests.pl -nocolour -with-xml

OMSimulator.log: difftool
	@$(MAKE) -C OMSimulator -f Makefile test > $@
	@grep == OMSimulator.log

API.log: difftool
	@$(MAKE) -C API -f Makefile test > $@
	@grep == API.log

OMSysIdent.log: difftool
	@$(MAKE) -C OMSysIdent -f Makefile test > $@
	@grep == OMSysIdent.log

AircraftVehicleDemonstrator.log: difftool
	@$(MAKE) -C AircraftVehicleDemonstrator -f Makefile test > $@
	@grep == AircraftVehicleDemonstrator.log

OMTLMSimulator.log: difftool
	@$(MAKE) -C OMTLMSimulator -f Makefile test > $@
	@grep == OMTLMSimulator.log

difftool:
	@$(MAKE) -C difftool
