# AWELE-KALAHA

**Un peu d'histoire perso...**

Il y a (très, très...) longtemps, j'ai écrit un programme d'awele-kalaha pour un TP à la Fac.
Puis j'ai fait une version pour mon amiga aux vacances suivantes donc août 1989 !

Fin 2020, j'ai retrouvé les sources en transférant mes anciennes disquettes en ADF pour utilisation via gotek et émulateur






Lien vers le GitHub :  

 https://github.com/k-y-e-x/awele
 

## Caractéristiques

__Le simple fichier awele.c qui ne faisait qu'un affichage sur la sortie standard s'est un peu complexifié :__
- Réécriture pour oric et compilation avec cc65
- Réécriture pour Gameboy et compilation avec gbdk
- Fusion en un seul répertoire avec Makefile unique
- modification de tap2dsk pour créer des D7 au format EDSK : obligatoire pour le core Oric sur Mister
- Ajout de la compilation vers C64
- Mise en commun de la partie conio pour Oric et C64
- Ajout d'un menu sur Oric et C64 + possibilité d'appel du menu en cours de partie
- Ajout des règles du jeu
- Boucle sur nouvelle partie (nécessaire sur gameboy)
- Ajouter un menu d'option pour gérer des variantes des règles (et mise à jour automatique des règles)
- Ajout Apple// et // enhanced (toujours avec conio)
- Ajout d'un écran titre (suggestion de @didier_v de https://ceo.oric.org)


## Reste À Faire

- Nettoyage du code !!!!!
- Optimisation et clarification de la gestion des menus
- Musique 


## Documentation

[Lien vers la documentation]( https://k-y-e-x.github.io/awele/doc/html/index.html)

__Version Oric, C64 et Apple//__

Le menu est affiché en haut de l'écran.
Il permet de configurer les caractéristiques de jeu.
L'ouverture d'un menu se faire par la touche ENTER/RETURN ou le bouton FEU du joystick ou la touche/le joystick BAS
Ensuite, on se déplace verticalement dans les points de menu et horizontalement pour choisir chaque option (avec les flèches ou le joystick)
Pour revenir au menu principal, c'est la touche ENTER ou le bouton FIRE du joystick ou via la touche/le joystick HAUT
Le menu Jeu permet de commencer, abandonner, retourner à la partie ou quitter le jeu.

Pendant le déroulement du jeu, l'appel au menu en quand on a la main (attente d'une touche/joystick) s'effectue par la touche ESC sur Oric et RUN/STOP sur C64
Le choix de la case à jouer se fait via les touches fleches gauche/droite ou le joystick.
La case sélectionnée passe en inverse video.
La validation est par le touche ENTER/RETURN ou le bouton FEU.
De même la case jouée par l'ordinateur passe en inverse video et son numéro est indiqué.

## License

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://github.com/k-y-e-x/awele/blob/main/LICENSE)

## Releases

[![Github](https://img.shields.io/github/downloads/k-y-e-x/awele/total)](https://github.com/k-y-e-x/awele/releases)

