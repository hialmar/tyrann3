10 TEXT:CLS:PAPER 0:INK3:POKE48035,0:POKE#26A,PEEK(#26A)AND254
20 S$="EDITEUR DE PERSONNAGE":GOSUB 1000:PRINT@8,4;S$
30 GOSUB 40000
100 REM EQUIPE
110 CLS:PRINT@8,1;CHR$(145)CHR$(128)" * TYRANN 3 - EQUIPE *  "CHR$(144)
120 L=3:PRINT@3,L;CHR$(145)CHR$(128)"PERSONNAGES  MAISON   CARRIERE NIV "CHR$(144)
130 PRINT@3,L+1;CHR$(148)CHR$(128)" Argent     CC CT Fo Ag In FM PV  "CHR$(144):L=5:TE=0
140 FORI=1TO6
150  IFCP(I)=1THENENC=131
160  IFCP(I)=2THENENC=135
170  IFCP(I)=3THENENC=134
180  IFCP(I)=4THENENC=133
190  IFCP(I)=5THENENC=132
200  IFCP(I)=6THENENC=130
210  PRINT@1,L;CHR$(ENC);I;N$(I);:PRINT@17,L;M$(MP(I)):PRINT@27,L;C$(CP(I))
220  PRINT@37,L;NI(I)
230  PRINT@4,L+1;STR$(RI(I));" ca"
240  S$=STR$(CC(I))+STR$(CT(I))+STR$(FO(I))+STR$(AG(I))+STR$(IN(I))+STR$(FM(I))+STR$(PV(I))
250  PRINT@16,L+1;S$:L=L+3:TE=TE+RI(I)
260 NEXTI:PRINT@3,L-1;CHR$(148);CHR$(128)" Argent     CC CT Fo Ag In FM PV   "CHR$(144)
290 EN=4
350 S$="EDITER QUEL HEROS (1-6) ?":GOSUB 2000:PRINT@7,23;S$
355 S$="Sauvegarder: 0":GOSUB 1000:PRINT@10,24;S$
360 GOSUB 3000:IF P=0THEN GOSUB30000:GOTO100
400 CLS:L=23:GOSUB 10000'menu edition
430 PRINT@6,3;"Prenom:  ";N$(P)
440 PRINT@6,5;"Famille: ";M$(MP(P))
440 PRINT@6,7;"Carriere:";C$(CP(P))
450 PRINT@6,9;"Niveau:";NI(P)
450 PRINT@6,11;"Points de Vie:";PV(P)
460 PRINT@6,13;"Bourse:";RI(P)"c.a"
471 PRINT@6,15;"Capacite Combat:";CC(P)
472 PRINT@6,16;"Capacite de Tir:";CT(P)
473 PRINT@6,17;"Force .........:";FO(P)
474 PRINT@6,18;"Agilite .......:";AG(P)
475 PRINT@6,19;"Intelligence ..:";IN(P)
476 PRINT@6,20;"Force Mentale..:";FM(P)
500 S$="Fleches ou Q)uitter":GOSUB1000:PRINT@4,22;S$
510 S$="M)odif":GOSUB1000:MO$=S$
520 S$="<- +>":GOSUB1000:FLECHE$=S$
600 REM EDITION
610 X=26:LI=3:UP=0:L=1
620 REPEAT
630  PRINT@4,LI;"=>":IFLI<8THEN PRINT@X,LI;MO$ ELSE PRINT@X,LI;FLECHE$
640  GETA$
650  IFA$<>"M"ANDA$<>"Q"ANDASC(A$)<8ANDASC(A$)>11THEN640
660  IF(A$="M"ANDLI>7)OR((ASC(A$)=8ORASC(A$)=9)ANDLI<8)THEN640
670  PRINT@4,LI;"  ":PRINT@X,LI;"         "
680  IFASC(A$)=10THENUP=0:GOSUB4000:GOTO630
690  IFASC(A$)=11THENUP=1:GOSUB4000:GOTO630
720 UNTIL (LI<8ANDA$="M")ORA$="Q"OR(LI>7AND(ASC(A$)=8ORASC(A$)=9))
730 IFA$="Q"THEN100
790 PRINT@4,LI;"=>":IFLI<4THEN PRINT@X,LI;MO$ ELSE PRINT@X,LI;FLECHE$
800 IFLI<14 THEN ON L GOSUB 6000,6200,6300,6400,6500,6600
810 IFLI>14 THEN GOSUB 6700
890 IFL<4THEN400ELSE620
1000 REM FOND BLEU 
1010 S$=" "+CHR$(148)+CHR$(131)+S$+CHR$(131)+CHR$(144)+" "
1020 RETURN
2000 REM FOND ROUGE
2010 S$=" "+CHR$(145)+CHR$(135)+S$+CHR$(131)+CHR$(144)
2020 RETURN
3000 GETA$:P=VAL(A$):IFP>6THENPING:GOTO 3000
3010 RETURN
3500 S$="< ESPACE > ":GOSUB2000:PRINT@13,L;S$:GETA$:IF A$<>" "THEN3500
3501 RETURN
4000 REM descend ou monte
4010 IFUP=1THEN 4050
4015   L=L+1
4020   IFLI<14THENLI=LI+2ELSELI=LI+1
4030   IFL=13THENLI=3:L=1
4040   GOTO4100
4050   L=L-1
4060 IF LI>15THENLI=LI-1ELSELI=LI-2
4070 IF L=0THENLI=20:L=12
4100 RETURN
6000 PRINT@22,4;"=>";:INPUTN$(P):PING
6010 IFLEN(N$(P))<2THENZAP:GOTO 6000
6020 IFLEN(N$(P))>10THENN$(P)=LEFT$(N$(P),10)
6030 NN$=N$(P):N$(P)=LEFT$(NN$,1)' Mise en minuscule du prLENnom
6040 FORI=2TOLEN(NN$)
6050 MI=ASC(MID$(NN$,I,1))
6060 IF MI>64 AND MI<91 THEN MI=MI+32
6070 L$=CHR$(MI)
6080 N$(P)=N$(P)+L$
6090 NEXT 
6095 PRINT@22,4;"            "
6100 RETURN
6200 REM MAISON
6210 FORI=1TO9
6220 PRINT@25,4+I;I;M$(I):NEXT
6230 GETM$:M=VAL(M$):IFM<1ORM>9THENZAP:GOTO6230
6240 MP(P)=M:PING
6250 RETURN
6300 REM CARRIERE
6310 FORI=1TO6
6320 PRINT@25,6+I;I;C$(I):NEXT
6330 GETM$:C=VAL(M$):IFC<1ORC>6THENZAP:GOTO6330
6340 CP(P)=C:PING
6350 RETURN
6400 REM NIVEAU
6420 'REPEAT
6430 CPT=NI(P):MAX=8:MIN=1:BO=1:GOSUB 7000
6440 NI(P)=CPT
6450 PRINT@13,9;NI(P)
6460 'UNTIL ASC(A$)=10ORASC(A$)=11
6490 RETURN
6500 REM PV
6520 'REPEAT
6530 CPT=PV(P):MAX=99:MIN=1:BO=1:GOSUB 7000
6540 PV(P)=CPT
6550 PRINT@20,11;PV(P)
6560 'UNTIL ASC(A$)=10ORASC(A$)=11
6560 ET(P)=CPT
6590 RETURN
6600 REM ARGENT
6620 'REPEAT
6630 CPT=RI(P):MAX=90000:MIN=1000:BO=1000:GOSUB 7000
6650 RI(P)=CPT
6660 PRINT@14,13;RI(P)"c a "
6670 PING
6680 'UNTIL ASC(A$)=10ORASC(A$)=11
6690 RETURN
6700 REM CARACS
6720 'REPEAT
6730 ON LI-14 GOTO 6740,6750,6760,6770,6780,6790
6740 CPT=CC(P):GOTO6800
6750 CPT=CT(P):GOTO6800
6760 CPT=FO(P):GOTO6800
6770 CPT=AG(P):GOTO6800
6780 CPT=IN(P):GOTO6800
6790 CPT=FM(P)
6800 MAX=99:MIN=1:BO=1:GOSUB 7000
6805 ON LI-14 GOTO 6810,6820,6830,6840,6850,6860
6810 CC(P)=CPT:GOTO6865
6820 CT(P)=CPT:GOTO6865
6830 FO(P)=CPT:GOTO6865
6840 AG(P)=CPT:GOTO6865
6850 IN(P)=CPT:GOTO6865
6860 FM(P)=CPT
6865 PRINT@22,LI;CPT
6870 PING
6880 'UNTIL ASC(A$)=10ORASC(A$)=11
6890 RETURN
7000 REM incrementeur
7010 'GETA$:IFASC(A$)<8ORASC(A$)>11THENZAP:GOTO7010
7015 IFASC(A$)=10ORASC(A$)=11THENRETURN
7020 IFASC(A$)=9THEN CPT=CPT+BO ELSE CPT=CPT-BO
7030 IF CPT > MAX THEN CPT=MAX
7040 IF CPT < MIN THEN CPT=MIN
7100 RETURN
9000 END 
10000 CLS:PRINT
10020 PRINT" ************************************"
10030 FORI=1TOL:PRINT@2,I;"*":PRINT@38,I;"*":NEXTI
10080 PRINT@2,I;"*************************************"
10100 RETURN
30000 REM SAUVEGARDE
30010 PRINT@5,24;"SUR DE SAUVEGARDER (O/N) ?"
30020 A$=KEY$:IFA$=""THEN30020
30030 IFA$<>"O"THEN 100
30040 ZAP:GOSUB 49000
30050 RETURN
40000 FORI=1TO6:READ C$(I):NEXTI
40005 FORI=1TO9:READ M$(I):NEXTI:
40010 DIM CB(20),IT$(48)
40020 'RECALL IT$,"T-ITEMS",S
40030 PRINT@5,24;"INSEREZ LA DISQUETTE PRINCIPALE"
40040 PRINT@5,25;"DANS LE LECTEUR ET TAPEZ ESPACE"
40050 IF KEY$<>" " THEN 40050
48000 GOSUB49600
48005 LOAD"TEAM.BIN"
48010 O1=#A000
48011 O1=O1+1:VIL=PEEK(O1)
48012 REM PRINT"Version " VIL 
48013 O1=O1+1:X=PEEK(O1)
48014 O1=O1+1:Y=PEEK(O1)
48015 O1=O1+1:S=PEEK(O1)
48016 O1=O1+1:CA=PEEK(O1)
48017 O1=O1+1:VIL=PEEK(O1)
48018 REM PRINT"Ville " VIL "X " X "Y " Y "S " S "CA " CA
48020 FOR P=1TO6
48030 O1=O1+1:DD=PEEK(O1)
48040 FORJ=1TODD:O1=O1+1:N$(P)=N$(P)+CHR$(PEEK(O1)):NEXTJ
48050 O1=O1+1:RI(P)=DEEK(O1)*10:O1=O1+2:CP(P)=PEEK(O1)
48056 O1=O1+1:MP(P)=PEEK(O1)
48060 O1=O1+1:CC(P)=PEEK(O1)
48070 O1=O1+1:CT(P)=PEEK(O1)
48080 O1=O1+1:FO(P)=PEEK(O1)
48100 O1=O1+1:AG(P)=PEEK(O1)
48110 O1=O1+1:IN(P)=PEEK(O1)
48120 O1=O1+1:FM(P)=PEEK(O1)
48130 O1=O1+1:PV(P)=PEEK(O1)::GOSUB49650
48140 O1=O1+1:ET(P)=PEEK(O1)
48150 O1=O1+1:OK(P)=PEEK(O1)
48160 O1=O1+1:NI(P)=PEEK(O1)
48170 O1=O1+1:XP(P)=DEEK(O1)
48180 O1=O1+2:WR(P)=PEEK(O1)
48190 O1=O1+1:WL(P)=PEEK(O1)
48200 O1=O1+1:PT(P)=PEEK(O1)
48210 O1=O1+1:CA(P)=PEEK(O1)
48220 O1=O1+1:BT(P)=PEEK(O1)
48230 FORI=1TO6:O1=O1+1:SAD(P,I)=PEEK(O1):NEXTI
48235 IF CP(P)>3 THEN FORI=1TO8:O1=O1+1:SN(P,I)=PEEK(O1):NEXT
48240 GOSUB49650:NEXT P
48250 O1=O1+1:BS=PEEK(O1)
48260 O1=O1+1:FI=PEEK(O1)
48265 O1=O1+1:SD=PEEK(O1):GOSUB49650
48270 FOR V=1TO9:FOR C=1TO4:O1=O1+1:CL(V,C)=PEEK(O1):NEXT C,V
48290 FOR I=1TO6:O1=O1+1:IG(I)=PEEK(O1):NEXT
48296 FOR V=1TO9:FORM=1TO5:O1=O1+1:TC(V,M)=PEEK(O1):NEXT M,V
48297 O1=O1+1:DE=PEEK(O1):GOSUB49650
48298 O1=O1+1:TL=PEEK(O1):'PRINT "TL";TL:REM FR = FRE("")
48310 O1=O1+1:NP=PEEK(O1)
48320 O1=O1+1:NF=PEEK(O1)
48330 O1=O1+1:PM=PEEK(O1)::GOSUB49650
48350 RETURN

