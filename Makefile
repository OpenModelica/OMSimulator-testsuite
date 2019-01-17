.PHONY: all test difftool partest

all: difftool test

test: AircraftVehicleDemonstrator.log OMSysIdent.log OMSimulator.log OMTLMSimulator.log

partest: difftool
	cd partest && time ./runtests.pl -nocolour -with-xml

OMSysIdent.log: difftool
	@$(MAKE) -C OMSysIdent -f Makefile test > $@
	@grep == OMSysIdent.log

AircraftVehicleDemonstrator.log: difftool
	@$(MAKE) -C AircraftVehicleDemonstrator -f Makefile test > $@
	@grep == AircraftVehicleDemonstrator.log

OMSimulator.log: difftool
	@$(MAKE) -C OMSimulator -f Makefile test > $@
	@grep == OMSimulator.log

OMTLMSimulator.log: difftool
	@$(MAKE) -C OMTLMSimulator -f Makefile test > $@
	@grep == OMTLMSimulator.log

difftool:
	@$(MAKE) -C difftool
