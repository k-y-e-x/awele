;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.7 #12016 (Mac OS X x86_64)
;--------------------------------------------------------
	.module awele_gb
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _boitePlateau
	.globl _gbtbcar
	.globl _clrscr
	.globl _effaceChr
	.globl _effaceLigne
	.globl _revers
	.globl _printxy
	.globl _gbglobals
	.globl _color
	.globl _gotogxy
	.globl _wrtchr
	.globl _box
	.globl _gprintf
	.globl _gprintln
	.globl _gprint
	.globl _waitpadup
	.globl _waitpad
	.globl _joypad
	.globl _exit
	.globl _initJoystick
	.globl _initPlateau
	.globl _getkj
	.globl _menuOptions
	.globl _afficherPlateau
	.globl _afficherResultats
	.globl _afficherPosEval
	.globl _afficherAttente
	.globl _effacerAttente
	.globl _choixJoueur
	.globl _dbgprint
	.globl _afficherRegles
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
;src/gb/awele_gb.c:36: void printxy(UBYTE x, UBYTE y, BOOLEAN rv, STRPTR s)
;	---------------------------------
; Function printxy
; ---------------------------------
_printxy::
;src/gb/awele_gb.c:38: gotogxy(x,y);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	dec	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:39: if(rv)	color(WHITE, DKGREY, SOLID);
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
	jr	00103$
00102$:
;src/gb/awele_gb.c:40: else	color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
00103$:
;src/gb/awele_gb.c:41: gprintf(s);
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_gprintf
	add	sp, #2
;src/gb/awele_gb.c:43: }
	ret
;src/gb/awele_gb.c:45: void revers(BOOLEAN b)
;	---------------------------------
; Function revers
; ---------------------------------
_revers::
;src/gb/awele_gb.c:47: if(b)	color(WHITE, DKGREY, SOLID);
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
	ret
00102$:
;src/gb/awele_gb.c:48: else	color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:49: }
	ret
;src/gb/awele_gb.c:51: void effaceLigne(UINT8 l)
;	---------------------------------
; Function effaceLigne
; ---------------------------------
_effaceLigne::
;src/gb/awele_gb.c:54: color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:55: gotogxy(0,l);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:56: for(i=0;i<20;i++) wrtchr(' ');
	ld	c, #0x00
00102$:
	push	bc
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	pop	bc
	inc	c
	ld	a, c
	sub	a, #0x14
	jr	C, 00102$
;src/gb/awele_gb.c:57: }
	ret
;src/gb/awele_gb.c:59: void effaceChr(UINT8 l, UINT16 n)
;	---------------------------------
; Function effaceChr
; ---------------------------------
_effaceChr::
;src/gb/awele_gb.c:62: color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:63: gotogxy(0,l);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:64: for(i=0;i<n;i++) wrtchr(' ');
	ld	bc, #0x0000
00103$:
	ldhl	sp,	#3
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ret	NC
	push	bc
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	pop	bc
	inc	bc
;src/gb/awele_gb.c:65: }
	jr	00103$
;src/gb/awele_gb.c:66: void clrscr()
;	---------------------------------
; Function clrscr
; ---------------------------------
_clrscr::
;src/gb/awele_gb.c:68: effaceChr(0,360);
	ld	hl, #0x0168
	push	hl
	xor	a, a
	push	af
	inc	sp
	call	_effaceChr
	add	sp, #3
;src/gb/awele_gb.c:69: }
	ret
;src/gb/awele_gb.c:70: void gbtbcar()
;	---------------------------------
; Function gbtbcar
; ---------------------------------
_gbtbcar::
;src/gb/awele_gb.c:73: for(y=0;y<20;y++)
	ld	c, #0x00
;src/gb/awele_gb.c:75: for(x=0;x<20;x++)
00109$:
	ld	b, #0x00
00103$:
;src/gb/awele_gb.c:77: gotogxy(x,y);
	push	bc
	ld	a, c
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gb/awele_gb.c:78: wrtchr(y*20+x);
	ld	a, c
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	ld	e, b
	add	a, e
	push	bc
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	pop	bc
;src/gb/awele_gb.c:75: for(x=0;x<20;x++)
	inc	b
	ld	a, b
	sub	a, #0x14
	jr	C, 00103$
;src/gb/awele_gb.c:73: for(y=0;y<20;y++)
	inc	c
	ld	a, c
	sub	a, #0x14
	jr	C, 00109$
;src/gb/awele_gb.c:81: }
	ret
;src/gb/awele_gb.c:83: void boitePlateau()
;	---------------------------------
; Function boitePlateau
; ---------------------------------
_boitePlateau::
;src/gb/awele_gb.c:85: color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:86: box(16,23,144,48,M_NOFILL);
	xor	a, a
	ld	d,a
	ld	e,#0x30
	push	de
	ld	de, #0x9017
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	call	_box
	add	sp, #5
;src/gb/awele_gb.c:87: box(0,23,16,40,M_NOFILL);
	xor	a, a
	ld	d,a
	ld	e,#0x28
	push	de
	ld	de, #0x1017
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_box
	add	sp, #5
;src/gb/awele_gb.c:88: box(144,31,159,48,M_NOFILL);
	xor	a, a
	ld	d,a
	ld	e,#0x30
	push	de
	ld	de, #0x9f1f
	push	de
	ld	a, #0x90
	push	af
	inc	sp
	call	_box
	add	sp, #5
;src/gb/awele_gb.c:89: }
	ret
;src/gb/awele_gb.c:91: void initJoystick(){}
;	---------------------------------
; Function initJoystick
; ---------------------------------
_initJoystick::
	ret
