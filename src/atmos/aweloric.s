; source : cc65 chess version oric :
;)              _
;)  ___ ___ _ _|_|___ ___
;) |  _| .'|_'_| |_ -|_ -|
;) |_| |__,|_,_|_|___|___|
;)         raxiss (c) 2020

.export __TAPE__:abs = 1
.import __AUTORUN__, __PROGFLAG__
.import __BASHEAD_START__, __MAIN_LAST__

.segment "TAPE"

            .byte   $16, $16, $16, $24, $00, $00
            .byte   <__PROGFLAG__
            .byte   <__AUTORUN__
            .dbyt   __MAIN_LAST__ - 1
            .dbyt   __BASHEAD_START__
            .byte   $00
            .byte   "AWELE",0

; ======================================================================
.segment "CODE"


; ----------------------------------------------------------------------
scrnoff       = $a000
rst           = $fffc
irq           = $fffe

hires_atmos   = $ec33
hires_oric1   = $e9bb

getkey_atmos  = $eb78
getkey_oric1  = $e905

; ----------------------------------------------------------------------

; ======================================================================
_setup:
              lda   irq
              cmp   #$28
              beq   isOric1

isAtmos:      lda   #<hires_atmos
              sta   _hires+1
              lda   #>hires_atmos
              sta   _hires+2
              lda   #<getkey_atmos
              sta   _getkey+1
              lda   #>getkey_atmos
              sta   _getkey+2
              jmp   _hires

isOric1:      lda   #<hires_oric1
              sta   _hires+1
              lda   #>hires_oric1
              sta   _hires+2
              lda   #<getkey_oric1
              sta   _getkey+1
              lda   #>getkey_oric1
              sta   _getkey+2

; ----------------------------------------------------------------------
_hires:       rts
              jsr   $f00d
              lda   #$08
              sta   $26a
              rts

; ----------------------------------------------------------------------
_quit:        lda   rst
              sta   l00_aptr+1
              lda   rst+1
              sta   l00_aptr+2
              sei
l00_aptr:     jmp   $dead

; ----------------------------------------------------------------------
_getkey:      jsr   $f00d
              and   #$7f
              beq   test
              cmp   #$0d
test:
              ldx   #$00
              rts

; ======================================================================

_cursorno:
        lda $026A
        ora #%00001000
        and #%01111110      ; and #!%10000000 <-- doesn't work
        sta $026A
        rts
        

.export _getkey

.export _quit
.export _setup
.export _hires
.export _cursorno