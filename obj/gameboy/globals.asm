;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.7 #12016 (Mac OS X x86_64)
;--------------------------------------------------------
	.module globals
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gEgalite
	.globl _gVainqueur
	.globl _gQuelleCase
	.globl _gPositionsEvaluees
	.globl _gJoueur
	.globl _gJ2
	.globl _gJ1
	.globl _gOptionProfondeur
	.globl _gJ2ordi
	.globl _gJ1commence
	.globl _gOptionQuiCommence
	.globl _gOptionJoueurs
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_gOptionJoueurs::
	.ds 6
_gOptionQuiCommence::
	.ds 24
_gJ1commence::
	.ds 23
_gJ2ordi::
	.ds 30
_gOptionProfondeur::
	.ds 36
_gJ1::
	.ds 9
_gJ2::
	.ds 9
_gJoueur::
	.ds 4
_gPositionsEvaluees::
	.ds 9
_gQuelleCase::
	.ds 29
_gVainqueur::
	.ds 11
_gEgalite::
	.ds 8
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
;src/globals.c:7: char*	gOptionJoueurs[]= {"1 : Humain vs Humain","2 : Humain vs Ordinateur","3 : Ordinateur vs Ordinateur"};
	ld	hl, #_gOptionJoueurs
	ld	(hl), #<(___str_0)
	inc	hl
	ld	(hl), #>(___str_0)
	ld	hl, #(_gOptionJoueurs + 0x0002)
	ld	(hl), #<(___str_1)
	inc	hl
	ld	(hl), #>(___str_1)
	ld	hl, #(_gOptionJoueurs + 0x0004)
	ld	(hl), #<(___str_2)
	inc	hl
	ld	(hl), #>(___str_2)
;src/globals.c:8: char	gOptionQuiCommence[]="Quel joueur commence ? ";
	ld	hl, #_gOptionQuiCommence
	ld	(hl), #0x51
	ld	hl, #(_gOptionQuiCommence + 0x0001)
	ld	(hl), #0x75
	ld	hl, #(_gOptionQuiCommence + 0x0002)
	ld	(hl), #0x65
	ld	hl, #(_gOptionQuiCommence + 0x0003)
	ld	(hl), #0x6c
	ld	hl, #(_gOptionQuiCommence + 0x0004)
	ld	(hl), #0x20
	ld	hl, #(_gOptionQuiCommence + 0x0005)
	ld	(hl), #0x6a
	ld	hl, #(_gOptionQuiCommence + 0x0006)
	ld	(hl), #0x6f
	ld	hl, #(_gOptionQuiCommence + 0x0007)
	ld	(hl), #0x75
	ld	hl, #(_gOptionQuiCommence + 0x0008)
	ld	(hl), #0x65
	ld	hl, #(_gOptionQuiCommence + 0x0009)
	ld	(hl), #0x75
	ld	hl, #(_gOptionQuiCommence + 0x000a)
	ld	(hl), #0x72
	ld	hl, #(_gOptionQuiCommence + 0x000b)
	ld	(hl), #0x20
	ld	hl, #(_gOptionQuiCommence + 0x000c)
	ld	(hl), #0x63
	ld	hl, #(_gOptionQuiCommence + 0x000d)
	ld	(hl), #0x6f
	ld	hl, #(_gOptionQuiCommence + 0x000e)
	ld	(hl), #0x6d
	ld	hl, #(_gOptionQuiCommence + 0x000f)
	ld	(hl), #0x6d
	ld	hl, #(_gOptionQuiCommence + 0x0010)
	ld	(hl), #0x65
	ld	hl, #(_gOptionQuiCommence + 0x0011)
	ld	(hl), #0x6e
	ld	hl, #(_gOptionQuiCommence + 0x0012)
	ld	(hl), #0x63
	ld	hl, #(_gOptionQuiCommence + 0x0013)
	ld	(hl), #0x65
	ld	hl, #(_gOptionQuiCommence + 0x0014)
	ld	(hl), #0x20
	ld	hl, #(_gOptionQuiCommence + 0x0015)
	ld	(hl), #0x3f
	ld	hl, #(_gOptionQuiCommence + 0x0016)
	ld	(hl), #0x20
	ld	hl, #(_gOptionQuiCommence + 0x0017)
	ld	(hl), #0x00
