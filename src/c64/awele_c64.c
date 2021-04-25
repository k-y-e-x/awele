// version du 14 mars 2021
// #include <stdio.h>
// #include <stdlib.h>
// #include <stdarg.h>
// #include <string.h>
// #include "../mes_types.h"
// #include <joystick.h>
// #include <conio.h>
// 
// #include "../macros.h"
// #include "../awele.h"
// #include "../globals.h"

#define STRCPY_JOUEURS		strcpy(gJoueur[0],"C65\x00");\
		strcpy(gJoueur[1],"C64\x00 ");\
		strcpy(gJ1,"C65\x00");\
		strcpy(gJ2,"C64\x00 ");\

#include "../conio/awele_conio.c"

//void free();
//void exit();

extern UWORD posEval;

void init()
{
	clrscr();
}
void initJoystick()
{
    joy_install (&c64_stdjoy_joy);
}

UBYTE getkj()
{
	UBYTE c=0,j=0;
	do{j=joy_read(JOY_1);} while(j);
	//gotoxy(5,11);
	//cputc(48+KEY_UP);cputc(48+KEY_DOWN);cputc(48+KEY_LEFT);cputc(48+KEY_RIGHT);cputc(48+KEY_RETURN);
	do
	{
		if(kbhit())
			c=cgetc();
        j=joy_read(JOY_1);
	}
	while(!c && !j);
// spécifique C64	
	switch(c)
	{
		case CH_CURS_LEFT :
			c = KEY_LEFT;
			break;
		case CH_CURS_RIGHT :
			c = KEY_RIGHT;
			break;
		case CH_CURS_DOWN :
			c = KEY_DOWN;
			break;
		case CH_CURS_UP :
			c = KEY_UP;
			break;
		case CH_ENTER :
			c = KEY_RETURN;
			break;
		case CH_ESC:
		case CH_STOP:
			c = KEY_ESC;
			break;
			
	}
	//gotoxy(0,10);if(j) cprintf("joy : %d left %d right %d",j,JOY_LEFT(j),JOY_RIGHT(j));
	if(JOY_UP(j)) c = KEY_UP;
	if(JOY_DOWN(j)) c = KEY_DOWN;
	if(JOY_LEFT(j)) c = KEY_LEFT;
	if(JOY_RIGHT(j)) c = KEY_RIGHT;
	if(JOY_FIRE(j)) c = KEY_RETURN;
	//if(c) cprintf("=>c=%d   ",c);
	do{j=joy_read(JOY_1);} while(j);
	while(kbhit()) cgetc();	// vide buffer clavier sinon pb joy_left=>key_right!
	return c;
}

void remplacerAccents(char *chaine)
{
	char *s;
	s=chaine;
	s=strchr(s,'é');
	while (s!=NULL)
	{
		*s ='e';
		s=strchr(s+1,'é');
	}
	s=chaine;
	s=strchr(s,'è');
	while (s!=NULL)
	{
		*s ='e';
		s=strchr(s+1,'è');
	}
	s=chaine;
	s=strchr(s,'à');
	while (s!=NULL)
	{
		*s ='a';
		s=strchr(s+1,'à');
	}
}

void initPlateau()
{
	remplacerAccents(gEgalite);
	remplacerAccents(gPositionsEvaluees);
	remplacerAccents(gRegles);
	remplacerAccents(gMenuRegles);
		
	strcpy(gJ2ordi,"C64 en joueur 2");
	clrscr();
}