
10 TEXT:CLS:PAPER0:INK6
20 DIM IP$(10,2)
35 O1=#A000
36 POKEO1,10
40 FOR VIL=1TO10
45  O1=O1+1:POKEO1,2
50  FOR P=1TO2
60   READ IP$(VIL,P):PRINT IP$(VIL,P);" ";VIL;P;
61   LG=LEN(IP$(VIL,P))
62   O1=O1+1:POKEO1,LG
63   IF LG=0 THEN 70
64   FOR J=1 TO LG
65     O1=O1+1:POKEO1,ASC(MID$(IP$(VIL,P),J,1))
66   NEXT J
70 NEXT P,VIL
80 PRINT"SAUVEGARDE DU TABLEAU"
90 REM STORE IP$,"T-IMG-P",S
95 SAVEO "TIMGP.BIN",A#A000,EO1
100 PRINT"> Images de Personnages OK":PING:ZAP:END

1000 REM IMAGES DES PERSOS 
1001 DATA "PORTR05.DAT","PORTR19.DAT"
1002 DATA "PORTR18.DAT","PORTR11.DAT"
1003 DATA "PORTR17.DAT","PORTR16.DAT"
1004 DATA "PORTR14.DAT","PORTR01.DAT"
1005 DATA "PORTR13.DAT","PORTR12.DAT"
1006 DATA "PORTR07.DAT","PORTR10.DAT"
1007 DATA "PORTR02.DAT","PORTR08.DAT"
1008 DATA "PORTR15.DAT","PORTR03.DAT"
1009 DATA "PORTR09.DAT","PORTR06.DAT"
1010 DATA "PORTR04.DAT","DAENY.DAT"






















