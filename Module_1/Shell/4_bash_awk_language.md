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

La formule utilisée ci-dessus permet d'avoir un nombre entier (grâce à `int(..)`) bete ntreween `zero` and `n - 1`, inclus. 

Voici un autre exemple avec la simulation d'un lancer de dé à 6 faces
```awk
# Function to roll a simulated die.
function roll(n) { 
    return 1 + int(rand() * n);
}

# Roll 3 six-sided dice and
# print total number of points.
{
    printf("%d points\n",roll(6)+roll(6)+roll(6));
}
```

> **Attention!**: La fonction `rand()` donne toujours la même série de nombres aléatoires à chaque nouvelle exécution. Si vous souhaitez un comportement plus aléatoire, il peut être bon d'utiliser la fonction `srand(...)` suivante.

##### 3.2.6.2. Fonction srand([x])

Génération d'un  nombre pseudo-aléatoire à partir d'une graine. Si non explicitement passé comme argument, utillise la date. La génération des nombres est la même pour une graine identique.

## 4. Les fonction sur les _String_ 

### asort(source [, dest [, how ] ]) #
asorti(source [, dest [, how ] ]) #

These two functions are similar in behavior, so they are described together.

NOTE: The following description ignores the third argument, how, as it requires understanding features that we have not discussed yet. Thus, the discussion here is a deliberate simplification. (We do provide all the details later on; see Sorting Array Values and Indices with gawk for the full story.)

Both functions return the number of elements in the array source. For asort(), gawk sorts the values of source and replaces the indices of the sorted values of source with sequential integers starting with one. If the optional array dest is specified, then source is duplicated into dest. dest is then sorted, leaving the indices of source unchanged.

When comparing strings, IGNORECASE affects the sorting (see section Sorting Array Values and Indices with gawk). If the source array contains subarrays as values (see section Arrays of Arrays), they will come last, after all scalar values. Subarrays are not recursively sorted.

For example, if the contents of a are as follows:

a["last"] = "de"
a["first"] = "sac"
a["middle"] = "cul"
A call to asort():

asort(a)
results in the following contents of a:

a[1] = "cul"
a[2] = "de"
a[3] = "sac"
The asorti() function works similarly to asort(); however, the indices are sorted, instead of the values. Thus, in the previous example, starting with the same initial set of indices and values in a, calling ‘asorti(a)’ would yield:

a[1] = "first"
a[2] = "last"
a[3] = "middle"
NOTE: You may not use either SYMTAB or FUNCTAB as the second argument to these functions. Attempting to do so produces a fatal error. You may use them as the first argument, but only if providing a second array to use for the actual sorting.

You are allowed to use the same array for both the source and dest arguments, but doing so only makes sense if you’re also supplying the third argument.

### gensub(regexp, replacement, how [, target]) 

Search the target string target for matches of the regular expression regexp. If how is a string beginning with ‘g’ or ‘G’ (short for “global”), then replace all matches of regexp with replacement. Otherwise, treat how as a number indicating which match of regexp to replace. Treat numeric values less than one as if they were one. If no target is supplied, use $0. Return the modified string as the result of the function. The original target string is not changed.

The returned value is always a string, even if the original target was a number or a regexp value.

gensub() is a general substitution function. Its purpose is to provide more features than the standard sub() and gsub() functions.

gensub() provides an additional feature that is not available in sub() or gsub(): the ability to specify components of a regexp in the replacement text. This is done by using parentheses in the regexp to mark the components and then specifying ‘\N’ in the replacement text, where N is a digit from 1 to 9. For example:

$ gawk '
> BEGIN {
>      a = "abc def"
>      b = gensub(/(.+) (.+)/, "\\2 \\1", "g", a)
>      print b
> }'
-| def abc
As with sub(), you must type two backslashes in order to get one into the string. In the replacement text, the sequence ‘\0’ represents the entire matched text, as does the character ‘&’.

The following example shows how you can use the third argument to control which match of the regexp should be changed:

$ echo a b c a b c |
> gawk '{ print gensub(/a/, "AA", 2) }'
-| a b c AA b c
In this case, $0 is the default target string. gensub() returns the new string as its result, which is passed directly to print for printing.

If the how argument is a string that does not begin with ‘g’ or ‘G’, or if it is a number that is less than or equal to zero, only one substitution is performed. If how is zero, gawk issues a warning message.

If regexp does not match target, gensub()’s return value is the original unchanged value of target. Note that, as mentioned above, the returned value is a string, even if target was not.

### gsub(regexp, replacement [, target])

