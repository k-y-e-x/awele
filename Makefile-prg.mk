PRG = build/awele-c64.prg

# Unix or Windows
ifeq ($(shell echo),)
	CP = cp $1
else
	CP = copy $(subst /,\,$1)
endif

REMOVES += $(PRG)

.PHONY: prg
prg: $(PRG)

$(PRG): build/awele.c64
	$(call CP, $< $@)
