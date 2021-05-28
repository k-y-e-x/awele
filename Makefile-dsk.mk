DSK = build/awelea2.dsk

# For this one, see https://applecommander.github.io/
AC = apple2/ac.jar

# Unix or Windows
ifeq ($(shell echo),)
	CP = cp $1
else
	CP = copy $(subst /,\,$1)
endif

REMOVES += $(DSK)

.PHONY: dsk
dsk: $(DSK)

$(DSK): build/awele.apple2
	$(call CP, apple2/template.dsk $@)
	java -jar $(AC) -p  $@ awele.system sys < $(shell cl65 --print-target-path)/apple2/util/loader.system
	java -jar $(AC) -as $@ awele        bin < build/awele.apple2

