// version avril 2021
// simplification avec appel fonctions 
#include "awele.h"

extern UWORD posEval;

UBYTE jeu[LGPLAT], prof[2], tab[20], j[2];

UBYTE temp[64];

/**
 *	Initialisation des variables globales (tableaux)
 */
void initPartie(void)
{
	UBYTE i;
	posEval = 0;
	for(i=0;i<NCASES;i++)
	  jeu[NCASES+1+i] = jeu[i] = NGRAINS;
	jeu[KALAH2] = jeu[KALAH1] = 0;
	prof[0]=prof[1]=1;
	j[0]=0;j[1]=1;
////	TESTS TESTS TESTS pour boucle fin
//	jeu[KALAH1] =33;
//	jeu[KALAH2] =1;
////
	
}

/**
 *	Main : boucle principale des parties et boucle de chaque partie pour humain & ordi
 */
void main (void)
{
	UBYTE i;
	UBYTE c;
	BOOLEAN b=TRUE, rejoue = TRUE;
	
	initJoystick(); 
	initPlateau();
	// boucle principale : jusqu'à ne plus rejouer
	do
	{
		initPartie();
		afficherPlateau(jeu);
		i=menuOptions(0); 
		afficherPlateau(jeu);

		// boucle d'une partie : jusqu'à égalité ou vainqueur
		do
		{
			if( j[i] )
			{
				// Ordi joue
				posEval=0;
				afficherPosEval();
				alphabeta(jeu, MOINS_INFINI, PLUS_INFINI, i, prof[i], 0, tab);
				afficherPosEval();
				for(c=0,b=1;b;c++)
				{
					b = jouer(jeu, jeu, tab[c], i);
					afficherAttente(i+1,tab[c]);
					effacerAttente();
					afficherPlateau(jeu);
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
					if(j[i]==1)	// on a changé de joueur vers ordi
					{
				   		i=1-i;	// pour sortir et ne pas changer i

						break;
					}
					if(c==99)	continue;
					b = jouer(jeu, jeu, c, i);
					afficherPlateau(jeu);
				} while(b);
			}

		i=1-i;
		} while((jeu[(2-i)*NCASES+1-i] <= NCASES*NGRAINS) &&  jeuPoss(jeu, i));
		rejoue = afficherResultats(jeu[KALAH1],jeu[KALAH2]);
	} while(rejoue);
}