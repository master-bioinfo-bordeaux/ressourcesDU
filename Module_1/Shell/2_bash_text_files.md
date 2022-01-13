# A. Configuration

Pour cette série d'exercices sur le shell Unix, nous utiliserons un émulateur ce qui évite toute installation.

1. N'utilisez que Firefox ou Google Chrome pour aller sur le web.
1. Ouvrir une nouvelle fenêtre du navigateur et essayer de voir les deux fenêtres simultanément sur votre écran.
1. Sur la 2ème fenêtre, allez sur le site https://copy.sh/v86 ou cliquez [ici].
1. Sélectionnez la distribution Linux Arch Linux (la 1ère). Attendez la fin du chargement.
1. Une fois que la page d'accueil apparaît. Vous devriez voir l'écran de la Fig. 1 ci-dessous.
1. Il y a une deuxième fenêtre juste en dessous avec le message This is the serial console. Cliquez dedans et validez avec la touche Entrée (Fig. 2).
1. Le prompt apparaît. Vous êtes prêt!
1. Et voilà! Vous pouvez passer à la prochaine page.

> **Note**: Chaque fois que vous cliquez dans la première fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche Esc.



**Fig.1**: Capture d'écran du shell Unix


### Références
- https://bioinformaticsworkbook.org/Appendix/Unix/unix-basics-1.html#gsc.tab=0
- https://data-skills.github.io/unix-and-bash/
- https://datacarpentry.org/shell-genomics/01-introduction/index.html



# B. Jeux de données  

## Téléchargement

Pour cette série d'exercices sur le shell Unix, nous utiliserons la séquence protéique d'insuline humaine.

> **Note**: Chaque fois que vous cliquez dans la première fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche Esc.



**Fig.1**: Capture d'écran du shell Unix

Téléchargez le fichier bioDU_archive.tar.xz dans la section Datasets ou cliquez ici [Link].
Ensuite, sur la page https://copy.sh/v86,
Cliquez sur le bouton Parcourir dans le panneau à droite à la rubrique Send Files to emulator.
Sélectionnez le fichier bioDU_archive.tar.xz
Dans le shell (2ème fenêtre), tapez les lignes suivantes pour décompresser l'archive.
Il y a un gros fichier qui peut prendre un peu de temps...

```bash
# On vérifie que le téléchargement s'est bien passé. 
# Le fichier est dans la racine '/' 
$ ls ..
bioDU_archive.tar.xz
# Décompresse l'archive 
$ tar xf ../bioDU_archive.tar.gz
# Vérifie que le dossier data/ est bien présent.
$ ls
data/
```

# C. Commande find    

## Comment retrouver ces fichiers dans son arborescence de fichiers?

> **Note**: Chaque fois que vous cliquez dans la fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche Esc.

### 1. Syntaxe de la commande find

La syntaxe générale est la suivante:

`find [-H] [-L] [-P] [-Olevel] [-D debugopts] [path...] [expression]`

On se propose d'afficher l'arborescence de tous les fichiers dans le répértoire data/.

```bash
# On se place dans son HOME. 
$ cd
# On affiche l'arborescence de data/ 
$ find data/
data/
data/improper.fasta
data/mouse
data/mouse/Mus_musculus.GRCm38.75_chr1.bed
data/mouse/Mus_musculus.GRCm38.75_chr1_bed.csv
data/mouse/Mus_musculus.GRCm38.75_chr1_genes.txt
data/mouse/Mus_musculus.GRCm38.75_chr1.gtf
data/zmays-snps
data/zmays-snps/data
data/zmays-snps/data/seqs
data/zmays-snps/data/seqs/zmaysA_R2.fastq
data/zmays-snps/data/seqs/zmaysC_R2.fastq
data/zmays-snps/data/seqs/zmaysC_R1.fastq
data/zmays-snps/data/seqs/zmaysA_R1.fastq
data/zmays-snps/data/seqs/zmaysB_R1.fastq
data/zmays-snps/data/seqs/zmaysB_R2.fastq
data/zmays-snps/analysis
data/zmays-snps/scripts
```

