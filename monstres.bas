
10 REM |====================================================|
20 REM |===============||| MONSTRES |||=====================|
30 REM |====================================================|

35 O1=#A000
40 DIM CM(23,5)
45 POKEO1,23
46 O1=O1+1:POKEO1,5
50 FOR I=1TO23
55  FOR J=1TO 5
60   READ CM(I,J):PRINT CM(I,J);
61   O1=O1+1:POKEO1,CM(I,J)
62  NEXTJ
64  PRINT
66 NEXTI
70 PRINT"SAUVEGARDE DU TABLEAU"
80 REM STORE CM,"T-MONST",S
85 SAVEO "TMONST.BIN",A#A000,EO1 
90 PRINT"CARACS OK":PING:END


999 REM  AGI,PV,CC,BF,QI
1001 DATA 30, 9,25, 1,15
1002 DATA 25,12,28, 1,20
1003 DATA 30,15,30, 1,25
1004 DATA 30,18,32, 1,28
1005 DATA 32,20,35, 2,30
1006 DATA 28,20,36, 2,35
1007 DATA 33,22,36, 2,37
1008 DATA 40,24,40, 2,37
1009 DATA 25,30,30, 2,18

1010 DATA 42,26,44, 3,32
1011 DATA 22,40,42, 3,20 
1012 DATA 44,24,48, 3,30
1013 DATA 50,20,40, 4,20
1014 DATA 35,36,35, 4,18

1015 DATA 42,30,25, 4,50
1016 DATA 46,25,20, 5,52
1017 DATA 46,30,28, 5,54

1018 DATA 42,30,25, 5,50
1019 DATA 46,25,20, 6,52
1020 DATA 46,30,28, 6,56


1021 DATA 50,36,42, 6,55
1022 DATA 42,38,50, 7,55
1023 DATA 45,46,50, 7,30

2000 REM  Rat mutant, Chien-loup, Chacal, Gobelin, Coupe-jarret, Gueux, Rodeur, Spadassin, Ogre
2010 REM  Dothrakhi, Geant, Sauvageon, Lion, Grizzly
2020 REM  Sorcier de Feu, Sombre Pretresse, Moine Fou
2030 REM  Druide-Demon, Esprit Noir, Septon Blanc
2040 REM  Elfe gris, Chevalier maudit, Marcheur blanc 



