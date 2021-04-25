;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.0.7 #12016 (Mac OS X x86_64)
;--------------------------------------------------------
	.module awele_gb
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _effaceChr
	.globl _effaceLigne
	.globl _revers
	.globl _color
	.globl _gotogxy
	.globl _wrtchr
	.globl _gprintf
	.globl _gprint
	.globl _waitpadup
	.globl _waitpad
	.globl _joypad
	.globl _exit
	.globl _printxy
	.globl _initJoystick
	.globl _initPlateau
	.globl _getkj
	.globl _menuOptions
	.globl _affPlateau
	.globl _clrscr
	.globl _afficherResultats
	.globl _afficherPosEval
	.globl _afficherAttente
	.globl _effacerAttente
	.globl _choixJoueur
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
;src/gameboy/awele_gb.c:51: void printxy(UBYTE x, UBYTE y, BOOLEAN rv, STRPTR s)
;	---------------------------------
; Function printxy
; ---------------------------------
_printxy::
;src/gameboy/awele_gb.c:53: gotogxy(x,y);
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
;src/gameboy/awele_gb.c:54: if(rv)	color(WHITE, DKGREY, SOLID);
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
;src/gameboy/awele_gb.c:55: else	color(BLACK, WHITE, SOLID);
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
;src/gameboy/awele_gb.c:56: gprintf(s);
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:58: }
	ret
;src/gameboy/awele_gb.c:60: void revers(BOOLEAN b)
;	---------------------------------
; Function revers
; ---------------------------------
_revers::
;src/gameboy/awele_gb.c:62: if(b)	color(WHITE, DKGREY, SOLID);
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
;src/gameboy/awele_gb.c:63: else	color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gameboy/awele_gb.c:64: }
	ret
;src/gameboy/awele_gb.c:66: void initJoystick(){}
;	---------------------------------
; Function initJoystick
; ---------------------------------
_initJoystick::
	ret
;src/gameboy/awele_gb.c:67: void initPlateau(){}
;	---------------------------------
; Function initPlateau
; ---------------------------------
_initPlateau::
	ret
;src/gameboy/awele_gb.c:69: UBYTE getkj()
;	---------------------------------
; Function getkj
; ---------------------------------
_getkj::
;src/gameboy/awele_gb.c:71: UBYTE c=0,j=0;
	ld	c, #0x00
;src/gameboy/awele_gb.c:73: while(!(pad=joypad()));
00101$:
	call	_joypad
	ld	d, #0x00
	ld	l, e
	ld	a, d
	or	a, e
	jr	Z, 00101$
;src/gameboy/awele_gb.c:76: if(pad &  J_UP) c = KEY_UP;
	bit	2, l
	jr	Z, 00105$
	ld	c, #0x0b
00105$:
;src/gameboy/awele_gb.c:77: if(pad &  J_DOWN) c = KEY_DOWN;
	bit	3, l
	jr	Z, 00107$
	ld	c, #0x0a
00107$:
;src/gameboy/awele_gb.c:78: if(pad &  J_LEFT) c = KEY_LEFT;
	bit	1, l
	jr	Z, 00109$
	ld	c, #0x08
00109$:
;src/gameboy/awele_gb.c:79: if(pad &  J_RIGHT) c = KEY_RIGHT;
	bit	0, l
	jr	Z, 00111$
	ld	c, #0x09
00111$:
;src/gameboy/awele_gb.c:80: if(pad &  J_A) c = KEY_RETURN;
	bit	4, l
	jr	Z, 00113$
	ld	c, #0x0d
00113$:
;src/gameboy/awele_gb.c:82: waitpadup();
	call	_waitpadup
;src/gameboy/awele_gb.c:84: return c;
	ld	e, c
;src/gameboy/awele_gb.c:85: }
	ret
;src/gameboy/awele_gb.c:89: UBYTE menuOptions(void)
;	---------------------------------
; Function menuOptions
; ---------------------------------
_menuOptions::
	add	sp, #-8
;src/gameboy/awele_gb.c:94: clrscr();
	call	_clrscr
;src/gameboy/awele_gb.c:95: i=2; // par défaut PvC
	ldhl	sp,	#7
	ld	(hl), #0x02
