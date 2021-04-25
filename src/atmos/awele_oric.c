// version du 16 avril 2021
// utilisation du fichier awele_conio.c commun
// Fichier edit� en ISO LATIN1

// red�finition des caracteres
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
 *	Remplacement des accents ISO Latin1 par les �quivalents red�finis pour Oric
 *	@param	chaine	: cha�ne de caract�res dont il faut remplacer les accents
 */
void remplacerAccents(char *chaine)
{
	char *s;
	s=chaine;
	s=strchr(s,'�');
	while (s!=NULL)
	{
		*s ='_';
		s=strchr(s+1,'�');
	}
	s=chaine;
	s=strchr(s,'�');
	while (s!=NULL)
	{
		*s ='^';
		s=strchr(s+1,'�');
	}
	s=chaine;
	s=strchr(s,'�');
	while (s!=NULL)
	{
		*s ='`';
		s=strchr(s+1,'�');
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
 *	@return	touche saisie ou �quivalent touche si joystick
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
 *	Modification d'un caract�re � partir d'un tableau 8 bits x 8 bits
 *	@param	c	: caract�re � red�finir
 *	@param	t	: tableau contenant les 8 octets du caract�re � modifier (type BYTEBITS)
 */
void modifCaractere(char c, BYTEBITS t[8])
{
	int i;
	for(i=0;i<8;i++)
		POKE(46080L+c*8+i, t[i]);
}

/**
 *	Initialisation du plateau de jeu : 
 *  	red�finition de caract�res pour les accents
 *		red�finition de caract�res pour le plateau de jeu
 *		remplacement des accents dans des variables globales
 *		red�finition de variables globales pour du sp�cifique Oric
 */
void initPlateau()
{
	int c,k,i;
	setup();

// gotoxy(1,20);cprintf("%d-->%c",'_','_');
// gotoxy(1,21);cprintf("%d-->%c-->%s",'�','�',"�galit�");
// gotoxy(1,22);cprintf("%s->%c->%d=%x",gEgalite,gEgalite[6],gEgalite[6],gEgalite[6]);
// gEgalite[6]='_';
// gotoxy(1,23);cprintf("%s->%c->%d=%x",gEgalite,gEgalite[6],gEgalite[6],gEgalite[6]);
//cgetc();
//fflush(stdin);
	strcpy(gJ2ordi,"Oric en joueur 2");
/* redef de caractere peu utilis� pour accent */
// livre ( = _ en latin1) pour �
	c=95;k=101;
	POKE(46080L+c*8, 4);
	POKE(46080L+c*8+1, 8);
	for(i=2;i<8;i++)
	{
		POKE(46080L+c*8+i, PEEK(46080L+k*8+i));
	}
   
// ^ pour �
	c=94;k=101;
	POKE(46080L+c*8, 16);
	POKE(46080L+c*8+1, 8);
	for(i=2;i<8;i++)
	{
		POKE(46080L+c*8+i, PEEK(46080L+k*8+i));
	}
// ` pour �
	c=96;k=97;
	POKE(46080L+c*8, 16);
	POKE(46080L+c*8+1, 8);
	for(i=2;i<8;i++)
	{
		POKE(46080L+c*8+i, PEEK(46080L+k*8+i));
	}
//    pour 1/2 (obsol�te ?)
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