49000 TEXT:CLS:PRINT@8,2;CHR$(145);CHR$(135);"++ PREPARE L EQUIPE ++ ";CHR$(144)
49010 O1=#A000::GOSUB49620
49011 O1=O1+1:POKEO1,1
49012 O1=O1+1:POKEO1,X
49013 O1=O1+1:POKEO1,Y
49014 O1=O1+1:POKEO1,S
49015 O1=O1+1:POKEO1,CA
49020 O1=O1+1:POKEO1,VIL
49030 FOR P=1TO6
49040 O1=O1+1:POKEO1,LEN(N$(P))
49050 FORJ=1TOLEN(N$(P)):O1=O1+1:POKEO1,ASC(MID$(N$(P),J,1)):NEXT
49080 O1=O1+1:DOKEO1,INT(RI(P)/10)
49090 O1=O1+2:POKEO1,CP(P)
49100 O1=O1+1:POKEO1,MP(P)
49105 O1=O1+1:POKEO1,CC(P)
49110 O1=O1+1:POKEO1,CT(P)
49120 O1=O1+1:POKEO1,FO(P)
49140 O1=O1+1:POKEO1,AG(P)
49150 O1=O1+1:POKEO1,IN(P)
49160 O1=O1+1:POKEO1,FM(P)::GOSUB49650
49180 O1=O1+1:POKEO1,PV(P)
49190 O1=O1+1:POKEO1,ET(P)
49200 O1=O1+1:POKEO1,OK(P)
49210 O1=O1+1:POKEO1,NI(P)
49215 O1=O1+1:DOKEO1,XP(P)
49220 O1=O1+2:POKEO1,WR(P)
49230 O1=O1+1:POKEO1,WL(P)
49240 O1=O1+1:POKEO1,PT(P)
49250 O1=O1+1:POKEO1,CA(P)
49260 O1=O1+1:POKEO1,BT(P)::GOSUB49650
49270 FORI=1TO6:O1=O1+1:POKEO1,SAD(P,I):NEXTI
49280 IF CP(P)>3 THEN FORI=1TO8:O1=O1+1:POKEO1,SN(P,I):NEXT
49290 NEXT P
49300 O1=O1+1:POKEO1,BS
49310 O1=O1+1:POKEO1,FI
49315 O1=O1+1:POKEO1,SD:GOSUB49650
49320 FOR V=1TO9:FOR C=1TO4:O1=O1+1:POKEO1,CL(V,C):NEXT C,V
49340 FORI=1TO6:O1=O1+1:POKEO1,IG(I):NEXT
49350 FOR V=1TO9:FORM=1TO5:O1=O1+1:POKEO1,TC(V,M):NEXT M,V
49360 O1=O1+1:POKEO1,DE
49370 O1=O1+1:POKEO1,TL:REM PRINT "TL";TL
48380 O1=O1+1:POKEO1,NP:GOSUB49650
48385 O1=O1+1:POKEO1,NF
48386 O1=O1+1:POKEO1,PM::GOSUB49650
49390 PING:SAVEU "TEAM.BIN",A#A000,EO1:REM FR = FRE("")
49395 REM SAVEU "TEAM2.BIN",A#A000,EO1
49400 RETURN

49600 CLS:PRINT@7,8;".. Chargement * Patientez .."
49610 S$=CHR$(148)+" "+CHR$(144):CU=1:GOTO49650
49620 PRINT@7,8;"++ Sauvegarde + Patientez ++"
49630 S$=CHR$(145)+" "+CHR$(144):CU=1
49650 CU=CU+2:PRINT@CU,9;S$:REM FR = FRE("")
49660 RETURN

50000 DATA Chevalier,Mercenaire,Ranger,Sorcier,Mestre,Septon
50020 DATA Aucune,MARTELL,BARATHEON,TYRELL,GREYJOY,ARRYN,LANNISTER,TULLY,STARK