;src/gameboy/awele_gb.c:96: do
00107$:
;src/gameboy/awele_gb.c:98: gotogxy(0,1);revers(i==1);gprintf(gOptionJoueurs[0]);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ldhl	sp,	#7
	ld	a, (hl)
	dec	a
	ld	a, #0x01
	jr	Z, 00282$
	xor	a, a
00282$:
	push	af
	inc	sp
	call	_revers
	inc	sp
	ld	hl, #_gOptionJoueurs
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:99: gotogxy(0,2);revers(i==2);gprintf(gOptionJoueurs[1]);
	ld	a, #0x02
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x02
	ld	a, #0x01
	jr	Z, 00284$
	xor	a, a
00284$:
	push	af
	inc	sp
	call	_revers
	inc	sp
	ld	hl, #(_gOptionJoueurs + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:100: gotogxy(0,3);revers(i==3);gprintf(gOptionJoueurs[2]);
	ld	a, #0x03
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x03
	ld	a, #0x01
	jr	Z, 00286$
	xor	a, a
00286$:
	push	af
	inc	sp
	call	_revers
	inc	sp
	ld	hl, #(_gOptionJoueurs + 0x0004)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:101: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gameboy/awele_gb.c:102: c = getkj();
	call	_getkj
	ldhl	sp,	#2
	ld	(hl), e
;src/gameboy/awele_gb.c:103: if(c == KEY_UP && i>1) i--;
	ld	a, (hl)
	sub	a, #0x0b
	jr	NZ, 00102$
	ld	a, #0x01
	ldhl	sp,	#7
	sub	a, (hl)
	jr	NC, 00102$
	dec	(hl)
00102$:
;src/gameboy/awele_gb.c:104: if(c == KEY_DOWN && i<3) i++;
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00108$
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x03
	jr	NC, 00108$
	inc	(hl)
00108$:
;src/gameboy/awele_gb.c:105: } while(c != KEY_RETURN);
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x0d
	jp	NZ,00107$
;src/gameboy/awele_gb.c:112: switch(i)
	ldhl	sp,	#7
	ld	a, (hl)
	dec	a
	jr	Z, 00110$
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x02
	jr	Z, 00111$
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x03
	jp	Z,00128$
	jp	00139$
;src/gameboy/awele_gb.c:114: case 1:
00110$:
;src/gameboy/awele_gb.c:115: printxy(0,l,FALSE,gJ1commence);
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
;src/gameboy/awele_gb.c:116: j[0] = j[1] = 0;
	ld	hl, #(_j + 0x0001)
	ld	(hl), #0x00
	ld	hl, #_j
	ld	(hl), #0x00
;src/gameboy/awele_gb.c:117: i = 0;
	xor	a, a
	ldhl	sp,	#7
	ld	(hl), a
;src/gameboy/awele_gb.c:118: break;
	jp	00140$
;src/gameboy/awele_gb.c:119: case 2:
00111$:
;src/gameboy/awele_gb.c:120: printxy(0,l,FALSE,gJ2ordi);
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
;src/gameboy/awele_gb.c:122: j[i]=1;
	ld	hl, #(_j + 0x0001)
	ld	(hl), #0x01
;src/gameboy/awele_gb.c:123: j[1-i]=0;
	ld	hl, #_j
	ld	(hl), #0x00
;src/gameboy/awele_gb.c:124: printxy(0,++l,FALSE,gOptionProfondeur);
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
;src/gameboy/awele_gb.c:125: i=1;
	ld	c, #0x01
;src/gameboy/awele_gb.c:126: do
00118$:
;src/gameboy/awele_gb.c:128: gotogxy(17,l);
	push	bc
	ld	de, #0x0511
	push	de
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gameboy/awele_gb.c:129: wrtchr((char)(i+48));
	ld	a, c
	add	a, #0x30
	push	bc
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	call	_getkj
	pop	bc
;src/gameboy/awele_gb.c:132: if(c == KEY_UP && i<6) i++;
	ld	a, e
	sub	a, #0x0b
	jr	NZ, 00113$
	ld	a, c
	sub	a, #0x06
	jr	NC, 00113$
	inc	c
