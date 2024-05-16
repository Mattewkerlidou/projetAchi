# Avertissement

Ce projet est à faire en binôme et à rendre en 2 semaines. Toute tentative de fraude avérée sera sanctionnée par un 0 pour le binôme "copieur" et par une division de la note par 2 pour le binôme "copié". Dans le cas où il est impossible de déterminer qui a copié sur qui, les 2 binômes se verront attribuer un 0.

## Introduction

Le circuit `projet.circ` est celui d’un microprocesseur qui a les caractéristiques suivantes :

- Instructions sur 32 bits
- Code opératoire sur 16 bits. Adresses ou données sur 16 bits
- Les données sortantes de l’ALU peuvent être stockées dans un des quatre registres 16 bits (A, B, SI ou DI) ou dans une RAM des données.
- L’entrée I0 de l’UAL peut prendre ses données soit à partir du Registre A, soit depuis le champ DATA ou Adresse du code de l’instruction et ceci en fonction de la valeur du bit MUX0.
- L’entrée I1 de l’UAL peut prendre ses données soit à partir du Registre B, soit à partir du Registre SI, soit à partir du registre DI, soit à partir de la RAM des données en fonction de la valeur des 2 bits de contrôle du MUX1 conformément à la table ci-dessous :

  | Bits de contrôle du MUX1 | Registre sélectionné |
  |--------------------------|----------------------|
  | 0 0                      | B                    |
  | 0 1                      | SI                   |
  | 1 0                      | DI                   |
  | 1 1                      | RAM des données      |
- Le circuit comporte un décodeur permettant de choisir le registre où sera écrit le résultat de l’UAL selon la table ci-dessous :

  | Bits de contrôle du décodeur | Registre sélectionné |
  |------------------------------|----------------------|
  | 0 0 0                        | Aucun                |
  | 0 0 1                        | A                    |
  | 0 1 0                        | B                    |
  | 0 1 1                        | SI                   |
  | 1 0 0                        | DI                   |
  | 1 0 1                        | RAM des données      |
  | 1 1 0                        | Aucun                |
  | 1 1 1                        | Aucun                |
- Ce circuit comporte 2 mémoires : une pour les instructions et une autre pour les données. Il est fait de telle sorte qu’il supporte un adressage indirect à partir des registres SI et DI, c’est-à-dire qu’il est possible d’utiliser une donnée (de la mémoire des données) dont l’adresse se trouve soit dans le registre SI soit dans le registre DI en fonction de la valeur du bit MUX2.

## Question 1

Charger le fichier `projet.circ`. Analysez le circuit et aidez-vous des TPs précédents pour comprendre son fonctionnement. Il n’existe pas de fichiers PROJET.MAD et PROJET.PAR, c’est à vous de les créer en utilisant le logiciel MAG. Commencez par créer les instructions suivantes :

| Instruction    | Description                                                                                                                                  |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| LOADA #valeur  | Charge dans le registre A, la valeur immédiate qui suit                                                                                      |
| LOADSI #valeur | Charge dans le registre SI, la valeur immédiate qui suit                                                                                     |
| LOADADI        | Copie dans le registre A, le contenu du registre DI                                                                                          |
| LOADAADRSI     | Charge dans le registre A, la donnée de la RAM des données dont l’adresse se trouve dans le registre SI                                      |
| LOADBADRDI     | Charge dans le registre B, la donnée de la RAM des données dont l’adresse se trouve dans le registre DI                                      |
| LOADDIADRSI    | Charge dans le registre DI, la donnée de la RAM des données dont l’adresse se trouve dans le registre SI                                     |
| INCSI          | Incrémente SI de 1                                                                                                                           |
| DECDI          | Décrémente DI de 1                                                                                                                           |
| CMPSIA         | Compare SI et A et met à jour les indicateurs en conséquence (l’UAL fait en interne la soustraction SI-A pour mettre à jour les indicateurs) |
| CMPBA          | Compare B et A et met à jour les indicateurs en conséquence (l’UAL fait en interne la soustraction B-A pour mettre à jour les indicateurs)   |
| JMP <label>    | Effectue un saut inconditionnel à l’instruction étiquetée par <label>                                                                        |
| JMPNZ <label>  | Effectue un saut à l’instruction étiquetée par <label> si le résultat de l’instruction précédente n’est pas nul                              |
| JMPPZ <label>  | Effectue un saut à l’instruction étiquetée par <label> si le résultat de l’instruction précédente n’est pas négatif (positif ou nul)         |