;src/gb/awele_gb.c:92: void initPlateau()
;	---------------------------------
; Function initPlateau
; ---------------------------------
_initPlateau::
;src/gb/awele_gb.c:94: gbglobals();
;src/gb/awele_gb.c:96: }
	jp  _gbglobals
;src/gb/awele_gb.c:98: UBYTE getkj()
;	---------------------------------
; Function getkj
; ---------------------------------
_getkj::
;src/gb/awele_gb.c:100: UBYTE c=0,j=0;
	ld	c, #0x00
;src/gb/awele_gb.c:102: while(!(pad=joypad()));
00101$:
	call	_joypad
	ld	d, #0x00
	ld	l, e
	ld	a, d
	or	a, e
	jr	Z, 00101$
;src/gb/awele_gb.c:105: if(pad &  J_UP) c = KEY_UP;
	bit	2, l
	jr	Z, 00105$
	ld	c, #0x0b
00105$:
;src/gb/awele_gb.c:106: if(pad &  J_DOWN) c = KEY_DOWN;
	bit	3, l
	jr	Z, 00107$
	ld	c, #0x0a
00107$:
;src/gb/awele_gb.c:107: if(pad &  J_LEFT) c = KEY_LEFT;
	bit	1, l
	jr	Z, 00109$
	ld	c, #0x08
00109$:
;src/gb/awele_gb.c:108: if(pad &  J_RIGHT) c = KEY_RIGHT;
	bit	0, l
	jr	Z, 00111$
	ld	c, #0x09
00111$:
;src/gb/awele_gb.c:109: if(pad &  J_A) c = KEY_RETURN;
	bit	4, l
	jr	Z, 00113$
	ld	c, #0x0d
00113$:
;src/gb/awele_gb.c:112: waitpadup();
	call	_waitpadup
;src/gb/awele_gb.c:113: return c;
	ld	e, c
;src/gb/awele_gb.c:114: }
	ret
;src/gb/awele_gb.c:116: UBYTE menuOptions(UBYTE n)
;	---------------------------------
; Function menuOptions
; ---------------------------------
_menuOptions::
	add	sp, #-6
;src/gb/awele_gb.c:121: clrscr();
	call	_clrscr
;src/gb/awele_gb.c:122: i=2; // par défaut PvC
	ldhl	sp,	#5
	ld	(hl), #0x02
;src/gb/awele_gb.c:123: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gb/awele_gb.c:124: if(n == 0)
	ldhl	sp,	#8
	ld	a, (hl)
	or	a, a
	jp	NZ, 00111$
;src/gb/awele_gb.c:125: do
00107$:
;src/gb/awele_gb.c:127: gotogxy(0,1);revers(i==1);gprint(gOption2Joueurs);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ldhl	sp,	#5
	ld	a, (hl)
	dec	a
	ld	a, #0x01
	jr	Z, 00291$
	xor	a, a
00291$:
	push	af
	inc	sp
	call	_revers
	inc	sp
	ld	hl, #_gOption2Joueurs
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:128: gotogxy(0,2);revers(i==2);gprint(gOption1Joueur);
	ld	a, #0x02
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00293$
	xor	a, a
00293$:
	push	af
	inc	sp
	call	_revers
	inc	sp
	ld	hl, #_gOption1Joueur
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:129: gotogxy(0,3);revers(i==3);gprint(gOption2Ordinateurs);
	ld	a, #0x03
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x03
	ld	a, #0x01
	jr	Z, 00295$
	xor	a, a
00295$:
	push	af
	inc	sp
	call	_revers
	inc	sp
	ld	hl, #_gOption2Ordinateurs
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:130: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gb/awele_gb.c:131: c = getkj();
	call	_getkj
;src/gb/awele_gb.c:132: if(c == KEY_UP && i>1) i--;
	ld	a, e
	sub	a, #0x0b
	jr	NZ, 00102$
	ld	a, #0x01
	ldhl	sp,	#5
	sub	a, (hl)
	jr	NC, 00102$
	dec	(hl)
00102$:
;src/gb/awele_gb.c:133: if(c == KEY_DOWN && i<3) i++;
	ld	a, e
	sub	a, #0x0a
	jr	NZ, 00108$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x03
	jr	NC, 00108$
	inc	(hl)
00108$:
;src/gb/awele_gb.c:134: } while(c != KEY_RETURN);
	ld	a, e
	sub	a, #0x0d
	jp	NZ,00107$
00111$:
;src/gb/awele_gb.c:137: switch(i)
	ldhl	sp,	#5
	ld	a, (hl)
	dec	a
	jr	Z, 00112$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00113$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x03
	jp	Z,00133$
	jp	00144$
;src/gb/awele_gb.c:139: case 1:
00112$:
;src/gb/awele_gb.c:140: printxy(0,l,FALSE,gJ1commence);
	ld	hl, #_gJ1commence
	push	hl
	xor	a, a
	ld	d,a
	ld	e,#0x04
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_printxy
	add	sp, #5
;src/gb/awele_gb.c:141: j[0] = j[1] = 0;
	ld	hl, #(_j + 0x0001)
	ld	(hl), #0x00
	ld	hl, #_j
	ld	(hl), #0x00
;src/gb/awele_gb.c:142: i = 0;
	xor	a, a
	ldhl	sp,	#5
	ld	(hl), a
;src/gb/awele_gb.c:143: break;
	jp	00145$
;src/gb/awele_gb.c:144: case 2:
00113$:
;src/gb/awele_gb.c:145: printxy(0,l,FALSE,gJ2ordi);
	ld	hl, #_gJ2ordi
	push	hl
	xor	a, a
	ld	d,a
	ld	e,#0x04
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_printxy
	add	sp, #5
;src/gb/awele_gb.c:147: j[i]=1;
	ld	hl, #(_j + 0x0001)
	ld	(hl), #0x01
