5 REM Textes de Highgarden (le Bief)
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
90 REM STORE TP$,"TX-PERS5",S
95 SAVEO "TXPERS5.BIN",A#A000,EO1
100 PING:ZAP:END

10000 REM TEXTES DE LORAS,...

10001 DATA "* * BIENVENUE DANS HIGHGARDEN * *"
10002 DATA "- Je suis Loras Tyrell du Bief"
10003 DATA "bla bla bla...."
10004 DATA "bla bla bla...."
10005 DATA "bla bla bla...."
10006 DATA "bla bla bla...."
10007 DATA "bla bla bla...."
10008 DATA "patati et patata...."
10009 DATA "patati et patata...."
10010 DATA "patati et patata...."
10011 DATA "patati et patata...."
10012 DATA "VOILA LA CLEF DE MAERGERY"

10013 DATA ""
10014 DATA ""
10015 DATA ""
10016 DATA ""
10017 DATA ""
10018 DATA ""
10019 DATA ""
10020 DATA ""
10021 DATA ""
10022 DATA ""
10023 DATA ""
10024 DATA ""

11001 DATA "* * BIENVENUE DANS HIGHGARDEN * *"
11002 DATA "- Je suis Maergery Tyrell"
11003 DATA "bla bla bla...."
11004 DATA "patati et patata...."
11005 DATA "bla bla bla...."
11006 DATA "patati et patata...."
11007 DATA "bla bla bla...."
11008 DATA "patati et patata...."
11009 DATA "bla bla bla...."
11010 DATA "patati et patata...."
11011 DATA "bla bla bla...."
11012 DATA " VOILA LA CLEF DE LA PRISON"

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

12001 DATA "* * BIENVENUE DANS HIGHGARDEN * *"
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













