D64 = build/awele.d64


REMOVES += $(D64)

.PHONY: d64
d64: $(D64)

$(D64): build/awele.c64
	cc1541 -f awele -w  $< $@
