// version du 16 avril 2021
// utilisation du fichier awele_conio.c commun
// Fichier edité en ISO LATIN1

// redéfinition des caracteres
#define CH_REDEFINED
#define MYCH_HLINE	'='
#define MYCH_VLINE	'|'
#define MYCH_CROSS	'@'
#define MYCH_RTEE	']'
#define MYCH_LTEE	'['
#define MYCH_TTEE	'{'
#define MYCH_BTEE	'}'
#define MYCH_URCORNER	'$'
#define MYCH_ULCORNER	'#'
#define MYCH_LRCORNER	'&'
#define MYCH_LLCORNER	'%'

//#pragma charmap (0xE9, 0x5F)

#include "../conio/awele_conio.c"

void setup(void);
int getkey(void);
// void hires(void);
// void quit(void);
// void cursorno();


/**
 *	Remplacement des accents ISO Latin1 par les équivalents redéfinis pour Oric
 *	@param	chaine	: chaîne de caractères dont il faut remplacer les accents
 */
void remplacerAccents(char *chaine)
{
	char *s;
	s=chaine;
	s=strchr(s,'é');
	while (s!=NULL)
	{
		*s ='_';
		s=strchr(s+1,'é');
	}
	s=chaine;
	s=strchr(s,'è');
	while (s!=NULL)
	{
		*s ='^';
		s=strchr(s+1,'è');
	}
	s=chaine;
	s=strchr(s,'à');
	while (s!=NULL)
	{
		*s ='`';
		s=strchr(s+1,'à');
	}
}
/**
 *	Initialisation du joystick : uniquement de type IJK sur Oric
 */
void initJoystick()
{
    joy_install (&atmos_ijk_joy);
}

/**
 *	Fonction qui attend la saisie d'une touche ou une action sur le joystick
 *	@return	touche saisie ou équivalent touche si joystick
 */
UBYTE getkj()
{
	UBYTE c=0,j=0;
	do{j=joy_read(JOY_1);} while(j);
	do
	{
		c = getkey(); 
        j=joy_read(JOY_1);
	}
	while(!c && !j);

	if(JOY_UP(j)) c = KEY_UP;
	if(JOY_DOWN(j)) c = KEY_DOWN;
	if(JOY_LEFT(j)) c = KEY_LEFT;
	if(JOY_RIGHT(j)) c = KEY_RIGHT;
	if(JOY_FIRE(j)) c = KEY_RETURN;

	do{j=joy_read(JOY_1);} while(j);
	return c;
}

/**
 *	Modification d'un caractère à partir d'un tableau 8 bits x 8 bits
 *	@param	c	: caractère à redéfinir
 *	@param	t	: tableau contenant les 8 octets du caractère à modifier (type BYTEBITS)
 */
void modifCaractere(char c, BYTEBITS t[8])
{
	int i;
	for(i=0;i<8;i++)
		POKE(46080L+c*8+i, t[i]);
}

/**
 *	Initialisation du plateau de jeu : 
 *  	redéfinition de caractères pour les accents
 *		redéfinition de caractères pour le plateau de jeu
 *		remplacement des accents dans des variables globales
 *		redéfinition de variables globales pour du spécifique Oric
 */