;src/gb/awele_gb.c:148: j[1-i]=0;
	ld	hl, #_j
	ld	(hl), #0x00
;src/gb/awele_gb.c:149: printxy(0,++l,FALSE,gOptionProfondeur);
	ld	hl, #_gOptionProfondeur
	push	hl
	xor	a, a
	ld	d,a
	ld	e,#0x05
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_printxy
	add	sp, #5
;src/gb/awele_gb.c:150: i=1;
	ld	c, #0x01
;src/gb/awele_gb.c:151: do
00120$:
;src/gb/awele_gb.c:153: gotogxy(17,l);
	push	bc
	ld	de, #0x0511
	push	de
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gb/awele_gb.c:154: wrtchr((char)(i+48));
	ld	a, c
	add	a, #0x30
	push	bc
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	call	_getkj
	pop	bc
;src/gb/awele_gb.c:156: if(c == KEY_UP && i<6) i++;
	ld	a, e
	sub	a, #0x0b
	jr	NZ, 00115$
	ld	a, c
	sub	a, #0x06
	jr	NC, 00115$
	inc	c
00115$:
;src/gb/awele_gb.c:157: if(c == KEY_DOWN && i>1) i--;
	ld	a, e
	sub	a, #0x0a
	jr	NZ, 00121$
	ld	a, #0x01
	sub	a, c
	jr	NC, 00121$
	dec	c
00121$:
;src/gb/awele_gb.c:158: } while(c != KEY_RETURN);
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00120$
;src/gb/awele_gb.c:159: prof[1]=i;
	ld	hl, #(_prof + 0x0001)
	ld	(hl), c
;src/gb/awele_gb.c:160: i=1;
	ldhl	sp,	#5
	ld	(hl), #0x01
;src/gb/awele_gb.c:162: printxy(0,++l,FALSE,gOptionQuiCommence);
	ld	hl, #_gOptionQuiCommence
	push	hl
	xor	a, a
	ld	d,a
	ld	e,#0x06
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_printxy
	add	sp, #5
;src/gb/awele_gb.c:163: do
00130$:
;src/gb/awele_gb.c:165: gotogxy(15,l);
	ld	de, #0x060f
	push	de
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:167: if(i==1) gprint(gVous); else gprint(gMoi);
	ldhl	sp,	#5
	ld	a, (hl)
	dec	a
	jr	NZ, 00124$
	ld	hl, #_gVous
	push	hl
	call	_gprint
	add	sp, #2
	jr	00125$
00124$:
	ld	hl, #_gMoi
	push	hl
	call	_gprint
	add	sp, #2
00125$:
;src/gb/awele_gb.c:168: c = getkj();
	call	_getkj
;src/gb/awele_gb.c:169: if(c == KEY_UP) i=2;
	ld	a, e
	sub	a, #0x0b
	jr	NZ, 00127$
	ldhl	sp,	#5
	ld	(hl), #0x02
00127$:
;src/gb/awele_gb.c:170: if(c == KEY_DOWN) i=1;
	ld	a, e
	sub	a, #0x0a
	jr	NZ, 00131$
	ldhl	sp,	#5
	ld	(hl), #0x01
00131$:
;src/gb/awele_gb.c:171: } while(c != KEY_RETURN);
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00130$
;src/gb/awele_gb.c:173: --i;
	ldhl	sp,	#5
	dec	(hl)
;src/gb/awele_gb.c:174: break;
	jp	00145$
;src/gb/awele_gb.c:176: case 3:
00133$:
;src/gb/awele_gb.c:177: j[0] = j[1] = 1;
	ld	hl, #(_j + 0x0001)
	ld	(hl), #0x01
	ld	hl, #_j
	ld	(hl), #0x01
;src/gb/awele_gb.c:178: gotogxy(0,l);
	ld	a, #0x04
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:179: printxy(0,l,FALSE,gJ1commence);
	ld	hl, #_gJ1commence
	push	hl
	xor	a, a
	ld	d,a
	ld	e,#0x04
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_printxy
	add	sp, #5
;src/gb/awele_gb.c:180: for( i=0; i<2; i++)
	xor	a, a
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x04
00146$:
;src/gb/awele_gb.c:182: gotogxy(0,++l);
	ldhl	sp,	#5
	inc	(hl)
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:183: gprint(gJoueur[i]);
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	sla	(hl)
	inc	hl
	rl	(hl)
;c
	pop	de
	push	de
	ld	hl, #_gJoueur
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:184: gprint(gOptionProfondeur);
	ld	hl, #_gOptionProfondeur
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:185: k = 1;
	ld	c, #0x01
;src/gb/awele_gb.c:186: do
00140$:
;src/gb/awele_gb.c:188: gotogxy(18,l);
	push	bc
	ldhl	sp,	#7
	ld	d, (hl)
	ld	e,#0x12
	push	de
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gb/awele_gb.c:189: wrtchr((char)(k+48));
	ld	a, c
	add	a, #0x30
	push	bc
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	call	_getkj
	pop	bc
;src/gb/awele_gb.c:191: if(c == KEY_UP && k<6) k++;
	ld	a, e
	sub	a, #0x0b
	jr	NZ, 00135$
	ld	a, c
	sub	a, #0x06
	jr	NC, 00135$
	inc	c
00135$:
;src/gb/awele_gb.c:192: if(c == KEY_DOWN && k>1) k--;
	ld	a, e
	sub	a, #0x0a
	jr	NZ, 00141$
	ld	a, #0x01
	sub	a, c
	jr	NC, 00141$
	dec	c
00141$:
;src/gb/awele_gb.c:193: } while(c != KEY_RETURN);
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00140$
;src/gb/awele_gb.c:194: prof[i]=k;
;c
	ld	de, #_prof
	ldhl	sp,	#4
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, c
	ld	(de), a
