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
/*  option config plateau gNbCases */

#include <stdio.h>
#include <types.h>
#include <stdlib.h>
#include <string.h>
//#include <gb/console.h>
#include <gb/gB.h>
#include "tileset.h"
#include "tilemap.h"

#include <gb/drawing.h>
#include "../macros.h"
#include "../awele.h"
#include "../globals.h"


//extern UWORD posEval;
extern void gbglobals();

extern UBYTE temp[64];

//#define clrscr() cls()

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
	box(16,(gPlateauY+2)*8-1,144,(gPlateauY+5)*8,M_NOFILL);
	box(0,(gPlateauY+2)*8-1,16,(gPlateauY+4)*8,M_NOFILL);
	box(144,(gPlateauY+3)*8-1,159,(gPlateauY+5)*8,M_NOFILL);
//	box(0,23,16,40,M_NOFILL);
//	box(144,31,159,48,M_NOFILL);
}

void init()
{
	gScreenY = SCREENHEIGHT/8;
	gScreenX = SCREENWIDTH/8;
}
void initJoystick()
{
}
void initPlateau()
{
	gbglobals();
//gbtbcar();waitpad(J_B);
}

void ecranTitre()
{
    set_bkg_data(0, TILESET_TILE_COUNT, TILESET);
    set_bkg_tiles(0, 0, TILEMAP_WIDTH, TILEMAP_HEIGHT, TILEMAP);
    SHOW_BKG;
    waitpad(J_START|J_A|J_B);
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
	if(pad &  J_B) c = KEY_ESC;
	
	//gotogxy(0,13);
	//gprintf("pad = %d / c=%d   ",pad,(int)c);
	waitpadup();
	return c;
}

UBYTE afficherMenu(UBYTE n)
{
	register UBYTE i,l,k,c,x;
	//signed char  c;
	
	clrscr();
	i=2; // par défaut PvC
	revers(FALSE);
	if(n == 0)
	do
	{
		gotogxy(0,1);revers(i==1);gprint(g2Joueurs);
		gotogxy(0,2);revers(i==2);gprint(g1Joueur);
		gotogxy(0,3);revers(i==3);gprint(g2Ordinateurs);
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
		printxy(0,++l,FALSE,gProfondeur);
		gprint(" : ");
		x=strlen(gProfondeur)+3;
		i=1;
		do
		{
			gotogxy(x,l);
			wrtchr((char)(i+48));
			c = getkj();
	     	if((c == KEY_UP || c == KEY_RIGHT) && i<6) i++;
	     	if((c == KEY_DOWN || c == KEY_LEFT) && i>1) i--;
	     } while(c != KEY_RETURN);
	     prof[1]=i;
	     i=1;
	     // A AMELIORER -> CHOIX ORDI / JOUEUR
		printxy(0,++l,FALSE,gQuiCommence);
		gprint(" : ");
		x=strlen(gQuiCommence)+3;
		do
	     {
			gotogxy(x,l);
			//wrtchr((char)(i+48));
			if(i==1) gprint(gVous); else gprint(gMoi);
	     	c = getkj();
	     	if(c == KEY_UP || c == KEY_RIGHT || c == KEY_DOWN || c == KEY_LEFT) i=3-i;
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
			gprint(gProfondeur);
			k = 1;
			do
			{
				gotogxy(18,l);
				wrtchr((char)(k+48));
				c = getkj();
				if((c == KEY_UP  || c == KEY_RIGHT) && k<6) k++;
				if((c == KEY_DOWN || c == KEY_LEFT) && k>1) k--;
			} while(c != KEY_RETURN);
			prof[i]=k;
		}
		i=0;
		break;
	   default:
//          cputs("\n\r\t\tVous n'^tes pas en forme !..\n\r");
//          cputs("Revenez me voir quand vous irez mieux ....\n\r");
//          cputs("\n\r\n\r\t\t\t\tAtchao !\n\r\n\r");
	      exit(5);
	   }
	clrscr();
	 gotogxy(0,0);gprint(gPositionsEvaluees);
	return(i);
  
}

