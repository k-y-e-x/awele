;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.7 #12016 (Mac OS X x86_64)
;--------------------------------------------------------
	.module aweleia
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _posEval
	.globl _jeuPoss
	.globl _jouer
	.globl _alphabeta
	.globl _minmax
	.globl _maxmin
	.globl _eval
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_posEval::
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
;src/aweleia.c:15: UWORD posEval = 0;
	ld	hl, #_posEval
	ld	(hl), #0x00
	inc	hl
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
;src/aweleia.c:22: BOOLEAN jeuPoss(UBYTE *p,UBYTE j)
;	---------------------------------
; Function jeuPoss
; ---------------------------------
_jeuPoss::
	add	sp, #-4
;src/aweleia.c:24: register UBYTE i, b=FALSE;
	xor	a, a
	ldhl	sp,	#2
	ld	(hl), a
;src/aweleia.c:26: for( i=j*(NCASES+1); i<(j+1)*NCASES+j; b|=p[i++] );
	ldhl	sp,	#8
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#3
	ld	(hl), a
00103$:
	ldhl	sp,	#8
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00118$
	bit	7, d
	jr	NZ, 00119$
	cp	a, a
	jr	00119$
00118$:
	bit	7, d
	jr	Z, 00119$
	scf
00119$:
	jr	NC, 00101$
;c
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#3
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#3
	inc	(hl)
	ld	a, (bc)
	dec	hl
	or	a, (hl)
	ld	(hl), a
	jr	00103$
00101$:
;src/aweleia.c:28: return(b);
	ldhl	sp,	#2
	ld	e, (hl)
;src/aweleia.c:29: }
	add	sp, #4
	ret
;src/aweleia.c:38: BOOLEAN jouer(UBYTE *p,UBYTE *pi,UBYTE c,UBYTE j)
;	---------------------------------
; Function jouer
; ---------------------------------
_jouer::
	add	sp, #-13
;src/aweleia.c:43: */ n  = pi[c];
;c
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#11
	ld	(hl), a
;src/aweleia.c:44: xi = (c+n)%LGPLAT;
	ldhl	sp,	#19
	ld	a, (hl)
	ld	e, #0x00
	ldhl	sp,	#11
	ld	c, (hl)
	ld	b, #0x00
	ld	l, a
	ld	h, e
	add	hl, bc
	inc	sp
	inc	sp
	push	hl
	ld	hl, #0x0012
	ld	c, l
	ld	b, h
	pop	hl
	push	hl
	push	bc
	push	hl
	call	__modsint
	add	sp, #4
	ldhl	sp,	#2
	ld	(hl), e
;src/aweleia.c:45: x = (xi>=j*(NCASES+1)) && (xi<(j+1)*NCASES+j) && !pi[xi];
	ldhl	sp,	#20
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#20
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
;c
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00178$
	bit	7, d
	jr	NZ, 00179$
	cp	a, a
	jr	00179$
00178$:
	bit	7, d
	jr	Z, 00179$
	scf
00179$:
	jr	C, 00117$
	ldhl	sp,	#3
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00180$
	bit	7, d
	jr	NZ, 00181$
	cp	a, a
	jr	00181$
00180$:
	bit	7, d
	jr	Z, 00181$
	scf
00181$:
	jr	NC, 00117$
;c
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00118$
00117$:
	xor	a, a
	jr	00119$
00118$:
	ld	a, #0x01
00119$:
	ldhl	sp,	#7
	ld	(hl), a
;src/aweleia.c:47: for( i=0; i<c; ++i )
	xor	a, a
	ldhl	sp,	#12
	ld	(hl), a
00107$:
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#19
	sub	a, (hl)
	jr	NC, 00101$
;src/aweleia.c:48: p[i]=pi[i];
;c
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
;c
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(bc), a
;src/aweleia.c:47: for( i=0; i<c; ++i )
	ldhl	sp,	#12
	inc	(hl)
	jr	00107$
00101$:
;src/aweleia.c:50: p[c]=0;
;c
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/aweleia.c:52: for( i=c+1; i<=c+n; ++i )
	ldhl	sp,	#19
	ld	a, (hl)
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
00110$:
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00182$
	bit	7, d
	jr	NZ, 00183$
	cp	a, a
	jr	00183$
00182$:
	bit	7, d
	jr	Z, 00183$
	scf
00183$:
	jr	C, 00102$