;src/gb/awele_gb.c:180: for( i=0; i<2; i++)
	ldhl	sp,	#4
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x02
	jp	C, 00146$
;src/gb/awele_gb.c:196: i=0;
	xor	a, a
	inc	hl
	ld	(hl), a
;src/gb/awele_gb.c:197: break;
	jr	00145$
;src/gb/awele_gb.c:198: default:
00144$:
;src/gb/awele_gb.c:202: exit(5);
	ld	hl, #0x0005
	push	hl
	call	_exit
	add	sp, #2
;src/gb/awele_gb.c:203: }
00145$:
;src/gb/awele_gb.c:204: clrscr();
	call	_clrscr
;src/gb/awele_gb.c:205: gotogxy(0,0);gprint(gPositionsEvaluees);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ld	hl, #_gPositionsEvaluees
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:206: return(i);
	ldhl	sp,	#5
	ld	e, (hl)
;src/gb/awele_gb.c:208: }
	add	sp, #6
	ret
;src/gb/awele_gb.c:210: void afficherPlateau(UBYTE *p)
;	---------------------------------
; Function afficherPlateau
; ---------------------------------
_afficherPlateau::
;src/gb/awele_gb.c:213: gotogxy(0,1);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:215: for( i=2*NCASES; i>NCASES; i--)
	ld	bc, #0x0010
00125$:
;src/gb/awele_gb.c:217: gotogxy(2*(2*NCASES-i+1),1);
	ld	e, c
	ld	a, #0x11
	sub	a, e
	add	a, a
	push	bc
	ld	h, #0x01
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gb/awele_gb.c:218: if(i%2)  color(BLACK, WHITE, SOLID);
	push	bc
	ld	hl, #0x0002
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	pop	bc
	ld	a, d
	or	a, e
	jr	Z, 00102$
	push	bc
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
	pop	bc
	jr	00103$
00102$:
;src/gb/awele_gb.c:219: else     color(WHITE, DKGREY, SOLID);
	push	bc
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
	pop	bc
00103$:
;src/gb/awele_gb.c:220: gprintln(i,10,UNSIGNED);
	push	bc
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	push	bc
	call	_gprintln
	add	sp, #4
	pop	bc
;src/gb/awele_gb.c:215: for( i=2*NCASES; i>NCASES; i--)
	dec	bc
	ld	e, b
	ld	d, #0x00
	ld	a, #0x08
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00214$
	bit	7, d
	jr	NZ, 00215$
	cp	a, a
	jr	00215$
00214$:
	bit	7, d
	jr	Z, 00215$
	scf
00215$:
	jr	C, 00125$
;src/gb/awele_gb.c:224: for( i=2*NCASES; i>NCASES; i--)
	ld	bc, #0x0010
00127$:
;src/gb/awele_gb.c:226: gotogxy(2*(2*NCASES-i+1),3);//+i%2);
	ld	e, c
	ld	a, #0x11
	sub	a, e
	add	a, a
	push	bc
	ld	h, #0x03
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gb/awele_gb.c:227: if(i%2)  color(BLACK, WHITE, SOLID);
	push	bc
	ld	hl, #0x0002
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	pop	bc
	ld	a, d
	or	a, e
	jr	Z, 00106$
	push	bc
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
	pop	bc
	jr	00107$
00106$:
;src/gb/awele_gb.c:228: else     color(WHITE, DKGREY, SOLID);
	push	bc
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
	pop	bc
00107$:
;src/gb/awele_gb.c:229: gprintln(p[i],10,UNSIGNED);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	push	bc
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	push	hl
	call	_gprintln
	add	sp, #4
	pop	de
	pop	bc
;src/gb/awele_gb.c:230: if(p[i]<10) wrtchr(' ');
	ld	a, (de)
	sub	a, #0x0a
	jr	NC, 00128$
	push	bc
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	pop	bc
00128$:
;src/gb/awele_gb.c:224: for( i=2*NCASES; i>NCASES; i--)
	dec	bc
	ld	e, b
	ld	d, #0x00
	ld	a, #0x08
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00216$
	bit	7, d
	jr	NZ, 00217$
	cp	a, a
	jr	00217$
00216$:
	bit	7, d
	jr	Z, 00217$
	scf
00217$:
	jp	C, 00127$
;src/gb/awele_gb.c:235: color(WHITE, DKGREY, SOLID);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:236: gotogxy(0,4);
	ld	a, #0x04
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:237: gprintln(p[KALAH2],10,UNSIGNED);
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0011
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	e, a
	ld	d, #0x00
	push	bc
	xor	a, a
	ld	h, a
	ld	l, #0x0a
	push	hl
	push	de
	call	_gprintln
	add	sp, #4
	pop	bc
;src/gb/awele_gb.c:238: if(p[KALAH2]<10) wrtchr(' ');
	ld	a, (bc)
	sub	a, #0x0a
	jr	NC, 00112$
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
00112$:
;src/gb/awele_gb.c:239: gotogxy(2*NCASES+2,4);
	ld	de, #0x0412
	push	de
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:240: gprintln(p[KALAH1],10,UNSIGNED);
;c
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	e, a
	ld	d, #0x00
	push	bc
	xor	a, a
	ld	h, a
	ld	l, #0x0a
	push	hl
	push	de
	call	_gprintln
	add	sp, #4
	pop	bc
;src/gb/awele_gb.c:241: if(p[KALAH1]<10) wrtchr(' ');
	ld	a, (bc)
	sub	a, #0x0a
	jr	NC, 00146$
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
;src/gb/awele_gb.c:244: for( i=0; i<NCASES; i++)
00146$:
	ld	bc, #0x0000
