/***      VERSION GB DMG       ***/
/* V0 reprise brute printf       */
/* V0.1 console.h gotogxy + joypad*/
/* V0.2 drawing.h gprint gotogxy */

/* TODO :                        */
/*   version graphique           */
/*   utilisation tuiles          */
/*   nettoyage code :            */
/*       - types GB (UINT8...)   */
/*       - commentaires debug    */
/*       - alignement            */
/*  optimisation                 */
/*  menu option + options defaut */
/*  option config plateau NCASES */

#include <stdio.h>
#include <types.h>
#include <stdlib.h>
//#include <gb/console.h>
#include <gb/gB.h>
#include <gb/drawing.h>
#include "../macros.h"
#include "../awele.h"
#include "../globals.h"
extern UWORD posEval;
extern void gbglobals();

//#define clrscr() cls()
/*******************

A METTRE DANS UN AWELE_GB OU PLAT_GB

***********+********/

void printxy(UBYTE x, UBYTE y, BOOLEAN rv, STRPTR s)
{
	gotogxy(x,y);
	 if(rv)	color(WHITE, DKGREY, SOLID);
	else	color(BLACK, WHITE, SOLID);
	gprintf(s);

}

void revers(BOOLEAN b)
{
	 if(b)	color(WHITE, DKGREY, SOLID);
	else	color(BLACK, WHITE, SOLID);
}

void effaceLigne(UINT8 l)
{
	register UINT8 i;
	color(BLACK, WHITE, SOLID);
	gotogxy(0,l);
	for(i=0;i<20;i++) wrtchr(' ');
}

void effaceChr(UINT8 l, UINT16 n)
{
	UWORD i;
	color(BLACK, WHITE, SOLID);
	gotogxy(0,l);
	for(i=0;i<n;i++) wrtchr(' ');
}
void clrscr()
{
	effaceChr(0,360);
}
void gbtbcar()
{
	register UBYTE x,y;
	for(y=0;y<20;y++)
	{
		for(x=0;x<20;x++)
		{
			gotogxy(x,y);
			wrtchr(y*20+x);
		}
	}
}

void boitePlateau()
{
	color(BLACK, WHITE, SOLID);
	box(16,23,144,48,M_NOFILL);
	box(0,23,16,40,M_NOFILL);
	box(144,31,159,48,M_NOFILL);
}

void initJoystick(){}
void initPlateau()
{
	gbglobals();
//gbtbcar();waitpad(J_B);
}

UBYTE getkj()
{
	UBYTE c=0,j=0;
	int pad;
	while(!(pad=joypad()));


	if(pad &  J_UP) c = KEY_UP;
	if(pad &  J_DOWN) c = KEY_DOWN;
	if(pad &  J_LEFT) c = KEY_LEFT;
	if(pad &  J_RIGHT) c = KEY_RIGHT;
	if(pad &  J_A) c = KEY_RETURN;
	//gotogxy(0,13);
	//gprintf("pad = %d / c=%d   ",pad,(int)c);
	waitpadup();
	return c;
}

UBYTE menuOptions(UBYTE n)
{
	register UBYTE i,l,k,c;
	//signed char  c;
	
	clrscr();
	i=2; // par défaut PvC
	revers(FALSE);
	if(n == 0)
	do
	{
		gotogxy(0,1);revers(i==1);gprint(gOption2Joueurs);
		gotogxy(0,2);revers(i==2);gprint(gOption1Joueur);
		gotogxy(0,3);revers(i==3);gprint(gOption2Ordinateurs);
		revers(FALSE);
		c = getkj();
		if(c == KEY_UP && i>1) i--;
		if(c == KEY_DOWN && i<3) i++;
	} while(c != KEY_RETURN);

	l=4;
	switch(i)
	{
		case 1:
		printxy(0,l,FALSE,gJ1commence);
		j[0] = j[1] = 0;
		i = 0;
		break;
	   case 2:
		printxy(0,l,FALSE,gJ2ordi);
		i=1;
		j[i]=1;
		j[1-i]=0;
		printxy(0,++l,FALSE,gOptionProfondeur);
		i=1;
		do
		{
			gotogxy(17,l);
			wrtchr((char)(i+48));
			c = getkj();
	     	if(c == KEY_UP && i<6) i++;
	     	if(c == KEY_DOWN && i>1) i--;
	     } while(c != KEY_RETURN);
	     prof[1]=i;
	     i=1;
	     // A AMELIORER -> CHOIX ORDI / JOUEUR
		printxy(0,++l,FALSE,gOptionQuiCommence);
	     do
	     {
			gotogxy(15,l);
			//wrtchr((char)(i+48));
			if(i==1) gprint(gVous); else gprint(gMoi);
	     	c = getkj();
	     	if(c == KEY_UP) i=2;
	     	if(c == KEY_DOWN) i=1;
	     } while(c != KEY_RETURN);

	      --i;
		break;

	   case 3:
		j[0] = j[1] = 1;
		gotogxy(0,l);
		printxy(0,l,FALSE,gJ1commence);
		for( i=0; i<2; i++)
		{
			gotogxy(0,++l);
	         gprint(gJoueur[i]);
			gprint(gOptionProfondeur);
			k = 1;
			do
			{
				gotogxy(18,l);
				wrtchr((char)(k+48));
				c = getkj();
				if(c == KEY_UP && k<6) k++;
				if(c == KEY_DOWN && k>1) k--;
			} while(c != KEY_RETURN);
			prof[i]=k;
		}
		i=0;
		break;
	   default:
//          clputs("\n\r\t\tVous n'^tes pas en forme !..\n\r");
//          clputs("Revenez me voir quand vous irez mieux ....\n\r");
//          clputs("\n\r\n\r\t\t\t\tAtchao !\n\r\n\r");
	      exit(5);
	   }
	clrscr();
	 gotogxy(0,0);gprint(gPositionsEvaluees);
	return(i);
  
}

