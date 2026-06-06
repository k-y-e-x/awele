/**
* @file aweleia.c
* S�paration en plusieurs fichiers pour faciliter la maintenance et le multi systeme
* 14/03/20121
* source la version GB => mise � jour des types dans mes_types.h
* ce fichier est commun pour toutes les versions
*/

#include "mes_types.h"
#include "macros.h"
#include "awele.h"
//#include <conio.h>
/**
 * gPosEval : variable globale contenant le nombre de position �valu�es
 */
UWORD gPosEval = 0;

/**
 * jeuPoss : retourne Vrai si le joueur j peut jouer
 * � partir du plateau p
 * @param p pointeur vers le plateau de jeu
 * @param j numero du joueur (0 ou 1)
 * @return Bool�en indiquant si le joueur j peut jouer
 */
BOOLEAN jeuPoss(UBYTE *p,UBYTE j)
{
   register UBYTE i, b=FALSE;

   for( i=j*(gNbCases+1); i<(j+1)*gNbCases+j; b|=p[i++] );

   return(b);
}

static UBYTE caseArrivee(UBYTE *p, UBYTE c, UBYTE n, UBYTE j, BOOLEAN semer);

/**
 * jouer : le plateau p est le plateau obtenu en jouant 
 * la case c sur le plateau initial pi
 * @param p pointeur vers le plateau de jeu rs�ultat
 * @param pi pointeur vers le plateau de jeu initial
 * @param c case jou�e
 * @param j num�ro du joueur (0 ou 1)
 * @return Vrai si le joueur doit rejouer
 */
BOOLEAN jouer(UBYTE *p,UBYTE *pi,UBYTE c,UBYTE j)
{
   register  UBYTE i, n,xi;
   BOOLEAN x;
/*   printf("jouer : %d par %d\n",c,j);
  */
	n  = pi[c];

// 	xi = (c+n)%gLongueurPlateau;
// 	gotoxy(0,24);
// 	cprintf("%d %d %d - xi=%d,j=%d,lgp=%d,pixi=%d   ",(xi>=j*(gNbCases+1)),(xi<(j+1)*gNbCases+j),!pi[xi],xi,j,kalahAdverse,pi[xi]);
	
	// copie du plateau initial
	for( i=0; i<gLongueurPlateau; ++i )
		p[i]=pi[i];

	p[c]=0;	// on vide la case jou�e

	xi = caseArrivee(p, c, n, j, TRUE);
	x = (xi>=j*(gNbCases+1)) && (xi<(j+1)*gNbCases+j) && (p[xi]==1);
// 	gotoxy(0,25);
// 	cprintf("%d %d %d - xi=%d,j=%d,nbc=%d,pixi=%d,pxi=%d   ",(xi>=j*(gNbCases+1)),(xi<(j+1)*gNbCases+j),!pi[xi],xi,j,gNbCases,pi[xi],p[xi]);

	if( x )
	{
		p[(j+1)*gNbCases+j] += p[2*gNbCases-xi]+1;
		p[2*gNbCases-xi] = p[xi] = 0;
	}

   return( (xi==((j+1)*gNbCases+j)) && jeuPoss(p,j) );

}

static UBYTE caseArrivee(UBYTE *p, UBYTE c, UBYTE n, UBYTE j, BOOLEAN semer)
{
   register UBYTE idx, kalahAdverse;

   idx = c;
   kalahAdverse = (2-j)*gNbCases+1-j;
   while(n)
   {
      ++idx;
      if(idx==gLongueurPlateau) idx=0;
      if(gSauteKalah && (idx == kalahAdverse))
         continue;
      if(semer)
         ++p[idx];
      --n;
   }
   return(idx);
}