00113$:
;src/gameboy/awele_gb.c:133: if(c == KEY_DOWN && i>1) i--;
	ld	a, e
	sub	a, #0x0a
	jr	NZ, 00119$
	ld	a, #0x01
	sub	a, c
	jr	NC, 00119$
	dec	c
00119$:
;src/gameboy/awele_gb.c:134: } while(c != KEY_RETURN);
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00118$
;src/gameboy/awele_gb.c:135: prof[i]=c;
	ld	hl, #_prof
	ld	b, #0x00
	add	hl, bc
	ld	(hl), e
;src/gameboy/awele_gb.c:136: i=1;
	ld	c, #0x01
;src/gameboy/awele_gb.c:138: printxy(0,++l,FALSE,gOptionQuiCommence);
	push	bc
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
	pop	bc
;src/gameboy/awele_gb.c:139: do
00125$:
;src/gameboy/awele_gb.c:141: gotogxy(15,l);
	push	bc
	ld	de, #0x060f
	push	de
	call	_gotogxy
	add	sp, #2
	pop	bc
;src/gameboy/awele_gb.c:142: wrtchr((char)(i+48));
	ld	a, c
	add	a, #0x30
	push	bc
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	call	_getkj
	pop	bc
;src/gameboy/awele_gb.c:144: if(c == KEY_UP) i=2;
	ld	a, e
	sub	a, #0x0b
	jr	NZ, 00122$
	ld	c, #0x02
00122$:
;src/gameboy/awele_gb.c:145: if(c == KEY_DOWN) i=1;
	ld	a, e
	sub	a, #0x0a
	jr	NZ, 00126$
	ld	c, #0x01
00126$:
;src/gameboy/awele_gb.c:146: } while(c != KEY_RETURN);
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00125$
;src/gameboy/awele_gb.c:148: --i;
	ld	a, c
	add	a, #0xff
	ldhl	sp,	#7
	ld	(hl), a
;src/gameboy/awele_gb.c:149: break;
	jp	00140$
;src/gameboy/awele_gb.c:151: case 3:
00128$:
;src/gameboy/awele_gb.c:152: j[0] = j[1] = 1;
	ld	hl, #(_j + 0x0001)
	ld	(hl), #0x01
	ld	hl, #_j
	ld	(hl), #0x01
;src/gameboy/awele_gb.c:153: gotogxy(0,l);
	ld	a, #0x04
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:154: printxy(0,l,FALSE,gJ1commence);
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
;src/gameboy/awele_gb.c:155: for( i=0; i<2; i++)
	xor	a, a
	ldhl	sp,	#5
	ld	(hl+), a
	ld	(hl), #0x04
00141$:
;src/gameboy/awele_gb.c:158: gotogxy(0,++l);
	ldhl	sp,	#6
	inc	(hl)
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:159: gprintf(gJoueur[i]);
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#1
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
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	hl
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:160: gprintf(gOptionProfondeur);
	ld	hl, #_gOptionProfondeur
	push	hl
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:161: k = 1;
	ldhl	sp,	#7
	ld	(hl), #0x01
;src/gameboy/awele_gb.c:162: do
00135$:
;src/gameboy/awele_gb.c:164: gotogxy(18,l);
	ldhl	sp,	#6
	ld	d, (hl)
	ld	e,#0x12
	push	de
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:165: wrtchr((char)(c+48));((char)(k+48));
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0x30
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
;src/gameboy/awele_gb.c:166: c = getkj();
	call	_getkj
	ldhl	sp,	#2
	ld	(hl), e
;src/gameboy/awele_gb.c:167: if(c == KEY_UP && k<6) k++;
	ld	a, (hl)
	sub	a, #0x0b
	jr	NZ, 00130$
	ldhl	sp,	#7
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0x86
	jr	NC, 00130$
	inc	(hl)
00130$:
;src/gameboy/awele_gb.c:168: if(c == KEY_DOWN && k>1) k--;
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x0a
	jr	NZ, 00136$
	ldhl	sp,	#7
	ld	e, (hl)
	ld	a,#0x01
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00313$
	bit	7, d
	jr	NZ, 00314$
	cp	a, a
	jr	00314$
