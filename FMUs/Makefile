FMUS = $(patsubst %/modelDescription.xml,%.fmu,$(wildcard */modelDescription.xml))

all: $(FMUS)
	echo "$(FMUS)"

$(FMUS): %.fmu: %/modelDescription.xml
	(cd $(@:%.fmu=%) && zip -r -0 "../$@" .)
