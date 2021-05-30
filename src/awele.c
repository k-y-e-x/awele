// version mai 2021
// simplification avec appel fonctions 
// passage de constantes (define) en variables globales => remplacement dans le code
// Nouvelle version dev :
// 	- refonte menu => en haut
// 	- centrage plateau de jeu donc redécoupage des zones l'écran
// 	- passage de define en variables pour nouveau menu d'options/variantes
//  - écran titre
#include "awele.h"

//extern UWORD gPosEval;

UBYTE jeu[LGPLAT], prof[2], tab[20], j[2];

UBYTE temp[64];

/**
 *	Initialisation des variables globales  du jeu (tableaux)
 */
void initPartie(BOOLEAN tout)
{
	UBYTE i;
	gPosEval = 0;
	for(i=0;i<gNbCases;i++)
	  jeu[gNbCases+1+i] = jeu[i] = gNbGrains;
	jeu[KALAH2] = jeu[KALAH1] = 0;
	if(tout)
	{
		prof[0]=prof[1]=1;
		j[0]=0;j[1]=1;
	}
}

/**
 *	Main : boucle principale des parties et boucle de chaque partie pour humain & ordi
 */
void main (void)
{
	UBYTE i;
	UBYTE c;
	BOOLEAN b=TRUE, rejoue = TRUE;


	init();
	gLongueurPlateau = (2*(gNbCases+1));
	gPlateauX=(gScreenX/2)-(3*gNbCases/2+6);
	gPosEval=gPlateauX;afficherPosEval();
	gPlateauY = gScreenY/2-4;
	gChoixJoueurY=gScreenY/2+5;
	gAttenteX = 0;
	gAttenteY = gChoixJoueurY+1;

	initJoystick();
	initPlateau();
	ecranTitre();
	// boucle principale : jusqu'à ne plus rejouer
	do
	{
		rejoue=FALSE;
		initPartie(TRUE);
		afficherPlateau(jeu);
		i=afficherMenu(0); 
		afficherPlateau(jeu);

		// boucle d'une partie : jusqu'à égalité ou vainqueur
		do
		{
			if( j[i] )
			{
				// Ordi joue
				gPosEval=0;
				afficherPosEval();
				alphabeta(jeu, MOINS_INFINI, PLUS_INFINI, i, prof[i], 0, tab);
				afficherPosEval();
				for(c=0,b=1;b;c++)
				{
					b = jouer(jeu, jeu, tab[c], i);
					rejoue = afficherAttente(i+1,tab[c]);
					effacerAttente();
					afficherPlateau(jeu);
					if(rejoue) break;
					if(j[i]==0)	// on a changé d'ordi vers joueur
					{
						if(b)	// si le joueur en cours peut encore jouer on garde la main
						{
							i=1-i;	// pour sortir et ne pas changer i
						}
						break;
					}
				}
			}
			else
			{
				// choix du joueur
				do
				{
					c = choixJoueur(i);
					rejoue=(c==99);
					if(rejoue) break;
					if(j[i]==1)	// on a changé de joueur vers ordi
					{
				   		i=1-i;	// pour sortir et ne pas changer i

						break;
					}
					if(c==100)	continue;
					b = jouer(jeu, jeu, c, i);
					afficherPlateau(jeu);
				} while(b);
			}

		i=1-i;
		} while(!rejoue && (jeu[(2-i)*gNbCases+1-i] <= gNbCases*gNbGrains) &&  jeuPoss(jeu, i));
		if(gCompte && jeu[KALAH1]<=gNbCases*gNbGrains && jeu[KALAH2]<=gNbCases*gNbGrains )
		{
			c=0;
			for( i=0; i<gNbCases; i++)
			{
				if(gCompte==1)
					jeu[KALAH1]+=jeu[i];
				else
					jeu[KALAH2]+=jeu[i];
				jeu[i]=0;
			}
			for( i=gNbCases+1; i<2*gNbCases+1; i++)
			{
				if(gCompte==1)
					jeu[KALAH2]+=jeu[i];
				else
					jeu[KALAH1]+=jeu[i];
				jeu[i]=0;
			}
			getkj();
			afficherPlateau(jeu);
		}
		if(!rejoue) rejoue = afficherResultats(jeu[KALAH1],jeu[KALAH2]);
	} while(rejoue);
}