;src/aweleia.c:53: p[i%LGPLAT]=pi[i%LGPLAT]+1;
	ld	a, #0x12
	push	af
	inc	sp
	ldhl	sp,	#13
	ld	a, (hl)
	push	af
	inc	sp
	call	__moduchar
	add	sp, #2
	push	de
;b
	ld	d, #0x00
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
;b
	ld	d, #0x00
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	inc	a
	ld	(bc), a
;src/aweleia.c:52: for( i=c+1; i<=c+n; ++i )
	ldhl	sp,	#12
	inc	(hl)
	jr	00110$
00102$:
;src/aweleia.c:55: for( i=c+n+1; i<LGPLAT; ++i )
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#19
	add	a, (hl)
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
00113$:
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x12
	jr	NC, 00103$
;src/aweleia.c:56: p[i]=pi[i];
;c
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;c
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;src/aweleia.c:55: for( i=c+n+1; i<LGPLAT; ++i )
	ldhl	sp,	#12
	inc	(hl)
	jr	00113$
00103$:
;src/aweleia.c:59: if( x )
	ldhl	sp,	#7
	ld	a, (hl)
	or	a, a
	jr	Z, 00105$
;src/aweleia.c:61: p[(j+1)*NCASES+j] += p[2*NCASES-xi]+1;
;c
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#10
	ld	(hl), a
	ld	de, #0x0010
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#12
	ld	(hl-), a
;c
	ld	a, e
	ld	(hl+), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#15
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	inc	a
	ldhl	sp,	#10
	ld	l, (hl)
	add	a, l
	ld	(bc), a
;src/aweleia.c:62: p[2*NCASES-xi] = p[xi] = 0;
	push	de
;c
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#4
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	xor	a, a
	ld	(de), a
00105$:
;src/aweleia.c:65: return( ((c+n)==((j+1)*NCASES+j)) && jeuPoss(p,j) );
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#5
	sub	a, (hl)
	jr	NZ, 00123$
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#6
	sub	a, (hl)
	jr	NZ, 00123$
	ldhl	sp,	#20
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_jeuPoss
	add	sp, #3
	ld	a, e
	or	a, a
	jr	NZ, 00124$
00123$:
	ld	e, #0x00
	jr	00125$
00124$:
	ld	e, #0x01
00125$:
;src/aweleia.c:67: }
	add	sp, #13
	ret
;src/aweleia.c:82: WORD alphabeta(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf, UBYTE n, UBYTE *res)
;	---------------------------------
; Function alphabeta
; ---------------------------------
_alphabeta::
	add	sp, #-32
;src/aweleia.c:102: jp=0;
	xor	a, a
	ldhl	sp,	#30
	ld	(hl), a
;src/aweleia.c:103: for( i=j*(NCASES+1); (i<(j+1)*NCASES+j) && (alpha<beta); i++)
	ldhl	sp,	#40
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#31
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#18
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
	ldhl	sp,	#18
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#22
	ld	(hl+), a
	ld	(hl), e
00115$:
	ldhl	sp,	#40
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	xor	a, a
	inc	hl
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl), a
	ld	a, #0x03
00160$:
	ldhl	sp,	#28
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00160$
;c
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#26
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#25
	ld	(hl), a
	ldhl	sp,	#31
	ld	a, (hl)
	ldhl	sp,	#26
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/aweleia.c:114: res[n]=i;
;c
	ldhl	sp,#43
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#30
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#29
	ld	(hl), a
;src/aweleia.c:103: for( i=j*(NCASES+1); (i<(j+1)*NCASES+j) && (alpha<beta); i++)
	ldhl	sp,	#26
	ld	e, l
	ld	d, h
	ldhl	sp,	#24
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00161$
	bit	7, d
	jr	NZ, 00162$
	cp	a, a
	jr	00162$
00161$:
	bit	7, d
	jr	Z, 00162$
	scf
00162$:
	jp	NC, 00110$
	ldhl	sp,	#36
	ld	e, l
	ld	d, h
	ldhl	sp,	#38
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00163$
	bit	7, d
	jr	NZ, 00164$
	cp	a, a
	jr	00164$
00163$:
	bit	7, d
	jr	Z, 00164$
	scf
00164$:
	jp	NC, 00110$
;src/aweleia.c:105: jp |= p[i];
;c
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#31
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	push	af
	ldhl	sp,	#32
	or	a, (hl)
	ld	(hl), a
	pop	af
;src/aweleia.c:107: if(p[i])
	or	a, a
	jp	Z, 00116$
