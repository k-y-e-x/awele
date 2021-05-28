// version du 16 avril 2021
// mise en commun affichage conio
// => on sort les init et les fonction joystick/clavier

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include "../mes_types.h"
#include <joystick.h>
#include <conio.h>

#include "../macros.h"
#include "../awele.h"
#include "../globals.h"



void exit();

//extern UWORD posEval;

void afficherPlateau(UBYTE *);

#ifndef CH_REDEFINED
#define MYCH_HLINE	CH_HLINE
#define MYCH_VLINE	CH_VLINE
#define MYCH_CROSS	CH_CROSS
#define MYCH_RTEE	CH_RTEE
#define MYCH_LTEE	CH_LTEE
#define MYCH_TTEE	CH_TTEE
#define MYCH_BTEE	CH_BTEE
#define MYCH_URCORNER	CH_URCORNER
#define MYCH_ULCORNER	CH_ULCORNER
#define MYCH_LRCORNER	CH_LRCORNER
#define MYCH_LLCORNER	CH_LLCORNER
#endif

char sLineUp[4] = {MYCH_HLINE,MYCH_HLINE,MYCH_TTEE,0};
char sLineUpRightCorner[4] = {MYCH_HLINE,MYCH_HLINE,MYCH_URCORNER,0};
char sKalahUpLeft[8] = {' ',' ',MYCH_ULCORNER,MYCH_HLINE,MYCH_HLINE,MYCH_HLINE,MYCH_RTEE,0};
char sKalahUpRight[6] = {MYCH_LTEE,MYCH_HLINE,MYCH_HLINE,MYCH_HLINE,MYCH_URCORNER,0};
char sLineDown[4] = {MYCH_HLINE,MYCH_HLINE,MYCH_BTEE,0};
char sLineDownCorner[4] = {MYCH_HLINE,MYCH_HLINE,MYCH_LRCORNER,0};
char sKalahDownLeft[8] = {' ',' ',MYCH_LLCORNER,MYCH_HLINE,MYCH_HLINE,MYCH_HLINE,MYCH_RTEE,0};
char sKalahDownRight[6] = {MYCH_LTEE,MYCH_HLINE,MYCH_HLINE,MYCH_HLINE,MYCH_LRCORNER,0};
char sLineMid[4]= {MYCH_HLINE,MYCH_HLINE,MYCH_CROSS,0};
char sLine[3]={MYCH_HLINE,MYCH_HLINE,0};


/**
 *	Affichage d'un caractère sans avancement de position du curseur
 *	@param	c	: caractère à afficher
 */
void cplotc(char c)
{
	cputc(c);
	gotox(wherex()-1); 
}

/**
 *	Affichage d'un entier au coordonnées fournies
 *	@param x,y	: coordonnées dans l'écran
 *	@param rv	: Booléen indiquant si inverse video ?
 *	@param grains : nombres de grains à afficher
 */
void cputixy(UBYTE x, UBYTE y, BOOLEAN rv, UBYTE grains)
{
	revers(rv);
	gotoxy(x,y);
	#ifndef __ATMOS__
	textcolor(cpeekcolor());
	#endif
	cprintf("%2d",grains);
	textcolor(COLOR_WHITE);
	revers(FALSE);
}



void init()
{
	char k;
	screensize(&gScreenX,&gScreenY);
	gPosEvalY = gScreenY-1;
	
	gLongueurPlateau = (2*(gNbCases+1));
	gPlateauX=(gScreenX/2)-(3*gNbCases/2+6);
//gPosEval=gPlateauX;afficherPosEval();
	gPlateauY = gScreenY/2-4;
	gChoixJoueurY=gPlateauY+9;
	gAttenteY=gChoixJoueurY+1;
	
	gMenuOKX = gScreenX - strlen(gMenuOK)-1;
	
// 	gotoxy(0,3);cprintf("c = %d,%d,%d,%d =>r=%d n=%d ret=%d !", gRegles[31], gRegles[32], gRegles[33], gRegles[34],'\r','\n','\
// ');
// 			do k = getkj(); while(!k);



}

void ecranTitre()
{
	//// eéran titre à la demande de didier_v
	UBYTE x,y,i;
	char s[]=__DATE__;
	
	i=strlen(gTitreCredits)-8;
	gTitreCredits[i++]=s[0];
	gTitreCredits[i++]=s[1];
	gTitreCredits[i++]=s[2];i++;
 	gTitreCredits[i++]=s[7];
 	gTitreCredits[i++]=s[8];
 	gTitreCredits[i++]=s[9];
 	gTitreCredits[i++]=s[10];
	
	clrscr();
	x=gScreenX/2-strlen(gTitre)/2;
	y=2;
	#ifdef __ATMOS__

	POKE(0xbb80+y*40+x-2,1);	// rouge
	POKE(0xbb80+y*40+x-1,10);	// double hauteur
	cputsxy(x,y++,gTitre);		// donc on double l'écriture
	POKE(0xbb80+y*40+x-2,2);
	POKE(0xbb80+y*40+x-1,10);
	// scrptr = (STRPTR)(0xbb80+y*40+x-1);
// 	*scrptr = 10;
// 	scrptr+=40;
// 	*scrptr = 10;


	#endif
	textcolor(2);
	gotoxy(x,y++);
	for(i=0;i<strlen(gTitre);i++)
	{
		textcolor((i%2)?COLOR_RED:COLOR_GREEN);
		cputc(gTitre[i]);
	}
	textcolor(1);

	cputsxy(gScreenX/2-strlen(gTitreCredits)/2,y++,gTitreCredits);
	afficherPlateau(jeu);
	
	cputsxy(1,gScreenY-1,gAppuyerTouche);
	getkj();
	clrscr();
	
}

