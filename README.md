# AWELE-KALAHA

**Un peu d'histoire perso...**

Il y a (très, très...) longtemps, j'ai écrit un programme d'awele-kalaha pour un TP à la Fac. Puis j'ai fait une version pour mon Amiga aux vacances suivantes, en août 1989 !

Fin 2020, j'ai retrouvé les sources en transférant mes anciennes disquettes en ADF pour les utiliser avec un Gotek et un émulateur.

## Évolution du projet

Parti d'un seul fichier `awele.c` qui affichait le jeu sur la sortie standard, le projet a évolué par étapes :

_2021_
- Réécriture pour l'Oric avec cc65, puis portage sur Game Boy avec GBDK.
- Réunion des versions dans un même répertoire avec un Makefile unique.
- Modification de `tap2dsk` pour produire des disquettes au format EDSK, nécessaire au cœur Oric de MiSTer ; la compilation actuelle utilise `tap2edsk`.
- Ajout de la version C64, puis mise en commun de l'interface `conio` entre Oric et C64.
- Ajout d'un menu sur Oric et C64, également accessible pendant une partie, et des règles du jeu.
- Ajout d'une boucle pour lancer une nouvelle partie, notamment nécessaire sur Game Boy.
- Ajout d'options pour les variantes des règles, avec mise à jour des règles affichées selon les choix.
- Ajout des versions Apple II et Apple II enhanced, qui utilisent aussi l'interface `conio`.
- Ajout d'un écran titre sur une suggestion de `@didier_v` du [CEO Oric](https://ceo.oric.org).

_2026_
- Reprise du projet pour optimisation
- Utilisation de l'IA (Codex) pour optimisation du code : 2x plus rapide à la fin des optimisations
- Correction de bugs résiduels et des risques d'écriture mémoire hors limite
- Passage à GBDK 4.5
- Compléments, nettoyage et corrections du Makefile

## Le projet aujourd'hui

Le programme initial, monolithique et limité à la sortie standard, est devenu un jeu modulaire pour **Oric Atmos, Commodore 64, Apple II, Apple II enhanced et Game Boy**. La logique du jeu et de l'ordinateur est commune aux différentes versions ; chaque machine possède son interface.

Le jeu propose des parties à deux joueurs humains, à un joueur contre l'ordinateur ou entre deux ordinateurs. Les menus permettent de choisir le joueur qui commence et le niveau de l'ordinateur. Sur Oric, C64 et Apple II, ils proposent aussi plusieurs variantes des règles : nombre de cases, nombre de graines, passage par le kalah adverse et attribution des graines restantes. Les règles affichées dans le jeu suivent les options choisies. Sur ces machines, il est possible de consulter le menu pendant une partie. On peut lancer une nouvelle partie sans redémarrer le programme.

La recherche des coups de l'ordinateur a été optimisée : calculs communs préparés à l'initialisation, classement des coups et distribution des graines simplifiée. **Selon les essais du mainteneur, son temps de réflexion a été réduit d'environ moitié** par rapport à la version précédente. Des bugs résiduels ont aussi été corrigés, notamment dans la compatibilité Game Boy avec GBDK 4.0 et 4.5 et dans les interfaces.

Les interfaces Oric, C64 et Apple II partagent une base `conio`. La Game Boy dispose de sa propre interface graphique et de commandes adaptées. Les versions Oric, C64 et Apple II affichent un écran titre et acceptent le clavier ou le joystick.

## Compilation

Le `Makefile` utilise **cc65** pour Oric, C64 et Apple II, et **GBDK** pour Game Boy. La ROM par défaut utilise GBDK 4.5 (`/opt/gbdk-4.5`). GBDK 4.0 (`/opt/gbdk`) reste disponible pour une compilation séparée.

| Commande | Résultat |
| --- | --- |
| `make` | Construit les quatre exécutables cc65 et `build/awele.gb` avec GBDK 4.5. |
| `make atmos` | Construit l'exécutable Oric, la cassette `.tap` et les disquettes `.dsk` standard et EDSK. |
| `make c64` | Construit l'exécutable C64, le programme `.prg` et la disquette `.d64`. |
| `make apple2` ou `make apple2enh` | Construit l'exécutable et la disquette `.dsk` de la version Apple II choisie. |
| `make gb` | Construit uniquement `build/awele.gb` avec GBDK 4.5. |
| `make gbdk-4.0` ou `make gbdk-4.5` | Construit uniquement la ROM Game Boy avec la version choisie de GBDK. |
| `make all` | Conserve `build/awele.gb`, construit aussi les deux ROM nommées (`awele-gbdk-4.0.gb` et `awele-gbdk-4.5.gb`) et les supports physiques : `.prg`, `.d64`, `.tap` et disquettes `.dsk` Oric et Apple II. |
| `make clean` | Nettoie les objets et les fichiers produits par les compilations. |
| `make doc` ou `make docs` | Génère la documentation Doxygen dans `doc/`. |

La création des supports requiert aussi `cc1541`, `tap2dsk`, `tap2edsk`, `old2mfm` et Java avec `apple2/ac.jar`. Les disquettes Oric, Apple II et Apple II enhanced ont toutes l'extension `.dsk`, mais des noms distincts. La documentation générée est consultable dans `doc/html/index.html` et dans la [version publiée](https://k-y-e-x.github.io/awele/doc/html/index.html).

Les ROM Game Boy issues des deux versions de GBDK ont été testées par le mainteneur sur des parties complètes. La compilation seule ne remplace pas un essai en émulateur ou sur machine.

## Commandes du jeu

**Oric, C64 et Apple II.** Le menu se trouve en haut de l'écran. Pour ouvrir une rubrique, appuyer sur Entrée/Retour, sur le bouton de feu du joystick, sur la touche fléchée ↓ du clavier ou pousser le joystick vers le bas. Dans les sous-menus, les flèches du clavier ou les directions du joystick servent à se déplacer et à modifier les options. Entrée/Retour, le bouton de feu, la touche fléchée ↑ ou le joystick vers le haut permettent de revenir au menu principal. Le menu **Jeu** sert à commencer, reprendre ou abandonner une partie, à afficher les règles et à quitter le jeu.

Pendant une partie, le menu est accessible lorsque le jeu attend une commande : au moment où un humain choisit sa case, mais aussi après l'annonce du coup d'un ordinateur, avant de poursuivre avec Entrée/Retour ou le bouton de feu. Cela fonctionne donc également avec deux ordinateurs. À ces moments, Échap sur Oric ou Apple II, ou RUN/STOP sur C64, ouvre le menu ; la réflexion de l'ordinateur elle-même ne peut pas être interrompue ainsi.

Pour jouer, les flèches gauche et droite du clavier ou les directions correspondantes du joystick sélectionnent la case ; elle apparaît en vidéo inversée. Entrée/Retour ou le bouton de feu valide le coup. Le coup de l'ordinateur est également mis en évidence et son numéro est affiché.

**Game Boy.** Les menus et les coups se pilotent avec la croix directionnelle et les boutons de la console. Une partie peut être relancée depuis le jeu.

## À venir

La **musique** est le principal chantier restant. 
Retour aux source avec une version amiga. Cette version sera entièrement graphique avec pour cible l'Amiga 500 de base en 1.2 jusqu'à AmigaOS 3.2.

## Licence

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://github.com/k-y-e-x/awele/blob/main/LICENSE)

## Versions publiées

[![Téléchargements GitHub](https://img.shields.io/github/downloads/k-y-e-x/awele/total)](https://github.com/k-y-e-x/awele/releases)