00129$:
;src/gb/awele_gb.c:246: gotogxy(2*i+2,5);//+i%2);
	ld	a, c
	add	a, a
	add	a, #0x02
	push	bc
	ld	h, #0x05
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gb/awele_gb.c:247: if(i%2)     color(WHITE, DKGREY, SOLID);
	push	bc
	ld	hl, #0x0002
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	pop	bc
	ld	a, d
	or	a, e
	jr	Z, 00116$
	push	bc
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
	pop	bc
	jr	00117$
00116$:
;src/gb/awele_gb.c:248: else     color(BLACK, WHITE, SOLID);
	push	bc
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
	pop	bc
00117$:
;src/gb/awele_gb.c:249: gprintln(p[i],10,UNSIGNED);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	l, a
	ld	h, #0x00
	push	bc
	push	de
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	push	hl
	call	_gprintln
	add	sp, #4
	pop	de
	pop	bc
;src/gb/awele_gb.c:250: if(p[i]<10) wrtchr(' ');
	ld	a, (de)
	sub	a, #0x0a
	jr	NC, 00130$
	push	bc
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	pop	bc
00130$:
;src/gb/awele_gb.c:244: for( i=0; i<NCASES; i++)
	inc	bc
	ld	a, c
	sub	a, #0x08
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00129$
;src/gb/awele_gb.c:254: for( i=0; i<NCASES; i++)
	ld	bc, #0x0000
00131$:
;src/gb/awele_gb.c:256: gotogxy(2*i+2,7);
	ld	a, c
	add	a, a
	add	a, #0x02
	push	bc
	ld	h, #0x07
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gb/awele_gb.c:257: if(i%2)     color(WHITE, DKGREY, SOLID);
	push	bc
	ld	hl, #0x0002
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	pop	bc
	ld	a, d
	or	a, e
	jr	Z, 00122$
	push	bc
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
	pop	bc
	jr	00123$
00122$:
;src/gb/awele_gb.c:258: else     color(BLACK, WHITE, SOLID);
	push	bc
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
	pop	bc
00123$:
;src/gb/awele_gb.c:259: gprintln(i,10,UNSIGNED);
	push	bc
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	push	bc
	call	_gprintln
	add	sp, #4
	pop	bc
;src/gb/awele_gb.c:254: for( i=0; i<NCASES; i++)
	inc	bc
	ld	a, c
	sub	a, #0x08
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00131$
;src/gb/awele_gb.c:261: }
	ret
;src/gb/awele_gb.c:265: BOOLEAN afficherResultats(UBYTE k1, UBYTE k2)
;	---------------------------------
; Function afficherResultats
; ---------------------------------
_afficherResultats::
	dec	sp
;src/gb/awele_gb.c:267: gotogxy(0,12);
	ld	a, #0x0c
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:268: color(WHITE, DKGREY, SOLID);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:269: if( k1>k2 )
	ldhl	sp,	#4
	ld	a, (hl-)
	sub	a, (hl)
	jr	NC, 00105$
;src/gb/awele_gb.c:271: gprint(gJoueur[0]);
	ld	hl, #_gJoueur
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:272: gprint(gVainqueur);
	ld	hl, #_gVainqueur
	push	hl
	call	_gprint
	add	sp, #2
	jr	00106$
00105$:
;src/gb/awele_gb.c:274: else if( k1==k2 )
	ldhl	sp,	#3
	ld	a, (hl+)
	sub	a, (hl)
	jr	NZ, 00102$
;src/gb/awele_gb.c:275: gprint(gEgalite);
	ld	hl, #_gEgalite
	push	hl
	call	_gprint
	add	sp, #2
	jr	00106$
00102$:
;src/gb/awele_gb.c:278: gprint(gJoueur[1]);
	ld	hl, #(_gJoueur + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:279: gprint(gVainqueur);
	ld	hl, #_gVainqueur
	push	hl
	call	_gprint
	add	sp, #2
00106$:
;src/gb/awele_gb.c:281: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gb/awele_gb.c:282: gotogxy(2,13);gprintf(" %d : ",(k1<k2)?k2:k1);gprintf("%d",(k1<k2)?k1:k2);
	ld	de, #0x0d02
	push	de
	call	_gotogxy
	add	sp, #2
	ldhl	sp,	#3
	ld	a, (hl+)
	sub	a, (hl)
	ld	a, #0x00
	rla
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, c
	or	a, a
	jr	Z, 00109$
	ld	a, b
	jr	00110$
00109$:
	ldhl	sp,	#0
	ld	a, (hl)
00110$:
	ld	e, a
	ld	d, #0x00
	push	bc
	push	de
	ld	hl, #___str_0
	push	hl
	call	_gprintf
	add	sp, #4
	pop	bc
	ld	a, c
	or	a, a
	jr	Z, 00111$
	ldhl	sp,	#0
	ld	b, (hl)
00111$:
	ld	d, #0x00
	ld	e, b
	push	de
	ld	hl, #___str_1
	push	hl
	call	_gprintf
	add	sp, #4
;src/gb/awele_gb.c:283: effaceLigne(14);
	ld	a, #0x0e
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gb/awele_gb.c:285: gotogxy(2,15);
	ld	de, #0x0f02
	push	de
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:286: color(WHITE, DKGREY, SOLID);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:287: gprint("B pour continuer");
	ld	hl, #___str_2
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:288: waitpad(J_B);
	ld	a, #0x20
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/gb/awele_gb.c:289: waitpadup();
	call	_waitpadup
;src/gb/awele_gb.c:290: effaceLigne(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gb/awele_gb.c:292: return(TRUE);
	ld	e, #0x01
;src/gb/awele_gb.c:293: }
	inc	sp
	ret
___str_0:
	.ascii " %d : "
	.db 0x00
