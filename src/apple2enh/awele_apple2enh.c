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

#define STRCPY_JOUEURS		strcpy(gJoueur[0],"IIe\x00");\
		strcpy(gJoueur[1],"IIc\x00 ");\
		strcpy(gJ1,"IIe\x00");\
		strcpy(gJ2,"IIc\x00 ");\

#include "../conio/awele_conio.c"

//void free();
//void exit();

//extern UWORD posEval;

// void init()
// {
// 	clrscr();
// }
void initJoystick()
{
    joy_install (&a2e_stdjoy_joy);
}

UBYTE getkj()
{
	UBYTE c=0,j=0;
	do{j=joy_read(JOY_1);} while(j);
	do
	{
		if(kbhit())
			c=cgetc();
        j=joy_read(JOY_1);
	}
	while(!c && !j);

	if(JOY_UP(j)) c = KEY_UP;
	if(JOY_DOWN(j)) c = KEY_DOWN;
	if(JOY_LEFT(j)) c = KEY_LEFT;
	if(JOY_RIGHT(j)) c = KEY_RIGHT;
	if(JOY_BTN_1(j)) c = KEY_RETURN;
	do{j=joy_read(JOY_1);} while(j);
	//while(kbhit()) cgetc();	// vide buffer clavier sinon pb joy_left=>key_right!
	return c;
}

void remplacerAccents(char *chaine)
{
	char *s;
	s=chaine;
	s=strchr(s,'�');
	while (s!=NULL)
	{
		*s ='e';
		s=strchr(s+1,'�');
	}
	s=chaine;
	s=strchr(s,'�');
	while (s!=NULL)
	{
		*s ='e';
		s=strchr(s+1,'�');
	}
	s=chaine;
	s=strchr(s,'�');
	while (s!=NULL)
	{
		*s ='a';
		s=strchr(s+1,'�');
	}
}

void initPlateau()
{
	remplacerAccents(gEgalite);
	remplacerAccents(gPositionsEvaluees);
	remplacerAccents(gRegles);
	remplacerAccents(gJeuRegles);
	remplacerAccents(gOptionCompte);

	strcpy(gJ2ordi,"Apple en joueur 2");
	clrscr();
}