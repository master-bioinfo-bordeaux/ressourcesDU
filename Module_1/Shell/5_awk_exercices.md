## Exercices

Pour ces exercices, on utilisera deux jeux de données

#### people.tsv
```
Nom	Age	Sexe	A	B
Anna	21	F	123	10
Denise	89	F	654	89
Xavier	32	H	245	?
Chloé	45	F	332	21
Fredo	62	H	?	54
Denise	89	F	654	89
?	34	H	276	17
Léa	28	F	200	15
```

#### matrix.csv
```
1,2,3,4,5
5,4,9,2,3
9,3,9,7,2
8,7,6,5,4
-1,4,-9,2,-3
```
### Question 1: Ecrire un script `head.awk`
Ce script doit reproduire le comportement de la commande shell `head`. Le code doit pouvoir n'afficher que les premières lignes
Par exemple,

```awk
$ awk -v N=3 -f head.awk people.tsv
Nom	Age	Sexe	A	B
Anna	21	F	123	10
Denise	89	F	654	89
```
>**Note**:L'argument `-v N=3` permet de passer la variable `N` ainsi que la valeur assigné `3` au script. On l'utilise alors comme n'importe quelle variable comme le montre le script ci-dessous:

    ```awk
    $ awk -v N=3 'BEGIN {print N}' people.tsv
    3
    ```

### Question 2: Ecrire un script `linecount.awk`
Ce script doit reproduire le comportement de la commande shell `wc -l`. Le code doit pouvoir compter le nombre de lignes d'un fichier texte.
Par exemple,

```awk
$ awk -f linecount.awk people.tsv
9
```

### Question 3: Ecrire un script `wordcount.awk`
Ce script doit reproduire le comportement de la commande shell `wc -w`. Le code doit pouvoir compter le nombre de mots.
Par exemple,

```awk
$ awk -f wordcount.awk people.tsv
9     45     156
```
### Question 4: Ecrire un script `wc.awk`
En vous inspirant de ce que vous avez trouvé précédemment, Ecrire un script qui doit reproduire le comportement de la commande shell `wc`. Le code doit pouvoir compter le nombre de lignes, de mots et de caractères.
Par exemple,

```awk
$ awk -f wc.awk people.tsv
9     45     156
```

### Question 5: Ecrire un script `sum.awk`
Ce script fait la somme de tous les champs dans un record
Par exemple,

```awk
$ awk -F ',' -f sum.awk matrix.csv 
15
23
30
30
-7
```
> **Note**: Essayez de faire une implantation avec une boucle pour que le script fonctionne quel que soit le nombre de colonnes.

### Question 6: Ecrire un script `uppercase.awk`
Ce script convertit chaque _record_ en majuscule.
Par exemple,

```awk
$ awk  -f uppercase.awk people.tsv 
NOM	AGE	SEXE	A	B
ANNA	21	F	123	10
DENISE	89	F	654	89
XAVIER	32	H	245	?
CHLOÉ	45	F	332	21
FREDO	62	H	?	54
DENISE	89	F	654	89
?	34	H	276	17
LÉA	28	F	200	15
```

### Question 7: Ecrire un script `vowel.awk`
Ce script supprime toutes les voyelles **minuscules** dans chaque _record_.
Par exemple,

```awk
$ awk  -f vowel.awk people.tsv 
Nm	Ag	Sx	A	B
Ann	21	F	123	10
Dns	89	F	654	89
Xvr	32	H	245	?
Chlé	45	F	332	21
Frd	62	H	?	54
Dns	89	F	654	89
?	34	H	276	17
Lé	28	F	200	15
```

>**Note**: Les accents ne seront pas pris en compte comme dans Chloé

>**Note**: Dans un 1er temps, on ne tiendra pas compte du cas particulier de l'entête.

Si vous voulez perfectionner votre script et éviter de prendre en compte l'entête, voici le résultat attendu.

```awk
Nom	Age	Sexe	A	B
Ann	21	F	123	10
Dns	89	F	654	89
Xvr	32	H	245	?
Chlé	45	F	332	21
Frd	62	H	?	54
Dns	89	F	654	89
?	34	H	276	17
Lé	28	F	200	15
```

### Question 8: Ecrire un script `reverse.awk`
Ce script inverse les lettres d'un mot. Par exemple `Denise`deviendra `esineD`
Par exemple,

```awk
$ cut -f 1 people.tsv | awk  -f reverse.awk

```

>**Note**: Le script fonctionnera uniquement pour des fichiers texte à une colonne

### Question 9: Ecrire un script `complement.awk`
Ce script calcule le brin complémentaire d'une séquence nucléique.
Par exemple,

```awk
$ echo "CTCGAGGGGCCTAGACATTGCCCTCCAGAGAGAGC" | awk  -f complement.awk
GCTCTCTCTGGAGGGCAATGTCTAGGCCCCTCGAG
```

>**Note**: Le script fonctionnera uniquement pour des fichiers texte à une colonne


### Question 10: Ecrire un script `occurrences.awk`
Ce script doit reproduire le comportement de la commande shell `uniq -c`. Le code doit pouvoir compter le nombre d'occurrences d'un mot dans un fichier texte.
Par exemple,

```awk
$ awk -f occurrences.awk people.tsv
1 ?
1 Anna
1 Chloé
2 Denise
1 Fredo
1 Léa
1 Nom
1 Xavier
```
> **Note**: On ne prendra en compte que la 1ère colonne

> **Note**: Pour l'implantation, on utilisera un dictionnaire (tableau avec un système clé/valeur).

### Question 11: Ecrire un script `distribution.awk`
Le code doit pouvoir compter le nombre d'occurrences des bases nucléiques d'une séquence.
Par exemple,

```awk
$ echo "CTCGAGGGGCCTAGACATTGCCCTCCAGAGAGAGC" | awk  -f complement.awk
A 8
C 11
T 5
G 11
```

> **Note**: Pour l'implantation, on utilisera un dictionnaire (tableau avec un système clé/valeur).

### Question 12: Ecrire un script `tail.awk`
Le code doit pouvoir mimer le fonctionnement de la commande shell `tail`.
Par exemple,

```awk
awk  -v N=4 -f tail.awk people.tsv
Fredo	62	H	?	54
Denise	89	F	654	89
?	34	H	276	17
Léa	28	F	200	15
```

> **Note**: Il faut utiliser un _reducer_ avec un accumulateur pour garder une trace des _records_ à afficher.
