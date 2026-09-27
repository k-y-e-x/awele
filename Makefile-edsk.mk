# Oric Atmos : image de disquette EDSK requise par le cœur Oric de MiSTer.
# Conversion du TAP avec tap2edsk ; sortie en .dsk : build/awele-oric_edsk.dsk.
EDSK = build/awele-oric_edsk.dsk

atmos_MEDIA += $(EDSK)

.PHONY: edsk
edsk: $(EDSK)

$(EDSK): build/aweloric.tap
	tap2edsk -nAWELE-KALAHA -iCLS:AWELE $< $@
