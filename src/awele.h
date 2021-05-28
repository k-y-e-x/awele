/**
 * @file awele.h
 * Déclaration des fonctions et define du projet
 */
 
#ifndef	AWELE_H
/** Define pour ne pas repasser dans ce .h plusieurs fois */
#define	AWELE_H
#include "mes_types.h"
#include "globals.h"

// definition des fonctions publiques
WORD minmax(UBYTE* a, WORD b, WORD c, UBYTE d, UBYTE e);
WORD maxmin(UBYTE*, WORD , WORD , UBYTE , UBYTE);
WORD eval(UBYTE *, UBYTE);
WORD evalFin(UBYTE *, UBYTE);

BOOLEAN jeuPoss(UBYTE *p,UBYTE j);
BOOLEAN jouer(UBYTE *p,UBYTE *pi,UBYTE c,UBYTE j);
WORD alphabeta(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf, UBYTE n, UBYTE *res);
UBYTE afficherMenu(UBYTE n); 
BOOLEAN afficherResultats(UBYTE k1, UBYTE k2);
void afficherPosEval(void);
BOOLEAN afficherAttente(UBYTE joueur, UBYTE casejouee);
void afficherRegles(void);
void effacerAttente(void);
void initJoystick(void);
UBYTE getkj(void);
void afficherPlateau(UBYTE*);
void init(void);
void initPlateau(void);
void initPartie(BOOLEAN tout);
void ecranTitre(void);

UBYTE choixJoueur(UBYTE joueur);

void dbgprint(STRPTR s);

//void clputs(STRPTR);
void cplotc(char);


/// Define divers
/*-----------------------------------------------------------------------*/
#define KEY_LEFT        8
#define KEY_RIGHT       9
#define KEY_DOWN        10
#define KEY_UP          11
#define KEY_RETURN		13
#define KEY_ESC			27
/*-----------------------------------------------------------------------*/
 
// defines à transformer en variables pour menu options ?
// On garde  NCASES et NGRAINScomme valeurs maximales des nouvelles  variables globales
#define NCASES 8
#define NGRAINS 6
#define LGPLAT (2*(NCASES+1))

#define KALAH1 gNbCases
#define KALAH2 (2*gNbCases+1)

#define PLUS_INFINI 1000
#define MOINS_INFINI -1000


// variables globales de jeu => à passer dans globals.h (ce n'est pas des chaines)?
extern UBYTE jeu[LGPLAT], prof[2], tab[20], j[2];

// gestion CC65 ou GBDK (et autres un jour, ou pas) via option compilation -D
// donc le else laisse le printf standard
// #if defined(CC65) 
// #define PRINTF cprintf
// #elif defined(GB)
// #define PRINTF gprintf
// #else
// #define PRINTF printf
// #endif

#endif	/* AWELE_H */