Search target for all of the longest, leftmost, nonoverlapping matching substrings it can find and replace them with replacement. The ‘g’ in gsub() stands for “global,” which means replace everywhere. For example:

{ gsub(/Britain/, "United Kingdom"); print }
replaces all occurrences of the string ‘Britain’ with ‘United Kingdom’ for all input records.

The gsub() function returns the number of substitutions made. If the variable to search and alter (target) is omitted, then the entire input record ($0) is used. As in sub(), the characters ‘&’ and ‘\’ are special, and the third argument must be assignable.

### index(in, find)
Search the string in for the first occurrence of the string find, and return the position in characters where that occurrence begins in the string in. Consider the following example:

$ awk 'BEGIN { print index("peanut", "an") }'
-| 3
If find is not found, index() returns zero.

With BWK awk and gawk, it is a fatal error to use a regexp constant for find. Other implementations allow it, simply treating the regexp constant as an expression meaning ‘$0 ~ /regexp/’. (d.c.)

### length([string])
Return the number of characters in string. If string is a number, the length of the digit string representing that number is returned. For example, length("abcde") is five. By contrast, length(15 * 35) works out to three. In this example, 15 * 35 = 525, and 525 is then converted to the string "525", which has three characters.

If no argument is supplied, length() returns the length of $0.

NOTE: In older versions of awk, the length() function could be called without any parentheses. Doing so is considered poor practice, although the 2008 POSIX standard explicitly allows it, to support historical practice. For programs to be maximally portable, always supply the parentheses.

If length() is called with a variable that has not been used, gawk forces the variable to be a scalar. Other implementations of awk leave the variable without a type. (d.c.) Consider:

