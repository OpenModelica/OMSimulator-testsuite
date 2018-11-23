.PHONY: all test difftool partest

all: difftool test

test: API.log OMSimulator.log OMSysIdent.log OMTLMSimulator.log oms3.log

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

oms3.log: difftool
	@$(MAKE) -C oms3 -f Makefile test > $@
	@grep == oms3.log

ssc.log: difftool
	@$(MAKE) -C StepSizeControl -f Makefile test > $@
	@grep == ssc.log

difftool:
	@$(MAKE) -C difftool