;src/aweleia.c:108: if(jouer(np, p, i, j))
	ldhl	sp,#18
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#40
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#32
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#36
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	_jouer
	add	sp, #6
	ld	a, e
	or	a, a
	jr	Z, 00106$
;src/aweleia.c:110: a=alphabeta(np, alpha, beta, j, prf, n+1, res);
	ldhl	sp,	#42
	ld	b, (hl)
	inc	b
	ldhl	sp,#22
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	inc	sp
	ldhl	sp,	#44
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#43
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	de
	call	_alphabeta
	add	sp, #11
	ld	c, e
	ld	b, d
;src/aweleia.c:111: if( a>alpha )
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00165$
	bit	7, d
	jr	NZ, 00166$
	cp	a, a
	jr	00166$
00165$:
	bit	7, d
	jr	Z, 00166$
	scf
00166$:
	jr	NC, 00116$
;src/aweleia.c:113: alpha=a;
	ldhl	sp,	#36
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/aweleia.c:114: res[n]=i;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	hl
	ld	a, (hl)
	ld	(de), a
	jr	00116$
00106$:
;src/aweleia.c:119: a=minmax(np, alpha, beta, j, prf-1);
	ldhl	sp,	#41
	ld	a, (hl)
	dec	a
	ldhl	sp,#20
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	af
	inc	sp
	ldhl	sp,	#41
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#40
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	_minmax
	add	sp, #8
	ld	c, e
	ld	b, d
;src/aweleia.c:120: if( a>alpha )
	ldhl	sp,	#36
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00167$
	bit	7, d
	jr	NZ, 00168$
	cp	a, a
	jr	00168$
00167$:
	bit	7, d
	jr	Z, 00168$
	scf
00168$:
	jr	NC, 00116$
;src/aweleia.c:122: alpha=a;
	ldhl	sp,	#36
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/aweleia.c:123: res[n]=i;
	ldhl	sp,#28
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	hl
	ld	a, (hl)
	ld	(de), a
00116$:
;src/aweleia.c:103: for( i=j*(NCASES+1); (i<(j+1)*NCASES+j) && (alpha<beta); i++)
	ldhl	sp,	#31
	inc	(hl)
	jp	00115$
00110$:
;src/aweleia.c:150: if(!jp)
	ldhl	sp,	#30
	ld	a, (hl)
	or	a, a
	jr	NZ, 00112$
;src/aweleia.c:154: res[n]=i;
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	inc	hl
	ld	a, (hl)
	ld	(de), a
;src/aweleia.c:155: return( eval(p, j) );
	ldhl	sp,	#40
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_eval
	add	sp, #3
	jr	00117$
00112$:
;src/aweleia.c:158: return( alpha );
	ldhl	sp,#36
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00117$:
;src/aweleia.c:159: }
	add	sp, #32
	ret
;src/aweleia.c:162: WORD minmax(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf)
;	---------------------------------
; Function minmax
; ---------------------------------
_minmax::
	add	sp, #-31
;src/aweleia.c:164: register UBYTE np[LGPLAT], i, jp=0, jo;
	xor	a, a
	ldhl	sp,	#29
	ld	(hl), a
;src/aweleia.c:166: if(prf<=0)
	ldhl	sp,	#40
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;src/aweleia.c:167: return( eval(p,j) );
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_eval
	add	sp, #3
	jp	00115$
00102$:
;src/aweleia.c:169: jo=1-j;
	ldhl	sp,	#39
	ld	c, (hl)
	ld	a, #0x01
	sub	a, c
	ldhl	sp,	#18
;src/aweleia.c:171: for( i=jo*(NCASES+1); (i<(jo+1)*NCASES+jo) && (alpha<beta); i++)
	ld	(hl), a
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#30
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#19
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
00113$:
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#23
	ld	(hl), a
	xor	a, a
	inc	hl
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#28
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, #0x03
00167$:
	ldhl	sp,	#25
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00167$
;c
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#23
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#29
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#28
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#25
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#25
	ld	e, l
	ld	d, h
	ldhl	sp,	#27
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00168$
	bit	7, d
	jr	NZ, 00169$
	cp	a, a
	jr	00169$
00168$:
	bit	7, d
	jr	Z, 00169$
	scf
00169$:
	jp	NC, 00108$
	ldhl	sp,	#35
	ld	e, l
	ld	d, h
	ldhl	sp,	#37
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00170$
	bit	7, d
	jr	NZ, 00171$
	cp	a, a
	jr	00171$
