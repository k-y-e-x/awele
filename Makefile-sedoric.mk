DSK = awele-oric.dsk

REMOVES += $(DSK)

.PHONY: dsk
dsk: $(DSK)

$(DSK): aweloric.tap
	tap2dsk -nKALAHA -iCLS:AWELE $< $@
	old2mfm $@