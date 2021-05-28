/**
 * @file globals.h
 * définition des variables globales pour l'affichage
 */

#ifndef _GLOBALS_H_
#define _GLOBALS_H_

/*-----------------------------------------------------------------------*/
// Display labels
GLOBAL char*	gTypeJoueurs[];
GLOBAL char	g2Joueurs[];
GLOBAL char	g1Joueur[];
GLOBAL char	g2Ordinateurs[];
GLOBAL char	gQuiCommence[];
GLOBAL char	gJ1commence[];
GLOBAL char	gJ2ordi[];
GLOBAL char	gProfondeur[];
GLOBAL char	gJoueursType[];
GLOBAL char	gJ1[];
GLOBAL char	gJ2[];
GLOBAL char*	gJoueur[];
GLOBAL char	gPositionsEvaluees[];
GLOBAL char	gQuelleCase[];
GLOBAL char	gVainqueur[];
GLOBAL char	gEgalite[];
GLOBAL char	gVous[];
GLOBAL char	gMoi[];
GLOBAL char	gJ1[];
GLOBAL char	gJ2[];
GLOBAL char	gO1[];
GLOBAL char	gO2[];
GLOBAL char	gOptionNbCases[];
GLOBAL char	gOptionNbGrains[];
GLOBAL char	gOptionCompte[];
GLOBAL char*	gComptes[];
GLOBAL char*	gNonOui[];
GLOBAL char	gOptionSauteKalah[];

GLOBAL char	gTitre[];
GLOBAL char	gTitreCredits[];

GLOBAL char	gAppuyerTouche[];
GLOBAL char	gRejouer[];
GLOBAL char	gAppuyerReturn[];
GLOBAL char	gEscMenu[];
GLOBAL char	gJoueurJoueCase[];
GLOBAL char*	gPopAbandonner[];
GLOBAL char*	gPopQuitter[];

GLOBAL char	gReglesTitre[];
GLOBAL char	gRegles[];
GLOBAL char*	gJ[3][2];

GLOBAL char	gMenuRegles[];
GLOBAL char	gMenuJoueurs[];
GLOBAL char	gMenuOptions[];
GLOBAL char	gMenuOK[];
GLOBAL char	gMenuJeu[];

GLOBAL char	gJeuRetour[];
GLOBAL char	gJeuCommencer[];
GLOBAL char	gJeuRegles[];
GLOBAL char	gJeuAbandonner[];
GLOBAL char	gJeuQuitter[];

GLOBAL UBYTE	gNbCases;
GLOBAL UBYTE	gNbGrains;
GLOBAL BOOLEAN 	gSauteKalah;
GLOBAL UBYTE	gCompte;
GLOBAL UBYTE	gLongueurPlateau;

GLOBAL UWORD	gPosEval;

GLOBAL UBYTE	gScreenX,gScreenY;
GLOBAL UBYTE	gPlateauX,gPlateauY;
GLOBAL UBYTE	gChoixJoueurY;
GLOBAL UBYTE	gAttenteX,gAttenteY;
GLOBAL UBYTE	gPosEvalX;
GLOBAL UBYTE	gPosEvalY;

GLOBAL UBYTE	gMenuY;
GLOBAL UBYTE	gMenuReglesX;
GLOBAL UBYTE	gMenuJoueursX;
GLOBAL UBYTE	gMenuOptionsX;
GLOBAL UBYTE	gMenuOKX;
GLOBAL UBYTE	gMenuJeuX;

#endif //_GLOBALS_H_