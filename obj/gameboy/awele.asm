;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.7 #12016 (Mac OS X x86_64)
;--------------------------------------------------------
	.module awele
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _initPlateau
	.globl _affPlateau
	.globl _initJoystick
	.globl _choixJoueur
	.globl _effacerAttente
	.globl _afficherAttente
	.globl _afficherPosEval
	.globl _afficherResultats
	.globl _menuOptions
	.globl _alphabeta
	.globl _jouer
	.globl _jeuPoss
	.globl _j
	.globl _tab
	.globl _prof
	.globl _jeu
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_jeu::
	.ds 18
_prof::
	.ds 2
_tab::
	.ds 20
_j::
	.ds 2
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
;src/awele.c:22: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-4
;src/awele.c:27: BOOL b, fin = FALSE;
	xor	a, a
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), a
;src/awele.c:28: posEval = 0;
	ld	hl, #_posEval
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;src/awele.c:31: initJoystick();    
	call	_initJoystick
;src/awele.c:32: initPlateau();
	call	_initPlateau
;src/awele.c:34: for(i=0;i<NCASES;i++)
	ld	c, #0x00
00115$:
;src/awele.c:35: jeu[NCASES+1+i] = jeu[i] = NGRAINS;
	ld	a, c
	add	a, #0x09
	ld	e, a
	rla
	sbc	a, a
	ld	d, a
	ld	hl, #_jeu
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #_jeu
	ld	b, #0x00
	add	hl, bc
	ld	a,#0x04
	ld	(hl),a
	ld	(de), a
;src/awele.c:34: for(i=0;i<NCASES;i++)
	inc	c
	ld	a, c
	sub	a, #0x08
	jr	C, 00115$
;src/awele.c:37: jeu[KALAH2] = jeu[KALAH1] = 0;
	ld	hl, #(_jeu + 0x0008)
	ld	(hl), #0x00
	ld	hl, #(_jeu + 0x0011)
	ld	(hl), #0x00
;src/awele.c:39: i=menuOptions(); 
	call	_menuOptions
	ldhl	sp,	#0
	ld	(hl), e
;src/awele.c:41: affPlateau(jeu);
	ld	hl, #_jeu
	push	hl
	call	_affPlateau
	add	sp, #2
;src/awele.c:43: while( !fin )
00112$:
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jp	NZ, 00114$
;src/awele.c:45: if(jeuPoss(jeu, i))
	dec	hl
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_jeu
	push	hl
	call	_jeuPoss
	add	sp, #3
	ld	c, e
;src/awele.c:59: afficherAttente(i+1,tab[c]);
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl), a
;src/awele.c:45: if(jeuPoss(jeu, i))
	ld	a, c
	or	a, a
	jp	Z, 00110$
;src/awele.c:48: if( j[i] )
;c
	ld	de, #_j
	dec	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, (hl)
;src/awele.c:59: afficherAttente(i+1,tab[c]);
	ldhl	sp,	#1
	ld	a, (hl)
	inc	a
	inc	hl
	ld	(hl), a
;src/awele.c:48: if( j[i] )
	ld	a, c
	or	a, a
	jp	Z, 00103$
;src/awele.c:51: posEval=0;
	ld	hl, #_posEval
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;src/awele.c:52: afficherPosEval();
	call	_afficherPosEval
;src/awele.c:53: alphabeta(jeu, MOINS_INFINI, PLUS_INFINI, i, prof[i], 0, tab);
	ld	bc, #_tab
;c
	ld	de, #_prof
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	bc
	ld	h, #0x00
	push	hl
	inc	sp
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #0x03e8
	push	hl
	ld	hl, #0xfc18
	push	hl
	ld	hl, #_jeu
	push	hl
	call	_alphabeta
	add	sp, #11
;src/awele.c:54: afficherPosEval();
	call	_afficherPosEval
;src/awele.c:55: for(c=0,b=1;b;c++)
	ld	de, #0x0001
	xor	a, a
	ldhl	sp,	#3
	ld	(hl), a
00118$:
	ld	a, d
	or	a, e
	jr	Z, 00108$
;src/awele.c:57: b = jouer(jeu, jeu, tab[c], i);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	rla
	sbc	a, a
	ld	b, a
	pop	af
	add	a, #<(_tab)
	ld	c, a
	ld	a, b
	adc	a, #>(_tab)
	ld	b, a
	ld	a, (bc)
	push	bc
	ldhl	sp,	#2
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	ld	hl, #_jeu
	push	hl
	push	hl
	call	_jouer
	add	sp, #6
	pop	bc
	ld	a, e
	rla
	sbc	a, a
	ld	d, a
;src/awele.c:58: affPlateau(jeu);
	push	bc
	push	de
	ld	hl, #_jeu
	push	hl
	call	_affPlateau
	add	sp, #2
	pop	de
	pop	bc
;src/awele.c:59: afficherAttente(i+1,tab[c]);
	ld	a, (bc)
	push	de
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	_afficherAttente
	add	sp, #2
	call	_effacerAttente
	pop	de
;src/awele.c:55: for(c=0,b=1;b;c++)
	ldhl	sp,	#3
	inc	(hl)
	jr	00118$
;src/awele.c:66: do
00103$:
;src/awele.c:68: c = choixJoueur(i);
	ldhl	sp,	#0
	ld	a, (hl)
	push	af
	inc	sp
	call	_choixJoueur
	inc	sp
	ld	a, e
;src/awele.c:69: b = jouer(jeu, jeu, c, i);
	ldhl	sp,	#0
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	ld	hl, #_jeu
	push	hl
	push	hl
	call	_jouer
	add	sp, #6
	ld	a, e
	rla
	sbc	a, a
	ld	d, a
;src/awele.c:70: affPlateau(jeu);
	push	de
	ld	hl, #_jeu
	push	hl
	call	_affPlateau
	add	sp, #2
	pop	de
;src/awele.c:71: } while(b);
	ld	a, d
	or	a, e
	jr	NZ, 00103$
00108$:
;src/awele.c:74: fin = (jeu[(i+1)*NCASES+i] > NCASES*NGRAINS);
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	dec	hl
	add	a, (hl)
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #_jeu
	add	hl, bc
	ld	c, (hl)
	ld	a, #0x20
	sub	a, c
	ld	a, #0x00
	rla
	ldhl	sp,	#2
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	jr	00111$
00110$:
;src/awele.c:77: fin = TRUE;
	ldhl	sp,	#2
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl), a
00111$:
;src/awele.c:79: i=1-i;
	ld	a, #0x01
	ldhl	sp,	#1
	sub	a, (hl)
	dec	hl
	ld	(hl), a
	jp	00112$
00114$:
;src/awele.c:82: afficherResultats(jeu[KALAH1],jeu[KALAH2]);
	ld	a, (#(_jeu + 0x0011) + 0)
	ld	hl, #(_jeu + 0x0008)
	ld	b, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_afficherResultats
	add	sp, #2
;src/awele.c:85: }
	add	sp, #4
	ret
	.area _CODE
	.area _CABS (ABS)
