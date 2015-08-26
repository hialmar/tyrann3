
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
1001 DATA 35,20,40, 1,15'Rat mutant
1002 DATA 30,25,42, 1,20'Chien-loup
1003 DATA 35,25,44, 2,25'Chacal
1004 DATA 35,30,40, 2,28'Gobelin
1005 DATA 38,35,46, 3,30'Coupe-jarret
1006 DATA 35,30,44, 3,35'Gueux
1007 DATA 38,35,48, 4,37'Rodeur
1008 DATA 45,40,55, 4,37'Spadassin
1009 DATA 25,55,55, 8,18'Ogre
1010 DATA 48,45,58, 6,32'Dothrakhi
1011 DATA 27,65,50, 9,20'Geant
1012 DATA 49,45,60, 5,30'Sauvageon
1013 DATA 55,50,50, 6,20'Lion
1014 DATA 40,65,48, 9,18'Grizzly

1015 DATA 50,40,35, 5,50'Sorcier de Feu
1016 DATA 54,40,30, 6,52'Sombre Pretresse
1017 DATA 56,46,36, 6,54'Moine Fou
1018 DATA 45,50,34, 6,54'Druide-Demon
1019 DATA 56,55,30, 7,58'Esprit Noir
1020 DATA 60,58,44, 7,65'Septon Blanc

1021 DATA 64,60,60, 8,68'Elfe gris
1022 DATA 64,65,70,12,75'Chevalier maudit
1023 DATA 80,80,80,15,45'Marcheur blanc