/**
 *	Affichage du plateau de jeu
 *	@param p	: pointeur vers le tableau contenant le plateau à afficher
 */
void afficherPlateau(UBYTE *p)
{
	register int i;
	UBYTE y;


	#ifdef __ATMOS__
	// un peu de couleur sur le plateau
 	y = gPlateauY;
 	POKE(0xbb80+y*40,1);
 	y+=2;
 	POKE(0xbb80+y*40,6);  // 2 OK (verts->magenta),  3OK (jaune->blau)
 	y++;
 	POKE(0xbb80+y*40,6);  // 2 OK (verts->magenta),  3OK (jaune->blau)
 	y++;
 	POKE(0xbb80+y*40,6);  // 2 OK (verts->magenta),  3OK (jaune->blau)
 	y++;
 	POKE(0xbb80+y*40,3); // 6 OK (cyan->rouge)
 	y++;
 	POKE(0xbb80+y*40,3);
	y+=2;
 	POKE(0xbb80+y*40,2);
	#endif
		
	
	y = gPlateauY;
	textcolor(COLOR_RED);
	cputsxy(gScreenX/2-strlen(gJ[j[0]+j[1]][1])/2,y++,gJ[j[0]+j[1]][1]);

	gotoxy(gPlateauX+7,y++);
	textcolor(COLOR_WHITE);
	for( i=2*gNbCases; i>gNbCases; i--)
	{
		cprintf("%2d ", i);
	}
	gotoxy(gPlateauX+6,y++);
	cputc(MYCH_ULCORNER);
	for( i=0; i<gNbCases-1; i++)
	{
		cputs(sLineUp);
	}
	cputs(sLineUpRightCorner);
	
	cputsxy(gPlateauX,y++,sKalahUpLeft);
	for( i=2*gNbCases; i>gNbCases+1; i--)
	{
		textcolor(COLOR_CYAN);cprintf("%2d", p[i]);textcolor(COLOR_WHITE);cputc(MYCH_VLINE);
	}
	textcolor(COLOR_CYAN);
	cprintf("%2d", p[i]);
	textcolor(COLOR_WHITE);
	cputs(sKalahUpRight);
	
	gotoxy(gPlateauX,y++);
	cprintf("%2d%c",KALAH2,MYCH_VLINE);
	textcolor(COLOR_CYAN);
	cprintf("%2d ",p[KALAH2]);
	textcolor(COLOR_WHITE);
	#ifdef __ATMOS__
	POKE(0xbb58+y*40+gPlateauX+5,7); 
	#endif
	cputc(MYCH_LTEE);
	for( i=0; i<gNbCases-1; i++)
		cputs(sLineMid);
	cputs(sLine);
	cputc(MYCH_RTEE);
	textcolor(COLOR_YELLOW);
	cprintf(" %2d",p[KALAH1]);
	textcolor(COLOR_WHITE);
	#ifdef __ATMOS__
	POKE(0xbb58+y*40+gPlateauX+7+3*gNbCases,3); 
	#endif
	cprintf("%c%2d\r\n",MYCH_VLINE,KALAH1);
	
	cputsxy(gPlateauX,y++,sKalahDownLeft);
	for( i=0; i<gNbCases-1; i++)
	{
		textcolor(COLOR_YELLOW);cprintf("%2d", p[i]);textcolor(COLOR_WHITE);cputc(MYCH_VLINE);
	  //cprintf("%2d%c", p[i],MYCH_VLINE);
	}
	textcolor(COLOR_YELLOW);
	cprintf("%2d", p[i]);
	textcolor(COLOR_WHITE);

	cputs(sKalahDownRight);

	gotoxy(gPlateauX+6,y++);
	cputc(MYCH_LLCORNER);
	for( i=0; i<gNbCases-1; i++)
		cputs(sLineDown);
	cputs(sLineDownCorner);

	gotoxy(gPlateauX+7,y++);
	for( i=0; i<gNbCases; i++)
	{
	  cprintf("%2d ", i);
	}
	textcolor(COLOR_GREEN);
	cputsxy(gScreenX/2-strlen(gJ[j[0]+j[1]][1])/2,y++,gJ[j[0]+j[1]][0]);
	textcolor(COLOR_WHITE);
	cputs("      ");

}

/**
 *	Affichage du résultat de la partie
 *	et question si l'utilisateur veut rejouer ou non
 *	@param k1	: Nombre de grains dans le kalah du joueur 1
 *	@param k2	: Nombre de grains dans le kalah du joueur 2
 *	@return	boolén si l'utilisateur veut rejouer ou non
 */