## Question 2

En utilisant uniquement les instructions précédentes, écrire un programme en assembleur, palin.asm, qui vérifie si la chaîne présente dans la mémoire des données est un palindrome. La première case de la RAM des données contiendra la longueur de la chaîne. Les cases suivantes contiendront les codes ASCII des caractères de la chaîne. Le programme devra mettre à la fin dans le registre A la valeur 1 si le mot est un palindrome et la valeur -1 si ce n’est pas un palindrome.

Votre programme devra obligatoirement se terminer par l’instruction suivante : fin JMP fin.

Votre programme ne devra pas dépasser plus de 17 instructions. Toute instruction supplémentaire entraînera un malus de -0,5 pts. Si votre programme fonctionne parfaitement (dans tous les cas) avec moins de 17 instructions vous recevrez un bonus de +0,5 pts par instruction économisée.

Vérifiez la bonne définition de vos instructions et le bon fonctionnement de votre programme dans LOGISIM.

On veillera à avoir un jeu d’essai le plus complet possible (mot vide, mot d’1 seul lettre, mot avec un nombre pair de lettres, mot avec un nombre impair de lettres, …). On considérera qu’un mot vide est un palindrome.

## Question 3

Ajoutez à vos fichiers PROJET.MAD et PROJET.PAR les instructions suivantes :

| Instruction  | Description                                                                                                                                                                |
|--------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| LOADASI      | Copie dans le registre A, le contenu du registre SI                                                                                                                        |
| LOADBADRSI   | Charge dans le registre B, la donnée de la RAM des données dont l’adresse se trouve dans le registre SI                                                                    |
| LOADADRSIB   | Copie le contenu du registre B, dans la RAM des données à l’adresse indiquée par le registre SI                                                                            |
| CMPDIA       | Compare DI et A et met à jour les indicateurs en conséquence (l’UAL fait en interne la soustraction DI-A pour mettre à jour les indicateurs)                               |
| CMPB #valeur | Compare B et la valeur immédiate qui suit et met à jour les indicateurs en conséquence (l’UAL fait en interne la soustraction B-valeur pour mettre à jour les indicateurs) |
| SUBB #valeur | Effectue la soustraction B – valeur et stocke le résultat dans B                                                                                                           |
| JMPN <label> | Effectue un saut à l’instru                                                                                                                                                |

## Question 4

En utilisant uniquement les instructions ci-dessous :

| Instruction                                                                                                        |            |              |               |
|--------------------------------------------------------------------------------------------------------------------|------------|--------------|---------------|
| LOADSI #valeur                                                                                                     | LOADBADRSI | CMPB #valeur | JMP <label>   |
| LOADASI                                                                                                            | LOADADRSIB | SUBB #valeur | JMPN <label>  |
| LOADDIADRSI                                                                                                        | CMPDIA     | INCSI        | JMPPZ <label> |


 écrire un programme en assembleur, maj.asm, qui modifie les lettres minuscules de la chaîne présente dans la       
 mémoire des données en lettres majuscules. La première case de la RAM des données contiendra la longueur de        
 la chaîne. Les cases suivantes contiendront les codes ASCII des caractères de la chaîne (voir table des caractères 
 à la fin du document).                                                                                             
 Votre programme devra obligatoirement se terminer par l’instruction suivante : fin JMP fin                         
 Votre programme ne devra pas dépasser plus de 16 instructions. Toute instruction supplémentaire entraînera un      
 malus de -0,5 pts. Si votre programme fonctionne parfaitement (dans tous les cas) avec moins de 16                 
 instructions vous recevrez un bonus de +0,5 pts par instruction économisée.                                        
 Vérifiez la bonne définition de vos instructions et le bon fonctionnement de votre programme dans LOGISIM.         
 On veillera à avoir un jeu d’essai le plus complet possible (chaîne mixant des lettres minuscules, majuscules,     
 chiffres, caractères spéciaux, …).                                                                                 
