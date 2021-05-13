# AWELE-KALAHA

**Un peu d'histoire perso...**

Il y a (très, très...) longtemps, j'ai écrit un programme d'awele-kalaha pour un TP à la Fac.
Puis j'ai fait une version pour mon amiga aux vacances suivantes donc août 1989 !

Fin 2020, j'ai retrouvé les sources en transférant mes anciennes disquettes en ADF pour utilisation via gotek et émulateur


__Le simple fichier awele.c qui ne faisait qu'un affichage sur la sortie standard s'est un peu complexifié :__
- Réécriture pour oric et compilation avec cc65
- Réécriture pour Gameboy et compilation avec gbdk
- Fusion en un seul répertoire avec Makefile unique
- modification de tap2dsk pour créer des D7 au format EDSK : obligatoire pour le core Oric sur Mister
- Ajout de la compilation vers C64
- Mise en commun de la partie conio Oric et C64
- Ajout d'un menu sur Oric et C64 + possibilité d'appel du menu en cours de partie
- Ajout des règles du jeu
- Boucle sur nouvelle partie (nécessaire sur gameboy)


__Reste À Faire :__
- Rendre variables certaines constantes qui sont sous forme de define
- Ajouter un menu d'option pour gérer des variantes des règles (avec les nouvelles variables)
- Nettoyage du code !!!!! (après pas mal d'ajout, une cohérence est à faire)- 
- Ajouter les règles dans la documentation sur Github Pages


Lien vers la documentation (sur Github Pages et créée avec doxygen) :  

 https://k-y-e-x.github.io/awele/doc/html/index.html
 
Lien vers le GitHub :  

 https://github.com/k-y-e-x/awele