BOOLEAN afficherResultats(UBYTE k1, UBYTE k2)
{
	UBYTE i,l;
	UBYTE k;


	#ifdef __ATMOS__
	POKE(0xbb80+(gPlateauY+8)*40,7);
	#endif
	l=gPlateauY+7;
	cputcxy(10,l,MYCH_ULCORNER);
	for(i=0;i<20;i++)	cputc(MYCH_HLINE);
	cputc(MYCH_URCORNER);
	
	cputcxy(10,++l,MYCH_VLINE);
	cputs(" ");
	revers(TRUE);
	if(j[0]+j[1]==2)
	{
		gJoueur[0][0]=1;
		gJoueur[1][0]=6;
	}	
	if( k1>k2 )
	{
		cputsxy(21-(strlen(gJoueur[0])+strlen(gVainqueur))/2,l,gJoueur[0]);
		cputs(gVainqueur);
	}
	else if( k1==k2 )
	{
		cputsxy(21-strlen(gEgalite)/2,l,gEgalite);
	}
	else
	{
		cputsxy(21-(strlen(gJoueur[1])+strlen(gVainqueur))/2,l,gJoueur[1]);
		cputs(gVainqueur);
	}
	revers(FALSE);
	cputcxy(31,l,MYCH_VLINE);
	
	gotoxy(10,++l);
	cprintf("%c       %2d : %2d      %c\n\r",MYCH_VLINE,(k1<k2)?k2:k1,(k1<k2)?k1:k2,MYCH_VLINE);

	cputcxy(10,++l,MYCH_VLINE);
	cputcxy(31,l,MYCH_VLINE);
	
	cputcxy(10,++l,MYCH_VLINE);
	cputcxy(31,l,MYCH_VLINE);

	cputsxy(12,l,gRejouer);

	
	cputcxy(10,++l,MYCH_VLINE);
	cputcxy(31,l,MYCH_VLINE);
	
	cputcxy(10,++l,MYCH_LLCORNER);
	for(i=0;i<20;i++)	cputc(MYCH_HLINE);
	cputc(MYCH_LRCORNER);
	
	l-=2;
	i=TRUE;	// par défaut on rejoue
	do
	{
		revers(i);
		cputsxy(23,l,gNonOui[1]);
		revers(FALSE);cputc(' ');
		revers(!i);
		cputs(gNonOui[0]);
		k = getkj();
		if(k == KEY_LEFT || k == KEY_RIGHT)
		{
			i = !i;
		} 
	} while(k != KEY_RETURN);

	clrscr();
	return((BOOLEAN)i);
}

BOOLEAN afficherPopUpOuiNon(char *ligne1, char* ligne2)
{
	UBYTE l1,l2,lmax,x,y,i,k;
	
	revers(FALSE);
	l1=strlen(ligne1);
	if(ligne2) l2=strlen(ligne2); else l2=0;
	
	lmax = (l1>l2)?l1:l2;
	lmax+=2;
	for(y=gPlateauY+9;y<gScreenY-2;y++) cclearxy(0,y,gScreenX);
	y=gPlateauY+9;
	x=gScreenX/2-lmax/2;
	
	
	cputcxy(x,y,MYCH_ULCORNER);
	for(i=0;i<lmax;i++)	cputc(MYCH_HLINE);
	cputc(MYCH_URCORNER);
	
	cputcxy(x,++y,MYCH_VLINE);
	cputc(' ');
	cputs(ligne1);
	cputcxy(x+lmax+1,y,MYCH_VLINE);
	if(l2>0)
	{
	cputcxy(x,++y,MYCH_VLINE);
	cputc(' ');
	cputs(ligne2);
	cputcxy(x+lmax+1,y,MYCH_VLINE);
	}
	cputcxy(x,++y,MYCH_VLINE);	
	cputcxy(x+lmax+1,y,MYCH_VLINE);

	cputcxy(x,++y,MYCH_LLCORNER);
	for(i=0;i<lmax;i++)	cputc(MYCH_HLINE);
	cputc(MYCH_LRCORNER);
	y-=1;
	i=FALSE;
	do
	{
		revers(i);
		cputsxy(x+lmax/2-3,y,gNonOui[1]);
		revers(FALSE);cputc(' ');
		revers(!i);
		cputs(gNonOui[0]);
		k = getkj();
		if(k == KEY_LEFT || k == KEY_RIGHT)
		{
			i = !i;
		} 
	} while(k != KEY_RETURN);
	
	//clrscr();
	revers(FALSE);
	for(y=gPlateauY+9;y<gScreenY-2;y++) cclearxy(0,y,gScreenX);
	return((BOOLEAN)i);	
}
/**
 *	Affichage du nombre de positions évaluées
 *	à la position prévue pour cela sur l'écran
 *	posEval est une varialbe globale
 */
void afficherPosEval()
{
	gotoxy(gPosEvalX,gPosEvalY);
	cprintf("%d   ",gPosEval);
}

/**
 *	Affichage du message d'attente lors d'un coup de l'ordinateur
 *	et attente de l'appui sur la touche RETURN (= le bouton de feu si joystick)
  *	@see effacerAttente
 *	@param joueur	: numéro du joueur (1 ou 2)
 *	@param casejouee	: case jouée par le joueur
 */
