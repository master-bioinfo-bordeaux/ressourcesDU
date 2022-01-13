# Langage awk

Source: https://www.gnu.org/software/gawk/manual/html_node/index.html

## 1. Blocs de code

## 2. Variables

## 3. Opérations mathématiques


The awk language uses the common arithmetic operators when evaluating expressions. All of these arithmetic operators follow normal precedence rules and work as you would expect them to.

Voici un exemple de fichier avec des noms d'étudiants et trois notes d'examens.

```
Pat   100 97 58
Sandy  84 72 93
Chris  72 92 89
```

Ce programme `awk`prend les notes des étudiants et en calcule la moyenne.

```bash
$ awk '{ sum = $2 + $3 + $4 ; avg = sum / 3; print $1, avg }' notes.tsv
-| Pat 85
-| Sandy 83
-| Chris 84.3333
```

### 3.1. Les opérateurs arithmétiques

|Fonction|Syntaxe|Description|
|--------|-------|-----------|
|Puissance|`x ^ y` ou `x ** y`| x puissance y ( 2 ^ 3 = 2 ** 3 -> 2 * 2 * 2 = 8 |
| Addition| x + y| 2 + 3 -> 5|
|Soustraction| x - y | 2 - 3 -> 1 |
|Multiplication| x * y | 2 * 3 -> 6 |
|Division| x * y | 3 / 4 -> 0.75 |
|Modulo| x % y | 3 % 2 -> 1 |
|Négation| -x | -3 -> -3 |
|Plus unitaire| +x | +"3" -> 3 . Conversion de type en nombre|


### 3.2. Les fonctions mathématiques

### 3.2.1. Arrondi à l'entier le plus proche
int(x)
```
int(3) is three, 
int(3.9) is three, 
int(-3.9) is -3, and 
int(-3) is -3 as well.
```

#### 3.2.2. Racine carrée
sqrt(x)
This gives you the positive square root of x. It reports an error if x is negative. Thus, sqrt(4) is two.

#### 3.2.3. Fonction exponentielle
exp(x)
This gives you the exponential of x (e ^ x), or reports an error if x is out of range. The range of values x can have depends on your machine's floating point representation.

#### 3.2.4. Fonction log
log(x)
This gives you the natural logarithm of x, if x is positive; otherwise, it reports an error.

#### 3.2.5. Fonctions trigonométriques

|Fonction|Description|
|--------|-----------|
|sin(x)  | sinus de x, with x en radians.|
|cos(x)|cosine of x, with x en radians.|
|atan2(y, x)|arc-tangente e y / x en radians.|

#### 3.2.6. Fonctions aléatoires

##### 3.2.6.1. Fonction rand()
Génére une valeur uniformément distribuée entre zero et one. La valeur n'est jamais zero ni un. Si on souhaite des nombres aléatoires entiers, onpeut utiliser cette fonction qui génère des nombres entre 0 et `n`.

```awk
function randint(n) {
     return int(n * rand())
}
```

The multiplication produces a random real number greater than zero and less than n. We then make it an integer (using int) between zero and n - 1, inclusive. Here is an example where a similar function is used to produce random integers between one and n. This program prints a new random number for each input record.
awk 

```awk
# Function to roll a simulated die.
function roll(n) { return 1 + int(rand() * n) }

# Roll 3 six-sided dice and
# print total number of points.
{
      printf("%d points\n",
             roll(6)+roll(6)+roll(6))
}
```

Caution: In most awk implementations, including gawk, rand starts generating numbers from the same starting number, or seed, each time you run awk. Thus, a program will generate the same results each time you run it. The numbers are random within one awk run, but predictable from run to run. This is convenient for debugging, but if you want a program to do different things each time it is used, you must change the seed to a value that will be different in each run. To do this, use srand.

##### 3.2.6.2. Fonction srand([x])

Génération d'un  nombre pseudo-aléatoire à partir d'une graine. Si non explicitement passé comme argument, utillise la date. La génération des nombres est la même pour une graine identique.

