#include <string.h>
#include <gb/gB.h>
#include <gb/drawing.h>
#include "../mes_types.h"
#include "../globals.h"


void gbglobals()
{
	strcpy(gOption2Ordinateurs,"2 Gameboy    ");
	strcpy(gOptionQuiCommence,"Qui commence ? ");
	strcpy(gJ1commence,"Joueur 1 commence");
	strcpy(gJ2ordi,"Je suis le joueur2");
	strcpy(gOptionProfondeur," niveau ? ");
	strcpy(gPositionsEvaluees,"_valu_es");  //"positions _valu_es :      ");

	strcpy(gQuelleCase,"quelle case ? ");
	strcpy(gVainqueur," vainqueur");
	strcpy(gEgalite,"Egalit_");

	// remplacement caractères accentués pour GB
	gEgalite[6]=(char)130;
	gPositionsEvaluees[0]=gPositionsEvaluees[5]=(char)130;
	gOptionProfondeur[11]=(char)130;
}