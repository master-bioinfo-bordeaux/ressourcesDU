Solution: Où suis-je?     
Exercice
A partir du diagramme ci-dessous, si la commande pwd affiche /Users/thing, qu'affiche la commande ls ../backup [ choix 1,2,3,4]?

../backup: No such file or directory
2021-12-01 2022-01-08 2022-01-27
2021-12-01/ 2022-01-08/ 2022-01-27/
original pnas_final pnas_sub
La bonne solution est la 4. Pour comprendre, comment cela fonctionne, on va remplacer la commande ls par cd (change directory). Vous êtes au départ dans /Users/thing, si vous faites cd .., vous "remontez" dans /Users, puis cd backup, vous "redescendez" dans le répertoire backup/. Ce que vous listez est donc les trois répertoires original, pnas_final et pnas_sub.



Source: https://datacarpentry.org/shell-genomics/02-the-filesystem/index.html
Table de contenu
Contenu 1:	Return
Aller 1:	Exercice: Où suis-je?
Importer des questions | Ajouter une page de contenu | Ajouter un groupe | Ajouter une fin de branchement | Ajouter une fin de groupe | Ajouter une page question ici
Solutions seq     
Il existe une commande seq qui génère automatiquement une série de nombres entiers

Pour avoir la documentation de cette commande, pensez à utiliser l'argument --help

# seq --help
Question 1: Générer une série de nombres de 1 à 10.
seq 10
Question 2: Générer une série de nombres de 10 à 20
seq 10 20
Question 3: Générer les nombres pairs de 0 à 10 inclus
seq 0 2 10

Question 4: Générer les nombres impairs de 0 à 10 inclus en une seule ligne séparée par des virgules
seq -s "," 1 2 10
ou avec un argument long...

seq --separator="," 1 2 10
Question 4: Générer les nombres multiples de 13 de 0 à 100 avec un (ou plusieurs zéros devant)
seq -w 0 13 100