### 2. Filtrage avec -name

On se propose de chercher uniquement les fichiers FASTQ dans les données téléchargées. On part du principe que tous ces fichiers ont l'extension .fastq.

```bash
# On se place dans son HOME. 
$ cd
# On fait la recherche 
$ find data/ -name '*.fastq'
./data/zmays-snps/data/seqs/zmaysA_R2.fastq
./data/zmays-snps/data/seqs/zmaysC_R2.fastq
./data/zmays-snps/data/seqs/zmaysC_R1.fastq
./data/zmays-snps/data/seqs/zmaysA_R1.fastq
./data/zmays-snps/data/seqs/zmaysB_R1.fastq
./data/zmays-snps/data/seqs/zmaysB_R2.fastq
```

Pour la commande find, on doit indiquer:

Où commencer la recherche. Ici data/ indique que nous partons du répertoire data/ pour faire la recherche.
-name suivi d'une phrase (String) séparé par des guillemets simples ou doubles indique le motif recherché dans les fichiers.
Note: Si vous voulez commencer la recherche du répertoire courant, il faut mettre un point (.)

### 3. Caractères joker pour la construction du motif

- L'étoile * sert à remplacer plusieurs caractères. Par exemple, -name "zmays*" permet de rechercher tous les fichiers commençant par zmays quelque soit le nombre et la valeur des caractères qui suit ce préfixe.
- Le point d'interrogation ?sert à remplacer un seul caractère. Par exemple, on recherche tous les fichiers dont l'extension est .fastq ou .fasta. On saisira le motif -name "*.fast?". Cela ne fonctionnera pas avec un fichier qui se termine par .fastas

Il y a plusieurs arguments pour moduler le comportement de find.

### 4. La négation.

Si vous voulez rechercher tout sauf un nom de fichier, il faut utiliser le point d'exclamation entre guillemets. "!". Par exemple, la commande suivante recherche tous les fichiers qui ne sont pas de type A.

```bash
find data/zmays-snps/data/seqs/ "!" -name "zmaysA*.fastq"
```

### 5. Les opérateurs logiques -or et -and

On peut combiner plusieur recherches avec des opérateurs logiques. La syntaxe est alors la suivante avec l'opérateur '-or'
```bash
find <directory>  -name <pattern1> -or -name <pattern2>
```

On peut combiner plusieur recherches avec des opérateurs logiques. La syntaxe est alors la suivante avec l'opérateur '-and'
```bash
find <directory>  -name <pattern1> -and -name <pattern2>
```

# D. Exercices Commande find   

## Exercices

> **Note**: Chaque fois que vous cliquez dans la fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche Esc.

### Question 1

Rechercher tous les fichiers FASTQ qui sont de type R2.

### Question 2

Rechercher tous les fichiers FASTQ qui sont de type C.

### Question 3

Rechercher tous les fichiers FASTQ qui sont de type A ou B et R1.

### Question 4

Vous avez ajouté des fichiers temporaires dans le répertoire data/zmays-snps/data/seq qui contiennent le mot '-temp'. Pour créer, ces fichiers, recopiez les commandes ci-dessous.

> **Note**: Pour les lignes de commande compliquées, vous pouvez faire un copier/coller. Sélectionner avec la souris -- par exemple -- la ligne 2 ci-dessous, faire un clic avec le bouton droit et sélectionner Copier. Puis, allez sur le shell Unix et faire un bouton droit pour choisir Coller. La ligne de commande est alors copiée, il ne vous reste plus qu'à la valider avec la touche Entrée.

```bash
# On se place dans son HOME. 
$ cd
$ cd data/zmays-snps/data/seqs
$ touch zmays{A,C}_R{1,2}-temp.fastq
```

Le résultat doit donner ceci...

```bash
$ ls
zmaysA_R1.fastq
zmaysA_R1-temp.fastq
zmaysA_R2.fastq
zmaysA_R2-temp.fastq
zmaysB_R1.fastq
zmaysB_R2.fastq
zmaysC_R1.fastq
zmaysC_R1-temp.fastq
zmaysC_R2.fastq
zmaysC_R2-temp.fastq
```

