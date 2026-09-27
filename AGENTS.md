# Repères pour travailler sur Awele-Kalaha

Ce dépôt contient un jeu d'awélé/kalaha en C pour Oric Atmos, Commodore 64, Apple II, Apple II enhanced et Game Boy. Le moteur et la boucle de jeu sont communs ; les interfaces sont propres aux machines. Le projet est construit sur Mac Intel avec cc65 pour les quatre premières cibles et GBDK pour la Game Boy. Lire le `README.md` pour l'histoire et les commandes du jeu.

## Organisation du code

- `src/awele.c` : initialisation et boucle des parties, humain et ordinateur.
- `src/aweleia.c` : règles, coups, évaluation et recherche alpha-bêta/minimax.
- `src/globals.c`, `src/globals.h` : textes, options et état global partagé. Les textes pourront devenir multilingues ; préserver leurs types et leur capacité de modification quand elle est nécessaire.
- `src/awele.h`, `src/mes_types.h`, `src/macros.h` : déclarations, limites et types communs. `mes_types.h` contient une adaptation nécessaire aux deux versions de GBDK.
- `src/conio/awele_conio.c` : interface texte partagée par Oric, C64 et Apple II ; elle est incluse directement par les fichiers propres à ces machines. Ne pas la compiler comme un module autonome sans revoir cette structure.
- `src/atmos/`, `src/c64/`, `src/apple2/`, `src/apple2enh/` : adaptations matérielles cc65 ; `src/gb/` : interface et ressources Game Boy.

Il n'y a **pas encore de cible Amiga dans ce dépôt**. La version historique était un programme monolithique en CLI sur Amiga 500. Une future version Amiga doit reprendre l'architecture actuelle et ajouter une interface graphique ainsi que les commandes clavier/joystick ; ne pas présenter le portage comme déjà réalisé.

## Compilation et sorties

- `make` (cible `build`) construit les exécutables Oric Atmos, C64, Apple II, Apple II enhanced et `build/awele.gb` avec GBDK 4.5.
- `make atmos` construit l'exécutable Oric, `build/aweloric.tap`, `build/awele-oric.dsk` et `build/awele-oric_edsk.dsk`. `make c64` construit l'exécutable C64, `build/awele-c64.prg` et `build/awele.d64`. `make apple2` ou `make apple2enh` construit l'exécutable et la disquette DSK de la version choisie. `make gb` construit seulement `build/awele.gb` avec GBDK 4.5. `make gbdk-4.0` et `make gbdk-4.5` construisent chacun une ROM nommée.
- `make all` conserve `build/awele.gb`, ajoute les deux ROM nommées (`build/awele-gbdk-4.0.gb` et `build/awele-gbdk-4.5.gb`) et les supports : `build/awele-c64.prg`, `build/awele.d64`, `build/aweloric.tap`, `build/awele-oric.dsk`, `build/awele-oric_edsk.dsk`, `build/awelea2.dsk` et `build/awelea2e.dsk`. Les trois formats de disquette utilisent tous l'extension `.dsk` ; leurs noms complets les distinguent.
- `make TARGETS=atmos`, `c64`, `apple2`, `apple2enh` ou `gb` construit une cible. La cible `gb` utilise GBDK 4.5 par défaut et des objets distincts de ceux des deux ROM nommées. Pour choisir manuellement un autre GBDK, renseigner aussi `GBDK_HOME` et `OBJDIR` afin de ne pas réutiliser les mêmes objets. Les cibles nommées fixent `/opt/gbdk` pour 4.0 et `/opt/gbdk-4.5` pour 4.5 ; le `PATH` global ne choisit pas entre elles.
- `make clean` nettoie toutes les cibles ; `make TARGETS=atmos clean` (ou une autre cible unique) ne nettoie que ses objets, son exécutable et ses supports.
- `make doc` et `make docs` lancent Doxygen avec `awele.dox` et écrivent dans `doc/`.

Le Makefile inclut les `Makefile-*.mk` pour créer les supports physiques. Les outils supplémentaires comprennent `cc1541`, `tap2dsk`, `tap2edsk`, `old2mfm`, Java et `apple2/ac.jar`. Le lancement des émulateurs est manuel : sur Mac, le mainteneur utilise Clock Signal (Apple II et Oric), Denis ou VICE (C64), et SameBoy ou KGB (Game Boy). Ne pas assimiler une compilation réussie à un test de partie.

## Compatibilité et vérification

Les deux versions GBDK 4.0 et 4.5 cohabitent et ont été testées par le mainteneur sur une partie complète après correction de `mes_types.h`. Une ancienne régression en 4.5 ramenait au choix du nombre de joueurs après pression sur B pendant l'annonce du coup de l'ordinateur ; en cas de modification de l'interface ou des types Game Boy, revérifier ce scénario, les modes un et deux joueurs et une partie complète. Les avertissements GBDK 4.0 de type 158 et GBDK 4.5 de type 110 ont déjà été observés ; examiner tout avertissement nouveau au lieu de supposer qu'il est bénin.

Il n'y a pas de suite de tests automatisés identifiée. Après un changement partagé, construire les six exécutables ; après un changement aux supports, exécuter `make all` ; après un changement de documentation, exécuter `make docs` et vérifier les accents dans `doc/html/index.html`. Tester sur émulateur les comportements touchés quand c'est possible.

## Encodage et documentation

Les fichiers source mélangent UTF-8 et ISO-8859-1. `README.md` est en UTF-8, tandis que plusieurs anciens `.c` et `src/awele.h` sont en ISO-8859-1. Ne pas convertir globalement les sources ni réenregistrer par mégarde un fichier historique en UTF-8 : les chaînes affichées sur les machines peuvent changer. `awele.dox` définit UTF-8 par défaut et liste dans `INPUT_FILE_ENCODING` les fichiers historiques en ISO-8859-1. Si l'on ajoute ou convertit un fichier, maintenir cette liste. Une mauvaise valeur globale ISO-8859-1 transforme « très » en « trÃ¨s » dans la documentation.

`awele.dox` est suivi par Git et exclut `AGENTS.md` et `CLAUDE.md` de la documentation. `doc/` et `obj/` sont des sorties générées ; plusieurs fichiers de `build/` sont suivis par Git et peuvent apparaître modifiés ou supprimés après compilation ou nettoyage. Préserver les modifications déjà présentes dans l'arbre de travail.
