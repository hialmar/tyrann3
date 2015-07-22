
10 TEXT:CLS:PAPER0:INK6
30 DIM TPERSO$(3,26)
35 O1=#A000
36 POKEO1,3
40 FOR P=1TO3
45  O1=O1+1:POKEO1,24
50  FOR X=1TO24
60   READ TP$(P,X):PRINT TP$(P,X)
61   LG=LEN(TP$(P,X))
62   O1=O1+1:POKEO1,LG
63   IF LG=0 THEN 70
64   FOR J=1 TO LG
65     O1=O1+1:POKEO1,ASC(MID$(TP$(P,X),J,1))
66   NEXT J
70 NEXT X,P
80 PRINT"SAUVEGARDE DU TABLEAU"
90 REM STORE TP$,"TX-PERS3",S
95 SAVEO "TXPERS3.BIN",A#A000,EO1
100 PING:ZAP:END

10000 REM TEXTES DE JAIME,TYRION,CATELIN

11001 DATA "  * * BIENVENUE A CASTRAL ROCK * *"
11002 DATA " Je suis Tyrion Lannister,le Nain "
11003 DATA "Hum Hum Ned Starck vous envoie !! "
11004 DATA "  Avant de partir a la mort vous  "
11005 DATA "devriez aller voir la rousse... "
11006 DATA "avant de rejoindre les Dieux,   "
11007 DATA "il y a ici bas des moments a ne "
11008 DATA "pas rater. Elle est si savante..."
11009 DATA "  Quant a Catelin Starck,c'est mon"
11010 DATA "frere Jaime qui la retient en   "
11011 DATA "prison, voila le passe pour lui"
11012 DATA "rendre visite, A bientot."

11013 DATA " D abord bravo d'avoir defier et "
11014 DATA "vaincu Jaime, mon frere se pensait"
11015 DATA "invincible, il a appris la modestie"
11016 DATA "grace a vous, j'en suis ravi, Merci"
11017 DATA "Catelin Starck est libre, d ailleurs"
11018 DATA "c est mon pere, Tywin Lannister, qui"
11019 DATA "vous l a dit. Il soutient votre voix"
11020 DATA "et vous le reverrez. "
11021 DATA "Voila la clef de la chapelle, vous y"
11022 DATA "trouverez surement un objet utile a"
11023 DATA "votre mission. Par les 7, je vous"
11024 DATA "souhaite la victoire.. TYRION .."

12001 DATA "Hola vous semblez plutot perdus "
12002 DATA "  C'est grand Castral Roc !!!     "
12003 DATA "  Vous etes chez les Lannister  "
12004 DATA "Peut-etre un peu impressiones !?"
12005 DATA "Bon vous venez pleurer pour que "
12006 DATA "je relache Lady Starck, elle est"
12007 DATA "une invitee, la prison est juste"
12008 DATA "un lieu sur, en fait elle est   "
12009 DATA "libre de partir si vous acceptez"
12010 DATA "de me defier en combat amical   "
12011 DATA "Alors qui se devoue ?"
12012 DATA "Si vous perdez, elle reste !!!  "

12021 DATA "Je m incline, vous m avez vaincu"
12022 DATA "Ned Starck vous a bien choisi !"
12023 DATA "Considerez cette epreuve reussie"
12024 DATA "comme un signe favorable des Dieux"
12025 DATA "qui ont guide votre bras face a la"
12026 DATA "meilleure lame de Westeros..."
12027 DATA "Voila la clef de la chambre de Lady"
12028 DATA "Catelin Starck, mon pere avait de "
12029 DATA "toute facon l intention de me "
12030 DATA "contrer sur cette decision, disons"
12031 DATA "maladroite... On se reverra !"
12032 DATA "- Jaime LANNISTER - Garde Royal -"

13001 DATA "!! Au secours  hommes du nord !!"
13002 DATA "Je suis prisonniere de Jaime qui"
13003 DATA "m'a capture sur la route alors  "
13004 DATA "que je revenais de chez mon pere"
13005 DATA "il veut ainsi attirer Ned dans  "
13006 DATA "un piege pour le faire tuer"
13007 DATA "Pouvez vous me liberer ? je ne  "
13008 DATA "serai pas une ingrate et je vous"
13009 DATA "donnerai quelque chose de tres  "
13010 DATA "utile pour votre quete..."
13011 DATA "Et puis Ned Starck,mon mari sera"
13012 DATA "encore plus reconnaissant !"

13021 DATA "Ho merci valeureuse equipe de m'avoir"
13022 DATA "libere de ce sadique de Regicide ! "
13023 DATA "Je vais aller rejoindre Ned au plus"
13024 DATA "vite pour qu'il vous remercie de vos"
13025 DATA "exploit. J'ai trouve cette clef, je"
13026 DATA "ne sais pas ce qu'elle ouvre, je vous"
13027 DATA "la donne, elle vous sera peut-etre"
13028 DATA "utile. Quant a Tyrion, je suis sur"
13029 DATA "qu'il peut vous aider, il est tres"
13030 DATA "intelligent et plutot noble d esprit"
13031 DATA "prenez cette clef et cette bourse et"
13032 DATA "A bientot j'espere. Catelin Starck .."


















