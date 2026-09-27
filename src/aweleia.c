/**
* @file aweleia.c
* Séparation en plusieurs fichiers pour faciliter la maintenance et le multisystème
* 14/03/2021
* Version GB : mise à jour des types dans mes_types.h
* Ce fichier est commun à toutes les versions.
*/

#include "mes_types.h"
#include "macros.h"
#include "awele.h"
//#include <conio.h>
/**
 * gPosEval : variable globale contenant le nombre de positions évaluées
 */
UWORD gPosEval = 0;

static UBYTE gDebut[2], gFin[2], gKalah[2], gKalahAdverse[2], gOppose[LGPLAT];

void initIA(void)
{
   UBYTE i;

   gDebut[0] = 0;
   gDebut[1] = gNbCases+1;
   gFin[0] = gNbCases;
   gFin[1] = 2*gNbCases+1;
   gKalah[0] = gNbCases;
   gKalah[1] = 2*gNbCases+1;
   gKalahAdverse[0] = gKalah[1];
   gKalahAdverse[1] = gKalah[0];

   for(i=0; i<LGPLAT; ++i)
      gOppose[i] = 2*gNbCases-i;
}

/**
 * jeuPoss : retourne Vrai si le joueur j peut jouer
 * à partir du plateau p
 * @param p pointeur vers le plateau de jeu
 * @param j numéro du joueur (0 ou 1)
 * @return Booléen indiquant si le joueur j peut jouer
 */
BOOLEAN jeuPoss(UBYTE *p,UBYTE j)
{
   register UBYTE i, b=FALSE;

   for( i=gDebut[j]; i<gFin[j]; b|=p[i++] );

   return(b);
}

static UBYTE caseArrivee(UBYTE c, UBYTE n, UBYTE j);
static UBYTE semerEtArrivee(UBYTE *p, UBYTE c, UBYTE n, UBYTE j);

/**
 * jouer : le plateau p est le plateau obtenu en jouant 
 * la case c sur le plateau initial pi
 * @param p pointeur vers le plateau de jeu résultat
 * @param pi pointeur vers le plateau de jeu initial
 * @param c case jouée
 * @param j numéro du joueur (0 ou 1)
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

	p[c]=0;	// on vide la case jouée

	xi = semerEtArrivee(p, c, n, j);
	x = (xi>=gDebut[j]) && (xi<gFin[j]) && (p[xi]==1);
// 	gotoxy(0,25);
// 	cprintf("%d %d %d - xi=%d,j=%d,nbc=%d,pixi=%d,pxi=%d   ",(xi>=j*(gNbCases+1)),(xi<(j+1)*gNbCases+j),!pi[xi],xi,j,gNbCases,pi[xi],p[xi]);

	if( x )
	{
		p[gKalah[j]] += p[gOppose[xi]]+1;
		p[gOppose[xi]] = p[xi] = 0;
	}

   return( (xi==gKalah[j]) && jeuPoss(p,j) );

}

static UBYTE caseArrivee(UBYTE c, UBYTE n, UBYTE j)
{
   register UBYTE idx;

   idx = c;
   while(n)
   {
      ++idx;
      if(idx==gLongueurPlateau) idx=0;
      if(gSauteKalah && (idx == gKalahAdverse[j]))
         continue;
      --n;
   }
   return(idx);
}

static UBYTE semerEtArrivee(UBYTE *p, UBYTE c, UBYTE n, UBYTE j)
{
   register UBYTE idx;

   idx = c;
   while(n)
   {
      ++idx;
      if(idx==gLongueurPlateau) idx=0;
      if(gSauteKalah && (idx == gKalahAdverse[j]))
         continue;
      ++p[idx];
      --n;
   }
   return(idx);
}

static UBYTE scoreCoup(UBYTE *p, UBYTE c, UBYTE j)
{
   UBYTE score, xi;

   score = 0;
   xi = caseArrivee(c, p[c], j);

   if(xi == gKalah[j])
      score += 8;
   if((xi>=gDebut[j]) && (xi<gFin[j]) && !p[xi] && p[gOppose[xi]])
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
   for(i=gDebut[j]; i<gFin[j]; ++i)
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
 * alphabeta : procédure d'élagage alpha-bêta
 * @see minmax
 * @param p contient le plateau de jeu initial
 * @param alpha vaut moins l'infini au premier appel
 * @param beta vaut plus l'infini au premier appel
 * @param j est le n° du joueur utilisant cette procédure (0 ou 1)
 * @param prf est la profondeur de recherche
 * @param n est le nombre de coups joués
 * @param res est un tableau contenant les coups successifs trouvés
 * @return valeur de l'évaluation alphabeta
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
 * @param j n° du joueur (0 ou 1)
 * @param prf profondeur de recherche max en cours
 * @return Si la profondeur maximale est atteinte, évaluation du plateau ; sinon, minimum des coups possibles.
 */
WORD minmax(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf)
{
   register UBYTE np[LGPLAT], i, jo;
   UBYTE coups[NCASES], nbCoups, k;
   WORD  b;
   if(prf<=0)
      return( eval(p,j) );

   jo=1-j; //jo = joueur opposé à j

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
 * @param j n° du joueur (0 ou 1)
 * @param prf profondeur de recherche max en cours
 * @return Si la profondeur maximale est atteinte, évaluation du plateau ; sinon, maximum des coups possibles.
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
 * eval : calcul de la position obtenue
 * @param p plateau de jeu
 * @param j n° du joueur (0 ou 1) pour lequel on évalue le plateau
 */
WORD eval(UBYTE *p, UBYTE j)
{
	 ++gPosEval; 
	return( (1-2*j)*(p[gKalah[0]]-p[gKalah[1]]) );
}

/**
 * evalFin : calcul d'une position de fin de partie (rangée vide)
 * @param p plateau de jeu
 * @param j n° du joueur (0 ou 1) pour lequel on évalue le plateau
 */
WORD evalFin(UBYTE *p, UBYTE j)
{
	WORD cpt=0;
	UBYTE i;

	if(p[gKalah[j]]>gNbCases*gNbGrains)
		return(99);
	j=1-j;
	if(p[gKalah[j]]>gNbCases*gNbGrains)
		return(-99);
	j=1-j;
	switch(gCompte)
	{
			case 0:		// aucun ajout
				break;
			case 1:		// ajout reste de ses grains
				for( i=gDebut[j]; i<gFin[j]; i++)	cpt+=p[i];
				j=1-j;
				for( i=gDebut[j]; i<gFin[j]; i++)	cpt-=p[i];			
				break;
			case 2:		// ajout reste grains adversaire
				j=1-j;
				for( i=gDebut[j]; i<gFin[j]; i++)	cpt+=p[i];
				j=1-j;
				for( i=gDebut[j]; i<gFin[j]; i++)	cpt-=p[i];
				break;
	}
	 ++gPosEval; 
	return( (1-2*j)*(p[gKalah[0]]-p[gKalah[1]]) + cpt);
}
