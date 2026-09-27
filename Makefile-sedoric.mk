# Oric Atmos / Sedoric : image de disquette DSK (build/awele-oric.dsk).
DSK = build/awele-oric.dsk

atmos_MEDIA += build/awele-oric.dsk

.PHONY: dsk
dsk: $(DSK)

$(DSK): build/aweloric.tap
	tap2dsk -nKALAHA -iCLS:AWELE $< $@
	old2mfm $@