;src/globals.c:9: char	gJ1commence[]="Le joueur 1 commence. ";
	ld	hl, #_gJ1commence
	ld	(hl), #0x4c
	ld	hl, #(_gJ1commence + 0x0001)
	ld	(hl), #0x65
	ld	hl, #(_gJ1commence + 0x0002)
	ld	(hl), #0x20
	ld	hl, #(_gJ1commence + 0x0003)
	ld	(hl), #0x6a
	ld	hl, #(_gJ1commence + 0x0004)
	ld	(hl), #0x6f
	ld	hl, #(_gJ1commence + 0x0005)
	ld	(hl), #0x75
	ld	hl, #(_gJ1commence + 0x0006)
	ld	(hl), #0x65
	ld	hl, #(_gJ1commence + 0x0007)
	ld	(hl), #0x75
	ld	hl, #(_gJ1commence + 0x0008)
	ld	(hl), #0x72
	ld	hl, #(_gJ1commence + 0x0009)
	ld	(hl), #0x20
	ld	hl, #(_gJ1commence + 0x000a)
	ld	(hl), #0x31
	ld	hl, #(_gJ1commence + 0x000b)
	ld	(hl), #0x20
	ld	hl, #(_gJ1commence + 0x000c)
	ld	(hl), #0x63
	ld	hl, #(_gJ1commence + 0x000d)
	ld	(hl), #0x6f
	ld	hl, #(_gJ1commence + 0x000e)
	ld	(hl), #0x6d
	ld	hl, #(_gJ1commence + 0x000f)
	ld	(hl), #0x6d
	ld	hl, #(_gJ1commence + 0x0010)
	ld	(hl), #0x65
	ld	hl, #(_gJ1commence + 0x0011)
	ld	(hl), #0x6e
	ld	hl, #(_gJ1commence + 0x0012)
	ld	(hl), #0x63
	ld	hl, #(_gJ1commence + 0x0013)
	ld	(hl), #0x65
	ld	hl, #(_gJ1commence + 0x0014)
	ld	(hl), #0x2e
	ld	hl, #(_gJ1commence + 0x0015)
	ld	(hl), #0x20
	ld	hl, #(_gJ1commence + 0x0016)
	ld	(hl), #0x00
;src/globals.c:10: char	gJ2ordi[]="L'ordinateur est le joueur 2 ";
	ld	hl, #_gJ2ordi
	ld	(hl), #0x4c
	ld	hl, #(_gJ2ordi + 0x0001)
	ld	(hl), #0x27
	ld	hl, #(_gJ2ordi + 0x0002)
	ld	(hl), #0x6f
	ld	hl, #(_gJ2ordi + 0x0003)
	ld	(hl), #0x72
	ld	hl, #(_gJ2ordi + 0x0004)
	ld	(hl), #0x64
	ld	hl, #(_gJ2ordi + 0x0005)
	ld	(hl), #0x69
	ld	hl, #(_gJ2ordi + 0x0006)
	ld	(hl), #0x6e
	ld	hl, #(_gJ2ordi + 0x0007)
	ld	(hl), #0x61
	ld	hl, #(_gJ2ordi + 0x0008)
	ld	(hl), #0x74
	ld	hl, #(_gJ2ordi + 0x0009)
	ld	(hl), #0x65
	ld	hl, #(_gJ2ordi + 0x000a)
	ld	(hl), #0x75
	ld	hl, #(_gJ2ordi + 0x000b)
	ld	(hl), #0x72
	ld	hl, #(_gJ2ordi + 0x000c)
	ld	(hl), #0x20
	ld	hl, #(_gJ2ordi + 0x000d)
	ld	(hl), #0x65
	ld	hl, #(_gJ2ordi + 0x000e)
	ld	(hl), #0x73
	ld	hl, #(_gJ2ordi + 0x000f)
	ld	(hl), #0x74
	ld	hl, #(_gJ2ordi + 0x0010)
	ld	(hl), #0x20
	ld	hl, #(_gJ2ordi + 0x0011)
	ld	(hl), #0x6c
	ld	hl, #(_gJ2ordi + 0x0012)
	ld	(hl), #0x65
	ld	hl, #(_gJ2ordi + 0x0013)
	ld	(hl), #0x20
	ld	hl, #(_gJ2ordi + 0x0014)
	ld	(hl), #0x6a
	ld	hl, #(_gJ2ordi + 0x0015)
	ld	(hl), #0x6f
	ld	hl, #(_gJ2ordi + 0x0016)
	ld	(hl), #0x75
	ld	hl, #(_gJ2ordi + 0x0017)
	ld	(hl), #0x65
	ld	hl, #(_gJ2ordi + 0x0018)
	ld	(hl), #0x75
	ld	hl, #(_gJ2ordi + 0x0019)
	ld	(hl), #0x72
	ld	hl, #(_gJ2ordi + 0x001a)
	ld	(hl), #0x20
	ld	hl, #(_gJ2ordi + 0x001b)
	ld	(hl), #0x32
	ld	hl, #(_gJ2ordi + 0x001c)
	ld	(hl), #0x20
	ld	hl, #(_gJ2ordi + 0x001d)
	ld	(hl), #0x00
