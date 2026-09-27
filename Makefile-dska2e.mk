# Apple II enhanced : image de disquette DSK amorçable (build/awelea2e.dsk).
DSK = build/awelea2e.dsk

# For this one, see https://applecommander.github.io/
AC = apple2/ac.jar

# Unix or Windows
ifeq ($(shell echo),)
	CP = cp $1
else
	CP = copy $(subst /,\,$1)
endif

apple2enh_MEDIA += build/awelea2e.dsk

.PHONY: dsk
dsk: $(DSK)

$(DSK): build/awele.apple2enh
	$(call CP, apple2/template.dsk $@)
	java -jar $(AC) -p  $@ awele.system sys < $(shell cl65 --print-target-path)/apple2enh/util/loader.system
	java -jar $(AC) -as $@ awele        bin < build/awele.apple2enh
