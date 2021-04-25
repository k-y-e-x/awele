/*******
* Séparation en plusieurs fichiers pour faciliter la maintenance et le multi systeme
* 14/03/20121
* source la version GB => mise à jour des types dans mes_types.h
* ce fichier est commun pour toutes les versions
*******/

//#include <stdio.h>
#include "mes_types.h"
//#include <stdlib.h>

#include "macros.h"
#include "awele.h"
//#include <gb/gB.h>
//#include <gb/drawing.h>
UWORD posEval = 0;

/**
 * jeuPoss : retourne Vrai si le joueur j peut jouer
 * à partir du plateau p
 * @param p : pointeur vers le plateau de jeu
 * @param j : numero du joueur (0 ou 1)
 * @return : Booléen indiquant si le joeuur j peut jouer
 */
BOOLEAN jeuPoss(UBYTE *p,UBYTE j)
{
   register UBYTE i, b=FALSE;

   for( i=j*(NCASES+1); i<(j+1)*NCASES+j; b|=p[i++] );

   return(b);
}


/**
 * jouer : le plateau p est le plateau obtenu en jouant 
 * la case c sur le plateau initial pi, la fonction
 * @param p : pointeur vers le plateau de jeu rséultat
 * @param pi: pointeur vers le plateau de jeu initial
 * @param c : case jouée
 * @param j : numéro du joueur (0 ou 1)
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
 * alphabeta : procedure alpha-beta
 * ~~~~~~~~~~~~~~~~~~~~
 * @param p contient le plateau de jeu initial
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

/*
    gotogxy(1,15);
    color(BLACK, WHITE, SOLID);
	gprintf("alphabeta : %d",prf);
    jp = 0;
    gotogxy(5,16);
    color(BLACK, WHITE, SOLID);
	gprintln(posEval, 10, UNSIGNED);
    gotogxy(10,16);
	gprintln(alpha, 10, SIGNED);
    gotogxy(15,16);
	gprintln(beta, 10, SIGNED);
	waitpad(J_B);
	gotogxy(1,15);
    color(BLACK, WHITE, SOLID);
	gprintf("     ");         
*/
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

/*
    gotogxy(10,17);
    color(BLACK, WHITE, SOLID);
    gprintf("%u %u %u ",posEval,alpha,beta);

    gotogxy(10,16);
	gprintln(alpha, 10, SIGNED);
    gotogxy(15,16);
	gprintln(beta, 10, SIGNED);
*/
/*
***************

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


WORD minmax(UBYTE *p, WORD alpha, WORD beta, UBYTE j, UBYTE prf)
{
   register UBYTE np[LGPLAT], i, jp=0, jo;
   WORD  b;
   if(prf<=0)
      return( eval(p,j) );

   jo=1-j;

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


WORD eval(UBYTE *p, UBYTE j)
{
      ++posEval; 
   return( (1-2*j)*(p[KALAH1]-p[KALAH2]) );
}


