# awele kalaha

AWELE-KAHALA

Il y a (tr�s, tr�s...) longtemps, j'ai �crit un programme d'awele-kalaha pour un TP � la Fac
Puis j'ai fait une version pour mon amiga 
Fin 2020, j'ai retrouv� les sources en transf�rant mes anciennes disquettes en ADF pour utilisation via gotek et �mulateur

Le simple fichier awele.c qui ne faisait qu'un affichage sur la sortie standard s'est un peu complexifi� :
R��criture pour oric et compilation avec cc65
R��criture pour Gameboy et compilation avec gbdk
Fusion en un seul r�pertoire avec Makefile unique
Ajout de la compilation vers C64
Mise en commun de la partie conio Oric et C64
Ajout d'un menu sur Oric et C64 + possibilit� d'appel du menu en cours de partie
Ajout des r�gles du jeu
Boucle sur nouvelle partie (n�cessaire sur gameboy)

Reste � Faire :
Rendre variables certaines constantes qui sont sous forme de define
Ajouter un menu d'option pour g�rer des variantes des r�gles (avec les nouvelles variables)
Nettoyage du code !!!!! (apr�s pas mal d'ajout, une coh�rence est � faire)
Ajouter les r�gles dans la documentation sur Github Pages

Lien vers la documentation (Sur Github Pages et cr��e par doxygen) :
 https://k-y-e-x.github.io/awele/doc/html/index.html
Lien vers le GitHub :
 https://github.com/k-y-e-x/awele
