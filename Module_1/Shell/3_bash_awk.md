# awk

## Commande awk

awk est une commande qui permet de manipuler de façon poussée les fichiers texte organisée en table. C'est en fait un langage de programmation dédié à la manipulation de texte qui est la plupart du temps utilisé sur une seule ligne avec ses fonctionnalités les plus basiques.

Sa syntaxe générale est:

`awk [-arguments] 'script' file`


Copier la ligne suivante qui créé un fichier texte de type CSV.

```bash
$ echo -e "A,B,C\n1,2,x\n4,5,y\n6,7,z"  > dummy.csv
```

Vous pouvez vérifier que le fichier a été correctement créé avec la commande less:

```bash
$  less dummy.csv 
A,B,C
1,2,x
4,5,y
6,7,z
```

### 1. Choisir le séparateur

Selon le type de fichier contenant les données tabulaires, le séparateur peut être une virgule, un point-virgule, un espace, une tabulation, etc. On doit le spécifier à awk pour qu'il puisse traiter correctement les données.

> **Note**: Le séparateur par défaut est le Tab ou l'espace (un ou plusieurs). Dans ce cas, pas besoin de le spécifier.
On utilise l'argument -F suivi du caractère séparant les données dans une ligne. Ce caractère doit être délimité par des guillemets simples ou doubles. Si c'est une virgule, on tapera -F ',' comme ci-dessous.

```bash
$ awk -F ',' '{print($2)}' dummy.csv
```

### 2. Écrire un script awk

Le script awk doit être placé après les arguments et avant le nom de fichier.
Il doit être délimité par des guillemets simples (pour ne pas le confondre avec le nom de fichier).
Les instructions du langage awk doivent être incluses dans des accolades ouvrante et fermante {et }. Ces caractères sont obtenus avec les combinaisons de touche suivantes: AltGr+4 et AltGr++, respectivement.
Si on utilise plusieurs instructions dans le script, on doit les séparer par un point-virgule ;.
Un script awk aura donc la syntaxe suivante:
awk '{ instruction1 ;  instruction2 ; instruction3 }' file

### 3. Afficher du texte

L'instruction (ou fonction) la plus utile est print(..) qui permet d'afficher des données du fichier à traiter.

Dans cet exemple très simple, on affiche le texte "Hello Bordeaux!" pour chaque ligne du fichier dummy.csv

```bash
$ awk -F ',' '{print("Hello Bordeaux!")}' dummy.csv
Hello Bordeaux!
Hello Bordeaux!
Hello Bordeaux!
Hello Bordeaux!
```

`Hello Bordeaux!` est une phrase (nommée _String_ en informatique) et doit être encadré obligatoirement par des guillemets doubles. Par contre, les nombres doivent être saisis tel quel comme dans l'exemple ci-dessous.

```bash
$ awk -F ',' '{print(2022)}' dummy.csv
2022
2022
2022
2022
```

On peut utiliser plusieurs arguments dans la fonction print(..). Il suffit de séparer les arguments par des virgules comme indiqué dans la syntaxe ci-dessous:

```bash
print(arg1,arg2,..., argn).
```

Par exemple, ici la fonction print(..) a trois arguments: les deux premiers sont des String (avec des guillemets doubles) et le troisième est un Number (pas de guillemets).

```bash
$ awk -F ',' '{print("Hello Bordeaux!","in",2022)}' dummy.csv
Hello Bordeaux! in 2022
Hello Bordeaux! in 2022
Hello Bordeaux! in 2022
Hello Bordeaux! in 2022
```

> **Note**: Pour la fonction print(..), les parenthèses sont facultatives mais je vous conseille de les mettre pour plus de clarté.


### 4. Manipuler les colonnes
Une colonne dans awk est symbolisée par le signe dollar <kbd>$</kbd> suivi d'un nombre qui indique le Numéro de colonne. On les compte à partir de 1.

> **Note**: Le symbole `$0` représente la ligne entière
 
Script awk pour afficher la colonne 2 (la colonne B)

```bash
$ awk -F ',' '{print($2)}' dummy.csv
```

Si on veut afficher les colonnes 1 et 3, le script devient:

```bash
$ awk -F ',' '{print($1,$3)}' dummy.csv
A C
1 x
4 y
6 z
```

Par défaut, la fonction `print(..)` sépare les deux colonnes par un espace.

## 5. Les variables NF et NR

Dans awk, il est souvent nécessaire de connaître le numéro de ligne et le nombre de colonnes. Il existe deux mots clés spécifiques NF et NR.

- `NF` (Number of Fields) indique le nombre de colonnes.
- `NR` (Number of Record) indique le Numéro de ligne
- 
Par exemple, la ligne de commande suivante permet d'afficher le nombre de colonnes dans le fichier.

```bash
$ awk -F ',' '{print("Columns:",NF,"in row",$0)}' -
Columns: 3 in row A,B,C
Columns: 3 in row 1,2,x
Columns: 3 in row 4,5,y
Columns: 3 in row 6,7,z
```

C'est assez redondant. Le plus efficace est d'utiliser un pipeline avec l'extraction de la 1ère ligne du fichier avec la commande head puis cette ligne unique est passée dans awk qui affiche NF soit le nombre de colonnes.

```bash
$ head -n 1 dummy.csv | awk -F ',' '{print("Columns:",NF)}' -
Columns: 3
```

Si on souhaite afficher le numéro de ligne devant chaque ligne, on utilisera un script

```bash
$ awk -F ',' '{print("Row",NR,":",$0)}' -
Row 1 : A,B,C
Row 2 : 1,2,x
Row 3 : 4,5,y
Row 4 : 6,7,z
```

## 6. Le branchement conditionnel

Dans le cadre de nettoyage de fichier, on veut souvent supprimer une ligne en fonction d'une condition. Par exemple, si la valeur de la colonne 2 est supérieur à 4, je garde cette ligne. On écrira la condition avec le mot clé **if** suivi de la condition entre parenthèses. La syntaxe est:

`if (condition) instruction1; else instruction 2;`

Par exemple, pour ne sélectionner que les lignes dont la valeur de la colonne 2 est supérieur à 4, le script est:

```bash
$ awk -F ',' '{if ($2 > 4) print($0)}' dummy.csv
A,B,C
4,5,y
6,7,z
```
Par exemple, si vous voulez marquer les lignes supprimées, vous allez rajouter une clause 'else' comme ci-dessous:

```bash
$ awk -F ',' '{if ($2 > 4) print($0); else print("-,-,-")}' dummy.csv
A,B,C
-,-,-
4,5,y
6,7,z
```
