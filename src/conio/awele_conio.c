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



void free();
void exit();

extern UWORD posEval;

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


UBYTE screenx,screeny;


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
 *	Affichage d'une chaine suivi d'un retour chariot
 *	@param	s	: chaîne à afficher
 */
void clputs(STRPTR s)
{
	cputs(s);cputs("\r\n");
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
	cprintf("%2d",grains);
	revers(FALSE);
}

/**
 *	Affichage du plateau de jeu
 *	@param p	: pointeur vers le tableau contenant le plateau à afficher
 */
void afficherPlateau(UBYTE *p)
{
	register int i;

	cputsxy(0,1,"               ");
	//if(j[0]+j[1] == 1) cputs(gMoi);else cputs(gJ2);
	cputs(gJ[j[0]+j[1]][1]);
	cputs("       \r\n       ");
	for( i=2*NCASES; i>NCASES; i--)
	{
		cprintf("%2d ", i);
	}

	clputs("");
	cputs("      ");cputc(MYCH_ULCORNER);
	for( i=0; i<NCASES-1; i++)
	{
		cputs(sLineUp);
	}
	clputs(sLineUpRightCorner);
	cputs(sKalahUpLeft);
	for( i=2*NCASES; i>NCASES+1; i--)
	{
		cprintf("%2d", p[i]);cputc(MYCH_VLINE);
	}
	cprintf("%2d", p[i]);
	clputs(sKalahUpRight);

	cprintf("%2d%c%2d %c",KALAH2,MYCH_VLINE,p[KALAH2],MYCH_LTEE);
	for( i=0; i<NCASES-1; i++)
		cputs(sLineMid);
	cputs(sLine);
	cprintf("%c%2d %c%2d\r\n",MYCH_RTEE,p[KALAH1],MYCH_VLINE,KALAH1);
	cputs(sKalahDownLeft);
	for( i=0; i<NCASES-1; i++)
	{
	  cprintf("%2d%c", p[i],MYCH_VLINE);
	}
	cprintf("%2d", p[i]);
	clputs(sKalahDownRight);

	cputs("      ");cputc(MYCH_LLCORNER);
	for( i=0; i<NCASES-1; i++)
		cputs(sLineDown);
	clputs(sLineDownCorner);

	cputs("       ");
	for( i=0; i<NCASES; i++)
	{
	  cprintf("%2d ", i);
	}
	clputs("");
	cputs("               ");
	//if(j[0]+j[1] == 1) cputs(gVous);else cputs(gJ1);
	cputs(gJ[j[0]+j[1]][0]);
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

	l=11;
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

	cputsxy(12,l,"Rejouer ?");

	
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
		cputsxy(23,l,"Oui");
		revers(FALSE);cputc(' ');
		revers(!i);
		cputs("Non");
		k = getkj();
		if(k == KEY_LEFT || k == KEY_RIGHT)
		{
			i = !i;
		} 
	} while(k != KEY_RETURN);
	

	clrscr();

	return((BOOLEAN)i);
}

/**
 *	Affichage du nombre de positions évaluées
 *	à la position prévue pour cela sur l'écran
 *	posEval est une varialbe globale
 */
void afficherPosEval()
{
	gotoxy(21,0);
	cprintf("%d   ",posEval);
}

/**
 *	Affichage du message d'attente lors d'un coup de l'ordinateur
 *	et attente de l'appui sur la touche RETURN (= le bouton de feu si joystick)
  *	@see effacerAttente
 *	@param joueur	: numéro du joueur (1 ou 2)
 *	@param casejouee	: case jouée par le joueur
 */
void afficherAttente(UBYTE joueur, UBYTE casejouee)
{
	UBYTE k;
	gotoxy(0,12);
	cprintf("Le joueur %u joue la case %u           \r\n",joueur,casejouee);
	#ifdef __ATMOS__
		cputs("\x0C\x02");
	#endif
	cputs("<RETURN> pour continuer");
	do
	{
		k = getkj();
		if(k == KEY_ESC)
		{
			menuOptions(1+j[0]+j[1]);
			if(j[joueur-1] == 0 ) k=KEY_RETURN;
		}			

	}
	while(k != KEY_RETURN);

}

/**
 *	Effacer le message d'attente du coup de l'ordinateur
 *	@see afficherAttente
 */