BOOLEAN afficherAttente(UBYTE joueur, UBYTE casejouee)
{
	UBYTE k;
	gotoxy(gAttenteX,gAttenteY);
	cprintf(gJoueurJoueCase,joueur,casejouee);
	gotoxy(gAttenteX,gAttenteY+1);
	#ifdef __ATMOS__
		cputc('\x02');
	#endif
	cputs(gAppuyerReturn);
	//gotoxy(gAttenteX,gAttenteY+2);
	cputc(' ');
	cputs(gEscMenu);
	do
	{
		k = getkj();
		if(k == KEY_ESC)
		{
			if(afficherMenu(1+j[0]+j[1]) == 99) return(TRUE);
			if(j[joueur-1] == 0 ) k=KEY_RETURN;
		}			

	}
	while(k != KEY_RETURN);
	return(FALSE);
}

/**
 *	Effacer le message d'attente du coup de l'ordinateur
 *	@see afficherAttente
 */
void effacerAttente()
{
	cclearxy(gAttenteX,gAttenteY,40);
	cclearxy(gAttenteX,gAttenteY+1,40);
}

/**
 *	Fonction de selection d'un coup par le joueur en cours
 *	permet aussi l'accès au menu principal en cours de partie
  *	@see effacerAttente
 *	@param joueur	: numéro du joueur (1 ou 2)
 *	@return	: case jouée par le joueur
 */
UBYTE choixJoueur(UBYTE joueur)
{
	UBYTE x,y;
	UBYTE k;
	signed char c;
	
//	cputsxy(0,10, gJoueur[joueur]);
	cputsxy(0,gChoixJoueurY, gJ[j[0]+j[1]][joueur]);
	cputs(gQuelleCase); 

	for(c=joueur*(gNbCases+1);!jeu[c];c++);
	y= gPlateauY+5-joueur*2;
	do
	{
		x=7+gPlateauX+(7*joueur+(1-2*joueur)*(c-joueur*(gNbCases+1)))*3;
		cputixy(x,y,TRUE,jeu[c]);
		do
		{

			do k = getkj(); while(!k);
			if(k == KEY_ESC)
			{
				cputixy(x,y,FALSE,jeu[c]);
				if(afficherMenu(1+j[0]+j[1]) == 99) return(99);
				if(j[joueur])	return(100);
			}			
			if(k == KEY_LEFT)
			{
					cputixy(x,y,FALSE,jeu[c]);
					c-=(1-2*joueur);
			
			}
			else if(k == KEY_RIGHT)
			{
					cputixy(x,y,FALSE,jeu[c]);
					c+=(1-2*joueur);
			} 

		   if(c<joueur*(gNbCases+1)) c=joueur*(gNbCases+1);
			else if(c>=(joueur+1)*gNbCases+joueur) c=(joueur+1)*gNbCases+joueur-1;

			x=7+gPlateauX+(7*joueur+(1-2*joueur)*(c-joueur*(gNbCases+1)))*3;
			cputixy(x,y,TRUE,jeu[c]);

		
		} while(k != KEY_RETURN);
		cputixy(x,y,FALSE,jeu[c]);
	
	} while(c<joueur*(gNbCases+1) || c>=(joueur+1)*gNbCases+joueur || !jeu[c]);
	
	cclearxy(0,gChoixJoueurY,38);
	return(c);
}

/**
 *	Fonction locale d'affichage du détail du menu Joueurs
 *	@see afficherMenu
 *	@param choix 	: option choisie dans le menu joueur
 *	@param n 		: n=0 pour l'affichage en début de partie sinon numéro du joueur en cours
 *	@return	: joueur qui commence
 */
void afficherMenuJoueur(UBYTE choix, signed char n)
{
	revers(FALSE);
	//gotoxy(0,gScreenY-2);cprintf("choix=%d, n=%d",choix,n);
	cclearxy(gMenuJoueursX,gMenuY+2,38);
	cclearxy(gMenuJoueursX,gMenuY+3,38);							
	switch(choix)
	{
		case 1:	// 2 joueurs => pas d'autre question : joueur 1 commence !
			if(n<=0)
			{
				cputsxy(0,gChoixJoueurY,gJ1commence);cputs("          ");
			}
// 			cclearxy(gMenuJoueursX,gMenuY+2,38);
// 			cclearxy(gMenuJoueursX,gMenuY+3,38);							
			break;
		case 2:
			if(n<=0)
			{		
				cputsxy(0,gChoixJoueurY,gJ2ordi);cputs("          ");
				revers(TRUE);
				cputsxy(gMenuJoueursX,gMenuY+3," ");
				cputsxy(gMenuJoueursX+1,gMenuY+3,gQuiCommence);
				//revers(FALSE);
				//if(n==0) cputs(gVous); else cputs(gMoi);
				//cputs("          ");
			}
// 			else
// 				cclearxy(gMenuJoueursX,gMenuY+3,38);
			revers(TRUE);			
			cputsxy(gMenuJoueursX,gMenuY+2," ");			
			cputsxy(gMenuJoueursX+1,gMenuY+2,gProfondeur);//revers(FALSE);cprintf("%d",prof[1]);cputs("          ");
			break;
		case 3:
			if(n<=0)
			{
				cputsxy(0,gChoixJoueurY,gJ1commence);cputs("          ");
			}
			revers(TRUE);cputsxy(gMenuJoueursX,gMenuY+2, gO1);revers(TRUE);cputs(gProfondeur);//revers(FALSE);cprintf("%c",(char)(prof[0]+48));cputs("          ");
			revers(TRUE);cputsxy(gMenuJoueursX,gMenuY+3, gO2);revers(TRUE);cputs(gProfondeur);//revers(FALSE);cprintf("%c",(char)(prof[1]+48));cputs("          ");
			break;
	}
	revers(FALSE);
}

