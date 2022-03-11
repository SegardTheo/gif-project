# gif

Projet Dev mobile : Liste gifs

## Doc

### Liens
- [Schéma UseCase](https://drive.google.com/file/d/1CYod4Dvz7qaI1TaO_0MMA5KnimZ-Uuu7/view?usp=sharing)

### Technologies et librairies
- Android 12
- Flutter
- http: ^0.13.4
- share_plus: ^3.0.4 
- path_provider: ^2.0.9
- focused_menu: ^1.0.5
- simple_animations: ^4.0.1
- photofilters: ^3.0.1
  
### Fonctionnalités
- Main : animation particules, bouton (navigation vers HomePage)
- HomePage : Liste des gifs avec l'api tenor - limite à 75, recherche par mot-clé, bouton "vider" (réinitialise la recherche api), voir la page détail via un clique sur le gif, menu quand long press sur un gif, menu : Detail, partage et modifer gif
- Partage : fonctionnalité de partage via réseaux sociaux
- Détail : Vue en plein écran du gif sélectionné. Possibilité de partager en cliquant sur le gif
- Modifier gif : librairie pour changer de filtre sur le gif. Capture une image du gif