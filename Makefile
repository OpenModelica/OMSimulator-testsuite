.PHONY: all test difftool partest

all: difftool test

test: AircraftVehicleDemonstrator.log OMSysIdent.log oms3.log

partest: difftool
	cd partest && time ./runtests.pl -nocolour -with-xml

OMSysIdent.log: difftool
	@$(MAKE) -C OMSysIdent -f Makefile test > $@
	@grep == OMSysIdent.log

AircraftVehicleDemonstrator.log: difftool
	@$(MAKE) -C AircraftVehicleDemonstrator -f Makefile test > $@
	@grep == AircraftVehicleDemonstrator.log

oms3.log: difftool
	@$(MAKE) -C oms3 -f Makefile test > $@
	@grep == oms3.log

difftool:
	@$(MAKE) -C difftool