UBYTE afficherMenuJeu(signed char n)
{
	UBYTE choix = 1, c,y;
	UBYTE l1,l2,l3,l4,lmax;
	BOOLEAN reponse;
	
	revers(FALSE);
	
	l1=strlen(gJeuRegles);
	lmax=l1;
	if(n==0) l2=strlen(gJeuCommencer); else l2=strlen(gJeuRetour);
	lmax=(l2>lmax)?l2:lmax;
	l3=strlen(gJeuAbandonner);
	lmax=(l3>lmax)?l3:lmax;
	l4=strlen(gJeuQuitter);
	lmax=(l4>lmax)?l4:lmax;
	
	lmax++;
	l1=lmax-l1;
	l2=lmax-l2;
	l3=lmax-l3;
	l4=lmax-l4;
	//gotoxy(0,gScreenY-3);
	//cprintf("%d-%d-%d-%d max=%d",l1,l2,l3,l4,lmax);

	do
	{
		y=gMenuY+1;
		revers(TRUE);cputcxy(gMenuJeuX,y,' ');revers(choix!=1);cputsxy(gMenuJeuX+1,y,gJeuRegles);
		cclear(l1);revers(TRUE);cputcxy(gMenuJeuX+lmax,y,' ');
		revers(TRUE);cputcxy(gMenuJeuX,++y,' ');revers(choix!=2);cputsxy(gMenuJeuX+1,y,(n==0)?gJeuCommencer:gJeuRetour);
		cclear(l2);revers(TRUE);cputcxy(gMenuJeuX+lmax,y,' ');
		if(n>0)
		{
		revers(TRUE);cputcxy(gMenuJeuX,++y,' ');revers(choix!=3);cputsxy(gMenuJeuX+1,y,gJeuAbandonner);
		cclear(l3);revers(TRUE);cputcxy(gMenuJeuX+lmax,gMenuY+3,' ');
		}
		revers(TRUE);cputcxy(gMenuJeuX,++y,' ');revers(choix!=4);cputsxy(gMenuJeuX+1,y,gJeuQuitter);
		cclear(l4);revers(TRUE);cputcxy(gMenuJeuX+lmax,y,' ');
		c = getkj();
		if(c == KEY_UP && choix>1) 
		{
			choix--;
			if(n==0 && choix==3) choix--;
		}
		if(c == KEY_DOWN && choix<4)
		{
			choix++;
			if(n==0 && choix==3) choix++;
		}

	} while(c != KEY_RETURN);
	revers(FALSE);
	
	switch(choix)
	{
		case 1:
			afficherRegles();
			clrscr();
			afficherPlateau(jeu);
			break;
		case 2:	
			for(c=1;c<6;c++) cclearxy(0,gMenuY+c,gScreenX);
			return(4);
			break;
		case 3:
			// Abandonner la partie en cours
			// popup de confirmation
			reponse = afficherPopUpOuiNon(gPopAbandonner[0],gPopAbandonner[1]);
			if(reponse)
			{
				return(3);
			}
			break;
		case 4:
			// Quitter l'application cours
			// popup de confirmation
			reponse = afficherPopUpOuiNon(gPopQuitter[0],gPopQuitter[1]);
			if(reponse)
			{
				clrscr();
				exit(0);
			}
			break;
	}
	return(1);
}
/**
 *	Fonction locale d'ffichage du détail du menu Options
 *	@see afficherMenu
 */
