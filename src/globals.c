/**
 *	@file globals.c
 * initialisation des variables globales pour l'affichage
 */
 
#include <string.h>
#include "mes_types.h"
#include "globals.h"

char	gMenuRegles[]="Règles";
char	gMenuJoueurs[]="Joueurs";
char	gMenuOptions[]="Options";
char	gMenuOK[]="OK";
char	gMenuJeu[]="Jeu";
//char*	gTypeJoueurs[]={"2 joueurs     ","1 joueur      ","2 ordinateurs "};
char*	gTypeJoueurs[]={"2 joueurs","1 joueur","2 ordinateurs"};
char	g2Joueurs[]=	"2 joueurs     ";
char	g1Joueur[]=		"1 joueur      ";
char	g2Ordinateurs[]="2 ordinateurs ";
char	gJoueursType[]=	"Type Joueurs >";
char	gQuiCommence[]=	"Qui commence >";
char	gProfondeur[]=	"Niveau       >";

char	gJ1commence[]="Le joueur 1 commence ";
char	gJ2ordi[]="L'ordinateur est le joueur 2 ";
char*	gJoueur[]={"Joueur 1","Joueur 2"};
char*	gJ[3][2]={{"Joueur 1","Joueur 2"},{"  Vous  ","  Moi   "},{" Ordi 1 "," Ordi 2 "}};
//char	gJ[]={{"Joueur 1","Joueur 2"},{"Ordi 1  ","ORDI 2  "},{"Vous    ","Moi     "}};
char	gPositionsEvaluees[]="positions évaluées    ";  //"positions _valu_es :      ";
char	gOptionNbCases[]	= "Nombre cases";
char	gOptionNbGrains[]	= "Nombre graines";
char	gOptionSauteKalah[] = "Saute kalah";
char*	gNonOui[] = {"Non","Oui"};
char	gOptionCompte[] 	= "Ajout reste";
char*	gComptes[]={"Aucun","mien ","adv. "};

char	gJeuRetour[]=	"Retour jeu";
char	gJeuCommencer[]=	"Commencer";
char	gJeuRegles[]=	"Règles";
char	gJeuAbandonner[]="Abandonner";
char	gJeuQuitter[]=	"Quitter";

char	gTitre[]="AWELE-KALAHA";
char	gTitreCredits[]="v1.1 kyex mmm yyyy";
char 	gVous[]="Joueur  ";
char 	gMoi[]=	"Ordi    ";
char	gJ1[]=	"Joueur 1";
char	gJ2[]=	"Joueur 2";
char	gO1[]=	" Ordi 1 ";
char	gO2[]=	" Ordi 2 ";

char	gQuelleCase[]=" que jouez-vous ? ";
char	gVainqueur[]=" vainqueur";
char	gEgalite[]=" Egalité ";

char	gAppuyerTouche[]="Appuyer sur une touche pour continuer";
char	gRejouer[]="Rejouer ?";
char	gAppuyerReturn[] = "<RETURN> : continuer";
char	gEscMenu[] = "<ESC> : Menu";
char	gJoueurJoueCase[]="Le joueur %u joue la case %u           \r\n";

char*	gPopAbandonner[] ={"Voulez-vous abandonner","la partie ?"};
char*	gPopQuitter[] ={"Voulez-vous quitter ?",""};

//char	gRegles[]="0123456789012345678901234567890123456789
char	gReglesTitre[]=" REGLES DE L'AWELE-KAHLAHA";
char	gRegles[]="Les joueurs placent leurs graines par $\
dans les trous de leur rangée.\
On ne place aucune graine dans le Kalaha\
A son tour de jeu, un joueur prend les\
graines dans un trou de la rangée proche\
de lui et les sème une par une dans\
chacun des trous qui suivent ainsi que\
dans *** Kalaha en sens anti-horaire.\
Si le joueur sème sa dernière graine\
dans son Kalaha, il peut rejouer. \
Si le joueur sème sa dernière graine\
dans un trou vide de sa propre rangée,il\
capture les graines situées dans le trou\
en face et les place dans son Kalaha\
Puis c'est a son adversaire de jouer.\
Si le joueur sème sa dernière graine\
dans un trou qui n'était pas vide, son\
tour se termine, c'est à son adversaire\
de jouer.\
\f\
La partie se termine quand un joueur ne\
peut plus jouer car lors de son tour de\
jeu, sa rangée est vide.\
#Il récolte les graines restantes de la\
#rangée opposée et les place dans\
#son kalaha.\
@Son adversaire récolte ses graines\
@restantes et les ajoute à son kalaha\
 \
Le vaiqueur est le joueur ayant le plus\
de graines dans son kalaha.";
 //3456789 123456789 123456789 123456789^  

UBYTE	gNbCases = 8;
UBYTE	gNbGrains = 4;
UBYTE	gCompte = 0;	// = Aucun
BOOLEAN 	gSauteKalah = FALSE;
UBYTE	gLongueurPlateau;
UBYTE	gScreenX,gScreenY;
UBYTE	gPlateauX=0;
UBYTE	gPlateauY=1;
UBYTE	gChoixJoueurY=10;
UBYTE	gAttenteX=0;
UBYTE	gAttenteY=12;
UBYTE	gPosEvalX=20;
UBYTE	gPosEvalY=0;

UBYTE	gMenuY=0;
UBYTE	gMenuReglesX=1;
UBYTE	gMenuJeuX = 1;
UBYTE	gMenuJoueursX=8;
UBYTE	gMenuOptionsX = 17;
UBYTE	gMenuOKX=30;