void afficherPlateau(UBYTE *p)
{
	register int i;
	gotogxy(0,1);
	// les numeros des cases du joueur 2 en alternant inversion couleur
	for( i=2*NCASES; i>NCASES; i--)
		{
			gotogxy(2*(2*NCASES-i+1),1);
	   	if(i%2)  color(BLACK, WHITE, SOLID);
		else     color(WHITE, DKGREY, SOLID);
		gprintln(i,10,UNSIGNED);
	   
	}
	// les cases du joueur 2 en alternant inversion couleur
	for( i=2*NCASES; i>NCASES; i--)
	{
	   	gotogxy(2*(2*NCASES-i+1),3);//+i%2);
	   	if(i%2)  color(BLACK, WHITE, SOLID);
		else     color(WHITE, DKGREY, SOLID);
	     gprintln(p[i],10,UNSIGNED);
	     if(p[i]<10) wrtchr(' ');

	}

	//
	color(WHITE, DKGREY, SOLID);
	gotogxy(0,4);
	gprintln(p[KALAH2],10,UNSIGNED);
	if(p[KALAH2]<10) wrtchr(' ');
	gotogxy(2*NCASES+2,4);
	gprintln(p[KALAH1],10,UNSIGNED);
	if(p[KALAH1]<10) wrtchr(' ');

	// les cases du joueur 1 en alternant inversion couleur
	for( i=0; i<NCASES; i++)
	{
		gotogxy(2*i+2,5);//+i%2);
		if(i%2)     color(WHITE, DKGREY, SOLID);
		else     color(BLACK, WHITE, SOLID);
	     gprintln(p[i],10,UNSIGNED);
		if(p[i]<10) wrtchr(' ');
	}

	// les numeros des cases du joueur 1 en alternant inversion couleur
	for( i=0; i<NCASES; i++)
	{
			gotogxy(2*i+2,7);
		if(i%2)     color(WHITE, DKGREY, SOLID);
		else     color(BLACK, WHITE, SOLID);
		gprintln(i,10,UNSIGNED);
	}
}



BOOLEAN afficherResultats(UBYTE k1, UBYTE k2)
{
	gotogxy(0,12);
	color(WHITE, DKGREY, SOLID);
	if( k1>k2 )
	{
	   gprint(gJoueur[0]);
	   gprint(gVainqueur);
	}
	else if( k1==k2 )
	   gprint(gEgalite);
	else
	{
	   gprint(gJoueur[1]);
	   gprint(gVainqueur);
	}
	revers(FALSE);
	gotogxy(2,13);gprintf(" %d : ",(k1<k2)?k2:k1);gprintf("%d",(k1<k2)?k1:k2);
	effaceLigne(14);
	
	gotogxy(2,15);
	color(WHITE, DKGREY, SOLID);
	gprint("B pour continuer");
	waitpad(J_B);
	waitpadup();
	effaceLigne(15);

	return(TRUE);
}

void afficherPosEval()
{
	gotogxy(10,0);
	revers(FALSE);
	 gprintf("%d   ",posEval);
}