;src/globals.c:11: char	gOptionProfondeur[]="Profondeur recherche (en \\coups) ? ";
	ld	hl, #_gOptionProfondeur
	ld	(hl), #0x50
	ld	hl, #(_gOptionProfondeur + 0x0001)
	ld	(hl), #0x72
	ld	hl, #(_gOptionProfondeur + 0x0002)
	ld	(hl), #0x6f
	ld	hl, #(_gOptionProfondeur + 0x0003)
	ld	(hl), #0x66
	ld	hl, #(_gOptionProfondeur + 0x0004)
	ld	(hl), #0x6f
	ld	hl, #(_gOptionProfondeur + 0x0005)
	ld	(hl), #0x6e
	ld	hl, #(_gOptionProfondeur + 0x0006)
	ld	(hl), #0x64
	ld	hl, #(_gOptionProfondeur + 0x0007)
	ld	(hl), #0x65
	ld	hl, #(_gOptionProfondeur + 0x0008)
	ld	(hl), #0x75
	ld	hl, #(_gOptionProfondeur + 0x0009)
	ld	(hl), #0x72
	ld	hl, #(_gOptionProfondeur + 0x000a)
	ld	(hl), #0x20
	ld	hl, #(_gOptionProfondeur + 0x000b)
	ld	(hl), #0x72
	ld	hl, #(_gOptionProfondeur + 0x000c)
	ld	(hl), #0x65
	ld	hl, #(_gOptionProfondeur + 0x000d)
	ld	(hl), #0x63
	ld	hl, #(_gOptionProfondeur + 0x000e)
	ld	(hl), #0x68
	ld	hl, #(_gOptionProfondeur + 0x000f)
	ld	(hl), #0x65
	ld	hl, #(_gOptionProfondeur + 0x0010)
	ld	(hl), #0x72
	ld	hl, #(_gOptionProfondeur + 0x0011)
	ld	(hl), #0x63
	ld	hl, #(_gOptionProfondeur + 0x0012)
	ld	(hl), #0x68
	ld	hl, #(_gOptionProfondeur + 0x0013)
	ld	(hl), #0x65
	ld	hl, #(_gOptionProfondeur + 0x0014)
	ld	(hl), #0x20
	ld	hl, #(_gOptionProfondeur + 0x0015)
	ld	(hl), #0x28
	ld	hl, #(_gOptionProfondeur + 0x0016)
	ld	(hl), #0x65
	ld	hl, #(_gOptionProfondeur + 0x0017)
	ld	(hl), #0x6e
	ld	hl, #(_gOptionProfondeur + 0x0018)
	ld	(hl), #0x20
	ld	hl, #(_gOptionProfondeur + 0x0019)
	ld	(hl), #0x5c
	ld	hl, #(_gOptionProfondeur + 0x001a)
	ld	(hl), #0x63
	ld	hl, #(_gOptionProfondeur + 0x001b)
	ld	(hl), #0x6f
	ld	hl, #(_gOptionProfondeur + 0x001c)
	ld	(hl), #0x75
	ld	hl, #(_gOptionProfondeur + 0x001d)
	ld	(hl), #0x70
	ld	hl, #(_gOptionProfondeur + 0x001e)
	ld	(hl), #0x73
	ld	hl, #(_gOptionProfondeur + 0x001f)
	ld	(hl), #0x29
	ld	hl, #(_gOptionProfondeur + 0x0020)
	ld	(hl), #0x20
	ld	hl, #(_gOptionProfondeur + 0x0021)
	ld	(hl), #0x3f
	ld	hl, #(_gOptionProfondeur + 0x0022)
	ld	(hl), #0x20
	ld	hl, #(_gOptionProfondeur + 0x0023)
	ld	(hl), #0x00