void afficherMenuOptions()
{
	UBYTE choix = 1, c,x,y;
	UBYTE l1,l2,l3,l4,lmax;

	l1=strlen(gOptionNbCases);
	lmax=l1;
	l2=strlen(gOptionNbGrains);
	lmax=(l2>lmax)?l2:lmax;
	l3=strlen(gOptionCompte);
	lmax=(l3>lmax)?l3:lmax;
	l4=strlen(gOptionSauteKalah);
	lmax=(l4>lmax)?l4:lmax;
	
// 	gotoxy(0,gScreenY-3);
// 	cprintf("%d-%d-%d-%d max=%d",l1,l2,l3,l4,lmax);
	l1=lmax-l1;
	l2=lmax-l2;
	l3=lmax-l3;
	l4=lmax-l4;
// 	gotoxy(0,gScreenY-2);
// 	cprintf("%d-%d-%d-%d max=%d",l1,l2,l3,l4,lmax);

	revers(TRUE);
	x = gMenuOptionsX + strlen(gOptionNbCases);
	do
	{
		// affichage des options
		revers(TRUE);cputcxy(gMenuOptionsX,gMenuY+1,' ');
		revers(choix!=1);cputsxy(gMenuOptionsX+1,gMenuY+1,gOptionNbCases);
		for(x=0;x<l1;x++) cputc(' ');cputc('>');
		if(choix==1)
		{
			revers(TRUE);
			cprintf(" %d",gNbCases);
		}
		else
		{
			revers(FALSE);
			cputs("  ");
		}
		revers(TRUE);cputcxy(gMenuOptionsX,gMenuY+2,' ');
		revers(choix!=2);cputsxy(gMenuOptionsX+1,gMenuY+2,gOptionNbGrains);//revers(choix==2);
		for(x=0;x<l2;x++) cputc(' ');cputc('>');
		if(choix==2)
		{
			revers(TRUE);
			cprintf(" %d",gNbGrains);
		}
		else
		{
			revers(FALSE);
			cputs("  ");
		}
		revers(TRUE);cputcxy(gMenuOptionsX,gMenuY+3,' ');
		revers(choix!=3);cputsxy(gMenuOptionsX+1,gMenuY+3,gOptionSauteKalah);//revers(choix==3);
		for(x=0;x<l3;x++) cputc(' ');cputc('>');
		if(choix==3)
		{
			revers(TRUE);
			cputs(gNonOui[gSauteKalah]);
		}
		else
		{
			revers(FALSE);
			cputs("    ");
		}
		revers(TRUE);cputcxy(gMenuOptionsX,gMenuY+4,' ');
		revers(choix!=4);cputsxy(gMenuOptionsX+1,gMenuY+4,gOptionCompte);//revers(choix==4);
		for(x=0;x<l4;x++) cputc(' ');cputc('>');
		if(choix==4)
		{
			revers(TRUE);
			cputs(gComptes[gCompte]);
		}
		else
		{
			revers(FALSE);
			cputs("     ");
		}
		c = getkj();
		if(c == KEY_UP && choix>1) choix--;
		if(c == KEY_DOWN && choix<4) choix++;
		if(c == KEY_RIGHT)
		{
			switch(choix)
			{
				case 1 :
					if(gNbCases<NCASES)
					{
						gNbCases++;
						for(y=gPlateauY+1;y<gPlateauY+8;y++) cclearxy(0,y,40);
						init();
						initPartie(FALSE);
						afficherPlateau(jeu);
					}
					break;
				case 2:
					if(gNbGrains<NGRAINS)
					{
						gNbGrains++;
						initPartie(FALSE);
						afficherPlateau(jeu);
					}
					break;
				case 3:
					gSauteKalah = !gSauteKalah;
					break;
				case 4:
					if(gCompte<2) gCompte++;
					break;
			}
		}
		if(c == KEY_LEFT)
		{
			switch(choix)
			{
				case 1 :
					if(gNbCases>4)
					{
						gNbCases--;
						for(y=gPlateauY+1;y<gPlateauY+8;y++) cclearxy(0,y,40);
						init();
						initPartie(FALSE);
						afficherPlateau(jeu);
					}
					break;
				case 2:
					if(gNbGrains>3)
					{
						gNbGrains--;
						initPartie(FALSE);
						afficherPlateau(jeu);
					}
					break;
				case 3:
					gSauteKalah = !gSauteKalah;
					break;
				case 4:
					if(gCompte>0) gCompte--;
					break;
			}
		}
	} while(c != KEY_RETURN);
	revers(FALSE);
}
/**
 *	Fonction de choix dans les menus de l'application
 *	- Affichage des règles du jeu
 *	- choix des options de jeu (0/1/2 joueurs huamains ou ordinateurs)
 *	- TODO : menu pour gérer des variantes
 *	@see choixJoueur
 *	@see main
 *	@param n 	: n=0 pour l'affichage en début de partie sinon numéro du joueur en cours
 *	@return	: joueur qui commence
 */
