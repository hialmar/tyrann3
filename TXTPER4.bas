5 REM Textes de Riverrun (le Conflans))
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
90 REM STORE TP$,"TX-PERS4",S
95 SAVEO "TXPERS4.BIN",A#A000,EO1
100 PING:ZAP:END

10000 REM TEXTES DE EDMURE,...

10001 DATA "* * BIENVENUE DANS LE CONFLANS * *"
10002 DATA "- Je suis Edmure Tully de Riverrun."
10003 DATA "Mon pere, Hoster, est devenu fou."
10004 DATA "Il croit etre revenu dans le temps passe."
10005 DATA "Il ne fait plus confiance a personne."
10006 DATA "Voila une potion qui devrait le guerir."
10007 DATA "Faites la lui boire, s'il vous plait."
10008 DATA "J'espere que ca va marcher."
10009 DATA "Si vous reussissez vous serez les heros du Conflans."
10010 DATA "Bien bien, voici la cle des appartements de Hoster."
10011 DATA "Merci encore pour ce que vous allez tenter."
10012 DATA "Bonne chance."

10013 DATA "Ca a marche ?"
10014 DATA "..."
10015 DATA "Merci beaucoup."
10016 DATA "Vous nous sauvez."
10017 DATA "Vous serez toujours les bienvenus dans le Conflans."
10018 DATA "Et a Riverrun."
10019 DATA ""
10020 DATA ""
10021 DATA ""
10022 DATA ""
10023 DATA ""
10024 DATA ""

11001 DATA "Qui ose me deranger ?"
11002 DATA "Je suis Hoster Tully de Riverrun."
11003 DATA "Vous n'avez rien a faire ici."
11004 DATA "*en criant* Gardes venez arreter ces intrus."
11005 DATA "..."
11006 DATA "Non je n'ai pas soif."
11007 DATA "Arretez, je vous dit que je n'ai pas soif."
11008 DATA "Gloups."
11009 DATA "Que m'arrive-t-il ?"
11010 DATA "Mais qu'ais-je fait ?"
11011 DATA "Je m'excuse pour tout le mal que j'ai cause."
11012 DATA "Voila la cle de la prison, faites-en sortir mon frere s'il vous plait."

11013 DATA ""
11014 DATA ""
11015 DATA ""
11016 DATA ""
11017 DATA ""
11018 DATA ""
11019 DATA ""
11020 DATA ""
11021 DATA ""
11022 DATA ""
11023 DATA ""
11024 DATA ""

12001 DATA "* * BIENVENUE DANS LE CONFLANS * *"
12002 DATA "Je suis prisonnier !"
12003 DATA "patati et patata...."
12004 DATA ""
12005 DATA "patati et patata...."
12006 DATA ""
12007 DATA "patati et patata...."
12008 DATA ""
12009 DATA "patati et patata...."
12010 DATA ""
12011 DATA "patati et patata...."
12012 DATA "ALLEZ VOIR Num 10"

12013 DATA "MERCI"
12014 DATA ""
12015 DATA ""
12016 DATA ""
12017 DATA ""
12018 DATA ""
12019 DATA ""
12020 DATA ""
12021 DATA ""
12022 DATA ""
12023 DATA ""
12024 DATA ""