___str_1:
	.ascii "%d"
	.db 0x00
___str_2:
	.ascii "B pour continuer"
	.db 0x00
;src/gb/awele_gb.c:295: void afficherPosEval()
;	---------------------------------
; Function afficherPosEval
; ---------------------------------
_afficherPosEval::
;src/gb/awele_gb.c:297: gotogxy(10,0);
	xor	a, a
	ld	d,a
	ld	e,#0x0a
	push	de
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:298: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gb/awele_gb.c:299: gprintf("%d   ",posEval);
	ld	hl, #_posEval
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #___str_3
	push	hl
	call	_gprintf
	add	sp, #4
;src/gb/awele_gb.c:300: }
	ret
___str_3:
	.ascii "%d   "
	.db 0x00
;src/gb/awele_gb.c:302: void afficherAttente(UBYTE joueur, UBYTE casejouee)
;	---------------------------------
; Function afficherAttente
; ---------------------------------
_afficherAttente::
	dec	sp
;src/gb/awele_gb.c:306: gotogxy(0,14);
	ld	a, #0x0e
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:307: color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:308: gprintf("J%d joue en ", joueur);
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	hl, #___str_4
	push	hl
	call	_gprintf
	add	sp, #4
;src/gb/awele_gb.c:309: gprintf("%d   ", casejouee);
	ldhl	sp,	#4
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	hl, #___str_5
	push	hl
	call	_gprintf
	add	sp, #4
;src/gb/awele_gb.c:310: gotogxy(2,15);
	ld	de, #0x0f02
	push	de
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:311: color(WHITE, DKGREY, SOLID);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:312: gprint("B pour continuer");
	ld	hl, #___str_6
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:313: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gb/awele_gb.c:315: joueur--;
	ldhl	sp,	#3
	dec	(hl)
;src/gb/awele_gb.c:316: y= 6-joueur*4;
	ld	c, (hl)
	ld	a, c
	add	a, a
	add	a, a
	ld	b, a
	ld	a, #0x06
	sub	a, b
	ld	b, a
;src/gb/awele_gb.c:318: color(WHITE,WHITE,SOLID);
	push	bc
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
	pop	bc
;src/gb/awele_gb.c:319: (joueur==0)?box(16,49,144,55,M_FILL):box(16,16,144,22,M_FILL);
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	NZ, 00103$
	push	bc
	ld	de, #0x0137
	push	de
	ld	de, #0x9031
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	call	_box
	add	sp, #5
	pop	bc
	jr	00104$
00103$:
	push	bc
	ld	de, #0x0116
	push	de
	ld	de, #0x9010
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	call	_box
	add	sp, #5
	pop	bc
00104$:
;src/gb/awele_gb.c:321: x=(casejouee-joueur*(NCASES+1));
	ldhl	sp,	#3
	ld	a, (hl)
	ld	e, a
	add	a, a
	add	a, a
	add	a, a
	add	a, e
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#0
	sub	a, (hl)
	ld	d, a
;src/gb/awele_gb.c:322: x = (1-2*joueur)*x;
	ld	a, c
	add	a, a
	ld	e, a
	ld	a, #0x01
	sub	a, e
	push	bc
	push	de
	inc	sp
	push	af
	inc	sp
	call	__muluschar
	add	sp, #2
	pop	bc
	ldhl	sp,	#0
	ld	(hl), e
;src/gb/awele_gb.c:323: x+=7*joueur;
	ld	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	ldhl	sp,	#0
	ld	c, (hl)
	add	a, c
;src/gb/awele_gb.c:324: x = x*2;
	add	a, a
;src/gb/awele_gb.c:325: x+=2;
	add	a, #0x02
;src/gb/awele_gb.c:326: gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
	ldhl	sp,	#3
	ld	a, (hl)
	inc	a
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
;src/gb/awele_gb.c:328: boitePlateau();
	call	_boitePlateau
;src/gb/awele_gb.c:330: waitpad(J_B);
	ld	a, #0x20
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/gb/awele_gb.c:331: effaceLigne(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gb/awele_gb.c:332: effaceLigne(16);
	ld	a, #0x10
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gb/awele_gb.c:333: }
	inc	sp
	ret
___str_4:
	.ascii "J%d joue en "
	.db 0x00
___str_5:
	.ascii "%d   "
	.db 0x00
___str_6:
	.ascii "B pour continuer"
	.db 0x00
;src/gb/awele_gb.c:335: void effacerAttente()
;	---------------------------------
; Function effacerAttente
; ---------------------------------
_effacerAttente::
;src/gb/awele_gb.c:337: effaceLigne(12);
	ld	a, #0x0c
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gb/awele_gb.c:338: effaceLigne(13);
	ld	a, #0x0d
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gb/awele_gb.c:339: }
	ret
;src/gb/awele_gb.c:341: UBYTE choixJoueur(UBYTE joueur)
;	---------------------------------
; Function choixJoueur
; ---------------------------------
_choixJoueur::
	add	sp, #-20