00313$:
	bit	7, d
	jr	Z, 00314$
	scf
00314$:
	jr	NC, 00136$
	ldhl	sp,	#7
	dec	(hl)
00136$:
;src/gameboy/awele_gb.c:169: } while(c != KEY_RETURN);
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00135$
;src/gameboy/awele_gb.c:170: prof[i]=k;
;c
	ld	de, #_prof
	ldhl	sp,	#5
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(de), a
;src/gameboy/awele_gb.c:155: for( i=0; i<2; i++)
	dec	hl
	dec	hl
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x02
	jp	C, 00141$
;src/gameboy/awele_gb.c:172: i=0;
	xor	a, a
	inc	hl
	inc	hl
	ld	(hl), a
;src/gameboy/awele_gb.c:173: break;
	jr	00140$
;src/gameboy/awele_gb.c:174: default:
00139$:
;src/gameboy/awele_gb.c:178: exit(5);
	ld	hl, #0x0005
	push	hl
	call	_exit
	add	sp, #2
;src/gameboy/awele_gb.c:179: }
00140$:
;src/gameboy/awele_gb.c:182: clrscr();
	call	_clrscr
;src/gameboy/awele_gb.c:183: gotogxy(0,0);gprintf(gPositionsEvaluees);
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
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:185: return(i);
	ldhl	sp,	#7
	ld	e, (hl)
;src/gameboy/awele_gb.c:187: }
	add	sp, #8
	ret
;src/gameboy/awele_gb.c:189: void affPlateau(UBYTE *p)
;	---------------------------------
; Function affPlateau
; ---------------------------------
_affPlateau::
;src/gameboy/awele_gb.c:192: gotogxy(0,1);
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:193: for( i=2*NCASES; i>NCASES; i--)
	ld	bc, #0x0010
00121$:
;src/gameboy/awele_gb.c:195: gotogxy(2*(2*NCASES-i+1),1);
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
;src/gameboy/awele_gb.c:196: if(i%2)  color(BLACK, WHITE, SOLID);
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
;src/gameboy/awele_gb.c:197: else     color(WHITE, DKGREY, SOLID);
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
;src/gameboy/awele_gb.c:199: gprintf("%d", i);
	push	bc
	push	bc
	ld	hl, #___str_0
	push	hl
	call	_gprintf
	add	sp, #4
	pop	bc
;src/gameboy/awele_gb.c:193: for( i=2*NCASES; i>NCASES; i--)
	dec	bc
	ld	e, b
	ld	d, #0x00
	ld	a, #0x08
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00200$
	bit	7, d
	jr	NZ, 00201$
	cp	a, a
	jr	00201$
00200$:
	bit	7, d
	jr	Z, 00201$
	scf
00201$:
	jr	C, 00121$
;src/gameboy/awele_gb.c:202: for( i=2*NCASES; i>NCASES; i--)
	ld	bc, #0x0010
00123$:
;src/gameboy/awele_gb.c:204: gotogxy(2*(2*NCASES-i+1),3);//+i%2);
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
;src/gameboy/awele_gb.c:205: if(i%2)  color(BLACK, WHITE, SOLID);
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
;src/gameboy/awele_gb.c:206: else     color(WHITE, DKGREY, SOLID);
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
;src/gameboy/awele_gb.c:207: gprintf("%d", p[i]);
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
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_gprintf
	add	sp, #4
	pop	de
	pop	bc
;src/gameboy/awele_gb.c:208: if(p[i]<10) wrtchr(' ');
	ld	a, (de)
	sub	a, #0x0a
	jr	NC, 00124$
	push	bc
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	pop	bc
00124$:
;src/gameboy/awele_gb.c:202: for( i=2*NCASES; i>NCASES; i--)
	dec	bc
	ld	e, b
	ld	d, #0x00
	ld	a, #0x08
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00202$
	bit	7, d
	jr	NZ, 00203$
	cp	a, a
	jr	00203$
00202$:
	bit	7, d
	jr	Z, 00203$
	scf
00203$:
	jp	C, 00123$
