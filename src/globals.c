#include <string.h>
#include "mes_types.h"
#include "globals.h"



char*	gOptionJoueurs[]={"2 joueurs    ","1 joueur     ","2 ordinateurs"};
char	gOption2Joueurs[]="2 joueurs    ";
char	gOption1Joueur[]= "1 joueur     ";
char	gOption2Ordinateurs[]= "2 ordinateurs";
char	gOptionQuiCommence[]="Quel joueur commence ? ";
char	gJ1commence[]="Le joueur 1 commence ";
char	gJ2ordi[]="L'ordinateur est le joueur 2 ";
char	gOptionProfondeur[]="Profondeur recherche ? ";
char*	gJoueur[]={"Joueur 1","Joueur 2"};
char*	gJ[3][2]={{"Joueur 1","Joueur 2"},{"Vous    ","Moi     "},{"Ordi 1  ","Ordi 2  "}};
//char	gJ[]={{"Joueur 1","Joueur 2"},{"Ordi 1  ","ORDI 2  "},{"Vous    ","Moi     "}};
char	gPositionsEvaluees[]="positions �valu�es    ";  //"positions _valu_es :      ";

char 	gVous[]="Vous    ";
char 	gMoi[]="Moi     ";
char	gJ1[]="Joueur 1";
char	gJ2[]="Joueur 2";
char	gO1[]="Ordi 1  ";
char	gO2[]="Ordi 2  ";

char	gQuelleCase[]=" que jouez-vous ? ";
char	gVainqueur[]=" vainqueur";
char	gEgalite[]=" Egalit� ";

char	gRegles[]="       REGLES DE L'AWELE-KAHLAHA\r\
Les joueurs placent leurs graines par 4\r\
dans les trous de leur rang�e.\r\
On ne place aucune graine dans le KalahaA son tour de jeu, un joueur prend les\r\
graines dans un trou de la rang�e prochede lui et les s�me une par une dans\r\
chacun des trous qui suivent ainsi que\r\
dans son Kalaha en sens anti-horaire.\r\
Si le joueur s�me sa derni�re graine\r\
dans son Kalaha, il peut rejouer. \r\
Si le joueur s�me sa derni�re graine\r\
dans un trou vide de sa propre rang�e,ilcapture les graines situ�es dans le trouen face et les place dans son Kalaha\r\
Puis c'est a son adversaire de jouer.\r\
Si le joueur s�me sa derni�re graine\r\
dans un trou qui n'�tait pas vide, son\r\
tour se termine, c'est � son adversaire de jouer.\r\
\
La partie se termine quand un joueur\r\
ne peux plus jouer car lors de son tour\r\
de jeu, sa rang�e est vide.";

char	gMenuRegles[]="R�gles";
char	gMenuJoueurs[]="Joueurs";
char	gMenuOptions[]="Options";
char	gMenuOK[]="OK";