;src/globals.c:12: char	gJ1[]="Joueur 1";
	ld	hl, #_gJ1
	ld	(hl), #0x4a
	ld	hl, #(_gJ1 + 0x0001)
	ld	(hl), #0x6f
	ld	hl, #(_gJ1 + 0x0002)
	ld	(hl), #0x75
	ld	hl, #(_gJ1 + 0x0003)
	ld	(hl), #0x65
	ld	hl, #(_gJ1 + 0x0004)
	ld	(hl), #0x75
	ld	hl, #(_gJ1 + 0x0005)
	ld	(hl), #0x72
	ld	hl, #(_gJ1 + 0x0006)
	ld	(hl), #0x20
	ld	hl, #(_gJ1 + 0x0007)
	ld	(hl), #0x31
	ld	hl, #(_gJ1 + 0x0008)
	ld	(hl), #0x00
;src/globals.c:13: char	gJ2[]="Joueur 2";
	ld	hl, #_gJ2
	ld	(hl), #0x4a
	ld	hl, #(_gJ2 + 0x0001)
	ld	(hl), #0x6f
	ld	hl, #(_gJ2 + 0x0002)
	ld	(hl), #0x75
	ld	hl, #(_gJ2 + 0x0003)
	ld	(hl), #0x65
	ld	hl, #(_gJ2 + 0x0004)
	ld	(hl), #0x75
	ld	hl, #(_gJ2 + 0x0005)
	ld	(hl), #0x72
	ld	hl, #(_gJ2 + 0x0006)
	ld	(hl), #0x20
	ld	hl, #(_gJ2 + 0x0007)
	ld	(hl), #0x32
	ld	hl, #(_gJ2 + 0x0008)
	ld	(hl), #0x00
;src/globals.c:14: char*	gJoueur[]={"Joueur 1","Joueur 2"};
	ld	hl, #_gJoueur
	ld	(hl), #<(___str_9)
	inc	hl
	ld	(hl), #>(___str_9)
	ld	hl, #(_gJoueur + 0x0002)
	ld	(hl), #<(___str_10)
	inc	hl
	ld	(hl), #>(___str_10)
;src/globals.c:16: char	gPositionsEvaluees[]="_valu_es";  //"positions _valu_es :      ";
	ld	hl, #_gPositionsEvaluees
	ld	(hl), #0x5f
	ld	hl, #(_gPositionsEvaluees + 0x0001)
	ld	(hl), #0x76
	ld	hl, #(_gPositionsEvaluees + 0x0002)
	ld	(hl), #0x61
	ld	hl, #(_gPositionsEvaluees + 0x0003)
	ld	(hl), #0x6c
	ld	hl, #(_gPositionsEvaluees + 0x0004)
	ld	(hl), #0x75
	ld	hl, #(_gPositionsEvaluees + 0x0005)
	ld	(hl), #0x5f
	ld	hl, #(_gPositionsEvaluees + 0x0006)
	ld	(hl), #0x65
	ld	hl, #(_gPositionsEvaluees + 0x0007)
	ld	(hl), #0x73
	ld	hl, #(_gPositionsEvaluees + 0x0008)
	ld	(hl), #0x00
