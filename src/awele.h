/**
 * @file awele.h
 * @brief	Déclaration des fonctions et #define du projet
 */
 
#ifndef	AWELE_H
/** Define pour ne pas repasser dans ce .h plusieurs fois */
#define	AWELE_H
#include "mes_types.h"

WORD minmax(UBYTE* a, WORD b, WORD c, UBYTE d, UBYTE e);
WORD maxmin(UBYTE*, WORD , WORD , UBYTE , UBYTE);
WORD eval(UBYTE *, UBYTE);

BOOLEAN jeuPoss(UBYTE *p,UBYTE j);
BOOLEAN jouer(UBYTE *p,UBYTE *pi,UBYTE c,UBYTE j);
WORD alphabeta(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf, UBYTE n, UBYTE *res);
UBYTE menuOptions(UBYTE n); 
BOOLEAN afficherResultats(UBYTE k1, UBYTE k2);
void afficherPosEval(void);
void afficherAttente(UBYTE joueur, UBYTE casejouee);
void afficherRegles(void);
void effacerAttente(void);
void initJoystick(void);
UBYTE getkj(void);
void afficherPlateau(UBYTE*);
void initPlateau(void);
UBYTE choixJoueur(UBYTE joueur);

void dbgprint(STRPTR s);

void clputs(STRPTR);
void cplotc(char);


/*-----------------------------------------------------------------------*/
#define KEY_LEFT        8
#define KEY_RIGHT       9
#define KEY_DOWN        10
#define KEY_UP          11
#define KEY_RETURN		13
#define KEY_ESC			27
/*-----------------------------------------------------------------------*/
 
// defines à transformer en variables pour menu options ?
#define NCASES 8
#define LGPLAT (2*(NCASES+1))
#define KALAH1 NCASES
#define KALAH2 (2*NCASES+1)
#define NGRAINS 4
#define PLUS_INFINI 1000
#define MOINS_INFINI -1000

extern UBYTE jeu[LGPLAT], prof[2], tab[20], j[2];

// gestion CC65 ou GBDK (et autres un jour, ou pas) via option compilation -D
// donc le else laisse le printf standard
#if defined(CC65) 
#define PRINTF cprintf
#elif defined(GB)
#define PRINTF gprintf
#else
#define PRINTF printf
#endif

#endif	/* AWELE_H */