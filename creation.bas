1  REM {+++++++ ORIC - TYRANN 3 - janvier 2014 +++++++++++}
5  PAPER0:INK7:HIRES:LOAD"ZINTRO.BIN":POKE 48035,0
10 POKE#26A,PEEK(#26A) AND 254 'Vire le curseur
13 PRINT:PRINT SPC(10);" TYRANN 3 ORIC"
15 WAIT500:PRINT SPC(12);" < ESPACE >"
18 IF KEY$<>" " THEN 18
19 A=DEEK(#308):R=RND(-A)
20 TEXT:CLS:INK3
30 PRINT CHR$(17);CHR$(20):REM +++ EFFACE CURSEUR ET CAPS
40 PRINTSPC(2);CHR$(4);CHR$(27);"JMAXIMUS et HIALMAR ";CHR$(27)"BPRESENTENT"
50 PRINT:PRINT:PRINT
60 PRINTSPC(12);CHR$(27);"A";CHR$(27)"JTYRANN 3";CHR$(4)
70 PRINT:PRINT:PRINT
80 PRINT "   "CHR$(27);"E";CHR$(96)" RENDEZ VOUS A WESTEROS":PRINT
90 A$=CHR$(126):B$=CHR$(255)
100 LP$=B$:FORI=1TO34:LP$=LP$+B$:NEXTI
110 L$=B$:FORI=1TO33:L$=L$+B$:NEXTI:L$=L$+B$
120 PRINT LP$
130 PRINT B$;SPC(33);B$
140 PRINT B$;"   Vous avez survecu a Tyrann 1  ";B$
150 PRINT B$;SPC(33);B$
160 PRINT B$;"   Vous avez vaincu Nargaloth    ";B$
170 PRINT B$;SPC(33);B$
180 PRINT L$
190 PRINT B$;SPC(33);B$
200 PRINT B$;"  Par les Sept ! survivrez vous  ";B$
210 PRINT B$;SPC(33);B$
220 PRINT B$;SPC(33);B$
230 PRINT B$;"     a ce qui vient du Nord      ";B$
240 PRINT B$;SPC(33);B$
250 PRINT LP$
255 WAIT300:PLOT 28,24," ESPACE >"
260 GETA$:IF A$<>" " THEN 260
270 PRINT CHR$(17);CHR$(20)

280 SEARCH "TEAM.BIN"
290 IF EF=1 THEN 30000

300 REM ++++++++++ CREATION DES PERSONNAGES ++++++++++++
305 GOSUB 1800:REM ++++ MESSAGE INFO ++++
310 DEF FNA(X)=INT(RND(1)*X)+1:D=10:REM ++ CREATION du D� 10 faces (D10) ++
320 FORI=1TO6:READ C$(I):NEXTI:REM ++ Carrieres ++
330 FORI=1TO8:READ M$(I),CR$(I):NEXTI:REM ++ Maisons M$ et COURONNES CR$ ++
340 READ M$(9):REM +++ >  PAS DE MAISON - choix des roturiers +++
350 FOR I=1TO6:READ CAR$(I):NEXTI:REM +++ 6 CARACTERISTIQUES principales +++ 
360 FOR C=1TO6:FORB=1TO6:READ BC(C,B):NEXT B, C:REM ++ Bonus des carrieres ++

370 FOR P=1TO6:REM +++++++  6 PERSOS , LA VARIABLE P EST r�serv�e +++++++++
380 FOR I=1TO6:SAD(P,I)=0:NEXTI:REM ++ INITIALISE LE SAC A DOS
400 CLS:PRINT:PRINTSPC(12);CHR$(4);CHR$(27)"JTYRANN 3";CHR$(4)
410 PRINT
420 PRINT:S$=" ******* CREATION PERSONNAGES ****** ":GOSUB 1900:PRINT
422 IF P=1 THEN 430
423 S$="Equipe: ":GOSUB 1950:PRINT:T=P-1
424  FORI=1TO T:PRINT I;C$(CP(I));:S$=N$(I)
426 PRINT @15,I+8;S$:IF MP(I)<9 THEN PRINT @26,I+8;M$(MP(I))
429 NEXT
430 PRINT:S$="PRENOM DU PERSONNAGE No"+STR$(P)+" ":GOSUB 1950
435 INPUTN$(P)
440 IFLEN(N$(P))>10THENN$(P)=LEFT$(N$(P),10)
445 GOSUB 1100
450 N=9:S$=N$(P):X=0:GOSUB15000
460 PRINT @6,15;" QUELLE MAISON ? ";
470 GET M$:IFVAL(M$)<1ORVAL(M$)>9THEN 470
480 MP(P)=VAL(M$):PRINT M$(MP(P))
490 GOSUB 1000:IF OK$="N" THEN 450
500 S$=N$(P):IF MP(P)<9 THEN S$=S$+" "+M$(MP(P))
505 N=6:X=1:GOSUB 15000
510 PRINT @6,13;"QUELLE CARRIERE ? ";
520 T=1:NI(P)=1
530 GETC$:IFVAL(C$)<1ORVAL(C$)>6THEN 530
540 C=VAL(C$):CP(P)=C:PRINT C$(CP(P))
550 GOSUB 1000:IF OK$="N" THEN 500

600 REM ++++++++ TIRAGE DES CARACTERISTIQUES + BONUS CARRIERE +++++++
605 IF MP(P)=8 THEN M$="" ELSE M$=M$(MP(P))
610 CLS:S$=" "+N$(P)+" "+M$+" "+C$(CP(P))+" ":GOSUB1950
620 S$=" LANCER de DES <espace> ":GOSUB1900
625 PRINTCHR$(145)" Essai:"T" ";CHR$(144):PRINT
630 S$="CC:"+CAR$(1)+">":GOSUB1900:GOSUB19000:GOSUB 20010:CC(P)=D1+D2+20+BC(CP(P),1):PRINT@26,4;CC(P):PRINT
640 S$="CT:"+CAR$(2)+" > ":GOSUB1900:GOSUB19000:GOSUB 20010:CT(P)=D1+D2+20+BC(CP(P),2):PRINT@26,6;CT(P):PRINT
650 S$="FO:"+CAR$(3)+" > ":GOSUB1900:GOSUB19000:GOSUB 20010:FO(P)=D1+D2+20+BC(CP(P),3):PRINT@26,8;FO(P):PRINT
670 S$="AG:"+CAR$(4)+" > ":GOSUB1900:GOSUB19000:GOSUB 20010:AG(P)=D1+D2+20+BC(CP(P),5):PRINT@26,10;AG(P):PRINT
680 S$="QI:"+CAR$(5)+" > ":GOSUB1900:GOSUB19000:GOSUB 20010:IN(P)=D1+D2+20+BC(CP(P),6):PRINT@26,12;IN(P):PRINT
690 S$="FM:"+CAR$(6)+" > ":GOSUB1900:GOSUB19000:GOSUB 20010:FM(P)=D1+D2+20+BC(CP(P),7):PRINT@26,14;FM(P):PRINT
700 PV(P)=INT((FO(P)*2)/10)+4+FNA(3):IF CP(P)<4 THEN PV(P)=PV(P)+CP(P)
710 ET(P)=PV(P)
760 XP(P)=1:CA(P)=10:OK(P)=1
780 RI(P)=FNA(100)+200:WAIT100: REM ++ FIN INITIALISATION

800 REM +++ APPLICATIONS DES MAISONS +++
810 MP=MP(P)
820 IF MP=1 OR MP=2 THEN FO(P)=FO(P)+2:FM(P)=FM(P)+2
830 IF MP=3 OR MP=4 THEN IN(P)=IN(P)+2:RI(P)=RI(P)+150+INT(FNA(200))
840 IF MP=5 OR MP=6 THEN FO(P)=FO(P)+2:PV(P)=PV(P)+2:ET(P)=PV(P)
850 IF MP=7 OR MP=8 THEN AG(P)=AG(P)+2:CC(P)=CC(P)+3
860 IF MP=9 THEN AG(P)=AG(P)+2:CT(P)=CT(P)+2:IN(P)=IN(P)+2
880 CUMUL=CC(P)+CT(P)+FO(P)+AGI(P)+IN(P)+FM(P)
890 GOTO 1500

900 REM PAUSE
910 WAIT 100
920 PRINT @15,24;CHR$(148);"< ESPACE >";CHR$(144):PING
930 A$=KEY$:IF A$="" THEN 930
940 IF A$<>" " THEN 920
950 RETURN

1000 REM OK ?
1010 PING:WAIT 100
1020 PRINT@11,17;CHR$(148)" < OK ? O/N > "CHR$(144)
1030 OK$=KEY$:IF OK$="" THEN 1030
1040 IF OK$<>"N" AND OK$<>"O" THEN 1030
1050 RETURN

1100 REM Mise en minuscule du prenom
1110 S$=N$(P):N$(P)=LEFT$(S$,1)
1120 FORI=2TOLEN(S$)
1130 MI=ASC(MID$(S$,I,1))
1140 IF MI>64 AND MI<91 THEN MI=MI+32
1150 L$=CHR$(MI)
1160 N$(P)=N$(P)+L$
1170 NEXT 
1200 RETURN

1500 CLS:PAPER 0:INK 7
1510 PRINT@10,1;CHR$(138);CHR$(145);" Fiche de ";N$(P)" ";CHR$(144)
1520 PRINT@10,2;CHR$(138);CHR$(145);" Fiche de ";N$(P)" ";CHR$(144)
1530 PRINT@4,4;CHR$(148)" "C$(CP(P))" "CHR$(144)
1540 S$=" CC  CT  Fo  Ag  In  FM  => Cumul "
1550 PRINT@4,7;CHR$(148)S$CHR$(144)
1560 S$=STR$(CC(P))+" "+STR$(CT(P))+" "+STR$(FO(P))+" "+STR$(AG(P))+" "+STR$(IN(P))+" "+STR$(FM(P))+"     "+STR$(CUMUL)
1570 PRINT@5,9;S$:PRINT:PRINT
1580 PRINT@4,12;CHR$(148)" Richesse: "CHR$(144);RI(P);" Cerfs d'argent"
1590 PRINT@4,14;CHR$(148)" PV (Points de Vie): "CHR$(144);PV(P)
1600 IF T=3 THEN 1640
1610 IF T=1 THEN S$="IL VOUS RESTE 2 ESSAIS" ELSE S$="!! DERNIER ESSAI !!"
1620 PRINT@10,18; S$:PRINT
1630 PRINT@6,20; "VOUS GARDEZ CE PERSONNAGE ?...O/N":GOTO1650
1640 PRINT@10,18; "C'ETAIT LE DERNIER ESSAI"
1645 PRINT@15,20;CHR$(148)" < O)K > "CHR$(144)
1650 GETOK$
1660 IF T=3 AND OK$="O" THEN 1700
1670 IFOK$="O"THEN 1700
1680 IFOK$<>"N"THEN 1650
1690 IF T<3 THEN T=T+1:GOTO 600
1700 NEXT P
1750 GOTO 2000

1800 CLS:S$="******* CREATION PERSONNAGES ******* ":GOSUB1900:PRINT:PRINT
1810 PRINT "Vous allez creer 6 personnages, choi- sissez leur un prenom et une famille, ensuite choisissez leur une carriere":PRINT
1820 PRINT "Comme dans tous les jeux de roles,  il faut lancer 2 D10 pour definir les 8 caracteristiques principales":PRINT
1830 PRINT "Evidemment les carrieres modifient les tirages, vous avez 3 essais":PRINT
1840 PRINT @6,16;"Bonne creation d'equipe ! ;-)":PRINT@13 ,20;CHR$(148)"< Espace > "CHR$(144)
1850 GETA$:IFA$<>" " THEN 1850
1860 RETURN

1900 REM +++++++++  TEXTE SUR FOND BLEU +++++++++++++++
1910 PRINTCHR$(148);S$;CHR$(144)
1920 RETURN

1950 REM +++++++++  TEXTE SUR FOND ROUGE +++++++++++++++
1960 PRINTCHR$(145);S$;CHR$(144)
1970 RETURN


1999 REM |======================================================|
2000 REM |>>>>>>>>>>> INITIALISATION & SAUVEGARDE  >>>>>>>>>>>>>|
2001 REM |======================================================|
2010 CLS:GOSUB 5000
2020 A$=KEY$:IF A$="" THEN 2020
2050 S$="   SAUVEGARDES EN COURS - PATIENCE  ":GOSUB 1950
2060 VIL=1:BS=0:FIL=0:SD=0' ni boussole, ni Filet, ni Selle
2100 O1=#A000:POKE O1,0
2101 O1=O1+1:POKEO1,1 'numero de version
2102 O1=O1+1:POKEO1,85'X
2103 O1=O1+1:POKEO1,2'Y
2104 O1=O1+1:POKEO1,S
2105 O1=O1+1:POKEO1,CA
2110 O1=O1+1:POKEO1,VIL
2120 FOR P=1TO6
2130 O1=O1+1:POKEO1,LEN(N$(P))'Longueur du pr�nom
2140 FORJ=1TOLEN(N$(P))
2150 O1=O1+1:POKEO1,ASC(MID$(N$(P),J,1))'stockage du pr�nom
2160 NEXTJ
2170 O1=O1+1:DOKEO1,INT(RI(P)/10)' argent sur 2 octets
2180 O1=O1+2:POKEO1,CP(P):REM ++ Carriere du Personnage
2190 O1=O1+1:POKEO1,MP(P):REM ++ Maison du Personnage
2200 O1=O1+1:POKEO1,CC(P):REM ++ Capacit� de Combat
2210 O1=O1+1:POKEO1,CT(P):REM ++ Capacit� de Tir
2220 O1=O1+1:POKEO1,FO(P):REM ++ Force
2240 O1=O1+1:POKEO1,AG(P):REM ++ Agilit�
2250 O1=O1+1:POKEO1,IN(P):REM ++ Intelligence
2260 O1=O1+1:POKEO1,FM(P):REM ++ Force Mentale
2300 O1=O1+1:POKEO1,PV(P):REM > Points de Vie ou de Blessures
2310 O1=O1+1:POKEO1,ET(P):REM > Etat des PV
2320 O1=O1+1:OK(P)=1:POKEO1,OK(P):REM > Sant�
2330 O1=O1+1:NI(P)=1:POKEO1,NI(P):REM > Niveau du perso
2340 O1=O1+1:XP(P)=0:DOKEO1,XP(P):REM > Experience
2350 O1=O1+2:WR(P)=0:POKEO1,WR(P):REM > ARME DROITE (WEAPON RIGHT)
2360 O1=O1+1:WL(P)=0:POKEO1,WL(P):REM > ARME G (WEAPON LEFT)
2370 O1=O1+1:PT(P)=0:POKEO1,PT(P):REM > PROTECTION
2380 O1=O1+1:CA(P)=0:POKEO1,CA(P):REM > Classe d'armure
2390 O1=O1+1:BT(P)=0:POKEO1,BT(P):REM > BETE (ANIMAL)
2410 FORI=1TO6:O1=O1+1:POKEO1,SAD(P,I):NEXTI:REM Sac � Dos
2415 IF CP(P)>3 THEN FORI=1TO8:O1=O1+1:POKEO1,SN(P,I):NEXT'SORTS
2420 NEXT P
2430 O1=O1+1:POKEO1,BS'Boussole
2440 O1=O1+1:POKEO1,FI'Filet
2445 O1=O1+1:POKEO1,SD'Selle de Dragon
2450 FOR L=1TO9:FOR C=1TO4:O1=O1+1:CLEF(L,C)=0:POKEO1,CLEF(L,C):NEXT C,L:REM Trousseau de clefs
2470 FORI=1TO6:O1=O1+1:POKEO1,IG(I):NEXT' tableau des 6 ingr�dients de la potion
2475 FOR V=1TO9:FORM=1TO5:O1=O1+1:POKEO1,0:NEXT M,V' tableau coffres et combats � 0
2480 O1=O1+1:POKEO1,0'DEdans
2490 O1=O1+1:POKEO1,0'TL

2490 PING
2500 SAVEU "TEAM.BIN",A#A000,EO1
2600 SAVEU "TEAM2.BIN",A#A000,EO1:REM Copie secours

3000 LOAD"VILLE"

5000 REM AFFICHE EQUIPE
5010 CLS:PRINT@8,1;CHR$(145)" * TYRANN 3 - EQUIPE *  "CHR$(144)
5012 L=3:PRINT@3,L;CHR$(145)"PERSONNAGES� MAISON    CARRIERE   "CHR$(144)
5015 PRINT@3,L+1;CHR$(148)" Argent      CC CT Fo Ag In FM PV "CHR$(144):L=5
5020 FOR I=1TO6
5030  IF CP(I)=1 THEN ENC=131
5040  IF CP(I)=2 THEN ENC=135
5050  IF CP(I)=3 THEN ENC=134
5060  IF CP(I)=4 THEN ENC=133
5070  IF CP(I)=5 THEN ENC=132
5080  IF CP(I)=6 THEN ENC=130
5090 PRINT @ 1,L;CHR$(ENC);I;N$(I);:PRINT @ 17,L;M$(MP(I)):PRINT @ 27,L;C$(CP(I))
5100 PRINT @ 4,L+1;STR$(RI(I));" ca"
5130 S$=STR$(CC(I))+STR$(CT(I))+STR$(FO(I))+STR$(AG(I))+STR$(IN(I))+STR$(FM(I))+STR$(PV(I))
5140 PRINT@16,L+1;S$:L=L+3
5200 NEXT I:PRINT@3,L-1;CHR$(148)" Argent      CC CT Fo Ag In FM PV "CHR$(144)
5210 ENC=4
5250 RETURN

15000 REM +++ AFFICHEUR  ++++
15004 CLS:PRINT
15005 PRINT"    ******************************"
15006 T=INT((37-LEN(S$))/2)
15010 PRINT @ T,1;" ";CHR$(145);" ";S$;"  ";CHR$(144)
15030 PRINT"    *                            *"
15040 FOR I=1TON:L=I+2
15045 IF X=0 THEN C$=M$(I) ELSE C$=C$(I)
15050 PRINT @6,L;"*":PRINT @35,L;"*"
15080 PRINT @14,L;I;C$
15130 NEXT I
15140 PRINT"    *                            *"
15150 PRINT"    ******************************"
15200 RETURN

19000 PING
19010 GETA$:IF A$<>" " THEN 19010
19020 RETURN

20000 REM +++ LANCER DE D�s +++
20010 D1=FNA(D):PRINT "D1:";D1;
20020 D2=FNA(D):PRINT "D2:";D2;" = ";D1+D2
20220 RETURN

30000 PRINT "Une sauvegarde existe. Voulez-vous continuer le jeu ? (O/N)"
30010 GETA$:IF A$<>"O" AND A$<>"o" THEN 305
30020 LOAD "VILLE"

50000 DATA Chevalier,Mercenaire,Ranger,Sorcier,Mestre,Septon
50010 DATA MARTELL,DORNE, BARATHEON,STORMLAND, TYRELL,THE REACH, GREYJOY,PIKE
50020 DATA ARRYN,MOUNTAIN & VALE,LANNISTER,WESTERLAND, TULLY,RIVERLAND ,STARK,THE NORTH, AUCUNE
50030 DATA Capacite de Combat, Capacite de Tir, Force
50040 DATA Agilite, Intelligence, Force Mentale

50050 DATA 5,-3,5,0,0,0:REM CHEVALIER
50060 DATA 3,-3,3,0,3,3:REM PALADIN
50070 DATA 5,2,4,4,-2,3:REM RANGER
50090 DATA -4,-5,-3,3,7,6:REM SEPTON
50100 DATA -4,-4,-3,3,6,5:REM MESTRE
50110 DATA -2,-2,0,4,5,7:REM SORCIER

51000 DATA  1,2,1,1,1,1,3,1,3,3,1,1,2,3,1,1,1,1,1,2,2,1,1,1,3