static UBYTE scoreCoup(UBYTE *p, UBYTE c, UBYTE j)
{
   UBYTE score, xi, debut, fin;

   score = 0;
   xi = caseArrivee(p, c, p[c], j, FALSE);
   debut = j*(gNbCases+1);
   fin = debut+gNbCases;

   if(xi == ((j+1)*gNbCases+j))
      score += 8;
   if((xi>=debut) && (xi<fin) && !p[xi] && p[2*gNbCases-xi])
      score += 4;
   if(p[c] > gNbCases)
      ++score;

   return(score);
}

static UBYTE listeCoups(UBYTE *p, UBYTE j, UBYTE *coups)
{
   UBYTE scores[NCASES];
   UBYTE i, k, n, score, coup;

   n = 0;
   for(i=j*(gNbCases+1); i<(j+1)*gNbCases+j; ++i)
   {
      if(p[i])
      {
         coup = i;
         score = scoreCoup(p, coup, j);
         k = n;
         while(k && score > scores[k-1])
         {
            coups[k] = coups[k-1];
            scores[k] = scores[k-1];
            --k;
         }
         coups[k] = coup;
         scores[k] = score;
         ++n;
      }
   }
   return(n);
}

/**
 * alphabeta : procedure d'�lagage alpha-beta
 * @see minmax
 * @param p contient le plateau de jeu initial
 * @param alpha vaut moins l'infini au premier appel
 * @param beta vaut plus l'infini au premier appel
 * @param j est le n� du joueur utilisant cette procedure (0 ou 1)
 * @param prf est la profondeur de recherche
 * @param n est le nombre de coups jou�s
 * @param res est un tableau contenant les coups succesifs trouves
 * @return valeur de l'�valuation alphabeta
 */
WORD alphabeta(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf, UBYTE n, UBYTE *res)
{
   register UBYTE np[LGPLAT], i;
   UBYTE coups[NCASES], nbCoups, k;
   WORD a=0;

   nbCoups = listeCoups(p, j, coups);
   for( k=0; (k<nbCoups) && (alpha<beta); ++k)
   {
      i = coups[k];
      
      if(jouer(np, p, i, j))
      {
         a=alphabeta(np, alpha, beta, j, prf, n+1, res);
         if( a>alpha )
         {
            alpha=a;
            res[n]=i;
         }
      }
      else
      {
         a=minmax(np, alpha, beta, j, prf-1);
         if( a>alpha )
         {
         	alpha=a;
            res[n]=i;
         }
      }
   }


/****************

A METTRE A JOUR : TEST POUR AFFICHAGE INFO AVANCEMENT RECHERCHE
=> APPEL FONCTION  UI DEPOEND DU SYSTEM CIBLE
ou du simplement du compilateur
***************

    gotogxy(10,17);
    color(BLACK, WHITE, SOLID);
	gprintln(gPosEval, 10, UNSIGNED);
*/
   if(!nbCoups)
   {
      res[n]=0;
      return( evalFin(p, j) );
   }
// 	else
// 	{
// 				gotoxy(0,1);
// 		cprintf("ab jp=%d i=%d pi=%d j=%d prf=%d       ",jp,i,p[i],j,prf);
// 
// 		//getkj();
// 	}

   return( alpha );
}

/**
 * minmax : algorithme minmax avec utilisation de l'inverse pour changement de joueur et descente dans la profondeur de recherche
 * @see maxmin
 * @see eval
 * @param p plateau de jeu
 * @param alpha
 * @param beta
 * @param j n� du joueur (0 ou 1)
 * @param prf profondeur de recherche max en cours
 * @return si on est sur un feuille ou plus de profondeur de recherche alors l'�valuation du plateau sino calcul du MIN
 */
