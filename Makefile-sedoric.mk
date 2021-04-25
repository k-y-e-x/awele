DSK = build/awele-oric.dsk

REMOVES += $(DSK)

.PHONY: dsk
dsk: $(DSK)

$(DSK): build/aweloric.tap
	tap2dsk -nKALAHA -iCLS:AWELE $< $@
	old2mfm $@