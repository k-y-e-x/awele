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