UBYTE afficherMenu(UBYTE n)
{
	UBYTE c, i, choix,commence,k; //, l;
	
	choix=1;
	i=(n!=0)?n:2; // choix joueurs/ordinateur : par défaut PvC
	commence = 0;
	do
	{
		#ifdef __ATMOS__
		POKE(0xbb80+40,7);
		#endif
		textcolor(COLOR_WHITE);

		//for(k=7;k>0;k--) cclearxy(0,gScreenY-k,38);
		for(k=1;k<6;k++) cclearxy(0,gMenuY+k,gScreenX);
		// Choix du du menu : Règles - Joueurs - OK => RàF: Quitter puis Variantes
		revers(TRUE);
		cclearxy(0,0,gScreenX);
		do
		{
			//revers(choix!=1);cputsxy(gMenuReglesX,gMenuY,gMenuRegles);
			revers(choix!=1);cputsxy(gMenuJeuX,gMenuY,gMenuJeu);
			gotoxy(gMenuJoueursX,gMenuY);revers(choix!=2);cputs(gMenuJoueurs);
			gotoxy(gMenuOptionsX,gMenuY);revers(choix!=3);cputs(gMenuOptions);			
			//gotoxy(gMenuOKX,gMenuY);revers(choix!=4);cputs(gMenuOK);
			revers(TRUE);
			c = getkj();
			if(c == KEY_LEFT && choix>1) choix--;
			if(c == KEY_RIGHT && choix<3) choix++;
		} while(c != KEY_RETURN);
		
		revers(FALSE);
		switch(choix)
		{
			case 1:	// Règles du jeu
				//afficherRegles();
				//clrscr();
				//afficherPlateau(jeu);
				choix = afficherMenuJeu(n);
				if(choix==3) return(99);
				break;
			case 2:	// nb de joeurs/ordinateurs
				revers(TRUE);
				afficherMenuJoueur(i,n-commence);
				do
				{

					do
					{
						gotoxy(gMenuJoueursX,gMenuY+1);
						revers(TRUE);
						cputc(' ');
						revers(FALSE);cputs(gJoueursType);
						revers(TRUE);cputs(gTypeJoueurs[i-1]);revers(FALSE);cclear(7);
						c = getkj();
						if(c == KEY_RIGHT && i>1) i--;
						if(c == KEY_LEFT && i<3) i++;
						afficherMenuJoueur(i,n-commence);
						
						cputsxy(gScreenX/2-strlen(gJ[j[0]+j[1]][1])/2,gPlateauY,gJ[i-1][1]);
						cputsxy(gScreenX/2-strlen(gJ[j[0]+j[1]][1])/2,gPlateauY+8,gJ[i-1][0]);
					} while(c!=KEY_RETURN && c!=KEY_DOWN && c!=KEY_UP);
					j[0]=(i-1)>>1;
					j[1]=i>>1;
					
					revers(TRUE);

					if(c!=KEY_RETURN && c!=KEY_UP)
					{
						gotoxy(gMenuJoueursX,gMenuY+1);
						cputc(' ');
						cputsxy(gMenuJoueursX+1,gMenuY+1,gJoueursType);
						revers(FALSE);cclear(strlen(gTypeJoueurs[i-1]));
					}
					else break;
					
					revers(FALSE);

					switch(i)
					{
						case 1:	// 2 joueurs => pas d'autre question : joueur 1 commence !
						
							j[0] = j[1] = 0;
							break;
						case 2:	// 1 joueur
							//cputsxy(0,gScreenY-8,gJ2ordi);
							j[0]=0;
							j[1]=1;
							// choix de la profondeur de recherche pour l'ordi
							do
							{
								revers(TRUE);
								gotoxy(gMenuJoueursX,gMenuY+2);
								cputc(' ');
								revers(FALSE);
								cputs(gProfondeur); // sans reverse
								i = prof[1];
								revers(TRUE);
								cputc(' ');
								do
								{
									cplotc((char)(i+48));
									c = getkj();
									if(c == KEY_RIGHT && i<6) i++;
									if(c == KEY_LEFT && i>1) i--;
								} while(c != KEY_RETURN && c !=KEY_UP && (n!=0 || c !=KEY_DOWN) );
								prof[1]=i;
								revers(TRUE);
								gotoxy(gMenuJoueursX,gMenuY+2);
								cputc(' ');
								cputs(gProfondeur); // sans reverse
								revers(FALSE);
								cputs("  ");
								//cplotc((char)(i+48));
								if(c==KEY_UP || c==KEY_RETURN) break; // du do/while
						
								// commence utile juste la première fois quand n=0
								if(n==0)
								{
									i = commence;
									revers(FALSE);cputsxy(gMenuJoueursX+1,gMenuY+3,gQuiCommence);revers(TRUE);
									do
									{
										if(i==0) cputs(gVous); else cputs(gMoi);
										gotox(wherex()-strlen(gVous));
										c = getkj();
										if( c == KEY_LEFT || c == KEY_RIGHT) i=1-i;
									} while(c != KEY_RETURN && c != KEY_UP); // && c != KEY_DOWN );
									commence=i;
									cputsxy(gMenuJoueursX+1,gMenuY+3,gQuiCommence);
									revers(FALSE);
									//if(i==0) cputs(gVous); else cputs(gMoi);
									cclear(strlen(gMoi));
								}
						
							}  while (c!=KEY_RETURN);
								
							i=2;
							break;
						case 3:	// 2 ordi 
							//#ifdef STRCPY_JOUEURS
							//STRCPY_JOUEURS
							//#endif
							j[0] = j[1] = 1;
							i=0;
							do
							{
								//char k;
								gotoxy(gMenuJoueursX,gMenuY+2+i);
								revers(TRUE);
								//cputsxy(gMenuJoueursX,gMenuY+2+i, 
								cputc(gJ[2][i][0]);
								revers(FALSE);
								cputs(gJ[2][i]+1);
								revers(FALSE);cputs(gProfondeur);revers(TRUE);
								k = prof[i];
								cputc(' ');
								do
								{
									cplotc((char)(k+48));
									c = getkj();
									if(c == KEY_RIGHT && k<6) k++;
									if(c == KEY_LEFT && k>1) k--;
								} while(c != KEY_RETURN && c != KEY_UP && (c != KEY_DOWN || i==1));
								prof[i]=k;
								if(i==1 & c==KEY_UP)  c=0;// en bas donc on ne quitte pas
								revers(TRUE);cputsxy(gMenuJoueursX,gMenuY+2, gO1);
								revers(TRUE);cputs(gProfondeur);revers(FALSE);cputs("   ");
								revers(TRUE);cputsxy(gMenuJoueursX,gMenuY+3, gO2);
								revers(TRUE);cputs(gProfondeur);revers(FALSE);cputs("   ");
								i=1-i;
							}
							while(c != KEY_RETURN && c != KEY_UP);
							i=3;
							break;
						default:
						// inutile maintenant mais souvenir de la première version de 89!
							cputs("\n\r\t\tVous n'^tes pas en forme !..\n\r");
							cputs("Revenez me voir quand vous irez mieux ....\n\r");
							cputs("\n\r\n\r\t\t\t\tAtchao !\n\r\n\r");
							exit(5);
					}
					//afficherPlateau(jeu);
				} while (c!= KEY_RETURN);
				if(j[0]==j[1]) commence = 0; // 2 joueurs ou 2 ordi => joueur 1 commence
				revers(FALSE);
				break;
			case 3:	// Menu OPTIONS
				if(n==0) afficherMenuOptions();
				break;
			case 4:
				break;
		}
		//gotoxy(0,10);cprintf("choix : %d, commence : %d ! ",choix,commence);
	} while (choix != 4);

	//clrscr();
	//for(k=7;k>0;k--) cclearxy(0,gScreenY-k,38);
	cputsxy(0,gPosEvalY,gPositionsEvaluees);
	
	revers(TRUE);
	cputsxy(gMenuJeuX,gMenuY,gMenuJeu);
	cputsxy(gMenuJoueursX,gMenuY,gMenuJoueurs);
	cputsxy(gMenuOptionsX,gMenuY,gMenuOptions);
	//cputsxy(gMenuOKX,gMenuY,gMenuOK);
	revers(FALSE);
	return(commence);
}