void afficherAttente(UBYTE joueur, UBYTE casejouee)
{
	UBYTE x,y;

	gotogxy(0,14);
	color(BLACK, WHITE, SOLID);
	gprintf("J%d joue en ", joueur);
	gprintf("%d   ", casejouee);
	gotogxy(2,15);
	color(WHITE, DKGREY, SOLID);
	gprint("B pour continuer");
	revers(FALSE);
	
	joueur--;
	y= 6-joueur*4;
	//effaceLigne(y);
	color(WHITE,WHITE,SOLID);
	(joueur==0)?box(16,49,144,55,M_FILL):box(16,16,144,22,M_FILL);
	
	x=(casejouee-joueur*(NCASES+1));
	x = (1-2*joueur)*x;
	x+=7*joueur;
	x = x*2;
	x+=2;
	gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
	//		sprintf(temp,"e%d,%d-%d-%d      ",x,y,casejouee,joueur);dbgprint(temp);
	boitePlateau();

	waitpad(J_B);
	effaceLigne(15);
	effaceLigne(16);
}

void effacerAttente()
{
	effaceLigne(12);
	effaceLigne(13);
}

UBYTE choixJoueur(UBYTE joueur)
{
	UBYTE x,y;
	UBYTE k;
	//UBYTE temp[64];
	signed char c;
	
	revers(FALSE);
	gotogxy(0,10);
	gprint(gJoueur[joueur]);
	gotogxy(0,11);
	gprint(gQuelleCase); 
//	effaceLigne(2);
//	effaceLigne(6);
	color(WHITE,WHITE,SOLID);
	box(16,16,144,22,M_FILL);
	box(16,49,144,55,M_FILL);

	for(c=joueur*(NCASES+1);!jeu[c];c++);
	y= 6-joueur*4;
	revers(FALSE);
	do
	{
		//effaceLigne(y);
		color(WHITE,WHITE,SOLID);
		(joueur==0)?box(16,49,144,55,M_FILL):box(16,16,144,22,M_FILL);
		//x=2+(2*joueur+(1-2*joueur)*(c-joueur*(NCASES+1)))*2;
		x=(c-joueur*(NCASES+1));
		x = (1-2*joueur)*x;
		x+=7*joueur;
		x = x*2;
		x+=2;
		gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
		boitePlateau();
		do
		{

			do k = getkj(); while(!k);
			if(k == KEY_LEFT)
			{
					gotogxy(x,y);revers(FALSE);wrtchr(32);
					c-=(1-2*joueur);
			
			}
			else if(k == KEY_RIGHT)
			{ 
					gotogxy(x,y);revers(FALSE);wrtchr(32);
					c+=(1-2*joueur);
			} 

			if(c<joueur*(NCASES+1)) c=joueur*(NCASES+1);
			else if(c>=(joueur+1)*NCASES+joueur) c=(joueur+1)*NCASES+joueur-1;

			x=(c-joueur*(NCASES+1));
			x = (1-2*joueur)*x;
			x+=7*joueur;
			x = x*2;
			x+=2;
			gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
			gotogxy(16,11);
			gprintf("%d ",c);
			boitePlateau();		
		} while(k != KEY_RETURN);
		waitpadup();

		gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
	
	} while(c<joueur*(NCASES+1) || c>=(joueur+1)*NCASES+joueur || !jeu[c]);
	effaceLigne(10);
	effaceLigne(11);
	return(c);
}

void dbgprint(STRPTR s)
{
	//return;
	gotogxy(0,15);
	revers(FALSE);
	gprint(s);	
	waitpad(J_B);
	waitpadup();
}

void afficherRegles()
{
	clrscr();
	gotogxy(0,1);
	gprint("ACTION: Au début de la partie, les joueurs placent leurs graines, par groupes de 6,\
dans les troues de leur rangée (on ne place aucune graines dans le Kalaha). L'un\
d'entre eux (tiré au sort) commence la partie.\
A son tour de jeu, un joueur prend les graines dans un trou des trous la rangée proche\
de lui et les sème une par une dans chacun des trous qui suivent ainsi que dans son\
Kalaha en suivant le sens anti-horaire. Le joueur ne sème jamais de graines dans le\
Kalaha de son adversaire.\
- Si le joueur sème sa dernière graine dans son Kalaha, il peut rejouer. On peut ainsi\
enchaîner plusieurs tous de jeu.\
- Si le joueur sème sa dernière graine dans un trou vide de sa propre rangée, il capture\
les graines situées dans le trou en vis à vis et les place dans son Kalaha. Puis c'est a\
son adversaire de jouer.\
- Si le joueur sème sa dernière graine dans un trou qui n'était pas vide, son tour de jeu\
se termine et c'est à son adversaire de jouer.\
La partie se termine lorsqu'un des joueur ne peux plus jouer car lors de son tour de\
jeu, sa rangée est vide. Les graines restant éventuellement dans la rangée d 'un joueur\
sont placées dans son Kalaha. Le vainqueur est celui qui a le plus grand nombre de\
graines dans son Kalaha.");
	
}
