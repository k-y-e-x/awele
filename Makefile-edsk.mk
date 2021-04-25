EDSK = build/awele-oric_edsk.dsk

REMOVES += $(EDSK)

.PHONY: edsk
edsk: $(EDSK)

$(EDSK): build/aweloric.tap
	tap2edsk -nAWELE-KALAHA -iCLS:AWELE $< $@