;src/globals.c:23: char	gQuelleCase[]=" : quelle case jouez-vous ? ";
	ld	hl, #_gQuelleCase
	ld	(hl), #0x20
	ld	hl, #(_gQuelleCase + 0x0001)
	ld	(hl), #0x3a
	ld	hl, #(_gQuelleCase + 0x0002)
	ld	(hl), #0x20
	ld	hl, #(_gQuelleCase + 0x0003)
	ld	(hl), #0x71
	ld	hl, #(_gQuelleCase + 0x0004)
	ld	(hl), #0x75
	ld	hl, #(_gQuelleCase + 0x0005)
	ld	(hl), #0x65
	ld	hl, #(_gQuelleCase + 0x0006)
	ld	(hl), #0x6c
	ld	hl, #(_gQuelleCase + 0x0007)
	ld	(hl), #0x6c
	ld	hl, #(_gQuelleCase + 0x0008)
	ld	(hl), #0x65
	ld	hl, #(_gQuelleCase + 0x0009)
	ld	(hl), #0x20
	ld	hl, #(_gQuelleCase + 0x000a)
	ld	(hl), #0x63
	ld	hl, #(_gQuelleCase + 0x000b)
	ld	(hl), #0x61
	ld	hl, #(_gQuelleCase + 0x000c)
	ld	(hl), #0x73
	ld	hl, #(_gQuelleCase + 0x000d)
	ld	(hl), #0x65
	ld	hl, #(_gQuelleCase + 0x000e)
	ld	(hl), #0x20
	ld	hl, #(_gQuelleCase + 0x000f)
	ld	(hl), #0x6a
	ld	hl, #(_gQuelleCase + 0x0010)
	ld	(hl), #0x6f
	ld	hl, #(_gQuelleCase + 0x0011)
	ld	(hl), #0x75
	ld	hl, #(_gQuelleCase + 0x0012)
	ld	(hl), #0x65
	ld	hl, #(_gQuelleCase + 0x0013)
	ld	(hl), #0x7a
	ld	hl, #(_gQuelleCase + 0x0014)
	ld	(hl), #0x2d
	ld	hl, #(_gQuelleCase + 0x0015)
	ld	(hl), #0x76
	ld	hl, #(_gQuelleCase + 0x0016)
	ld	(hl), #0x6f
	ld	hl, #(_gQuelleCase + 0x0017)
	ld	(hl), #0x75
	ld	hl, #(_gQuelleCase + 0x0018)
	ld	(hl), #0x73
	ld	hl, #(_gQuelleCase + 0x0019)
	ld	(hl), #0x20
	ld	hl, #(_gQuelleCase + 0x001a)
	ld	(hl), #0x3f
	ld	hl, #(_gQuelleCase + 0x001b)
	ld	(hl), #0x20
	ld	hl, #(_gQuelleCase + 0x001c)
	ld	(hl), #0x00
;src/globals.c:24: char	gVainqueur[]=" vainqueur";
	ld	hl, #_gVainqueur
	ld	(hl), #0x20
	ld	hl, #(_gVainqueur + 0x0001)
	ld	(hl), #0x76
	ld	hl, #(_gVainqueur + 0x0002)
	ld	(hl), #0x61
	ld	hl, #(_gVainqueur + 0x0003)
	ld	(hl), #0x69
	ld	hl, #(_gVainqueur + 0x0004)
	ld	(hl), #0x6e
	ld	hl, #(_gVainqueur + 0x0005)
	ld	(hl), #0x71
	ld	hl, #(_gVainqueur + 0x0006)
	ld	(hl), #0x75
	ld	hl, #(_gVainqueur + 0x0007)
	ld	(hl), #0x65
	ld	hl, #(_gVainqueur + 0x0008)
	ld	(hl), #0x75
	ld	hl, #(_gVainqueur + 0x0009)
	ld	(hl), #0x72
	ld	hl, #(_gVainqueur + 0x000a)
	ld	(hl), #0x00
;src/globals.c:25: char	gEgalite[]="Egalit_";
	ld	hl, #_gEgalite
	ld	(hl), #0x45
	ld	hl, #(_gEgalite + 0x0001)
	ld	(hl), #0x67
	ld	hl, #(_gEgalite + 0x0002)
	ld	(hl), #0x61
	ld	hl, #(_gEgalite + 0x0003)
	ld	(hl), #0x6c
	ld	hl, #(_gEgalite + 0x0004)
	ld	(hl), #0x69
	ld	hl, #(_gEgalite + 0x0005)
	ld	(hl), #0x74
	ld	hl, #(_gEgalite + 0x0006)
	ld	(hl), #0x5f
	ld	hl, #(_gEgalite + 0x0007)
	ld	(hl), #0x00
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
	.area _CODE
___str_0:
	.ascii "1 : Humain vs Humain"
	.db 0x00
___str_1:
	.ascii "2 : Humain vs Ordinateur"
	.db 0x00
___str_2:
	.ascii "3 : Ordinateur vs Ordinateur"
	.db 0x00
___str_9:
	.ascii "Joueur 1"
	.db 0x00
___str_10:
	.ascii "Joueur 2"
	.db 0x00
	.area _CABS (ABS)