void initPlateau()
{
	int c,k,i;
	setup();

// gotoxy(1,20);cprintf("%d-->%c",'_','_');
// gotoxy(1,21);cprintf("%d-->%c-->%s",'é','é',"égalité");
// gotoxy(1,22);cprintf("%s->%c->%d=%x",gEgalite,gEgalite[6],gEgalite[6],gEgalite[6]);
// gEgalite[6]='_';
// gotoxy(1,23);cprintf("%s->%c->%d=%x",gEgalite,gEgalite[6],gEgalite[6],gEgalite[6]);
//cgetc();
//fflush(stdin);
	strcpy(gJ2ordi,"Oric en joueur 2");
/* redef de caractere peu utilisé pour accent */
// livre ( = _ en latin1) pour é
	c=95;k=101;
	POKE(46080L+c*8, 4);
	POKE(46080L+c*8+1, 8);
	for(i=2;i<8;i++)
	{
		POKE(46080L+c*8+i, PEEK(46080L+k*8+i));
	}
   
// ^ pour è
	c=94;k=101;
	POKE(46080L+c*8, 16);
	POKE(46080L+c*8+1, 8);
	for(i=2;i<8;i++)
	{
		POKE(46080L+c*8+i, PEEK(46080L+k*8+i));
	}
// ` pour à
	c=96;k=97;
	POKE(46080L+c*8, 16);
	POKE(46080L+c*8+1, 8);
	for(i=2;i<8;i++)
	{
		POKE(46080L+c*8+i, PEEK(46080L+k*8+i));
	}
//    pour 1/2 (obsolète ?)
	{
		BYTEBITS tb[] = {
		0b00010001,
		0b00110010,
		0b00010100,
		0b00010111,
		0b00001001,
		0b00010010,
		0b00100111,
		0b00000000
		};
	modifCaractere(92,  tb);
	}
//
	{
		BYTEBITS tb[] = {
		0b00001100,
		0b00001100,
		0b00001100,
		0b00001100,
		0b00001100,
		0b00001100,
		0b00001100,
		0b00001100
		};
	modifCaractere(124,  tb);
	}
	
	{
		BYTEBITS tb[] = {
		0b00000000,
		0b00000000,
		0b00000000,
		0b00000111,
		0b00001111,
		0b00001110,
		0b00001100,
		0b00001100
		};
	modifCaractere(35,  tb);
	}
	
	
	{
		BYTEBITS tb[] = {
		0b00000000,
		0b00000000,
		0b00000000,
		0b00111000,
		0b00111100,
		0b00011100,
		0b00001100,
		0b00001100
		};
	modifCaractere(36,  tb);
	}
	
	{
		BYTEBITS tb[] = {
		0b00001100,
		0b00001100,
		0b00001110,
		0b00001111,
		0b00000111,
		0b00000000,
		0b00000000,
		0b00000000
		};
	modifCaractere(37,  tb);
	}
	
	{
		BYTEBITS tb[] = {
		0b00001100,
		0b00001100,
		0b00011100,
		0b00111100,
		0b00111000,
		0b00000000,
		0b00000000,
		0b00000000
		};
	modifCaractere(38,  tb);
	}

	{
		BYTEBITS tb[] = {
		0b00000000,
		0b00000000,
		0b00000000,
		0b00111111,
		0b00111111,
		0b00000000,
		0b00000000,
		0b00000000
		};
	modifCaractere(61,  tb);
	}

	{
		BYTEBITS tb[] = {
		0b00001100,
		0b00001100,
		0b00001110,
		0b00001111,
		0b00001111,
		0b00001110,
		0b00001100,
		0b00001100
		};
	modifCaractere(91,  tb);
	}
	
	{
		BYTEBITS tb[] = {
		0b00001100,
		0b00001100,
		0b00011100,
		0b00111100,
		0b00111100,
		0b00011100,
		0b00001100,
		0b00001100
		};
	modifCaractere(93, tb);
	}		
	
	
		{
		BYTEBITS tb[] = {
		0b00001100,
		0b00001100,
		0b00011110,
		0b00111111,
		0b00111111,
		0b00011110,
		0b00001100,
		0b00001100
		};
	modifCaractere(64, tb);
	}	
	
	
	{
		BYTEBITS tb[] = {
		0b00000000,
		0b00000000,
		0b00000000,
		0b00111111,
		0b00111111,
		0b00011110,
		0b00001100,
		0b00001100
		};
	modifCaractere(123, tb);
	}		
	{
		BYTEBITS tb[] = {
		0b00001100,
		0b00001100,
		0b00011110,
		0b00111111,
		0b00111111,
		0b00000000,
		0b00000000,
		0b00000000,
		};
	modifCaractere(125, tb);
	}
	
	
	remplacerAccents(gEgalite);
	remplacerAccents(gPositionsEvaluees);
	remplacerAccents(gRegles);
	gRegles[6]=1;
	remplacerAccents(gMenuRegles);
	strcpy(gO1,"\6Oric 1\7\x00");
	strcpy(gO2,"\1Atmos\7\x00 ");//gJ2[0]=1;
	strcpy(gJ[2][0],"\6Oric 1\7");
	strcpy(gJ[2][1],"\1Atmos\7 ");//gJ2[0]=1;

	clrscr();
}

