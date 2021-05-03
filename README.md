# AWELE-KAHALA

**Un peu d'histoire perso...**

Il y a (tr�s, tr�s...) longtemps, j'ai �crit un programme d'awele-kalaha pour un TP � la Fac.
Puis j'ai fait une version pour mon amiga aux vacances suivantes donc ao�t 1989 !

Fin 2020, j'ai retrouv� les sources en transf�rant mes anciennes disquettes en ADF pour utilisation via gotek et �mulateur


__Le simple fichier awele.c qui ne faisait qu'un affichage sur la sortie standard s'est un peu complexifi� :__
- R��criture pour oric et compilation avec cc65
- R��criture pour Gameboy et compilation avec gbdk
- Fusion en un seul r�pertoire avec Makefile unique
- modification de tap2dsk pour cr�er des D7 au format EDSK : obligatoire pour le core Oric sur Mister
- Ajout de la compilation vers C64
- Mise en commun de la partie conio pour Oric et C64
- Ajout d'un menu sur Oric et C64 + possibilit� d'appel du menu en cours de partie
- Ajout des r�gles du jeu
- Boucle sur nouvelle partie (n�cessaire sur gameboy)



__Reste � Faire :__
- Rendre variables certaines constantes qui sont sous forme de define
- Ajouter un menu d'option pour g�rer des variantes des r�gles (avec les nouvelles variables)
- Nettoyage du code !!!!! (apr�s pas mal d'ajout, une coh�rence est � faire)- 
- Ajouter les r�gles dans la documentation sur Github Pages


__Version Oric et C64__
Le menu est affich� en bas de l'�cran.
Il permet de configurer les options de jeu.
L'ouverture d'un menu se faire par la touche ENTER ou le bouton FEU du joystick
Ensuite, on se d�place verticalement dans les points de menu et horizontalement pour choisir chaque option (avec les fl�ches ou le joystick)
Pour revenir au menu principal, c'est la touche ENTER ou le bouton FIRE du joystick
Pour quitter le menu s�lectionner OK

Pendant le d�roulement du jeu, l'appel au menu en quand on a la main (attente d'une touche/joystick) s'effecture par la touche ESC sur Oric et RUN/STOP sur C64
Le choix de la case � jouer se fait via les touches fleches gauche/droite ou le joystick.
La case s�lectionn�e passe en inverse video.
La validation est par le touche ENTER ou le bouton FEU.
De m�me la case jou�e par l'ordinateur passe en inverse video et son num�ro est indiqu�.


Lien vers la documentation (sur Github Pages et cr��e avec doxygen) :  

 https://k-y-e-x.github.io/awele/doc/html/index.html
 
Lien vers le GitHub :  

 https://github.com/k-y-e-x/awele
