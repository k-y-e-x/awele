# AWELE-KAHALA

** Un peu d'histoire perso...
Il y a (très, très...) longtemps, j'ai écrit un programme d'awele-kalaha pour un TP à la Fac
Puis j'ai fait une version pour mon amiga 
Fin 2020, j'ai retrouvé les sources en transférant mes anciennes disquettes en ADF pour utilisation via gotek et émulateur


** Le simple fichier awele.c qui ne faisait qu'un affichage sur la sortie standard s'est un peu complexifié :
- Réécriture pour oric et compilation avec cc65
- Réécriture pour Gameboy et compilation avec gbdk
- Fusion en un seul répertoire avec Makefile unique
- Ajout de la compilation vers C64
- Mise en commun de la partie conio Oric et C64
- Ajout d'un menu sur Oric et C64 + possibilité d'appel du menu en cours de partie
- Ajout des règles du jeu
- Boucle sur nouvelle partie (nécessaire sur gameboy)


** Reste À Faire :
- Rendre variables certaines constantes qui sont sous forme de define
-Ajouter un menu d'option pour gérer des variantes des règles (avec les nouvelles variables)
Nettoyage du code !!!!! (après pas mal d'ajout, une cohérence est à faire)- 
- Ajouter les règles dans la documentation sur Github Pages


Lien vers la documentation (Sur Github Pages et créée par doxygen) :  

 https://k-y-e-x.github.io/awele/doc/html/index.html
 
Lien vers le GitHub :  

 https://github.com/k-y-e-x/awele