;src/gameboy/awele_gb.c:212: color(WHITE, DKGREY, SOLID);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gameboy/awele_gb.c:213: gotogxy(0,4);
	ld	a, #0x04
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:214: gprintf("%d",p[KALAH2]);
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
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_0
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:216: gotogxy(2*NCASES+2,4);
	ld	de, #0x0412
	push	de
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:217: gprintf("%d", p[KALAH1]);
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
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_0
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:219: for( i=0; i<NCASES; i++)
	ld	bc, #0x0000
00125$:
;src/gameboy/awele_gb.c:221: gotogxy(2*i+2,5);//+i%2);
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
;src/gameboy/awele_gb.c:222: if(i%2)     color(WHITE, DKGREY, SOLID);
	push	bc
	ld	hl, #0x0002
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	pop	bc
	ld	a, d
	or	a, e
	jr	Z, 00112$
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
	jr	00113$
00112$:
;src/gameboy/awele_gb.c:223: else     color(BLACK, WHITE, SOLID);
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
00113$:
;src/gameboy/awele_gb.c:225: gprintf("%d", p[i]);
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
	push	hl
	ld	hl, #___str_0
	push	hl
	call	_gprintf
	add	sp, #4
	pop	de
	pop	bc
;src/gameboy/awele_gb.c:226: if(p[i]<10) wrtchr(' ');
	ld	a, (de)
	sub	a, #0x0a
	jr	NC, 00126$
	push	bc
	ld	a, #0x20
	push	af
	inc	sp
	call	_wrtchr
	inc	sp
	pop	bc
00126$:
;src/gameboy/awele_gb.c:219: for( i=0; i<NCASES; i++)
	inc	bc
	ld	a, c
	sub	a, #0x08
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00125$
;src/gameboy/awele_gb.c:229: for( i=0; i<NCASES; i++)
	ld	bc, #0x0000
00127$:
;src/gameboy/awele_gb.c:231: gotogxy(2*i+2,7);
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
;src/gameboy/awele_gb.c:232: if(i%2)     color(WHITE, DKGREY, SOLID);
	push	bc
	ld	hl, #0x0002
	push	hl
	push	bc
	call	__modsint
	add	sp, #4
	pop	bc
	ld	a, d
	or	a, e
	jr	Z, 00118$
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
	jr	00119$
00118$:
;src/gameboy/awele_gb.c:233: else     color(BLACK, WHITE, SOLID);
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
00119$:
;src/gameboy/awele_gb.c:234: gprintf("%d", i);
	push	bc
	push	bc
	ld	hl, #___str_0
	push	hl
	call	_gprintf
	add	sp, #4
	pop	bc
;src/gameboy/awele_gb.c:229: for( i=0; i<NCASES; i++)
	inc	bc
	ld	a, c
	sub	a, #0x08
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00127$
;src/gameboy/awele_gb.c:236: }
	ret
___str_0:
	.ascii "%d"
	.db 0x00
;src/gameboy/awele_gb.c:238: void effaceLigne(UINT8 l)
;	---------------------------------
; Function effaceLigne
; ---------------------------------
_effaceLigne::
;src/gameboy/awele_gb.c:241: color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gameboy/awele_gb.c:242: gotogxy(0,l);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:243: for(i=0;i<20;i++) wrtchr(' ');
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
;src/gameboy/awele_gb.c:244: }
	ret
;src/gameboy/awele_gb.c:246: void effaceChr(UINT8 l, UINT16 n)
;	---------------------------------
; Function effaceChr
; ---------------------------------
_effaceChr::
;src/gameboy/awele_gb.c:249: color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gameboy/awele_gb.c:250: gotogxy(0,l);
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:251: for(i=0;i<n;i++) wrtchr(' ');
	ld	bc, #0x0000
00103$:
	ld	e, c
	ld	d, b
	ldhl	sp,	#3
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
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
;src/gameboy/awele_gb.c:252: }
	jr	00103$
;src/gameboy/awele_gb.c:254: void clrscr()
;	---------------------------------
; Function clrscr
; ---------------------------------
_clrscr::
;src/gameboy/awele_gb.c:256: effaceChr(0,360);
	ld	hl, #0x0168
	push	hl
	xor	a, a
	push	af
	inc	sp
	call	_effaceChr
	add	sp, #3
