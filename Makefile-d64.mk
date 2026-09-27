# Commodore 64 : image de disquette D64 (build/awele.d64).
D64 = build/awele.d64


c64_MEDIA += $(D64)

.PHONY: d64
d64: $(D64)

$(D64): build/awele.c64
	cc1541 -f awele -w  $< $@