#### Question 4.1: Recherchez les fichiers temporaires FASTQ

#### Question 4.2: Recherchez les fichiers FASTQ de type R1 qui ne sont pas temporaires


# E. Commandes head et tail, less 

## Inspecter les données.

> **Note**: Chaque fois que vous cliquez dans la fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche Esc.


### 1. Syntaxe de la commande head et tail

Ces commandes head et tail permettent d'afficher respectivement les premières et dernières lignes d'un fichier texte. C'est très pratique pour avoir un aperçu du contenu quand le fichier est très grand.

```bash
head -n <number> file
tail -n <number> file
```

Par exemple, si on veut afficher les trois 1ères lignes du fichier Mus_musculus.GRCm38.75_chr1.bed...

```bash
# On se place dans son HOME. 
$ cd
# On affiche l'arborescence de data/ 
$ cd data/mouse
$ head -n 3 Mus_musculus.GRCm38.75_chr1.bed
1	3054233	3054733
1	3054233	3054733
1	3054233	3054733
```

Pour la commande tail, c'est la même chose mais pour les dernières du fichier.
```bash
$ tail -n 3 Mus_musculus.GRCm38.75_chr1.bed
1	195240910	195241007
1	195240910	195241007
1	195240910	195241007
```

### 2. Saut de lignes avec -n + `<number>`
  
Si le nombre est précédé d'un signe '+', il y aura saut jusqu'au numéro de ligne. Par exemple, pour le fichier insulin.fasta que vous pouvez créer en copiant la ligne suivante et en la collant dans le shell
  
```bash
$ echo -e ">INS_HUMAN\nMALWMRLLPLLALLALWGPDPAAAFVNQHLCGSHLVEALYLVCGERGFFYTPKTRREAEDLQVGQVELGG\GPGAGSLQPLALEGSLQKRGIVEQCCTSICSLYQLENYCN" > insulin.fasta
```
  
Dans le format FASTA , il y a 1 ligne d'entête commençant par un chevron '>'. Si on veut l'enlever, on tapera:

```bash
# On se place dans son HOME. 
$ cd data
# On fait la recherche 
$ tail -n +2 insulin.fasta
```
  
### 3. La commande less
  
La commande less déjà mentionné est très adapté aux fichiers longs car elle permet d'afficher page par page. Il y a aussi quelques commandes utiles listés ci-dessous en particulier la recherche de mots.

#### 3.1. Navigation

```
**Key command**	**Action**                          
down arrow key  Move down one line.
up arrow key    Move up one line.
space bar	Move down one page.
b	        Move up one page.
right arrow key	Scroll horizontally to the right.
left arrow key	Scroll horizontally to the left.
g	        Go to the first line.
G	        Go to the last line.
```

#### 3.2. Recherche de mots

```
Key command	Action                          
/search term	Search forward from the current position for the search term string.
?search term	Search backward from the current position for the search term string.
n	        When searching, go to the next occurrence.
N	        When searching, go to the previous occurrence.
```

#### 3.3. Quitter less
```
Key command	Action                          
q	        Quit less
```


# F. Commande grep  

## Filtrer des lignes dans un fichier texte.

> **Note**: Chaque fois que vous cliquez dans la fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche <kbd>Esc</kbd>.


### 1. Syntaxe de la commande grep

La commande grep permet de restreindre l'affichage des lignes d'un fichier texte qui sont similaires au motif donné selon la syntaxe suivante:

`grep [arguments] <pattern> file`

La commande `grep` affiche les lignes du ou des fichiers qui contiennent le motif recherché. Il est souvent surligné d'une couleur (ici, en rouge).

### 2. Mot-clé simple

Par exemple, si on veut afficher quels sont les fichiers qui contiennent le mot Hello, on tapera la commande suivante:

```bash
# On se place dans son HOME. 
$ cd
$ grep Hello *
hello.asm:msg db 'Hello, world', 
hello.c:    printf("Hello, world\n");
hello.js:console.log("Hello, world");
hello.ml:print_endline "Hello, World!"
hello.pl:print "Hello, world\n"
hello.py:print("Hello, world")
grep: nbench: Is a directory
```

La commande grep affiche tous les fichiers qui contiennent le mot Hello (surligné en rouge). Il vous indique quelle.s ligne.s contient le motif recherché.

### 3. Les arguments
#### 3.1. Insensibilité à la casse. Argument -i

Si on cherche le mot world, la recherche ne se fera qu'avec une identité exacte de chaque caractère mais si on souhaite faire une recherche quelque soit la casse (majuscules ou minuscules), on utilisera l'argument -i comme dans la ligne de commande suivante:

```bash
$ grep -i 'world' *
hello.asm:msg db 'Hello, world', 0AH
hello.c:    printf("Hello, world\n");
hello.js:console.log("Hello, world");
hello.ml:print_endline "Hello, World!"
hello.pl:print "Hello, world\n"
hello.py:print("Hello, world")
```

#### 3.2. Recherche contraire. Argument -v
Si vous voulez rechercher toutes les lignes qui NE CONTIENNENT PAS le mot world dans le fichier hello.c, on aura:

```bash
$ grep -v 'world' hello.c 
// to run: tcc -run hello.c
#include <stdio.h>

main()
{
}
```


# G. Commande grep - regex 

## 4. Commande grep - Les expressions régulières

Note Bioinformatique: La syntaxe des expressions régulières de la commande grep est très proche de celle des séquences consensus de la banque de données PROSITE.

Pour la suite de cette page,  nous allons nous servir d'un fichier multi-fasta comme exemple créé avec la commande suivante (à copier et à coller dans le shell).

```bash
$ echo -e ">seq1\nACGT\n>qes2\nCCCA\n>esq3\nATATAT" > multi.fasta
```

Pour définir des motifs complexes et réaliser des recherches plus fines, il existe des syntaxes spécifiques utilisant les symboles ci-dessous .

```
Symbole               Description                                        
^ (Caret)        =    match expression at the start of a line, as in ^A.
$ (Question)     =    match expression at the end of a line, as in A$.
\ (Back Slash)   =    turn off the special meaning of the next character, as in \^.
[ ] (Brackets)   =    match any one of the enclosed characters, as in [aeiou].
                      Use Hyphen "-" for a range, as in [0-9].
[^ ]             =    match any one character except those enclosed in [ ], as in [^0-9].
. (Period)       =    match a single character of any value, except end of line.
* (Asterisk)     =    match zero or more of the preceding character or expression.
\{x,y\}          =    match x to y occurrences of the preceding.
\{x\}            =    match exactly x occurrences of the preceding.
\{x,\}           =    match x or more occurrences of the preceding.
```

### 4.0. Caractère d'échappement

Si on souhaite inclure dans le motif des symboles comme les guillemets simples ou double, des parenthèses, etc, il faudra utiliser le caractère d'échappement \ (AltGR+8) comme ceci:

```bash
$ grep \"Hello *
```