/**
 *	Affichage des règles du jeu
 *	Si compilation pour Oric, affichage du message d'attente en vert
 */
void afficherRegles()
{
	UBYTE k;
	char *lRegles;
	char *s;
	UBYTE x,y;
	
	clrscr();
	// gestion sur plusieurs pages si nécessaire
	// remplacement des valeurs variables
	lRegles = malloc(strlen(gRegles));
	strcpy(lRegles,gRegles);
	s=strchr(lRegles,'$');
	// $ = > affichage du nombre de graines par trou
	while (s!=NULL)
	{
		*s =gNbGrains+'0';
		s=strchr(s+1,'$');
	}
	// gestion du saute ou non le kalaha adverse lors de la distribution
	s=strstr(lRegles,"***");
	while (s!=NULL)
	{
		if(gSauteKalah)
		{
			*s++ = 's'; 
			*s++ = 'o'; 
			*s++ = 'n'; 
		}
		else
		{
			*s++ = 'l'; 
			*s++ = 'e'; 
			*s++ = 's'; 
		}		
		s=strstr(s,"***");
	}

	
		// titre = centré !
	textcolor(COLOR_RED);
	cputsxy(gScreenX/2-strlen(gReglesTitre)/2,0,gReglesTitre);
	textcolor(COLOR_WHITE);
	y=2;
	s=strtok(lRegles,"\n");
	// on découpe par ligne sur LF tant qu'on n'a pas tout afficher
	while(s)
	{
		// page suivante => message d'attente frappe clavier ou joystick
		if((*s == '\f') || (y==gScreenY-1))
		{
			gotoxy(15,gScreenY-1);
			#ifdef __ATMOS__
				cputs("\x02");
			#endif
			textcolor(COLOR_GREEN);
			cputs("<RETURN> pour continuer");
			textcolor(COLOR_WHITE);
			do k = getkj(); while(k != KEY_RETURN);
			clrscr();
			textcolor(COLOR_RED);
			cputsxy(gScreenX/2-strlen(gReglesTitre)/2,0,gReglesTitre);
			textcolor(COLOR_WHITE);
			y=2;
			
		}
		// @ => si gCompte->mien => affichage de la ligne sinon ligne suivante
		if(*s == '@')
		{
			s++;
			if(gCompte != 1)
				*s='\f'; // => pour ne rien écrire de la ligne

		}
		// +# => si gCompte->adversaire => affichage de la ligne sinon ligne suivante
		if(*s == '#')
		{
			s++;
			if(gCompte != 2)
				*s='\f'; // => pour ne rien écrire de la ligne

		}
	
		if(*s != '\f') 
			cputsxy(0,y++,s);
		s=strtok(NULL,"\n");
	}
	//cputsxy(0,0,gRegles);
	// message d'attente de frappe clavier /joystick
	gotoxy(15,gScreenY-1);
	#ifdef __ATMOS__
		cputs("\x02");
	#endif
	textcolor(COLOR_GREEN);
	cputs("<RETURN> pour continuer");
	do k = getkj(); while(k != KEY_RETURN);
	textcolor(COLOR_WHITE);

	free(lRegles);
	
}

/**
 *	Affichage d'une chaîne pour déboggage
 */
void dbgprint(STRPTR s)
{
	cputsxy(0,15,s);
}