;src/gb/awele_gb.c:348: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gb/awele_gb.c:349: gotogxy(0,10);
	ld	a, #0x0a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:350: gprint(gJoueur[joueur]);
	ldhl	sp,	#22
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
	pop	bc
	push	bc
	sla	c
	rl	b
	ld	hl, #_gJoueur
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:351: gotogxy(0,11);
	ld	a, #0x0b
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:352: gprint(gQuelleCase); 
	ld	hl, #_gQuelleCase
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:355: color(WHITE,WHITE,SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:356: box(16,16,144,22,M_FILL);
	ld	de, #0x0116
	push	de
	ld	de, #0x9010
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	call	_box
	add	sp, #5
;src/gb/awele_gb.c:357: box(16,49,144,55,M_FILL);
	ld	de, #0x0137
	push	de
	ld	de, #0x9031
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	call	_box
	add	sp, #5
;src/gb/awele_gb.c:359: for(c=joueur*(NCASES+1);!jeu[c];c++);
	ldhl	sp,	#22
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#18
	ld	(hl), a
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#18
	ld	e, (hl)
00124$:
	ld	a, e
	ld	c, a
	rla
	sbc	a, a
	ld	b, a
	ld	hl, #_jeu
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00144$
	inc	e
	jr	00124$
00144$:
	ldhl	sp,	#19
	ld	(hl), e
;src/gb/awele_gb.c:360: y= 6-joueur*4;
	ldhl	sp,	#22
	ld	c, (hl)
	ld	a, c
	add	a, a
	add	a, a
	ld	b, a
	ld	a, #0x06
	sub	a, b
	ldhl	sp,	#3
	ld	(hl), a
;src/gb/awele_gb.c:361: revers(FALSE);
	push	bc
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
	pop	bc
;src/gb/awele_gb.c:362: do
	ld	a, c
	add	a, a
	ld	b, a
	ld	a, #0x01
	sub	a, b
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, c
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#22
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
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#18
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00120$:
;src/gb/awele_gb.c:365: color(WHITE,WHITE,SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gb/awele_gb.c:366: (joueur==0)?box(16,49,144,55,M_FILL):box(16,16,144,22,M_FILL);
	ldhl	sp,	#22
	ld	a, (hl)
	or	a, a
	jr	NZ, 00128$
	ld	de, #0x0137
	push	de
	ld	de, #0x9031
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	call	_box
	add	sp, #5
	jr	00129$
00128$:
	ld	de, #0x0116
	push	de
	ld	de, #0x9010
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	call	_box
	add	sp, #5
00129$:
;src/gb/awele_gb.c:368: x=(c-joueur*(NCASES+1));
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#2
	sub	a, (hl)
;src/gb/awele_gb.c:369: x = (1-2*joueur)*x;
	push	af
	inc	sp
	inc	hl
	inc	hl
	ld	a, (hl)
	push	af
	inc	sp
	call	__muluschar
	add	sp, #2
	ld	a, e
;src/gb/awele_gb.c:370: x+=7*joueur;
	ldhl	sp,	#5
	add	a, (hl)
;src/gb/awele_gb.c:371: x = x*2;
	add	a, a
;src/gb/awele_gb.c:372: x+=2;
	add	a, #0x02
	ldhl	sp,	#11
	ld	(hl), a
;src/gb/awele_gb.c:373: gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
	ldhl	sp,	#22
	ld	c, (hl)
	ld	a, c
	inc	a
	ldhl	sp,	#12
	ld	(hl), a
	push	bc
	ld	a, (hl)
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	call	_boitePlateau
	pop	bc
;src/gb/awele_gb.c:378: do k = getkj(); while(!k);
	ldhl	sp,	#12
	ld	a, (hl)
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	add	a, #0xff
	inc	hl
	ld	(hl), a
00102$:
	call	_getkj
	ldhl	sp,	#14
	ld	(hl), e
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/gb/awele_gb.c:379: if(k == KEY_LEFT)
	ld	a, (hl)
	sub	a, #0x08
	jr	NZ, 00108$
;src/gb/awele_gb.c:381: gotogxy(x,y);revers(FALSE);wrtchr(32);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
;src/gb/awele_gb.c:382: c-=(1-2*joueur);
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#4
	sub	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	jr	00109$
00108$:
;src/gb/awele_gb.c:385: else if(k == KEY_RIGHT)
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x09
	jr	NZ, 00109$
;src/gb/awele_gb.c:387: gotogxy(x,y);revers(FALSE);wrtchr(32);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
;src/gb/awele_gb.c:388: c+=(1-2*joueur);
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#4
	add	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
00109$:
;src/gb/awele_gb.c:391: if(c<joueur*(NCASES+1)) c=joueur*(NCASES+1);
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl), a
;src/gb/awele_gb.c:392: else if(c>=(joueur+1)*NCASES+joueur) c=(joueur+1)*NCASES+joueur-1;
	pop	hl
	push	hl
	inc	hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	pop	hl
	push	hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#17
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#16
	ld	(hl), a
;src/gb/awele_gb.c:391: if(c<joueur*(NCASES+1)) c=joueur*(NCASES+1);
	ldhl	sp,	#17
	ld	e, l
	ld	d, h
	ldhl	sp,	#6
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00206$
	bit	7, d
	jr	NZ, 00207$
	cp	a, a
	jr	00207$
00206$:
	bit	7, d
	jr	Z, 00207$
	scf
00207$:
	jr	NC, 00113$
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
	jr	00114$
00113$:
;src/gb/awele_gb.c:392: else if(c>=(joueur+1)*NCASES+joueur) c=(joueur+1)*NCASES+joueur-1;
	ldhl	sp,	#17
	ld	e, l
	ld	d, h
	ldhl	sp,	#15
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00208$
	bit	7, d
	jr	NZ, 00209$
	cp	a, a
	jr	00209$
00208$:
	bit	7, d
	jr	Z, 00209$
	scf
00209$:
	jr	C, 00114$
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
00114$:
;src/gb/awele_gb.c:394: x=(c-joueur*(NCASES+1));
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#8
	sub	a, (hl)
;src/gb/awele_gb.c:395: x = (1-2*joueur)*x;
	push	af
	inc	sp
	ldhl	sp,	#5
	ld	a, (hl)
	push	af
	inc	sp
	call	__muluschar
	add	sp, #2
	ld	a, e
;src/gb/awele_gb.c:396: x+=7*joueur;
	ldhl	sp,	#5
	add	a, (hl)
;src/gb/awele_gb.c:397: x = x*2;
	add	a, a
;src/gb/awele_gb.c:398: x+=2;
	add	a, #0x02
	ldhl	sp,	#11
	ld	(hl), a
;src/gb/awele_gb.c:399: gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
;src/gb/awele_gb.c:400: gotogxy(16,11);
	ld	de, #0x0b10
	push	de
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:401: gprintf("%d ",c);
	ldhl	sp,	#19
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	rla
	sbc	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #___str_7
	push	hl
	call	_gprintf
	add	sp, #4
;src/gb/awele_gb.c:402: boitePlateau();		
	call	_boitePlateau
;src/gb/awele_gb.c:403: } while(k != KEY_RETURN);
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x0d
	jp	NZ,00102$