00170$:
	bit	7, d
	jr	Z, 00171$
	scf
00171$:
	jp	NC, 00108$
;src/aweleia.c:173: jp |= p[i];
;c
	ldhl	sp,#33
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#30
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	push	af
	ldhl	sp,	#31
	or	a, (hl)
	ld	(hl), a
	pop	af
;src/aweleia.c:174: if( p[i] )
	or	a, a
	jp	Z, 00114$
;src/aweleia.c:175: if( jouer(np, p, i, jo) )
	ldhl	sp,#19
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#31
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#35
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	_jouer
	add	sp, #6
	ld	c, e
;src/aweleia.c:178: beta = MIN(b, beta);
	ldhl	sp,	#37
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#27
	ld	(hl+), a
	ld	(hl), e
;src/aweleia.c:175: if( jouer(np, p, i, jo) )
	ld	a, c
	or	a, a
	jr	Z, 00104$
;src/aweleia.c:177: b = minmax(np, alpha, beta, j, prf);
	ldhl	sp,#19
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#40
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#39
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	_minmax
	add	sp, #8
	ld	c, e
	ld	b, d
;src/aweleia.c:178: beta = MIN(b, beta);
	ldhl	sp,	#37
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00172$
	bit	7, d
	jr	NZ, 00173$
	cp	a, a
	jr	00173$
00172$:
	bit	7, d
	jr	Z, 00173$
	scf
00173$:
	jr	NC, 00117$
	ldhl	sp,	#27
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00117$:
	ldhl	sp,	#27
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#37
	ld	(hl+), a
	ld	(hl), e
	jr	00114$
00104$:
;src/aweleia.c:182: b = maxmin(np, alpha, beta, j, prf-1);
	ldhl	sp,	#40
	ld	a, (hl)
	dec	a
	ldhl	sp,#21
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	af
	inc	sp
	ldhl	sp,	#40
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#39
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	_maxmin
	add	sp, #8
	ld	c, e
	ld	b, d
;src/aweleia.c:183: beta = MIN(b, beta);
	ldhl	sp,	#37
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00174$
	bit	7, d
	jr	NZ, 00175$
	cp	a, a
	jr	00175$
00174$:
	bit	7, d
	jr	Z, 00175$
	scf
00175$:
	jr	C, 00120$
	ldhl	sp,#27
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00120$:
	ldhl	sp,	#37
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00114$:
;src/aweleia.c:171: for( i=jo*(NCASES+1); (i<(jo+1)*NCASES+jo) && (alpha<beta); i++)
	ldhl	sp,	#30
	inc	(hl)
	jp	00113$
00108$:
;src/aweleia.c:187: if( !jp )
	ldhl	sp,	#29
	ld	a, (hl)
	or	a, a
	jr	NZ, 00110$
;src/aweleia.c:188: return( eval(p, j) );
	ldhl	sp,	#39
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_eval
	add	sp, #3
	jr	00115$
00110$:
;src/aweleia.c:190: return( beta );
	ldhl	sp,#37
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00115$:
;src/aweleia.c:191: }
	add	sp, #31
	ret
;src/aweleia.c:194: WORD maxmin(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf)
;	---------------------------------
; Function maxmin
; ---------------------------------
_maxmin::
	add	sp, #-30
;src/aweleia.c:196: register UBYTE np[LGPLAT], i, jp=0;
	xor	a, a
	ldhl	sp,	#28
	ld	(hl), a
;src/aweleia.c:198: if(prf<=0)
	ldhl	sp,	#39
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;src/aweleia.c:199: return( eval(p,j) );
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_eval
	add	sp, #3
	jp	00115$
00102$:
;src/aweleia.c:201: for( i=j*(NCASES+1); (i<(j+1)*NCASES+j) && (alpha<beta); i++)
	ldhl	sp,	#38
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#29
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#18
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	(hl+), a
	ld	(hl), e
00113$:
	ldhl	sp,	#38
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	xor	a, a
	inc	hl
;c
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#27
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, #0x03
00167$:
	ldhl	sp,	#24
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00167$
;c
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#28
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#27
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#24
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	ldhl	sp,	#24
	ld	e, l
	ld	d, h
	ldhl	sp,	#26
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00168$
	bit	7, d
	jr	NZ, 00169$
	cp	a, a
	jr	00169$
