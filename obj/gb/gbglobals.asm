;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.7 #12016 (Mac OS X x86_64)
;--------------------------------------------------------
	.module gbglobals
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gbglobals
	.globl _strcpy
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/gb/gbglobals.c:8: void gbglobals()
;	---------------------------------
; Function gbglobals
; ---------------------------------
_gbglobals::
;src/gb/gbglobals.c:10: strcpy(gOption2Ordinateurs,"2 Gameboy    ");
	ld	hl, #___str_0
	push	hl
	ld	hl, #_gOption2Ordinateurs
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:11: strcpy(gOptionQuiCommence,"Qui commence ? ");
	ld	hl, #___str_1
	push	hl
	ld	hl, #_gOptionQuiCommence
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:12: strcpy(gJ1commence,"Joueur 1 commence");
	ld	hl, #___str_2
	push	hl
	ld	hl, #_gJ1commence
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:13: strcpy(gJ2ordi,"Je suis le joueur2");
	ld	hl, #___str_3
	push	hl
	ld	hl, #_gJ2ordi
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:14: strcpy(gOptionProfondeur," niveau ? ");
	ld	hl, #___str_4
	push	hl
	ld	hl, #_gOptionProfondeur
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:15: strcpy(gPositionsEvaluees,"_valu_es");  //"positions _valu_es :      ");
	ld	hl, #___str_5
	push	hl
	ld	hl, #_gPositionsEvaluees
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:17: strcpy(gQuelleCase,"quelle case ? ");
	ld	hl, #___str_6
	push	hl
	ld	hl, #_gQuelleCase
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:18: strcpy(gVainqueur," vainqueur");
	ld	hl, #___str_7
	push	hl
	ld	hl, #_gVainqueur
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:19: strcpy(gEgalite,"Egalit_");
	ld	hl, #___str_8
	push	hl
	ld	hl, #_gEgalite
	push	hl
	call	_strcpy
	add	sp, #4
;src/gb/gbglobals.c:22: gEgalite[6]=(char)130;
	ld	hl, #(_gEgalite + 0x0006)
	ld	(hl), #0x82
;src/gb/gbglobals.c:23: gPositionsEvaluees[0]=gPositionsEvaluees[5]=(char)130;
	ld	hl, #(_gPositionsEvaluees + 0x0005)
	ld	(hl), #0x82
	ld	hl, #_gPositionsEvaluees
	ld	(hl), #0x82
;src/gb/gbglobals.c:24: gOptionProfondeur[11]=(char)130;
	ld	hl, #(_gOptionProfondeur + 0x000b)
	ld	(hl), #0x82
;src/gb/gbglobals.c:25: }
	ret
___str_0:
	.ascii "2 Gameboy    "
	.db 0x00
___str_1:
	.ascii "Qui commence ? "
	.db 0x00
___str_2:
	.ascii "Joueur 1 commence"
	.db 0x00
___str_3:
	.ascii "Je suis le joueur2"
	.db 0x00
___str_4:
	.ascii " niveau ? "
	.db 0x00
___str_5:
	.ascii "_valu_es"
	.db 0x00
___str_6:
	.ascii "quelle case ? "
	.db 0x00
___str_7:
	.ascii " vainqueur"
	.db 0x00
___str_8:
	.ascii "Egalit_"
	.db 0x00
	.area _CODE
	.area _CABS (ABS)