;src/gameboy/awele_gb.c:257: }
	ret
;src/gameboy/awele_gb.c:259: void afficherResultats(UBYTE k1, UBYTE k2)
;	---------------------------------
; Function afficherResultats
; ---------------------------------
_afficherResultats::
;src/gameboy/awele_gb.c:262: gotogxy(0,12);
	ld	a, #0x0c
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:263: color(WHITE, DKGREY, SOLID);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gameboy/awele_gb.c:265: if( k1>k2 )
	ldhl	sp,	#3
	ld	a, (hl-)
	sub	a, (hl)
	jr	NC, 00105$
;src/gameboy/awele_gb.c:267: gprintf(gJoueur[0]);
	ld	hl, #_gJoueur
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:268: gprintf(gVainqueur);
	ld	hl, #_gVainqueur
	push	hl
	call	_gprintf
	add	sp, #2
	jr	00106$
00105$:
;src/gameboy/awele_gb.c:270: else if( k1==k2 )
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, (hl)
	jr	NZ, 00102$
;src/gameboy/awele_gb.c:271: gprintf(gEgalite);
	ld	hl, #_gEgalite
	push	hl
	call	_gprintf
	add	sp, #2
	jr	00106$
00102$:
;src/gameboy/awele_gb.c:274: gprintf(gJoueur[1]);
	ld	hl, #(_gJoueur + 0x0002)
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:275: gprintf(gVainqueur);
	ld	hl, #_gVainqueur
	push	hl
	call	_gprintf
	add	sp, #2
00106$:
;src/gameboy/awele_gb.c:278: revers(FALSE);
	xor	a, a
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gameboy/awele_gb.c:279: }
	ret
;src/gameboy/awele_gb.c:281: void afficherPosEval()
;	---------------------------------
; Function afficherPosEval
; ---------------------------------
_afficherPosEval::
;src/gameboy/awele_gb.c:283: gotogxy(21,0);
	xor	a, a
	ld	d,a
	ld	e,#0x15
	push	de
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:284: gprintf("%d   ",posEval);
	ld	hl, #_posEval
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #___str_1
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:285: }
	ret
___str_1:
	.ascii "%d   "
	.db 0x00
;src/gameboy/awele_gb.c:287: void afficherAttente(UBYTE joueur, UBYTE casejouee)
;	---------------------------------
; Function afficherAttente
; ---------------------------------
_afficherAttente::
;src/gameboy/awele_gb.c:294: gotogxy(0,14);
	ld	a, #0x0e
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:295: color(BLACK, WHITE, SOLID);
	xor	a, a
	push	af
	inc	sp
	xor	a, a
	ld	d,a
	ld	e,#0x03
	push	de
	call	_color
	add	sp, #3
;src/gameboy/awele_gb.c:296: gprintf("%d joue en ", joueur);
	ldhl	sp,	#2
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	hl, #___str_2
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:297: gprintf("%d   ", casejouee);
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	hl, #___str_3
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:298: gotogxy(2,15);
	ld	de, #0x0f02
	push	de
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:299: color(WHITE, DKGREY, SOLID);
	xor	a, a
	ld	d,a
	ld	e,#0x02
	push	de
	xor	a, a
	push	af
	inc	sp
	call	_color
	add	sp, #3
;src/gameboy/awele_gb.c:300: gprint("B pour continuer");
	ld	hl, #___str_4
	push	hl
	call	_gprint
	add	sp, #2
;src/gameboy/awele_gb.c:301: waitpad(J_B);
	ld	a, #0x20
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/gameboy/awele_gb.c:302: effaceLigne(15);
	ld	a, #0x0f
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gameboy/awele_gb.c:303: effaceLigne(16);
	ld	a, #0x10
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gameboy/awele_gb.c:304: }
	ret
___str_2:
	.ascii "%d joue en "
	.db 0x00
___str_3:
	.ascii "%d   "
	.db 0x00
___str_4:
	.ascii "B pour continuer"
	.db 0x00