;src/gb/awele_gb.c:404: waitpadup();
	call	_waitpadup
;src/gb/awele_gb.c:406: gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
	ldhl	sp,	#3
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
;src/gb/awele_gb.c:408: } while(c<joueur*(NCASES+1) || c>=(joueur+1)*NCASES+joueur || !jeu[c]);
	ldhl	sp,	#17
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00212$
	bit	7, d
	jr	NZ, 00213$
	cp	a, a
	jr	00213$
00212$:
	bit	7, d
	jr	Z, 00213$
	scf
00213$:
	jp	C, 00120$
	ldhl	sp,	#17
	ld	e, l
	ld	d, h
	ldhl	sp,	#15
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00214$
	bit	7, d
	jr	NZ, 00215$
	cp	a, a
	jr	00215$
00214$:
	bit	7, d
	jr	Z, 00215$
	scf
00215$:
	jp	NC, 00120$
;c
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_jeu
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00120$
;src/gb/awele_gb.c:409: effaceLigne(10);
	ld	a, #0x0a
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gb/awele_gb.c:410: effaceLigne(11);
	ld	a, #0x0b
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gb/awele_gb.c:411: return(c);
	ldhl	sp,	#19
	ld	e, (hl)
;src/gb/awele_gb.c:412: }
	add	sp, #20
	ret
___str_7:
	.ascii "%d "
	.db 0x00
;src/gb/awele_gb.c:414: void dbgprint(STRPTR s)
;	---------------------------------
; Function dbgprint
; ---------------------------------
_dbgprint::
;src/gb/awele_gb.c:417: gotogxy(0,15);
	ld	a, #0x0f
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:418: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gb/awele_gb.c:419: gprint(s);	
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:420: waitpad(J_B);
	ld	a, #0x20
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/gb/awele_gb.c:421: waitpadup();
;src/gb/awele_gb.c:422: }
	jp  _waitpadup
;src/gb/awele_gb.c:424: void afficherRegles()
;	---------------------------------
; Function afficherRegles
; ---------------------------------
_afficherRegles::
;src/gb/awele_gb.c:426: clrscr();
	call	_clrscr
;src/gb/awele_gb.c:427: gotogxy(0,1);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gb/awele_gb.c:428: gprint("ACTION: Au début de la partie, les joueurs placent leurs graines, par groupes de 6,\
	ld	hl, #___str_8
	push	hl
	call	_gprint
	add	sp, #2
;src/gb/awele_gb.c:447: }
	ret
___str_8:
	.ascii "ACTION: Au d"
	.db 0xe9
	.ascii "but de la partie, les joueurs placent leurs graines, par gro"
	.ascii "upes de 6,dans les troues de leur rang"
	.db 0xe9
	.ascii "e (on ne place aucune graines dans le Kalaha). L'und'entre e"
	.ascii "ux (tir"
	.db 0xe9
	.ascii " au sort) commence la partie.A son tour de jeu, un joueur pr"
	.ascii "end les graines dans un trou des trous la rang"
	.db 0xe9
	.ascii "e prochede lui et les s"
	.db 0xe8
	.ascii "me une par une dans chacun des trous qui suivent ainsi que d"
	.ascii "ans sonKalaha en suivant le sens anti-horaire. Le joueur ne "
	.ascii "s"
	.db 0xe8
	.ascii "me jamais de graines dans leKalaha de son adversaire.- Si le"
	.ascii " joueur s"
	.db 0xe8
	.ascii "me sa derni"
	.db 0xe8
	.ascii "re graine dans son Kalaha, il peut rejouer. On peut ainsienc"
	.ascii "ha"
	.db 0xee
	.ascii "ner plusieurs tous de jeu.- Si le joueur s"
	.db 0xe8
	.ascii "me sa derni"
	.db 0xe8
	.ascii "re graine dans un trou vide de sa propre rang"
	.db 0xe9
	.ascii "e, il captureles graines situ"
	.db 0xe9
	.ascii "es dans le trou en vis "
	.db 0xe0
	.ascii " vis et les place dans son Kalaha. Puis c'est ason adversair"
	.ascii "e de jouer.- Si le joueur s"
	.db 0xe8
	.ascii "me sa derni"
	.db 0xe8
	.ascii "re graine dans un trou qui n'"
	.db 0xe9
	.ascii "tait pas vide, son tour de jeuse termine et c'est "
	.db 0xe0
	.ascii " son adversaire de jouer.La partie se termine lorsqu'un des "
	.ascii "joueur ne peux plus jouer car lors de son tour dejeu, sa ran"
	.ascii "g"
	.db 0xe9
	.ascii "e est vide. Les graines restant "
	.db 0xe9
	.ascii "ventuellement dans la rang"
	.db 0xe9
	.ascii "e d 'un joueursont plac"
	.db 0xe9
	.ascii "es dans son Kalaha. Le vainqueur est celui qui a le plus gra"
	.ascii "nd nombre degraines dans son Kalaha."
	.db 0x00
	.area _CODE
	.area _CABS (ABS)