void effacerAttente()
{
	cclearxy(0,12,40);
	cclearxy(0,13,40);
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
	cputsxy(0,10, gJ[j[0]+j[1]][joueur]);
	cputs(gQuelleCase); 

	for(c=joueur*(NCASES+1);!jeu[c];c++);
	y= 6-joueur*2;
	do
	{
		x=7+(7*joueur+(1-2*joueur)*(c-joueur*(NCASES+1)))*3;
		cputixy(x,y,TRUE,jeu[c]);
		do
		{

			do k = getkj(); while(!k);
			if(k == KEY_ESC)
			{
				cputixy(x,y,FALSE,jeu[c]);
				menuOptions(1+j[0]+j[1]);
				if(j[joueur])	return(99);
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

		   if(c<joueur*(NCASES+1)) c=joueur*(NCASES+1);
			else if(c>=(joueur+1)*NCASES+joueur) c=(joueur+1)*NCASES+joueur-1;

			x=7+(7*joueur+(1-2*joueur)*(c-joueur*(NCASES+1)))*3;
			cputixy(x,y,TRUE,jeu[c]);

		
		} while(k != KEY_RETURN);
		cputixy(x,y,FALSE,jeu[c]);
	
	} while(c<joueur*(NCASES+1) || c>=(joueur+1)*NCASES+joueur || !jeu[c]);
	
	return(c);
}

/**
 *	Fonction de choix dans les menus de l'application
 *	- Affichage des règles du jeu
 *	- choix des options de jeu (0/1/2 joueurs huamains ou ordinateurs)
 *	- TODO : menu pour gérer des variantes
 *	@see choixJoueur
 *	@see main
 *	@param n 	: n=0 pour l'affichage en début de partie sinon numéro du joueur en cours
 *	@return	: case jouée par le joueur
 */
UBYTE menuOptions(UBYTE n)
{
	UBYTE c, i, choix,commence,k; //, l;

	screensize(&screenx,&screeny);
	
	choix=1;
	i=(n!=0)?n:2; // choix joueurs/ordinateur : par défaut PvC
	commence =0;
	do
	{
		for(k=7;k>0;k--) cclearxy(0,screeny-k,38);
		// Choix du du menu : Règles - Joueurs - OK => RàF: Quitter puis Variantes
		do
		{
			revers(choix==1);cputsxy(0,screeny-1,gMenuRegles);
			gotoxy(10,screeny-1);revers(choix==2);cputs(gMenuJoueurs);
			gotoxy(20,screeny-1);revers(choix==3);cputs(gMenuOK);
			revers(FALSE);
			c = getkj();
			if(c == KEY_LEFT && choix>1) choix--;
			if(c == KEY_RIGHT && choix<3) choix++;
		} while(c != KEY_RETURN);
		switch(choix)
		{
			case 1:	// Règles du jeu
				afficherRegles();
				clrscr();
				afficherPlateau(jeu);
				break;
			case 2:	// nb de joeurs/ordinateurs
				switch(i)
				{
					case 1:	// 2 joueurs => pas d'autre question : joueur 1 commence !
						if(n==0)
						{
							cputsxy(0,screeny-8,gJ1commence);cputs("          ");
						}
						cclearxy(0,screeny-6,38);
						cclearxy(0,screeny-5,38);							
						break;
					case 2:
						if(n==0)
						{
							cputsxy(0,screeny-8,gJ2ordi);cputs("          ");
							cputsxy(0,screeny-5,gOptionQuiCommence);
							//if(commence==0) cputs(gVous); else cputs(gMoi);
							cputs(gJ[1][commence]);
							cputs("          ");
						}
						cputsxy(0,screeny-6,gOptionProfondeur);cprintf("%d",prof[1]);cputs("          ");
						break;
					case 3:
						if(n==0)
						{
							cputsxy(0,screeny-8,gJ1commence);cputs("          ");
						}
						cputsxy(0,screeny-6, gJ[2][0]);cputs(gOptionProfondeur);cprintf("%c",(char)(prof[0]+48));cputs("          ");
						cputsxy(0,screeny-5, gJ[2][1]);cputs(gOptionProfondeur);cprintf("%c",(char)(prof[1]+48));cputs("          ");
						break;
				}
				do
				{

					do
					{
						gotoxy(0,screeny-7);
						//revers(i==1);cputs(gOptionJoueurs[0]);revers(FALSE);clputs((i==1)?gJ1commence:"                    ");
						//revers(i==2);cputs(gOptionJoueurs[1]);revers(FALSE);clputs((i==2)?gJ2ordi:"                         ");
						//revers(i==3);cputs(gOptionJoueurs[2]);revers(FALSE);clputs((i==3)?gJ1commence:"                    ");
						revers(TRUE);cputs(gOptionJoueurs[i-1]);revers(FALSE);//clputs((i==2)?gJ2ordi:gJ1commence);
						c = getkj();
						if(c == KEY_RIGHT && i>1) i--;
						if(c == KEY_LEFT && i<3) i++;
						switch(i)
						{
							case 1:	// 2 joueurs => pas d'autre question : joueur 1 commence !
								if(n==0)
								{
									cputsxy(0,screeny-8,gJ1commence);cputs("          ");
								}
								cclearxy(0,screeny-6,38);
								cclearxy(0,screeny-5,38);							
								break;
							case 2:
								if(n==0)
								{
									cputsxy(0,screeny-8,gJ2ordi);cputs("          ");
									cputsxy(0,screeny-5,gOptionQuiCommence);
									//if(commence==0) cputs(gVous); else cputs(gMoi);
									cputs(gJ[1][commence]);
									cputs("          ");
								}
								else
									cclearxy(0,screeny-5,38);
								cputsxy(0,screeny-6,gOptionProfondeur);cplotc((prof[1]+48));cprintf("%c",(prof[1]+48));cputs("          ");
								break;
							case 3:
								if(n==0)
								{
									cputsxy(0,screeny-8,gJ1commence);cputs("          ");
								}
								cputsxy(0,screeny-6, gJ[2][0]);cputs(gOptionProfondeur);cprintf("%c",(char)(prof[0]+48));cputs("          ");
								cputsxy(0,screeny-5, gJ[2][1]);cputs(gOptionProfondeur);cprintf("%c",(char)(prof[1]+48));cputs("          ");
								break;
						}
						cputsxy(15,1,gJ[i-1][1]);
						cputsxy(15,9,gJ[i-1][0]);
					} while(c!=KEY_RETURN && c!=KEY_DOWN);
					j[0]=(i-1)>>1;
					j[1]=i>>1;
					if(c!=KEY_RETURN)
					{
						cputsxy(0,screeny-7,gOptionJoueurs[i-1]);
					}
					else break;
					switch(i)
					{
						case 1:	// 2 joueurs => pas d'autre question : joueur 1 commence !
							//cputsxy(0,screeny-8,gJ1commence);
						
							j[0] = j[1] = 0;
							//commence = 0;
							break;
						case 2:	// 1 joueur
							//cputsxy(0,screeny-8,gJ2ordi);
							j[0]=0;
							j[1]=1;
							// choix de la profondeur de recherche pour l'ordi
							do {
							revers(TRUE);cputsxy(0,screeny-6,gOptionProfondeur);revers(FALSE);
						
							i = prof[1];
							do
							{
								cplotc((char)(i+48));
								c = getkj();
								if(c == KEY_RIGHT && i<6) i++;
								if(c == KEY_LEFT && i>1) i--;
							} while(c != KEY_RETURN && c !=KEY_UP && (n!=0 || c !=KEY_DOWN) );
							prof[1]=i;
							cputsxy(0,screeny-6,gOptionProfondeur); // sans reverse
						
							if(c==KEY_UP || c==KEY_RETURN) break; // du do/while
						
							// commence utile juste la première fois quand n=0
							if(n==0)
							{
								i = commence;
								revers(TRUE);cputsxy(0,screeny-5,gOptionQuiCommence);revers(FALSE);
								do
								{
									if(i==0) cputs(gVous); else cputs(gMoi);
									gotox(wherex()-strlen(gVous));
									c = getkj();
									if( c == KEY_LEFT || c == KEY_RIGHT) i=2-i;
								} while(c != KEY_RETURN && c != KEY_UP); // && c != KEY_DOWN );
								commence=i;
								cputsxy(0,screeny-5,gOptionQuiCommence);
							}
						
							}  while (c!=KEY_RETURN);
												
							i=2;
							break;
						case 3:	// 2 ordi 
							//#ifdef STRCPY_JOUEURS
							//STRCPY_JOUEURS
							//#endif
							j[0] = j[1] = 1;
// 							if(n==0)
// 							{
// 								cputsxy(0,screeny-8,gJ1commence);
// 							}
							//for( i=0; i<2; i++)
							i=0;
							do
							{
								//char k;
								cputsxy(0,screeny-6+i, gJ[2][i]);
								revers(TRUE);cputs(gOptionProfondeur);revers(FALSE);
								k = prof[i];
								do
								{
									cplotc((char)(k+48));
									c = getkj();
									if(c == KEY_RIGHT && k<6) k++;
									if(c == KEY_LEFT && k>1) k--;
								} while(c != KEY_RETURN && c != KEY_UP && (c != KEY_DOWN || i==1));
								prof[i]=k;
								if(i==1 & c==KEY_UP)  c=0;
								cputsxy(0,screeny-6+i, gJ[2][i]);
								cputs(gOptionProfondeur);
								i=1-i;
							}
							while(c != KEY_RETURN && c != KEY_UP);
							//commence=0;
							i=3;
							break;
						default:
							clputs("\n\r\t\tVous n'^tes pas en forme !..\n\r");
							clputs("Revenez me voir quand vous irez mieux ....\n\r");
							clputs("\n\r\n\r\t\t\t\tAtchao !\n\r\n\r");
							exit(5);
					}
					//afficherPlateau(jeu);
				} while (c!= KEY_RETURN);
				if(j[0]==j[1]) commence = 0; // 2 joueurs ou 2 ordi => joueur 1 commence
				break;
			case 3:
				break;
		}
		//gotoxy(0,10);cprintf("choix : %d, commence : %d ! ",choix,commence);
	} while (choix != 3);

	//clrscr();
	for(k=7;k>0;k--) cclearxy(0,screeny-k,38);
	cputsxy(0,0,gPositionsEvaluees);
	return(commence);
  
}

/**
 *	Affichage des règles du jeu
 *	Si compilation pour Oric, affichage du message d'attente en vert
 */
void afficherRegles()
{
	UBYTE k;
	clrscr();
	cputsxy(0,0,gRegles);
	gotoxy(15,screeny-1);
	#ifdef __ATMOS__
		cputs("\x0C\x02");
	#endif
	cputs("<RETURN> pour continuer");
	do k = getkj(); while(k != KEY_RETURN);
	
}

/**
 *	Affichage d'une chaîne pour déboggage
 */
void dbgprint(STRPTR s)
{
	cputsxy(0,15,s);
}