void afficherPlateau(UBYTE *p)
{
	register int i,l;
	
	l=gPlateauY;
	
	gotogxy(0,l);
	// les numeros des cases du joueur 2 en alternant inversion couleur
	for( i=2*gNbCases; i>gNbCases; i--)
		{
			gotogxy(2*(2*gNbCases-i+1),l);
	   	if(i%2)  color(BLACK, WHITE, SOLID);
		else     color(WHITE, DKGREY, SOLID);
		gprintln(i,10,UNSIGNED);
	   
	}
	l+=2;
	// les cases du joueur 2 en alternant inversion couleur
	for( i=2*gNbCases; i>gNbCases; i--)
	{
	   	gotogxy(2*(2*gNbCases-i+1),l);//+i%2);
	   	if(i%2)  color(BLACK, WHITE, SOLID);
		else     color(WHITE, DKGREY, SOLID);
	     gprintln(p[i],10,UNSIGNED);
	     if(p[i]<10) wrtchr(' ');

	}
	l++;
	//
	color(WHITE, DKGREY, SOLID);
	gotogxy(0,l);
	gprintln(p[KALAH2],10,UNSIGNED);
	if(p[KALAH2]<10) wrtchr(' ');
	gotogxy(2*gNbCases+2,l);
	gprintln(p[KALAH1],10,UNSIGNED);
	if(p[KALAH1]<10) wrtchr(' ');
	l++;
	// les cases du joueur 1 en alternant inversion couleur
	for( i=0; i<gNbCases; i++)
	{
		gotogxy(2*i+2,l);//+i%2);
		if(i%2)     color(WHITE, DKGREY, SOLID);
		else     color(BLACK, WHITE, SOLID);
	     gprintln(p[i],10,UNSIGNED);
		if(p[i]<10) wrtchr(' ');
	}
	l+=2;
	// les numeros des cases du joueur 1 en alternant inversion couleur
	for( i=0; i<gNbCases; i++)
	{
			gotogxy(2*i+2,l);
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
	sprintf(temp,"%d",gPosEval);
	 gprintf("%s   ",temp);
}

BOOLEAN afficherAttente(UBYTE joueur, UBYTE casejouee)
{
	UBYTE x,y;

	gotogxy(0,gAttenteY);
	color(BLACK, WHITE, SOLID);
	gprintf("J%d joue en ", joueur);
	gprintf("%d   ", casejouee);
	gotogxy(2,gAttenteY+1);
	color(WHITE, DKGREY, SOLID);
	gprint("B pour continuer");
	revers(FALSE);
	joueur--;
	y= gPlateauY+5-joueur*4;
	//effaceLigne(y);
	color(WHITE,WHITE,SOLID);
	(joueur==0)?box(16,(gPlateauY+5)*8+1,144,(gPlateauY+6)*8-1,M_FILL):box(16,(gPlateauY)*8+8,144,(gPlateauY+2)*8-2,M_FILL);

	x=(casejouee-joueur*(gNbCases+1));
	x = (1-2*joueur)*x;
	x+=7*joueur;
	x = x*2;
	x+=2;
	gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
	//		sprintf(temp,"e%d,%d-%d-%d      ",x,y,casejouee,joueur);dbgprint(temp);
	boitePlateau();
	
	while(getkj() != KEY_ESC);

	//waitpad(J_B);
	return(FALSE);	// option menu / abandonner / quitter à faire pour GB
}

void effacerAttente()
{
	effaceLigne(gAttenteY);
	effaceLigne(gAttenteY+1);
}

UBYTE choixJoueur(UBYTE joueur)
{
	UBYTE x,y;
	UBYTE k;
	//UBYTE temp[64];
	signed char c;
	
	revers(FALSE);
	gotogxy(0,gChoixJoueurY);
	gprint(gJoueur[joueur]);
	gotogxy(0,gChoixJoueurY+1);
	gprint(gQuelleCase); 
//	effaceLigne(2);
//	effaceLigne(6);
	color(WHITE,WHITE,SOLID);
	box(16,(gPlateauY)*8+8,144,(gPlateauY+2)*8-2,M_FILL);
	box(16,(gPlateauY+5)*8+1,144,(gPlateauY+6)*8-1,M_FILL);
//??	box(16,16,144,22,M_FILL);
//??	box(16,49,144,55,M_FILL);

	for(c=joueur*(gNbCases+1);!jeu[c];c++);
	y= gPlateauY+5-joueur*4;

	revers(FALSE);
	do
	{
		//effaceLigne(y);
		color(WHITE,WHITE,SOLID);
		//???    (joueur==0)?box(16,49,144,55,M_FILL):box(16,16,144,22,M_FILL);
		//x=2+(2*joueur+(1-2*joueur)*(c-joueur*(gNbCases+1)))*2;
		x=(c-joueur*(gNbCases+1));
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

			if(c<joueur*(gNbCases+1)) c=joueur*(gNbCases+1);
			else if(c>=(joueur+1)*gNbCases+joueur) c=(joueur+1)*gNbCases+joueur-1;

			x=(c-joueur*(gNbCases+1));
			x = (1-2*joueur)*x;
			x+=7*joueur;
			x = x*2;
			x+=2;
			gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
			gotogxy(16,gChoixJoueurY+1);
			gprintf("%d ",c);
			boitePlateau();		
		} while(k != KEY_RETURN);
		waitpadup();

		gotogxy(x,y);revers(FALSE);wrtchr(1+(char)joueur);
	
	} while(c<joueur*(gNbCases+1) || c>=(joueur+1)*gNbCases+joueur || !jeu[c]);
	effaceLigne(gChoixJoueurY);
	effaceLigne(gChoixJoueurY+1);
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
