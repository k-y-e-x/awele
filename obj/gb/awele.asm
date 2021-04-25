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
	.globl _initPartie
	.globl _choixJoueur
	.globl _initPlateau
	.globl _afficherPlateau
	.globl _initJoystick
	.globl _effacerAttente
	.globl _afficherAttente
	.globl _afficherPosEval
	.globl _afficherResultats
	.globl _menuOptions
	.globl _alphabeta
	.globl _jouer
	.globl _jeuPoss
	.globl _temp
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
_temp::
	.ds 64
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
;src/awele.c:11: void initPartie(void)
;	---------------------------------
; Function initPartie
; ---------------------------------
_initPartie::
;src/awele.c:15: posEval = 0;
	ld	hl, #_posEval
	ld	a, #0x00
	ld	(hl+), a
	ld	(hl), #0x00
;src/awele.c:16: for(i=0;i<NCASES;i++)
	ld	c, #0x00
00102$:
;src/awele.c:17: jeu[NCASES+1+i] = jeu[i] = NGRAINS;
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
;src/awele.c:16: for(i=0;i<NCASES;i++)
	inc	c
	ld	a, c
	sub	a, #0x08
	jr	C, 00102$
;src/awele.c:18: jeu[KALAH2] = jeu[KALAH1] = 0;
	ld	hl, #(_jeu + 0x0008)
	ld	(hl), #0x00
	ld	hl, #(_jeu + 0x0011)
	ld	(hl), #0x00
;src/awele.c:19: prof[0]=prof[1]=1;
	ld	hl, #(_prof + 0x0001)
	ld	(hl), #0x01
	ld	hl, #_prof
	ld	(hl), #0x01
;src/awele.c:20: j[0]=0;j[1]=1;
	ld	bc, #_j+0
	xor	a, a
	ld	(bc), a
	inc	bc
	ld	a, #0x01
	ld	(bc), a
;src/awele.c:27: }
	ret
;src/awele.c:29: void main (void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-10
;src/awele.c:33: BOOLEAN b=TRUE, rejoue = TRUE;
	ldhl	sp,	#2
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl), a
;src/awele.c:35: initJoystick(); 
	call	_initJoystick
;src/awele.c:36: initPlateau();
	call	_initPlateau
;src/awele.c:38: do
00120$:
;src/awele.c:40: initPartie();
	call	_initPartie
;src/awele.c:41: afficherPlateau(jeu);
	ld	hl, #_jeu
	push	hl
	call	_afficherPlateau
	add	sp, #2
;src/awele.c:42: i=menuOptions(0); 
	xor	a, a
	push	af
	inc	sp
	call	_menuOptions
	inc	sp
	ldhl	sp,	#4
	ld	(hl), e
;src/awele.c:43: afficherPlateau(jeu);
	ld	hl, #_jeu
	push	hl
	call	_afficherPlateau
	add	sp, #2
;src/awele.c:46: do
00117$:
;src/awele.c:48: if( j[i] )
;c
	ld	de, #_j
	ldhl	sp,	#4
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	c, a
;src/awele.c:58: afficherAttente(i+1,tab[c]);
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	(hl), a
;src/awele.c:65: i=1-i;	// pour sortir et ne pas changer i
	ld	a, #0x01
	sub	a, (hl)
	inc	hl
	ld	(hl), a
;src/awele.c:48: if( j[i] )
	ld	a, c
	or	a, a
	jp	Z, 00135$
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
	ldhl	sp,	#4
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
	ldhl	sp,	#8
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
	ldhl	sp,	#2
	ld	(hl), #0x01
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), e
	xor	a, a
	inc	hl
	ld	(hl), a
00124$:
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jp	Z, 00115$
;src/awele.c:57: b = jouer(jeu, jeu, tab[c], i);
;c
	ld	de, #_tab
	ldhl	sp,	#9
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	push	bc
	ldhl	sp,	#6
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
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/awele.c:58: afficherAttente(i+1,tab[c]);
	ld	a, (bc)
	inc	hl
	inc	hl
	ld	b, (hl)
	inc	b
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_afficherAttente
	add	sp, #2
;src/awele.c:59: effacerAttente();
	call	_effacerAttente
;src/awele.c:60: afficherPlateau(jeu);
	ld	hl, #_jeu
	push	hl
	call	_afficherPlateau
	add	sp, #2
;src/awele.c:61: if(j[i]==0)	// on a changé d'ordi vers joueur
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00125$
;src/awele.c:63: if(b)	// si le joueur en cours peut encore jouer on garde la main
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00115$
;src/awele.c:65: i=1-i;	// pour sortir et ne pas changer i
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/awele.c:67: break;
	jr	00115$
00125$:
;src/awele.c:55: for(c=0,b=1;b;c++)
	ldhl	sp,	#9
	inc	(hl)
	jr	00124$
;src/awele.c:74: do
00135$:
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), e
00110$:
;src/awele.c:76: c = choixJoueur(i);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	call	_choixJoueur
	inc	sp
	ld	c, e
;src/awele.c:77: if(j[i]==1)	// on a changé de joueur vers ordi
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00107$
;src/awele.c:79: i=1-i;	// pour sortir et ne pas changer i
	ldhl	sp,	#6
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
;src/awele.c:81: break;
	jr	00115$
00107$:
;src/awele.c:83: if(c==99)	continue;
	ld	a, c
	sub	a, #0x63
	jr	Z, 00111$
;src/awele.c:84: b = jouer(jeu, jeu, c, i);
	ldhl	sp,	#4
	ld	b, (hl)
	push	bc
	ld	hl, #_jeu
	push	hl
	push	hl
	call	_jouer
	add	sp, #6
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/awele.c:85: afficherPlateau(jeu);
	ld	hl, #_jeu
	push	hl
	call	_afficherPlateau
	add	sp, #2
00111$:
;src/awele.c:86: } while(b);
	ldhl	sp,	#3
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00110$
00115$:
;src/awele.c:89: i=1-i;
	ldhl	sp,	#4
	ld	c, (hl)
	ld	a, #0x01
	sub	a, c
	ld	(hl), a
;src/awele.c:90: } while((jeu[(2-i)*NCASES+1-i] <= NCASES*NGRAINS) &&  jeuPoss(jeu, i));
	ld	c, (hl)
	ld	a, #0x02
	sub	a, c
	add	a, a
	add	a, a
	add	a, a
	inc	a
	sub	a, c
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #_jeu
	add	hl, bc
	ld	c, (hl)
	ld	a, #0x20
	sub	a, c
	jr	C, 00119$
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ld	hl, #_jeu
	push	hl
	call	_jeuPoss
	add	sp, #3
	ld	c, e
	ld	a, d
	or	a, c
	jp	NZ, 00117$
00119$:
;src/awele.c:91: rejoue = afficherResultats(jeu[KALAH1],jeu[KALAH2]);
	ld	hl, #(_jeu + 0x0011)
	ld	b, (hl)
	ld	a, (#(_jeu + 0x0008) + 0)
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_afficherResultats
	add	sp, #2
;src/awele.c:92: } while(rejoue);
	ld	a, d
	or	a, e
	jp	NZ, 00120$
;src/awele.c:93: }
	add	sp, #10
	ret
	.area _CODE
	.area _CABS (ABS)