00168$:
	bit	7, d
	jr	Z, 00169$
	scf
00169$:
	jp	NC, 00108$
	ldhl	sp,	#34
	ld	e, l
	ld	d, h
	ldhl	sp,	#36
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00170$
	bit	7, d
	jr	NZ, 00171$
	cp	a, a
	jr	00171$
00170$:
	bit	7, d
	jr	Z, 00171$
	scf
00171$:
	jp	NC, 00108$
;src/aweleia.c:203: jp |= p[i];
;c
	ldhl	sp,#32
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#29
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	push	af
	ldhl	sp,	#30
	or	a, (hl)
	ld	(hl), a
	pop	af
;src/aweleia.c:204: if( p[i] )
	or	a, a
	jp	Z, 00114$
;src/aweleia.c:205: if( jouer(np, p, i, j) )
	ldhl	sp,#18
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#38
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#30
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	_jouer
	add	sp, #6
	ld	c, e
;src/aweleia.c:208: alpha = MAX(a, alpha);
	ldhl	sp,	#34
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#26
	ld	(hl+), a
	ld	(hl), e
;src/aweleia.c:205: if( jouer(np, p, i, j) )
	ld	a, c
	or	a, a
	jr	Z, 00104$
;src/aweleia.c:207: a = maxmin(np, alpha, beta, j, prf);
	ldhl	sp,#18
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#39
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#38
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	_maxmin
	add	sp, #8
	ld	c, e
	ld	b, d
;src/aweleia.c:208: alpha = MAX(a, alpha);
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00172$
	bit	7, d
	jr	NZ, 00173$
	cp	a, a
	jr	00173$
00172$:
	bit	7, d
	jr	Z, 00173$
	scf
00173$:
	jr	NC, 00117$
	ldhl	sp,	#26
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00117$:
	ldhl	sp,	#26
	ld	a, (hl+)
	ld	e, (hl)
	ldhl	sp,	#34
	ld	(hl+), a
	ld	(hl), e
	jr	00114$
00104$:
;src/aweleia.c:212: a = minmax(np, alpha, beta, j, prf-1);
	ldhl	sp,	#39
	ld	a, (hl)
	dec	a
	ldhl	sp,#20
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	af
	inc	sp
	ldhl	sp,	#39
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ldhl	sp,	#38
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	push	bc
	call	_minmax
	add	sp, #8
	ld	c, e
	ld	b, d
;src/aweleia.c:213: alpha = MAX(a, alpha);
	ldhl	sp,	#34
	ld	a, (hl)
	sub	a, c
	inc	hl
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00174$
	bit	7, d
	jr	NZ, 00175$
	cp	a, a
	jr	00175$
00174$:
	bit	7, d
	jr	Z, 00175$
	scf
00175$:
	jr	C, 00120$
	ldhl	sp,#26
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
00120$:
	ldhl	sp,	#34
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00114$:
;src/aweleia.c:201: for( i=j*(NCASES+1); (i<(j+1)*NCASES+j) && (alpha<beta); i++)
	ldhl	sp,	#29
	inc	(hl)
	jp	00113$
00108$:
;src/aweleia.c:217: if( !jp )
	ldhl	sp,	#28
	ld	a, (hl)
	or	a, a
	jr	NZ, 00110$
;src/aweleia.c:218: return( eval(p, j) );
	ldhl	sp,	#38
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#33
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_eval
	add	sp, #3
	jr	00115$
00110$:
;src/aweleia.c:220: return( alpha );
	ldhl	sp,#34
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00115$:
;src/aweleia.c:221: }
	add	sp, #30
	ret
;src/aweleia.c:224: WORD eval(UBYTE *p, UBYTE j)
;	---------------------------------
; Function eval
; ---------------------------------
_eval::
	add	sp, #-2
;src/aweleia.c:226: ++posEval; 
	ld	hl, #_posEval
	inc	(hl)
	jr	NZ, 00103$
	inc	hl
	inc	(hl)
00103$:
;src/aweleia.c:227: return( (1-2*j)*(p[KALAH1]-p[KALAH2]) );
	ldhl	sp,	#6
	ld	c, (hl)
	ld	b, #0x00
	sla	c
	rl	b
	ld	de, #0x0001
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
;c
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
;c
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	d, #0x00
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
	push	bc
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	__mulint
	add	sp, #4
;src/aweleia.c:228: }
	add	sp, #2
	ret
	.area _CODE
	.area _CABS (ABS)
