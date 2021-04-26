/**
* @file aweleia.c
* Séparation en plusieurs fichiers pour faciliter la maintenance et le multi systeme
* 14/03/20121
* source la version GB => mise à jour des types dans mes_types.h
* ce fichier est commun pour toutes les versions
*/

#include "mes_types.h"
#include "macros.h"
#include "awele.h"

/**
 * posEval : variable globale contenant le nombre de position évaluées
 */
UWORD posEval = 0;

/**
 * jeuPoss : retourne Vrai si le joueur j peut jouer
 * à partir du plateau p
 * @param p pointeur vers le plateau de jeu
 * @param j numero du joueur (0 ou 1)
 * @return Booléen indiquant si le joueur j peut jouer
 */
BOOLEAN jeuPoss(UBYTE *p,UBYTE j)
{
   register UBYTE i, b=FALSE;

   for( i=j*(NCASES+1); i<(j+1)*NCASES+j; b|=p[i++] );

   return(b);
}


/**
 * jouer : le plateau p est le plateau obtenu en jouant 
 * la case c sur le plateau initial pi
 * @param p pointeur vers le plateau de jeu rséultat
 * @param pi pointeur vers le plateau de jeu initial
 * @param c case jouée
 * @param j numéro du joueur (0 ou 1)
 * @return Vrai si le joueur doit rejouer
 */
BOOLEAN jouer(UBYTE *p,UBYTE *pi,UBYTE c,UBYTE j)
{
   register  UBYTE i, n, xi;
   BOOLEAN x;
/*   printf("jouer : %d par %d\n",c,j);
  */ n  = pi[c];
   xi = (c+n)%LGPLAT;
   x = (xi>=j*(NCASES+1)) && (xi<(j+1)*NCASES+j) && !pi[xi];

   for( i=0; i<c; ++i )
      p[i]=pi[i];

   p[c]=0;

   for( i=c+1; i<=c+n; ++i )
      p[i%LGPLAT]=pi[i%LGPLAT]+1;

   for( i=c+n+1; i<LGPLAT; ++i )
      p[i]=pi[i];


   if( x )
   {
      p[(j+1)*NCASES+j] += p[2*NCASES-xi]+1;
      p[2*NCASES-xi] = p[xi] = 0;
   }

   return( ((c+n)==((j+1)*NCASES+j)) && jeuPoss(p,j) );

}

/**
 * alphabeta : procedure d'élagage alpha-beta
 * @see minmax
 * @param p contient le plateau de jeu initial
 * @param alpha vaut moins l'infini au premier appel
 * @param beta vaut plus l'infini au premier appel
 * @param j est le n° du joueur utilisant cette procedure (0 ou 1)
 * @param prf est la profondeur de recherche
 * @param n est le nombre de coups joués
 * @param res est un tableau contenant les coups succesifs trouves
 * @return valeur de l'évaluation alphabeta
 */
WORD alphabeta(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf, UBYTE n, UBYTE *res)
{
   register UBYTE np[LGPLAT], i, jp;
   WORD a=0;

	jp=0;
   for( i=j*(NCASES+1); (i<(j+1)*NCASES+j) && (alpha<beta); i++)
   {
      jp |= p[i];
      
      if(p[i])
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

***************

    gotogxy(10,17);
    color(BLACK, WHITE, SOLID);
	gprintln(posEval, 10, UNSIGNED);
*/
   if(!jp)
   {
      res[n]=i;
      return( eval(p, j) );
   }

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
 * @return si on est sur un feuille ou plus de profondeur de recherche alors l'évaluation du plateau sino calcul du MIN
 */
WORD minmax(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf)
{
   register UBYTE np[LGPLAT], i, jp=0, jo;
   WORD  b;
   if(prf<=0)
      return( eval(p,j) );

   jo=1-j; //jo = joueur opposé à j

   for( i=jo*(NCASES+1); (i<(jo+1)*NCASES+jo) && (alpha<beta); i++)
   {
      jp |= p[i];
   if( p[i] )
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

   if( !jp )
      return( eval(p, j) );

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
 * @return si on est sur un feuille ou plus de profondeur de recherche alors l'évaluation du plateau sino calcul du MAX
 */
WORD maxmin(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf)
{
   register UBYTE np[LGPLAT], i, jp=0;
   WORD a;
   if(prf<=0)
      return( eval(p,j) );

   for( i=j*(NCASES+1); (i<(j+1)*NCASES+j) && (alpha<beta); i++)
   {
      jp |= p[i];
   if( p[i] )
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

   if( !jp )
      return( eval(p, j) );

   return( alpha );
}

/**
 * maxmin : algorithme minmax pour gestion de changement du joueur : cas MAX
 * @param p plateau de jeu
 * @param j n° du joueur pour lequel on évalue le plateau
 */
WORD eval(UBYTE *p, UBYTE j)
{
      ++posEval; 
   return( (1-2*j)*(p[KALAH1]-p[KALAH2]) );
}