WORD minmax(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf)
{
   register UBYTE np[LGPLAT], i, jo;
   UBYTE coups[NCASES], nbCoups, k;
   WORD  b;
   if(prf<=0)
      return( eval(p,j) );

   jo=1-j; //jo = joueur oppos� � j

   nbCoups = listeCoups(p, jo, coups);
   for( k=0; (k<nbCoups) && (alpha<beta); ++k)
   {
      i = coups[k];
      if( jouer(np, p, i, jo) )
      {
         b = minmax(np, alpha, beta, j, prf);
         beta = MIN(b, beta);
      }
      else
      {
         b = maxmin(np, alpha, beta, j, prf-1);
         beta = MIN(b, beta);
	      }
	   }

	if( !nbCoups )
	{
		return( evalFin(p, j) );
	}
// 	else
// 	{
// 		gotoxy(0,2);
// 		cprintf("min jp=%d i=%d pi=%d j=%d prf=%d       ",jp,i,p[i],j,prf);
// //				getkj();
// 
// 	}

   return( beta );
}

/**
 * maxmin : algorithme minmax pour gestion de changement du joueur : cas MAX
 * @see minmax
 * @see eval
 * @param p plateau de jeu
 * @param alpha
 * @param beta
 * @param j n� du joueur (0 ou 1)
 * @param prf profondeur de recherche max en cours
 * @return si on est sur un feuille ou plus de profondeur de recherche alors l'�valuation du plateau sino calcul du MAX
 */
WORD maxmin(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf)
{
   register UBYTE np[LGPLAT], i;
   UBYTE coups[NCASES], nbCoups, k;
   WORD a;
   if(prf<=0)
      return( eval(p,j) );

   nbCoups = listeCoups(p, j, coups);
   for( k=0; (k<nbCoups) && (alpha<beta); ++k)
   {
      i = coups[k];
      if( jouer(np, p, i, j) )
      {
         a = maxmin(np, alpha, beta, j, prf);
         alpha = MAX(a, alpha);
      }
      else
      {
         a = minmax(np, alpha, beta, j, prf-1);
         alpha = MAX(a, alpha);
	      }
	   }

   if( !nbCoups )
   {
      return( evalFin(p, j) );
    }
// 	else
// 	{
// 		gotoxy(0,3);
// 		cprintf("max jp=%d i=%d pi=%d j=%d prf=%d       ",jp,i,p[i],j,prf);
// 	//getkj();
// 	}
   return( alpha );
}

/**
 * eval : calcul de la position onbtenue
 * @param p plateau de jeu
 * @param j n� du joueur (0 ou 1) pour lequel on �value le plateau
 */
WORD eval(UBYTE *p, UBYTE j)
{
	 ++gPosEval; 
	return( (1-2*j)*(p[KALAH1]-p[KALAH2]) );
}

/**
 * evalFin : calcul d'une position de fin de partie (rang�e vide)
 * @param p plateau de jeu
 * @param j n� du joueur (0 ou 1) pour lequel on �value le plateau
 */
WORD evalFin(UBYTE *p, UBYTE j)
{
	WORD cpt=0;
	UBYTE i;

	if(p[(j+1)*gNbCases+j]>gNbCases*gNbGrains)
		return(99);
	j=1-j;
	if(p[(j+1)*gNbCases+j]>gNbCases*gNbGrains)
		return(-99);
	j=1-j;
	switch(gCompte)
	{
		case 0:		// aucun ajout
			break;
		case 1:		// ajout reste de ses grains
			for( i=j*(gNbCases+1); (i<(j+1)*gNbCases+j); i++)	cpt+=p[i];
			j=1-j;
			for( i=j*(gNbCases+1); (i<(j+1)*gNbCases+j); i++)	cpt-=p[i];			
			break;
		case 2:		// ajout reste grains adversaire
			j=1-j;
			for( i=j*(gNbCases+1); (i<(j+1)*gNbCases+j); i++)	cpt+=p[i];
			j=1-j;
			for( i=j*(gNbCases+1); (i<(j+1)*gNbCases+j); i++)	cpt-=p[i];
			break;
	}
	 ++gPosEval; 
	return( (1-2*j)*(p[KALAH1]-p[KALAH2]) + cpt);
}
