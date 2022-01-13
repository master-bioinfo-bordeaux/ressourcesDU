# A. Configuration

Pour cette série d'exercices sur le shell Unix, nous utiliserons un émulateur ce qui évite toute installation.

1. N'utilisez que Firefox ou Google Chrome pour aller sur le web.
2. Ouvrir une nouvelle fenêtre du navigateur et essayer de voir les deux fenêtres simultanément sur votre écran.
3. Sur la 2ème fenêtre, allez sur le site https://copy.sh/v86 ou cliquez [ici].
4. Sélectionnez la distribution Linux Arch Linux (la 1ère). Attendez la fin du chargement.
5. Une fois que la page d'accueil apparaît. Vous devriez voir l'écran de la Fig. 1 ci-dessous.
6. Il y a une deuxième fenêtre juste en dessous avec le message This is the serial console. Cliquez dedans et validez avec la touche Entrée (Fig. 2).
7. Le prompt apparaît. Vous êtes prêt!
8. Et voilà! Vous pouvez passer à la prochaine page.

>**Note**: Chaque fois que vous cliquez dans la première fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche Esc.



**Fig.1**: Capture d'écran du shell Arch Linux avec le panneau d'information à gauche.


**Fig.2**: Capture d'écran de la 2ème fenêtre qui sera utilisée dans la suite du cours.

## Références

- https://bioinformaticsworkbook.org/Appendix/Unix/unix-basics-1.html#gsc.tab=0
- https://data-skills.github.io/unix-and-bash/
- https://datacarpentry.org/shell-genomics/01-introduction/index.html


> **Expert Only**: Si jamais, le clavier est en configuration QWERTY, tapez loadkeys fr (Attention avec un clavier Français, il faut tapez loqdkeys fr) puis validez avec la touche <kbd>Entrée</kbd>

# B. Ligne de commande

>**Note**: Chaque fois que vous cliquez dans la 1ère fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche Esc.

## 1. Le prompt


**Fig.1**: Capture d'écran du shell Unix

➔ Le prompt qui contient plusieurs informations:

- (i) le nom (en vert) du compte et de l'ordinateur sur lequel vous travaillez. Ici, votre compte se nomme root suivi du nom de la machine (ici localhost) suivi de votre position dans l'arborescence des fichiers (ici, ~/data ce qui signifie dans le sous-répertoire data/ du dossier personnel (~ symbolise le dossier personnel appelé généralement Home).
- (ii) Un séparateur (ici un dièse mais en général, c'est un dollar).
- (iii) le curseur (ici, un tiret ou un carré blanc clignotant selon les versions de shell).

## 2. La ligne de commande

➔ Quand vous tapez une commande, il faut la valider avec la touche Entrée pour lancer l'exécution de cette commande.

➔ Par exemple, tapez pwd . Validez avec Entrée. Sur la ligne suivante s'affiche le résultat: /root.

> **Note**: Cette commande sert à voir votre localisation dans l'arborescence de fichiers (par défaut sur cet émulateur, c'est /root). On appelle ce répertoire (directory) votre HOME (dossier personnel).

```bash
root@localhost:~# pwd Entrée
/root
root@localhost:~#
```

➔ Une commande Unix/Linux est composée de trois parties:

Le nom de la commande. Toutes les commandes Unix sont en minuscules et sont des mots assez courts.
Les arguments qui commencent par un ou deux tirets vont permettre de moduler le comportement de la commande
Les paramètres d'entrée qui sont la plupart du temps un ou plusieurs noms de fichiers. Ce sont eux que l'on va modifier par la commande.
Les commandes, arguments et nom.s de fichier doivent être séparés par des espaces (le nombre d'espaces n'a par contre aucune importance).
command [-argument] [--long-argument] file

> **Note**: Avoir de l'aide sur une commande se fait en tapant l'argument `--help`.

```bash
# Ceci est un commentaire
# Il ne doit pas être saisi
$ pwd --help
pwd: pwd [-LP]
    Affiche le nom du répertoire de travail courant.  
    Options :
      -L	affiche la valeur de $PWD s'il nomme le répertoire de travail courant
      -P	affiche le répertoire physique, sans aucun lien symbolique
    
    Par défaut, « pwd » se comporte comme si « -L » était spécifié.
    Code de retour :
    Renvoie 0 à moins qu'une option non valable ne soit donnée ou que le
    répertoire courant ne peut pas être lu.
```
```bash
#Plusieurs espaces ne changent rien
$ pwd     --help
# WRONG: Manque un espace
$ pwd--help
-bash: pwd--help command not found
```

## 3. Modification/Historique des commandes

➔ Pour vous déplacer dans une ligne de commande afin de corriger une lettre, un mot ou rajouter des arguments, vous devez vous déplacer avec les flèches gauche et/ou droite.
➔ Par contre, si votre curseur est au milieu d'une ligne de commande, vous pouvez très bien la valider avec la touche Entrée sans être obligé de retourner à la fin de la ligne avec la flèche droite.
➔ Toute commande Unix validée peut être rappelée avec les touches haut et bas.

### 3.1. Exemple de modification d'une ligne de commande

Vous avez tapé et validé la ligne suivante qui affiche dans la console le message `Hello bordeaux!`.
```bash
$ echo "Hello bordeaux!"
```

Vous souhaitez mettre le <kbd>b</kbd> de bordeaux en majuscule. Pour cela,

1. Rappelez la ligne précédente avec la flèche vers le haut ↑
1. Utilisez la flèche gauche ←pour vous déplacer à droite du b
1. Supprimer la lettre b avec la touche Del ⌫
1. Ajoutez la lettre B majuscule comme ci-dessous.
1. Votre curseur (le tiret) est donc au niveau de la lettre B. Si vous validez la ligne en appuyant sur Entrée, toute la ligne de commande est bien exécutée. Vous n'avez pas besoin de vous déplacer en fin de ligne de commande.
1. Vous affichez le message corrigé Hello Bordeaux! avec un B majuscule.
1. Félicitations!!

```bash
$ echo "Hello Bordeaux!"
```

Si vous voulez voir toutes les commandes saisies lors d'une session, tapez la commande history

```sh
2002  ls
2003  pwd
2004  sudo apt install exfat-fuse exfat-utils 
2005  df
2006  history
2007  ls
2008  pwd
2009  ls -al
```

## 4. Complétion des mots

➔ Il existe une fonctionnalité bien pratique pour éviter de taper toutes les lettres d'une commande ou d'un nom de fichier en utilisant la touche Tab.
Par exemple, pour la commande echo qui affiche du texte, on peut taper uniquement les deux premières lettres e + c + Tab et la commande est complétée.
➔ Si vous avez plusieurs mots possibles, rien n'est ajouté. Par contre, vous pouvez faire un double Tab (Tab + Tab) pour voir toutes les possibilités.
Par exemple, pour la commande `loadkeys` précédemment utilisée,
- Si vous tapez l + o + a + Tab, il y a complétion en load mais pas en loadkeys ce qui signifie qu'il y a plusieurs commandes commençant par load.
- Si vous faites un double Tab (Tab + Tab), alors la liste des commandes s'affiche. Il y en a deux:

```loadkeys loadunimap```

- Vous devez alors taper la lettre k + Tab pour voir afficher loadkeys

Récapitulatif
loa + Tab => load + k + Tab => loadkeys

> **Note**: C'est surtout intéressant lorsque vous ne vous souvenez plus de l'orthographe exacte d'une commande. En tapant les 1ères lettres vous pouvez lister les différentes commandes commençant par ces mêmes lettres.

# C. Exercice `seq`

Il existe une commande seq qui génère automatiquement une série de nombres entiers

> **Note**: Pour avoir la documentation de cette commande, pensez à utiliser l'argument --help
>```$ seq --help```

## **Question 1**: Générer une série de nombres de 1 à 10.
```bash
1
2
3
4
5
6
7
8
9
10
```

## Question 2: Générer une série de nombres de 10 à 20

```bash
10
11
12
13
14
15
16
17
18
19
20
```

## Question 3: Générer les nombres pairs de 0 à 10 inclus
```bash
0
2
4
6
8
10
```

## Question 4: Générer les nombres impairs de 0 à 10 inclus en une seule ligne séparée par des virgules

```bash
1,3,5,7,9
```

## Question 4: Générer les nombres multiples de 13 de 0 à 100 avec un nombre de chiffres constant ( un ou plusieurs zéros devant)
```bash
000
013
026
039
052
065
078
091
```

# D. Manipulation de Fichiers  

## 1. Navigation au sein du système de fichiers: ls, pwd, cd

### 1.1. Lister le contenu du répertoire courant (LiSt what is in your current directory)- `ls`

```bash
ls
# Avec différents arguments. Observez les différences.
ls -a
ls -l
ls -lh
```

> **Note**: Aide en ligne: Généralement, on a une aide sur les commandes de deux manières possibles:
```bash
  # Option 1
  ls --help
  # Option 2
  man ls
```

Dans l'émulateur, les pages manual affichables via la commande man n'ont pas été installées. Seule la 1ère méthode est donc disponible
On peut filtrer les fichiers qu'on souhaite lister en utilisant les caractères joker '*' et/ou '?'.
Le caractère étoile remplace un ou plusieurs caractères.
Le caractère '?' remplace un seul caractère.
Par exemple:
```bash
cd
# On affiche uniquement les fichiers qui ont l'extension .sh
ls *.sh
# On affiche les fichiers qui commence par hello
ls hello*
# On souhaite afficher tous les fichiers dont la 2ème lettre est un 'e'
ls ?e*
```

### 1.2. Affichez le répertoire courant (Print Working Directory) - pwd

```bash
pwd
```

### 1.3. Se déplacer dans le système de fichiers (Change working Directory) - cd
```bash
# cd into one of the directories you see when you type
ls -F
cd nbench
# Se déplacer un niveau au dessus | to go up a level (Back usually)
cd ..
# Revenir à son dossier personnel | To navigate to your home directory
# Option 1 avec le signe ~ (tilde)
cd ~
# Option 2 (la plus pratique), juste `cd`
cd
```

Les raccourcis à connaître pour se déplacer.
```
.  Current directory (one full stop)  
.. Directory above (two full stops)  
~  Home directory (tilde)  
/  Root of the file system (like C:\ in Windows)
```

### 1.4. Exercice

- **Question 1**: Dans le répertoire nbench/ combien y a t-il de fichiers?
- **Question 2**: Dans le répertoire nbench/ combien y a t-il de fichiers qui commence par la lettre 'n' et qui ont une extension 'h'?

# E. Exercice: Où suis-je?     

A partir du diagramme ci-dessous, si la commande pwd affiche /Users/thing, qu'affiche la commande ls ../backup [ choix 1,2,3,4]?

```
../backup: No such file or directory
2021-12-01 2022-01-08 2022-01-27
2021-12-01/ 2022-01-08/ 2022-01-27/
original pnas_final pnas_sub
```


> **Source**: https://datacarpentry.org/shell-genomics/02-the-filesystem/index.html


# F.Manipulation de fichiers (suite)

## 2. Files - Create, edit, delete files and directories: mkdir, nano, touch, cp, mv, rm, rmdir, cat, head, less
Pour s'amuser un peu, on va créer un répertoire nommé test.

Se placer dans son HOME en tapant la commande cd

### 2.1. Créer un répertoire (make directory) - mkdir

```bash
mkdir test
cd test
ls -l
```

Il n'y a rien dedans. Pour créer un nouveau fichier vide, vous pouvez utiliser:

### 2.2. touch
      
```bash
# Je m'assure que je suis dans mon HOME
cd
# Je me déplace dans le sous-répertoire test que je viens de créer
cd test
# Je crée un fichier nommé seq.fasta
touch seq.fasta
```

### 2.3. Copie d'un fichier (CoPy) -cp

Si on veut faire une copie de notre fichier seq.fasta...
```bash
# Copy with cp
cp seq.fasta backup.fasta```
```

> **Note**: Pensez à la complétion pour aller plus vite lors de la saisie. Par exemple, cp s e Tab pour afficher seq.fasta etc.

### 2.4. Visualiser le contenu d'un fichier - cat, less

On peut voir le contenu d'un fichier en utilisant:

la commande less (pratique pour des grands fichiers car affiche page par page) ou
la commande cat pour des petits fichiers.
cd
cat hello.c
less hello.c

### 2.5. wc

Permet de récupérer quelques statistiques simples comme le nombre de lignes:
```bash
wc -l hello.c
```

### 2.7. Déplacer, détruire un fichier ou un répertoire - mv, rm, rmdir
Pour déplacer et/ou renommer un fichier, on utilise la commande mv (MoVe)
Pour détruire un fichier, on utilise la commande rm (ReMove)
Pour détruire un répertoire, on utilise la commande rmdir

```bash
cd
mkdir backdir
mv backup.fasta backdir
```

A ce stade, quelle est l'arborescence de vos fichiers?
> **Note**: Vous pouvez utiliser la commande ls avec l'argument -R (pour récurrence) pour visualiser toute l'arborescence de votre répertoire personnel.

Maintenant, faire le ménage...

> **Conseil**: Faire les commandes les unes après les autres et vérifiez avec la commande ls pour savoir ce que vous avez fait.
> 
```bash
rm seq.fasta
rm backup.fasta
rm backdir/backup.fasta
rmdir backdir
```

# G. Editeur de Texte: nano  

Plutôt que `touch`, on peut utiliser un éditeur de texte pour créer un fichier et écrire/modifier son contenu.
```bash
cd
nano text.txt
```
Une fenêtre s'ouvre. Vous pouvez tapez votre texte. Dans la partie inférieure, vous avez la barre de menu.



**Fig. 1**: Capture d'écran de la zone de texte de nano + sa barre de menu. Source: https://www.tecmint.com/learn-nano-text-editor-in-linux/

Comme nous sommes en ligne de commande, la souris est inopérante. On se déplace avec les flèches du clavier, la touche Home, Fin,

Pour toutes les commandes de sauvegarde du texte fichier, vous avez une ligne d'aide en bas de la fenêtre. Le signe ^ signifie Ctrl et le signe M signifie Alt.

Par exemple, pour sauvegarder votre fichier, vous devez faire Ctrl + S.

## 2. Les raccourcis clavier

Toutes les commandes sont ici [Link]

Quelques commandes très utiles disponibles sur le site de nano.

```
File handling
Ctrl+S  Save current file
Ctrl+O	Offer to write file ("Save as")
Ctrl+X	Close buffer, exit from nano

Editing
Ctrl+K  Cut current line into cutbuffer
Alt+6	Copy current line into cutbuffer
Ctrl+U	Paste contents of cutbuffer

Search and replace
Ctrl+Q  Start backward search
Ctrl+W	Start forward search
Alt+Q	Find next occurrence backward
Alt+W	Find next occurrence forward
Alt+R	Start a replacing session

Deletion
Ctrl+H	Delete character before cursor      
Ctrl+D	Delete character under cursor
Alt+Bsp	Delete word to the left
Ctrl+Del Delete word to the right
Alt+Del	Delete current line

Moving around
Ctrl+B  One character backward
Ctrl+F	One character forward
Ctrl+←	One word backward
Ctrl+→	One word forward
Ctrl+A	To start of line
Ctrl+E	To end of line
Ctrl+P	One line up
Ctrl+N	One line down
Ctrl+↑	To previous block
Ctrl+↓	To next block
Ctrl+Y	One page up
Ctrl+V	One page down
Alt+\	To top of buffer
Alt+/	To end of buffer

Special movement
Alt+G   Go to specified line
Alt+↑	Scroll viewport up
Alt+↓	Scroll viewport down

Information
Ctrl+G	Display help text
```


# H. Exercice avec l'éditeur nano     
On se propose de créer un fichier FASTA contenant une séquence

Se placer dans son HOME en tapant la commande cd

## 1. Exécuter nano
```bash
nano test.fasta
```

Une zone de texte s'affiche avec la barre de menu dans la partie inférieure contenant les principaux raccourcis

## 2. Obtenir de l'aide

Pour avoir accès à tous les raccourcis, tapez Ctrl+G (Get help).

Pour quitter l'aide en ligne, faire Ctrl+X (c'est indiqué dans la barre de menu inférieure sous la forme ^X: Close).


Fig. 1: Capture d'écran de l'aide ne ligne. Source: https://www.linuxjournal.com/content/linux-command-line-interface-introduction-guide.

## 3.Saisie de texte

Il suffit de taper le texte, aucune commande n'est nécessaire. Pour corriger, modifier du texte, il faut déplacer le curseur à l'aide des flèches (pas de souris possible).
```
> Test d'une séquence au format FASTA
ACGT
```

## 4. Sélection, copier, coller de texte

Déplacez-vous avec les flèches au début de la ligne (avant la lettre A).
La 1ère chose est de définir une marque de début de sélection (Ctrl + 6)
Pour définir la zone de sélection, déplacez-vous avec les flèches (gauche,droite, haut, bas) pour surligner les 4 lettres ACGT
Ensuite, faire un couper (Ctrl+K) et faire des copier (Ctrl+U).

```
> Test d'une séquence au format FASTA
ACGT
```
Après duplication...
```
> Test d'une séquence au format FASTA
ACGTACGTACGTACGTACGTACGT
```

## Exercice: Faire la même chose pour cette ligne et dupliquez les lignes plusieurs fois.

```
> Test d'une séquence au format FASTA
ACGTACGTACGTACGTACGTACGT
ACGTACGTACGTACGTACGTACGT
ACGTACGTACGTACGTACGTACGT
ACGTACGTACGTACGTACGTACGT
ACGTACGTACGTACGTACGTACGT
ACGTACGTACGTACGTACGTACGT
```

> **Note**: Pensez à sélectionner aussi la fin de la ligne.
 
## 5. Sauvegarder le contenu d'un fichier

Plusieurs options

<kbd>Ctrl</kbd>+<kbd>S</kbd> pour sauvegarder le fichier existant
<kbd>Ctrl</kbd>+<kbd>O</kbd> pour sauvegarder sous un nouveau nom

> **Note**: ATTENTION!! Il n'y a aucune sauvegarde automatique de votre texte, pensez à le faire régulièrement (Ctrl+S)

## 6. Quittez nano
<kbd>Ctrl</kbd>+<kbd>X</kbd> permet de sortir de nano.

**Attention!!** Si vous n'avez pas sauvegardé votre texte au préalable, une confirmation (Y, N ou Ctrl+C) est demandée:

```
Save modified buffer?                                                                 
 Y Yes
 N No         ^C Cancel
```

## 7. Vérifiez le contenu de votre fichier

Vous pouvez faire un less pour voir le contenu du fichier.
```bash
less test.fasta
```