;src/gameboy/awele_gb.c:306: void effacerAttente()
;	---------------------------------
; Function effacerAttente
; ---------------------------------
_effacerAttente::
;src/gameboy/awele_gb.c:308: effaceLigne(12);
	ld	a, #0x0c
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gameboy/awele_gb.c:309: effaceLigne(13);
	ld	a, #0x0d
	push	af
	inc	sp
	call	_effaceLigne
	inc	sp
;src/gameboy/awele_gb.c:310: }
	ret
;src/gameboy/awele_gb.c:312: UBYTE choixJoueur(UBYTE joueur)
;	---------------------------------
; Function choixJoueur
; ---------------------------------
_choixJoueur::
	add	sp, #-19
;src/gameboy/awele_gb.c:317: gotogxy(0,10);
	ld	a, #0x0a
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
;src/gameboy/awele_gb.c:318: gprintf(gJoueur[joueur]);
	ldhl	sp,	#21
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
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:319: gprintf(gQuelleCase); 
	ld	hl, #_gQuelleCase
	push	hl
	call	_gprintf
	add	sp, #2
;src/gameboy/awele_gb.c:321: for(c=joueur*(NCASES+1);!jeu[c];c++);
	ldhl	sp,	#21
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, a
	add	a, a
	add	a, c
	ldhl	sp,	#16
	ld	(hl), a
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#16
	ld	c, (hl)
00124$:
	ld	hl, #_jeu
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jr	NZ, 00141$
	inc	c
	jr	00124$
00141$:
	ldhl	sp,	#3
	ld	(hl), c
;src/gameboy/awele_gb.c:322: y= 6-joueur*2;
	ldhl	sp,	#21
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	add	a, a
	inc	hl
	ld	(hl), a
	ld	a, #0x06
	sub	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
;src/gameboy/awele_gb.c:323: do
	ldhl	sp,	#21
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
	ldhl	sp,	#5
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,	#17
	ld	a, (hl)
	ld	c, a
	add	a, a
	add	a, c
	add	a, a
	add	a, c
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, #0x01
	ldhl	sp,	#18
	sub	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
00120$:
;src/gameboy/awele_gb.c:325: x=7+(7*joueur+(1-2*joueur)*(c-joueur*(NCASES+1)))*3;
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#2
	sub	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	__mulschar
	add	sp, #2
	ld	a, e
	ldhl	sp,	#10
	add	a, (hl)
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x07
	ldhl	sp,	#13
	ld	(hl), a
;src/gameboy/awele_gb.c:326: gotogxy(x,y);revers(TRUE);gprintf("%2d", jeu[c]);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ld	a, #0x01
	push	af
	inc	sp
	call	_revers
	inc	sp
;c
	ld	de, #_jeu
	ldhl	sp,	#3
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_5
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:330: do k = getkj(); while(!k);
00102$:
	call	_getkj
	ldhl	sp,	#16
	ld	(hl), e
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/gameboy/awele_gb.c:331: if(k == KEY_LEFT)
	ld	a, (hl)
	sub	a, #0x08
	jr	NZ, 00108$
;src/gameboy/awele_gb.c:333: gotogxy(x,y);revers(FALSE);gprintf("%2d", jeu[c]);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
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
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	ld	hl, #___str_5
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:334: c-=(1-2*joueur);
	ldhl	sp,	#12
	ld	a, (hl-)
	sub	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	jr	00109$
00108$:
;src/gameboy/awele_gb.c:337: else if(k == KEY_RIGHT)
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x09
	jr	NZ, 00109$
;src/gameboy/awele_gb.c:339: gotogxy(x,y);revers(FALSE);gprintf("%2d", jeu[c]);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
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
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_5
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:340: c+=(1-2*joueur);
	ldhl	sp,	#12
	ld	a, (hl-)
	add	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
00109$:
;src/gameboy/awele_gb.c:343: if(c<joueur*(NCASES+1)) c=joueur*(NCASES+1);
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	xor	a, a
	inc	hl
	ld	(hl), a
;src/gameboy/awele_gb.c:344: else if(c>=(joueur+1)*NCASES+joueur) c=(joueur+1)*NCASES+joueur-1;
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
	ldhl	sp,	#19
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#18
	ld	(hl), a