Un autre exemple où cette fois, on recherche le mot ("Hello c'est à dire le mot Hello précédé d'une parenthèse et d'un guillemet double...
```bash
$ grep \(\"Hello *
hello.c:    printf("Hello, world\n");
hello.js:console.log("Hello, world");
hello.py:print("Hello, world")
```

Pour éviter d'utiliser trop de caractères d'échappement, la plupart du temps, on délimite le motif par des guillemets simples (ou doubles selon).
```bash
$ grep '("Hello' *
hello.c:    printf("Hello, world\n");
hello.js:console.log("Hello, world");
hello.py:print("Hello, world")
```

### 4.1. Exemple d'utilisation du chapeau ^ et du dollar $

Ces deux symboles servent à limiter la recherche pour des mots commençant en début de ligne (^ ou AltGR+9) ou se terminant en fin de ligne ($).
Par exemple, recherchons toutes les entêtes c'est à dire le caractère chevron > en début de ligne pour ce fichier multi.fasta fraîchement créé.

```bash
$ grep '^>' multi.fasta
>seq1
>qes2
>esq3
```

Pour le dollar $, si on cherche les lignes qui se terminent par un ; dans les fichiers hello.* . On fera suivre le ; par un $ qui signifie fin de ligne comme ceci:
```bash
$ grep ';$' hello.*
hello.c:    printf("Hello, world\n");
hello.js:console.log("Hello, world");
```

### 4.2. Exemple d'utilisation des crochets [ ...].

Si on cherche les mots world ou World (avec un W majuscule). On écrira l'expression [wW] pour indiquer que la 1ère lettre est soit un w soit un W comme ceci:

```bash
$ grep '[wW]orld' hello*
hello.asm:msg db 'Hello, world', 0AH
hello.c:    printf("Hello, world\n");
hello.js:console.log("Hello, world");
hello.ml:print_endline "Hello, World!"
hello.pl:print "Hello, world\n"
hello.py:print("Hello, world")
```

On récupère un fichier de plus (hello.ml).

### 4.3. Exemple d'utilisation du point (.) et de l'étoile (*)

Pour tester ces deux symboles, on va compléter le fichier multi.fasta en y ajoutant deux autres séquences seqA et sq2A comme ceci (à copier et coller):

```bash
$ echo -e ">seqA\nCGCGCG\n>sq29\nTTTAAA\n>sequence4\nCCCTTTAAA\n" >> multi.fasta
```

On peut vérifier le contenu du fichier multi.fasta
```bash
$ less multi.fasta 
>seq1
ACGT
>qes2
CCCA
>eqs3
ATATAT
>seqA
CGCGCG
>sq29
TTTAAA
>sequence4
CCCTTTAAA
multi.fasta (END)
```

> **Note**: Tapez <kbd>q</kbd> pour sortir

Le point '.' remplace n'importe quel caractère. Par exemple, si on cherche les entêtes qui possèdent trois caractères quelconques suivi d'un chiffre. On saisira le motif suivant:

```bash
$ egrep '^>...[0-9]' multi.fasta 
>seq1
>qes2
>eqs3
>sq29
```

On voit que l'entête sq29 correspond bien à la définition du motif. On a trois caractères quelconques s q et 2 suivi d'un chiffre 9.

L'étoile  <kbd>*</kbd> est un opérateur de répétition qui indique que le caractère précédent dans le motif peut être répété 0 à plusieurs fois. On l'associe souvent au symbole point (.) mais il peut fonctionner avec n'importe quel autre opérateur.

Maintenant, si on cherche toutes les entêtes contenant un chiffre compris entre 0 et 8, on saisira:
```bash
$ grep '^>.*[0-8]' multi.fasta 
>seq1
>qes2
>eqs3
>sq29
>sequence4
```

Le mot sq2 de l'entête sq29 correspond bien au motif saisi c'est à dire un nombre variable de caractères (alphabétique) suivi d'un chiffre de 0 à 8. Le 9 n'est pas pris en compte lors de la recherche du motif par grep.

### 4.4. Exemple d'utilisation des accolades.

On va chercher les entêtes des séquences dont le nom est constitué de trois caractères alphabétiques minuscules (de a à z) en définissant le motif de la façon suivante:

```bash
# Motif écrit maladroitement
$ egrep '^>[a-z][a-z][a-z]' multi.fasta 
# Motif plus compact utilisant la répétition
$ egrep '^>[a-z]{3}' multi.fasta 
>seq1
>qes2
>eqs3
>seqA
>sequence4
```

# H. Pipe et redirection     

> **Note**: Chaque fois que vous cliquez dans la fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche Esc.

## 1. La redirection pour sauvegarder le résultat des commandes

Par défaut, dans un shell, le résultat d'une commande est affiché sur l'écran. On peut toutefois rediriger cette sortie dans un fichier à l'aide du symbole >

```bash
# On se place dans son HOME. 
$ cd
# On affiche l'arborescence de data/ 
$ cd data/mouse
$ head -n 3 Mus_musculus.GRCm38.75_chr1.bed
1	3054233	3054733
1	3054233	3054733
1	3054233	3054733
$ head -n 3 Mus_musculus.GRCm38.75_chr1.bed > three.bed
$ ls
Mus_musculus.GRCm38.75_chr1.bed
Mus_musculus.GRCm38.75_chr1_bed.csv
Mus_musculus.GRCm38.75_chr1_genes.txt
Mus_musculus.GRCm38.75_chr1.gtf
three.bed
$ less three.bed
1	3054233	3054733
1	3054233	3054733
1	3054233	3054733
three.bed (END)
```

Le fichier three.bed contient alors les 3 lignes.

## 2. Combiner plusieurs commandes avec le pipe  `|`

Dans la plupart des cas, on recherche à combiner plusieurs commandes à la suite de telle manière que le résultat de la commande précédente serve de données d'entrée pour la commande actuelle et ainsi de suite.
Par exemple,
```bash
# On se place dans son HOME. 
$ cd data/mouse
# C'est parti 
$ tail -n +6 Mus-musculus.GRCm38.75_chr1.gtf | head -n 5
```

Dans cet exemple, on a un pipeline avec deux commandes tail et head.

- La commande tail ne commence qu'à la 6ème ligne et affiche le contenu du reste du fichier.
- La commande head prend le résultat de tail (c'est à dire le fichier tronqué de son entête) et n'affiche que les 5 1ères lignes.

### Question 1: Dans le fichier data/improper.fasta, comment faites-vous pour n'afficher que la séquence de good-sequence

Le résultat attendu est: AGCTAGCTACTAGCAGCTACTACGAGCATCTACGGCGCGATCTACG

> Note: Si vous voulez commencer la recherche du répertoire courant, il faut mettre un point (.)


# I. Commandes cut, paste     

> **Note**: Chaque fois que vous cliquez dans la fenêtre de l'émulateur, celui-ci prend la main sur la souris et la fait "disparaître" (comme dans un vrai mode "Ligne de Commande"). Pour "retrouver" votre souris, tapez sur la touche <kbd>Esc</kbd>.


## 1. La commande cut
La commande cut est l'un des outils de filtrage de texte présents dans Linux et UNIX.
Elle s'utilise pour extraire des colonnes spécifiques des lignes de texte. Vous passez du texte à l'aide de fichiers ou la sortie d'une autre commande à la commande cut.

```bash
cut options [fichier]
```

Voici la liste des options disponible pour la commande cut :

```
Options            Description
-f (- champs)      Spécifiez les champs que vous souhaitez extraire.
-c (- caractères)  Spécifiez les caractères que vous souhaitez extraire.
-b (- octets)      Fournissez les octets que vous souhaitez extraire.
-d (-Délimiteur)   Ici, vous spécifiez le délimiteur que vous souhaitez utiliser avec la commande CUT.
                   Par défaut, l'onglet est considéré comme un délimiteur.
--complement	   Il est utilisé pour obtenir des colonnes non spécifiées par -f, -c ou -b Options.
--output-delimiter Par défaut, la commande CUT utilise le délimiteur d'entrée en tant que délimiteur de sortie,
mais vous pouvez modifier ce comportement en utilisant cette option.
```

> **Note**: Pour les lignes de commande compliquées, vous pouvez faire un copier/coller. Sélectionner avec la souris -- par exemple -- la ligne 2 ci-dessous, faire un clic avec le bouton droit et sélectionner Copier. Puis, allez sur le shell Unix et faire un bouton droit pour choisir Coller. La ligne de commande est alors copiée, il ne vous reste plus qu'à la valider avec la touche Entrée.

```bash
# On se place dans son HOME. 
$ cd
$ cd data/zmays-snps/data/seqs
$ touch zmays{A,C}_R{1,2}-temp.fastq
```

## 2. La commande paste

# J. Commandes sort et uniq