$ gawk 'BEGIN { print length(x) ; x[1] = 1 }'
-| 0
error→ gawk: fatal: attempt to use scalar `x' as array

$ nawk 'BEGIN { print length(x) ; x[1] = 1 }'
-| 0
If --lint has been specified on the command line, gawk issues a warning about this.

With gawk and several other awk implementations, when given an array argument, the length() function returns the number of elements in the array. (c.e.) This is less useful than it might seem at first, as the array is not guaranteed to be indexed from one to the number of elements in it. If --lint is provided on the command line (see section Command-Line Options), gawk warns that passing an array argument is not portable. If --posix is supplied, using an array argument is a fatal error (see section Arrays in awk).

### match(string, regexp [, array])
Search string for the longest, leftmost substring matched by the regular expression regexp and return the character position (index) at which that substring begins (one, if it starts at the beginning of string). If no match is found, return zero.

The regexp argument may be either a regexp constant (/…/) or a string constant ("…"). In the latter case, the string is treated as a regexp to be matched. See section Using Dynamic Regexps for a discussion of the difference between the two forms, and the implications for writing your program correctly.

The order of the first two arguments is the opposite of most other string functions that work with regular expressions, such as sub() and gsub(). It might help to remember that for match(), the order is the same as for the ‘~’ operator: ‘string ~ regexp’.

The match() function sets the predefined variable RSTART to the index. It also sets the predefined variable RLENGTH to the length in characters of the matched substring. If no match is found, RSTART is set to zero, and RLENGTH to -1.

For example:

{
    if ($1 == "FIND")
        regex = $2
    else {
        where = match($0, regex)
        if (where != 0)
            print "Match of", regex, "found at", where, "in", $0
       }
}
This program looks for lines that match the regular expression stored in the variable regex. This regular expression can be changed. If the first word on a line is ‘FIND’, regex is changed to be the second word on that line. Therefore, if given:

FIND ru+n
My program runs
but not very quickly
FIND Melvin
JF+KM
This line is property of Reality Engineering Co.
Melvin was here.
awk prints:

Match of ru+n found at 12 in My program runs
Match of Melvin found at 1 in Melvin was here.
If array is present, it is cleared, and then the zeroth element of array is set to the entire portion of string matched by regexp. If regexp contains parentheses, the integer-indexed elements of array are set to contain the portion of string matching the corresponding parenthesized subexpression. For example:

$ echo foooobazbarrrrr |
> gawk '{ match($0, /(fo+).+(bar*)/, arr)
>         print arr[1], arr[2] }'
-| foooo barrrrr
In addition, multidimensional subscripts are available providing the start index and length of each matched subexpression:

$ echo foooobazbarrrrr |
> gawk '{ match($0, /(fo+).+(bar*)/, arr)
>           print arr[1], arr[2]
>           print arr[1, "start"], arr[1, "length"]
>           print arr[2, "start"], arr[2, "length"]
> }'
-| foooo barrrrr
-| 1 5
-| 9 7
There may not be subscripts for the start and index for every parenthesized subexpression, because they may not all have matched text; thus, they should be tested for with the in operator (see section Referring to an Array Element).

The array argument to match() is a gawk extension. In compatibility mode (see section Command-Line Options), using a third argument is a fatal error.

### patsplit(string, array [, fieldpat [, seps ] ]) #

Divide string into pieces (or “fields”) defined by fieldpat and store the pieces in array and the separator strings in the seps array. The first piece is stored in array[1], the second piece in array[2], and so forth. The third argument, fieldpat, is a regexp describing the fields in string (just as FPAT is a regexp describing the fields in input records). It may be either a regexp constant or a string. If fieldpat is omitted, the value of FPAT is used. patsplit() returns the number of elements created. seps[i] is the possibly null separator string after array[i]. The possibly null leading separator will be in seps[0]. So a non-null string with n fields will have n+1 separators. A null string has no fields or separators.

The patsplit() function splits strings into pieces in a manner similar to the way input lines are split into fields using FPAT (see section Defining Fields by Content).

Before splitting the string, patsplit() deletes any previously existing elements in the arrays array and seps.

### split(string, array [, fieldsep [, seps ] ])

Divide string into pieces separated by fieldsep and store the pieces in array and the separator strings in the seps array. The first piece is stored in array[1], the second piece in array[2], and so forth. The string value of the third argument, fieldsep, is a regexp describing where to split string (much as FS can be a regexp describing where to split input records). If fieldsep is omitted, the value of FS is used. split() returns the number of elements created. seps is a gawk extension, with seps[i] being the separator string between array[i] and array[i+1]. If fieldsep is a single space, then any leading whitespace goes into seps[0] and any trailing whitespace goes into seps[n], where n is the return value of split() (i.e., the number of elements in array).

The split() function splits strings into pieces in the same way that input lines are split into fields. For example:

split("cul-de-sac", a, "-", seps)
splits the string "cul-de-sac" into three fields using ‘-’ as the separator. It sets the contents of the array a as follows:

a[1] = "cul"
a[2] = "de"
a[3] = "sac"
and sets the contents of the array seps as follows:

seps[1] = "-"
seps[2] = "-"
The value returned by this call to split() is three.

As with input field-splitting, when the value of fieldsep is " ", leading and trailing whitespace is ignored in values assigned to the elements of array but not in seps, and the elements are separated by runs of whitespace. Also, as with input field splitting, if fieldsep is the null string, each individual character in the string is split into its own array element. (c.e.) Additionally, if fieldsep is a single-character string, that string acts as the separator, even if its value is a regular expression metacharacter.

Note, however, that RS has no effect on the way split() works. Even though ‘RS = ""’ causes the newline character to also be an input field separator, this does not affect how split() splits strings.

Modern implementations of awk, including gawk, allow the third argument to be a regexp constant (/…/) as well as a string. (d.c.) The POSIX standard allows this as well. See section Using Dynamic Regexps for a discussion of the difference between using a string constant or a regexp constant, and the implications for writing your program correctly.

Before splitting the string, split() deletes any previously existing elements in the arrays array and seps.

If string is null, the array has no elements. (So this is a portable way to delete an entire array with one statement. See section The delete Statement.)

If string does not match fieldsep at all (but is not null), array has one element only. The value of that element is the original string.

In POSIX mode (see section Command-Line Options), the fourth argument is not allowed.

### sprintf(format, expression1, …)

Return (without printing) the string that printf would have printed out with the same arguments (see section Using printf Statements for Fancier Printing). For example:

pival = sprintf("pi = %.2f (approx.)", 22/7)
assigns the string ‘pi = 3.14 (approx.)’ to the variable pival.

### strtonum(str)
Examine str and return its numeric value. If str begins with a leading ‘0’, strtonum() assumes that str is an octal number. If str begins with a leading ‘0x’ or ‘0X’, strtonum() assumes that str is a hexadecimal number. For example:

$ echo 0x11 |
> gawk '{ printf "%d\n", strtonum($1) }'
-| 17
Using the strtonum() function is not the same as adding zero to a string value; the automatic coercion of strings to numbers works only for decimal data, not for octal or hexadecimal.47

Note also that strtonum() uses the current locale’s decimal point for recognizing numbers (see section Where You Are Makes a Difference).

### sub(regexp, replacement [, target])

Search target, which is treated as a string, for the leftmost, longest substring matched by the regular expression regexp. Modify the entire string by replacing the matched text with replacement. The modified string becomes the new value of target. Return the number of substitutions made (zero or one).

The regexp argument may be either a regexp constant (/…/) or a string constant ("…"). In the latter case, the string is treated as a regexp to be matched. See section Using Dynamic Regexps for a discussion of the difference between the two forms, and the implications for writing your program correctly.

This function is peculiar because target is not simply used to compute a value, and not just any expression will do—it must be a variable, field, or array element so that sub() can store a modified value there. If this argument is omitted, then the default is to use and alter $0.48 For example:

str = "water, water, everywhere"
sub(/at/, "ith", str)
sets str to ‘wither, water, everywhere’, by replacing the leftmost longest occurrence of ‘at’ with ‘ith’.

If the special character ‘&’ appears in replacement, it stands for the precise substring that was matched by regexp. (If the regexp can match more than one string, then this precise substring may vary.) For example:

{ sub(/candidate/, "& and his wife"); print }
changes the first occurrence of ‘candidate’ to ‘candidate and his wife’ on each input line. Here is another example:

$ awk 'BEGIN {
>         str = "daabaaa"
>         sub(/a+/, "C&C", str)
>         print str
> }'
-| dCaaCbaaa
This shows how ‘&’ can represent a nonconstant string and also illustrates the “leftmost, longest” rule in regexp matching (see section How Much Text Matches?).

The effect of this special character (‘&’) can be turned off by putting a backslash before it in the string. As usual, to insert one backslash in the string, you must write two backslashes. Therefore, write ‘\\&’ in a string constant to include a literal ‘&’ in the replacement. For example, the following shows how to replace the first ‘|’ on each line with an ‘&’:

{ sub(/\|/, "\\&"); print }
As mentioned, the third argument to sub() must be a variable, field, or array element. Some versions of awk allow the third argument to be an expression that is not an lvalue. In such a case, sub() still searches for the pattern and returns zero or one, but the result of the substitution (if any) is thrown away because there is no place to put it. Such versions of awk accept expressions like the following:

sub(/USA/, "United States", "the USA and Canada")
For historical compatibility, gawk accepts such erroneous code. However, using any other nonchangeable object as the third parameter causes a fatal error and your program will not run.

Finally, if the regexp is not a regexp constant, it is converted into a string, and then the value of that string is treated as the regexp to match.

substr(string, start [, length ])
Return a length-character-long substring of string, starting at character number start. The first character of a string is character number one.49 For example, substr("washington", 5, 3) returns "ing".

If length is not present, substr() returns the whole suffix of string that begins at character number start. For example, substr("washington", 5) returns "ington". The whole suffix is also returned if length is greater than the number of characters remaining in the string, counting from character start.

If start is less than one, substr() treats it as if it was one. (POSIX doesn’t specify what to do in this case: BWK awk acts this way, and therefore gawk does too.) If start is greater than the number of characters in the string, substr() returns the null string. Similarly, if length is present but less than or equal to zero, the null string is returned.

The string returned by substr() cannot be assigned. Thus, it is a mistake to attempt to change a portion of a string, as shown in the following example:

string = "abcdef"
# try to get "abCDEf", won't work
substr(string, 3, 3) = "CDE"
It is also a mistake to use substr() as the third argument of sub() or gsub():

gsub(/xyz/, "pdq", substr($0, 5, 20))  # WRONG
(Some commercial versions of awk treat substr() as assignable, but doing so is not portable.)

If you need to replace bits and pieces of a string, combine substr() with string concatenation, in the following manner:

string = "abcdef"
…
string = substr(string, 1, 2) "CDE" substr(string, 6)

### tolower(string)
Return a copy of string, with each uppercase character in the string replaced with its corresponding lowercase character. Nonalphabetic characters are left unchanged. For example, tolower("MiXeD cAsE 123") returns "mixed case 123".

### toupper(string)
Return a copy of string, with each lowercase character in the string replaced with its corresponding uppercase character. Nonalphabetic characters are left unchanged. For example, toupper("MiXeD cAsE 123") returns "MIXED CASE 123".

At first glance, the split() and patsplit() functions appear to be mirror images of each other. But there are differences:

split() treats its third argument like FS, with all the special rules involved for FS.
Matching of null strings differs. This is discussed in FS Versus FPAT: A Subtle Difference.
Matching the Null String
In awk, the ‘*’ operator can match the null string. This is particularly important for the sub(), gsub(), and gensub() functions. For example:

$ echo abc | awk '{ gsub(/m*/, "X"); print }'
-| XaXbXcX
Although this makes a certain amount of sense, it can be surprising.