;src/gameboy/awele_gb.c:343: if(c<joueur*(NCASES+1)) c=joueur*(NCASES+1);
	ldhl	sp,	#14
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
	jr	Z, 00199$
	bit	7, d
	jr	NZ, 00200$
	cp	a, a
	jr	00200$
00199$:
	bit	7, d
	jr	Z, 00200$
	scf
00200$:
	jr	NC, 00113$
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	jr	00114$
00113$:
;src/gameboy/awele_gb.c:344: else if(c>=(joueur+1)*NCASES+joueur) c=(joueur+1)*NCASES+joueur-1;
	ldhl	sp,	#14
	ld	e, l
	ld	d, h
	ldhl	sp,	#17
	ld	a, (de)
	sub	a, (hl)
	inc	hl
	inc	de
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00201$
	bit	7, d
	jr	NZ, 00202$
	cp	a, a
	jr	00202$
00201$:
	bit	7, d
	jr	Z, 00202$
	scf
00202$:
	jr	C, 00114$
	ldhl	sp,	#21
	ld	a, (hl)
	ld	l, a
	inc	l
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	a, l
	add	a, #0xff
	ldhl	sp,	#3
	ld	(hl), a
00114$:
;src/gameboy/awele_gb.c:325: x=7+(7*joueur+(1-2*joueur)*(c-joueur*(NCASES+1)))*3;
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#12
;src/gameboy/awele_gb.c:346: x=7+(7*joueur+(1-2*joueur)*(c-joueur*(NCASES+1)))*3;
	ld	(hl), a
	ldhl	sp,	#7
	sub	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#12
	ld	a, (hl)
	push	af
	inc	sp
	call	__mulschar
	add	sp, #2
	ld	a, e
	ldhl	sp,	#10
	add	a, (hl)
	ld	c, a
	add	a, a
	add	a, c
	add	a, #0x07
	ldhl	sp,	#13
	ld	(hl), a
;src/gameboy/awele_gb.c:347: gotogxy(x,y);revers(TRUE);gprintf("%2d", jeu[c]);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
	ld	a, (hl)
	push	af
	inc	sp
	call	_gotogxy
	add	sp, #2
	ld	a, #0x01
	push	af
	inc	sp
	call	_revers
	inc	sp
;src/gameboy/awele_gb.c:326: gotogxy(x,y);revers(TRUE);gprintf("%2d", jeu[c]);
;c
	ld	de, #_jeu
	ldhl	sp,	#3
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#16
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#15
;src/gameboy/awele_gb.c:347: gotogxy(x,y);revers(TRUE);gprintf("%2d", jeu[c]);
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_5
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:350: } while(k != KEY_RETURN);
	ldhl	sp,	#16
	ld	a, (hl)
	sub	a, #0x0d
	jp	NZ,00102$
;src/gameboy/awele_gb.c:351: gotogxy(x,y);revers(FALSE);gprintf("%2d", jeu[c]);
	ldhl	sp,	#4
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#14
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
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	hl, #___str_5
	push	hl
	call	_gprintf
	add	sp, #4
;src/gameboy/awele_gb.c:353: } while(c<joueur*(NCASES+1) || c>=(joueur+1)*NCASES+joueur || !jeu[c]);
	ldhl	sp,	#3
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#8
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00205$
	bit	7, d
	jr	NZ, 00206$
	cp	a, a
	jr	00206$
00205$:
	bit	7, d
	jr	Z, 00206$
	scf
00206$:
	jp	C, 00120$
	ldhl	sp,	#17
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00207$
	bit	7, d
	jr	NZ, 00208$
	cp	a, a
	jr	00208$
00207$:
	bit	7, d
	jr	Z, 00208$
	scf
00208$:
	jp	NC, 00120$
	ldhl	sp,#14
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00120$
;src/gameboy/awele_gb.c:355: return(c);
	ldhl	sp,	#3
	ld	e, (hl)
;src/gameboy/awele_gb.c:356: }
	add	sp, #19
	ret
___str_5:
	.ascii "%2d"
	.db 0x00
	.area _CODE
	.area _CABS (ABS)
