10 REM {+ ORIC 2014-15 + TYRANN 3 + MAXIMUS +}
20 TEXT:'PAPER0:INK6
30 POKE 48035,0:POKE#26A,PEEK(#26A)AND254
40 DIM SN(6,9)
60 GOSUB 50000:GOSUB 48000:PING:CG=0
80 AD=#BFE0:X=2:Y=2:S=2
90 REM POKE AD,X:POKE AD+1,Y:POKEAD+2,S
110 FORI=1TO9:FORJ=1TO4:CL(I,J)=1:NEXTJ,I'Toutes les cl�s
120 'FORI=1TO6:PV(I)=ET(I):NEXTI
135 'FORP=1TO6:FORI=1TO9:NI(I)=9:SN(P,I)=5:NEXTI,P'Tous les sorts
140 'FOR M=1TO5:TC(VIL,M)=0:NEXT M'Tous les combats actifs
145 'FORI=1TO6:IG(I)=0:NEXT:IG(3)=1:TL=9:VIL=9:NP=2
150 GOTO4000

200 REM Centre
210 T=INT((42-LEN(S$))/2):PRINT @T,L;S$
220 RETURN

299 REM LABY
300 CO = 0 : DE = 0 : GOSUB 49000 : LOAD "LABY"

4000 REM VILLAGE 
4001 REM FR = FRE("")
4002 DE = 0
4005 TEXT:CLS:PAPER 0:POKE48035,0:POKE#26A,PEEK(#26A) AND 254
4010 S$=" "+CR$(VI)+" ":L=17:GOSUB 10000
4020 PLOT 13,3,"VOUS POUVEZ..."
4030 PLOT 8,5,"1) VERS LES ECHOPPES"
4035 PLOT 8,6,"2) INSPECTER UN PERSONNAGE"
4040 PLOT 8,7,"3) VISUALISER L'EQUIPE"
4050 PLOT 8,8,"4) VOIR LE MESTRE"
4060 PRINT @8,9;"5) VISITER "+CR$(VILLE)
4070 PLOT 8,10,"6) EXPLORER WESTEROS"
4075 IFVI>2 THEN PLOT 8,11,"7) ALLER AU LABORATOIRE"
4080 PLOT 8,13,"9) SAUVEGARDE SCENARIO"
4090 PLOT 6,15,"F)in  M)emory  R)einit B)oost"
4100 GOSUB 10800:GOSUB22000

4200 GET A$
4205 IFA$<>"3"ANDA$<>"5"THEN CG=1
4210 IF A$="1" THEN 6000
4220 IF A$="2" THEN A=VAL(A$):ENC=6:GOSUB 4400:GOTO 4000
4230 IF A$="3" THEN GOSUB 5300:GOTO 4000
4240 IF A$="4" THEN5000
4250 IF A$="5" THEN X=2:Y=2:S=2:CA=50:GOTO 300
4255 IF A$="6" THEN5500
4260 IF A$="7" ANDVI>2THEN11000
4280 IF A$="9" THEN ZAP:GOSUB 49000:PING: GOTO 4000
4290 IF A$="F" THEN PING:CLS:PLOT 10,10,"ESPECE DE PLEUTRE":PRINT FRE(""):END
4295 IFA$="M"THENS$=" >"+STR$(FRE(""))+" octets":PLOT 18,15,S$
4296 IFA$="R"THEN GOSUB 40000
4297 IFA$="B"THEN GOSUB 41000
4300 GOTO 4200

4400 S$="INSPECTER QUEL HEROS ?  ":GOSUB 5650:PRINT@6,3;S$
4410 GOSUB 30200:P=A
4420 S$=N$(P)+" ":IF MP(P)<>8 THEN S$=S$+M$(MP(P))
4430 L=23:CLS:GOSUB 10000
4440 PRINT @4,3;"Carr :";C$(CP(P)):PRINT @21,3;"Niv:"NI(P);"EXP:"XP(P)
4450 PRINT @4,5;"Sante:";OK$(OK(P)):PRINT @21,5;"PV :";ET(P)"/"PV(P)
4460 PRINT @4,7;"Bourse:";RI(P)"Cerfs d'Argent"
4470 PRINT @4,9;"Arme D: ";IT$(WR(P))
4480 PRINT @4,10;"Arme G: ";IT$(WL(P))
4490 PRINT @4,11;"Animal: ";IT$(BT(P))
4500 PRINT @4,12;"Armure: ";IT$(PT(P));"  CA:";CA(P)
4510 S$="CC  CT  Fo  Ag  In  FM "
4520 PRINT@4,14;CHR$(145)CHR$(135)S$CHR$(144)
4530 S$=STR$(CC(P))+" "+STR$(CT(P))+" "+STR$(FO(P))+" "+STR$(AG(P))+" "+STR$(IN(P))+" "+STR$(FM(P))
4540 PLOT 5,15,S$
4550 L=16:OP(P)=0
4560 FOR I=1TO6
4570 IF SAD(P,I)>0 THEN M$=ITEM$(SA(P,I)):OP(P)=OP(P)+1 ELSE M$=".............."
4580 PRINT @3,L+I;I;" ";M$:NEXT I
4581 NC=0
4582 FORI=1TO4
4583 IF CL(VI,I)=1THENNC=NC+1
4584 NEXT
4585 PRINT@26,17;"Clefs de"
4590 PRINT@26,18;"la ville:":PRINT@34,18;STR$(NC)
4592 PRINT@26,20;"Ingredients"
4593 PRINT@28,21;"Potion:":PRINT@34,21;STR$(NP)
4600 S$=" DONNER: ":GOSUB 5600:PRINT @1,24;S$
4610 S$="A)rgent O)bjet R)ien ":GOSUB5650:PRINT@14,24;S$
4620 GETA$:IF A$<>"A" AND A$<>"O" AND A$<>"R"THEN4620
4630 IFA$<>"R"THEN4650
4640 IFCP(P)>3THEN4700ELSE4900
4650 IFA$="A"THEN5700ELSE5800

4700 CLS:S$=" * SORTS * ":L=14:GOSUB 10000
4705 SS=NI(P):IFSS>8THENSS=8
4710 FORI=1TOSS
4720 S$=STR$(I)+" - "+SPELL$(CP(P)-3,I):PRINT@11,I+3;S$
4730 S$="("+STR$(SN(P,I))+" )": PRINT@25,I+3;S$:NEXT
4735 IF CP(P)<>5 OR OK(P)>2THEN GOSUB 30000:GOTO 4900
4738 GOSUB 10800
4740 S$="Sort de soins (O/N)?":L=13:GOSUB 200
4750 GETA$:IF A$="N" THEN 4900 ELSE IF A$<>"O" THEN 4750
4760 S$="        LEQUEL  ?      ":L=13:GOSUB 200
4770 GETA$:SP=VAL(A$):IFSP<1 OR SP=4 OR SP=6 OR SP>7 OR SP>NI(P) THEN ZAP:GOTO 4770
4775 S$=" INCANTATION:"+SP$(2,SP)+" ":L=13:GOSUB 200
4780 IF SP=5 THEN 4870
4790 S$="   SOIGNER QUI  ? Aucun(0) ":L=17:GOSUB 200
4800 GETA$:P=VAL(A$):IFP>6THEN4800ELSEIFP=0THEN4900
4805 S$="                           ":L=17:GOSUB200:PING
4810 IF (SP=1 AND OK(P)=4) OR (SP=2 AND OK(P)<>2) OR (SP=3 AND OK(P)<>3) OR (SP=7 AND OK(P)<>4) THEN ZAP:GOTO 4900
4840 ET(P)=PV(P):IF SP<>1 THEN OK(P)=1
4850 GOSUB 10800:GOTO 4740
4870 FOR I=1TO6:IF OK(I)<>4 THEN ET(I)=PV(I)
4880 NEXT
4900 ZAP:RETURN

5000 REM SOINS
5010 S$="SOIGNER QUEL HEROS ? ":GOSUB 5650:PRINT@9,3;S$
5020 GETP$:P=VAL(P$):IF P<1 OR P>6 THEN PING:GOTO 5020
5040 ENC=2:S$="LE MESTRE LUWIN":L=16:CLS:GOSUB 10000
5050 PRINT @5,5;"Bienvenue ";N$(P)"
5060 PRINT @5,7;"Votre condition est: ";OK$(OK(P))
5070 S$="Etat:"+STR$(ET(P))+" /"+STR$(PV(P)):PLOT 5,9,S$
5080 IF OK(P)=1 AND ET(P)=PV(P) THEN M$="Vous etes en pleine forme !":HO=0
5090 IF OK(P)=2 OR OK(P)=3 THEN HO=NI(P)*50
5100 IF OK(P)=4 THEN HO=NI(P)*100
5110 IF OK(P)=1 AND ET(P)<PV(P) THEN HO=NI(P)*25
5120 IF HO=0 THEN PLOT 7,11,M$:PING:WAIT TI*8:GOTO 4000
5130 PRINT @5,11;"HONORAIRES: ";HO;" ca"
5140 PLOT 5,13,"JE VOUS SOIGNE (O/N) ?"
5150 GETA$
5160 IF A$="N" THEN 4000
5170 IF A$="O" THEN 5190
5180 GOTO 5150
5190 IF HO > RI(P) THEN S$="Par les 7, Vous etes trop pauvres !":GOTO 5210
5200 RI(P)=RI(P)-HO:OK(P)=1:ET(P)=PV(P):HO=0:S$="Par les 7, Vous voila gueri !"
5210 PING:GOSUB 5650:PRINT@4,15;S$
5250 WAIT25*TI
5260 GOTO 4000

5300 REM EQUIPE
5310 CLS:PRINT@8,1;CHR$(145)CHR$(128)" * TYRANN 3 - EQUIPE *  "CHR$(144)
5312 L=3:PRINT@3,L;CHR$(145)"PERSONNAGES� MAISON  CARRIERE  NIV "CHR$(144)
5315 PRINT@3,L+1;CHR$(148)" Argent      CC CT Fo Ag In FM PV  "CHR$(144):L=5
5320 FOR I=1TO6
5330  IF CP(I)=1 THEN EN=131
5340  IF CP(I)=2 THEN EN=135
5350  IF CP(I)=3 THEN EN=134
5360  IF CP(I)=4 THEN EN=133
5370  IF CP(I)=5 THEN EN=132
5380  IF CP(I)=6 THEN EN=130
5390 PRINT@1,L;CHR$(ENC);I;N$(I);:PRINT@17,L;M$(MP(I)):PRINT@27,L;C$(CP(I))
5395 PRINT@37,L;NI(I)
5400 PRINT@4,L+1;STR$(RI(I));" ca"
5410 S$=STR$(CC(I))+STR$(CT(I))+STR$(FO(I))+STR$(AG(I))+STR$(IN(I))+STR$(FM(I))+STR$(ET(I))
5420 PRINT@16,L+1;S$:L=L+3
5430 NEXT I:PRINT@3,L-1;CHR$(148)" Argent      CC CT Fo Ag In FM PV  "CHR$(144):WAIT300
5435 PRINT@3,L;CHR$(145)CHR$(128)"            < ESPACE >            "CHR$(144)
5440 ENC=4
5450 GET A$:IF A$<>" " THEN 5450
5460 RETURN

5500 EN=3:S$="EXPLORER WESTEROS":L=18:CLS:GOSUB 10000:L=3:EN=128
5505 FORI=1TOTL
5510 L=L+1:EN=128+EE(I)
5515 PRINT@3,L;CHR$(EN);
5516 SS$=". ":IF I=VILTHENSS$="->"
5520 PRINT@5,L;I;SS$;CR$(I);"..........."
5522 S$=M$(I):IF I=1THENS$="LE TRONE"
5523 S$=S$++CHR$(128+EE(VI))
5525 PRINT@27,L;S$
5530 NEXTI
5545 S$="OU VOULEZ VOUS ALLER ?":GOSUB 5650:PRINT@7,L+3;S$
5550 GETP$:CR=VAL(P$)
5555 IFCR=VIORP$=" "ORCR>TLORCR<1THEN4000
5560 S$=" OK !! EN ROUTE POUR:  ":GOSUB 5650:PRINT@7,L+3;S$
5565 L=L+5:S$=CR$(CR):GOSUB 200
5570 IFCR<1ORCR>TLTHEN PING:GOTO5550
5572 FOR M=1TO5:TC(VIL,M)=0:NEXT M
5574 DE=0
5576 VI=CR:GOTO4000

5600 REM FOND BLEU 
5610 S$=" "+CHR$(148)+CHR$(128)+S$+CHR$(134)+CHR$(144)+" "
5620 RETURN

5650 REM FOND ROUGE
5660 S$=" "+CHR$(145)+CHR$(135)+S$+CHR$(128+EE(VIL))+CHR$(144)+" "
5670 RETURN

5699 REM DONNER Ag
5700 L=18:CLS:S$=N$(P)+" DONNE":GOSUB 10000
5710 FORI=1TO6:PRINT @4,3+I;I;N$(I):PRINT @18,3+I;RI(I);" ca":NEXT
5715 PRINT @4,11;"Votre Bourse:";RI(P)"Cerfs Ag"
5720 PRINT@12,18;"0 pour Quitter"
5725 S$="COMBIEN de C.Ag ":GOSUB 5650:PRINT @3,14;S$;
5730 INPUT DO:IF DO> RI(P) THEN PING:GOTO 5700
5735 IF DO=0 THEN 5790
5740 PRINT@4,16;CHR$(145);"ENRICHIR QUEL HEROS ?  0:Aucun ";CHR$(144);
5750 GET A$:A=VAL(A$):IF A>6 THEN PING:GOTO 5750
5760 IF A=0 THEN 5890
5770 RI(A)=RI(A)+DO:RI(P)=RI(P)-DO:PING:GOTO 5700
5790 GOTO 4000

5800 S$="Quel Objet ? 0:aucun ":GOSUB5600:PRINT@13,24;S$
5810 GETA$:O=VAL(A$):IF O>OP(P)THENPING:GOTO5810
5820 IFO=0THEN5920
5822 IT=SA(P,O):IF(IT>21ANDIT<27)OR(IT>33ANDIT<44)THENL=24:GOSUB5950:GOTO5800
5830 L=14:CLS:S$=N$(P)+" DONNE":GOSUB10000
5840 S$=IT$(SA(P,O)):GOSUB 5600:PRINT@8,3;S$
5850 FORI=1TO6:PRINT @12,4+I;I;N$(I):NEXT
5860 PING:PRINT@14,12;CHR$(145);" A QUEL HEROS ?  ";CHR$(144);
5870 GET A$:A=VAL(A$):IF A<1 OR A>6 OR A=P THEN PING:GOTO 5870
5880 IFSA(A,6)>0THENL=12:GOSUB 5950:GOTO 5860
5882 I=0 
5885 REPEAT:I=I+1
5900 UNTILSA(A,I)=0
5910 SA(A,I)=SA(P,O):SA(P,O)=0
5915 CH=O:GOSUB8920
5920 GOTO 4000
5950 ZAP:PRINT @16,L;"  !IMPOSSIBLE!  ":WAIT150:RETURN


6000 REM SHOPS
6010 S$=" GRAND MARCHE ":N=6:ENC=EE(VIL):GOSUB9500
6020 PLOT10,10,"Qui veut marchander ?"
6030 PLOT8,20,"Q > Quitter les commerces"
6040 GETP$:P=VAL(P$)
6050 IFP$="Q"THEN GOSUB 49000:4000
6060 IFP<1ORP>6OROK(P)>2THENZAP:GOTO6040

6070 S$=" QUELLE ECHOPPE ?":N=NS:GOSUB9500:GOSUB9200
6080 PRINT@9,8;" 0 > Changer de Client "
6090 GETA$:SH=VAL(A$):IFSH>NSTHEN6090
6100 IFA$="C"THEN RI(P)=RI(P)+10000:GOTO6070
6110 IFA$="V"THENGOSUB8700:GOTO6070
6120 IFSH=0THEN6010

6130 REM CHOIX
6140 S$=SH$(SH):N=N(SH):EN=CO(SH):GOSUB 9500
6150 M$=" IMPOSSIBLE !":FD=145
6160 S$=CHR$(FD)+N$(P)+" "+C$(P)+" "+STR$(RI(P))+" ca "+CHR$(144)
6165 L=2:GOSUB200
6170 PRINT@6,3;" Que desirez vous acheter ";:INPUTCH
6180 IFCH>NTHEN9000
6190 IFCH=0THEN6070
6195 IFSH=1THENSS=0
6200 IFSH=2THENSS=N(1)
6210 IFSH=3THENSS=N(1)+N(2)
6220 IFSH=4THENSS=N(1)+N(2)+N(3)
6230 IFPR%(CH+SS)>RI(P)THENM$=" TROP CHER ! ":GOTO9000
6240 IFOB(P,6)<>0THENM$=" PLEIN! ":GOTO9000

6250 REM ARMES
6260 IFSH>1THEN6900
6270 IFCH>7THEN6500
6280 IFPT(P)>0THEN M$="DEJA UNE ARMURE: "+IT$(PT(P)):GOTO9000
6290 IFCH>3THEN6400
6300 IFCP(P)>2THEN8990
6310 GOTO6460 

6400 IFCH>6THEN6450
6410 IFCP(P)>4THEN8990
6420 GOTO6460

6450 IFCP(P)<5THEN8990
6460 PT(P)=CH:CA(P)=8-CH
6470 M$="  OK POUR: "+ IT$(PT(P))+" ":GOTO8960

6500 REM Achat
6510 IFWR(P)>0ANDWL(P)>0THEN M$="DEJA 2 ARMES: ":GOTO9000
6520 IFCH>12THEN6550
6530 IFCP(P)>2THEN8990
6540 GOTO6800
6550 REM 13 et 14
6560 IFCH>14THEN6700
6570 IFCP(P)>4THEN 8990
6580 GOTO6800
6590 REM TIR
6700 IFCH>17THEN6740
6710 IFCP(P)<3THEN8990
6720 IFCH=17AND(CP(P)<3ORCP(P)>3)THEN8990
6730 GOTO6800
6740 REM NET
6750 IFCH>18THEN6800
6760 IFCP(P)<>3THEN8990
6770 IFFI=1THEN M$="VOUS AVEZ DEJA UN FILET":GOTO9000ELSEFI=1

6780 REM VALID
6800 M$="  OK POUR: "+IT$(CH)+" " 
6810 IFWR(P)=0THENWR(P)=CHELSEWL(P)=CH
6850 GOTO8960 

6900 REM HERBO 
6910 IFSH>2THEN7000
6920 IFCP(P)=5ORCP(P)=6THEN6940
6930 IFCH>2ANDCP(P)<4THEN8990
6935 IFCP(P)=4ANDCH>7THEN8990
6940 M$="  OK POUR: "+IT$(CH+SS)+" ":GOSUB7200
6950 GOTO8960

7000 REM BAZAR
7010 IFSH=4THEN7100
7020 IFCH=9ANDCP(P)<5THEN8990
7030 IFCH=9THENIFBS=1THENM$="VOUS AVEZ DEJA UNE BOUSSOLE":GOTO9000ELSEBS=1
7040 IF CH=10ANDCP(P)=6 THEN IF SD=1THEN M$="VOUS AVEZ DEJA UNE SELLE":GOTO9000 ELSE SD=1
7050 IF CH=10ANDCP(P)<>6 THEN 8990

7080 M$="  OK POUR: "+IT$(CH+SS)+" ":GOSUB7200
7090 GOTO8960

7100 REM ANIMAL
7120 IFCH=1ANDMP(P)<>1THEN M$="Vous etes du SUD!":GOTO9000
7130 IFBT(P)>0THEN M$="DEJA UN ANIMAL: "+IT$(BT(P)):GOTO9000
7140 M$="  OK POUR: "+IT$(CH+SS)+" "
7150 BT(P)=CH+SS
7160 GOTO8960

7200 REM SAC
7210 IFSA(P,1)=0THENI=1:GOTO7260
7220 I=0:REPEAT 
7230 I=I+1
7240 UNTILSA(P,I)=0ORI=6
7250 IFSA(P,6)>0THEN M$="PLEIN!":GOTO9000
7260 SA(P,I)=SS+CH
7270 RETURN

8700 REM VENTE
8710 IFWR(P)=0ANDWL(P)=0ANDPT(P)=0ANDSA(P,1)=0ANDBT(P)=0THENPRINT@26,17;CHR$(149);"! VIDE !";CHR$(144):ZAP:WAIT80:RETURN
8720 PRINT@31,23;CHR$(149);"LEQUEL? ";CHR$(144)
8730 PRINT@33,22;:INPUTCH
8740 IFCH=0THEN8850
8750 IFCH<0ORCH>10THENPING:GOTO8700
8760 IFCH>6THEN8790
8770 IFSA(P,CH)=0THENPING:GOTO8700
8780 IFSA(P,CH)=38THENBS=0:GOTO8800
8785 IFSA(P,CH)=41THENSD=0:GOTO8800
8790 IF(CH=7ANDWR(P)=0)OR(CH=8ANDWL(P)=0)OR(CH=9ANDPT(P)=0)OR(CH=10ANDBT(P)=0)THEN8700
8800 IFCH<7THENPX=PR%(SA(P,CH)):GOSUB8900:SA(P,CH)=0:GOSUB8920
8810 IFCH=7THENPX=PR%(WR(P)):GOSUB8900:WR(P)=0:IFWR(P)=18THENFI=0
8820 IFCH=8THENPX=PR%(WL(P)):GOSUB8900:WL(P)=0:IFWL(P)=18THENFI=0
8830 IFCH=9THENPX=PR%(PT(P)):GOSUB8900:PT(P)=0:CA(P)=0
8840 IFCH=10THENPX=PR%(BT(P)):GOSUB8900:BT(P)=0
8850 RETURN

8900 REM OK
8910 RI(P)=RI(P)+INT(PX*2/3):ZAP:RETURN

8920 FORI=CHTO5
8930 IFSA(P,I+1)>0THENSA(P,I)=SA(P,I+1):SA(P,I+1)=0
8940 NEXTI 
8950 RETURN

8960 REM VALIDE
8970 RI(P)=RI(P)-PR%(CH+SS):FD=148:GOTO9000
8980 GOTO6130

8990 M$="Impossible pour un "+C$(CP(P))

9000 T=INT((38-LEN(M$))/2)
9010 PING:CLS:PRINT:PRINT@T,5;CHR$(FD);" ";M$;" ";CHR$(144)
9020 WAIT140:SS=0:GOTO6130


9200 REM CLIENT
9210 S$=CHR$(135)+CHR$(145)+"INVENTAIRE: "+N$(P)+" "+CHR$(128+ENC)
9230 L=10:T=INT((42-LEN(S$))/2)
9240 PRINT@T,L;S$;CHR$(144)
9250 L=L+2
9260 FORI=1TO14:PRINT@2,I+9;"*":PRINT@39,I+9;"*":NEXTI
9270 PRINT@29,L;C$(CP(P))
9280 PRINT@28,L+1;RI(P)"ca"
9290 PRINT@29,L+8;"CA>";CA(P)
9300 FORI=1TO6
9310 IFSA(P,I)>0THENM$=IT$(SA(P,I))ELSEM$="............"
9320 PRINT@4,L+I-1;I;M$
9330 NEXTI:L=L+I-1
9340 IFWR(P)>0THEN M$=IT$(WR(P))ELSEM$="..........."
9350 PRINT@5,L;I;M$:L=L+1:I=I+1
9360 IFWL(P)>0THEN M$=IT$(WL(P))ELSEM$="..........."
9370 PRINT@5,L;I;M$:L=L+1:I=I+1
9380 IF PT(P)>0THENM$=IT$(PT(P))ELSE M$="..........."
9390 PRINT@5,L;I;M$:L=L+1:I=I+1
9400 IFBT(P)>0THENM$=IT$(BT(P))ELSEM$="..........."
9410 PRINT@4,L;I;M$:L=L+2
9420 PRINT@2,L;"*************************************"
9430 PRINT@30,L;CHR$(135);CHR$(145);"V)endre ";CHR$(128+ENC)
9450 RETURN

9500 CLS:PRINT:INK(ENC):PRINTCHR$(17);
9510 POKE#26A,PEEK(#26A)AND254
9520 PRINT"**************************************"
9530 T=INT((33-LEN(S$))/2)
9540 S$="[ "+S$+" ] ":GOSUB5650:PRINT@T,1;S$;CHR$(128+EN)
9545 INK(EN):J=N+4
9550 FORI=1TOJ:PRINT@2,I+1;"*":PRINT@39,I+1;"*":NEXTI
9570 FORI=1TON:L=I+2
9580   IFN<>6THEN9600
9585   T=34-LEN(STR$(RI(I)))
9586   IFOK(I)<3THENS$=C$(CP(I))ELSES$=OK$(OK(I))
9590   PRINT@4,L;I;N$(I);@18,L;S$;@T,L;RI(I);"ca":GOTO9700
9600   IFN<>NSTHEN9620
9610   PRINT@12,L;I;SH$(I):GOTO9700
9620   REM ITEMS 
9630   IFSH=1THENO$=IT$(I):PX=PR%(I)
9640   IFSH=2THENO$=IT$(I+N(1)):PX=PR%(I+N(1))
9650   IFSH=3THENO$=IT$(I+N(1)+N(2)):PX=PR%(I+N(1)+N(2))
9660   IFSH=4THENO$=IT$(I+N(1)+N(2)+N(3)):PX=PR%(I+N(1)+N(2)+N(3))
9665   T=8-LEN(STR$(I)):PRINT@T,L+1;I"..."
9670   T=14-LEN(STR$(PX)):PRINT@T,L+1;PX"...."
9680   PRINT@17,L+1;O$
9700 NEXTI
9710 IFN<>6ANDN<>NSTHENPRINT@12,L+3;" 0 POUR SORTIR"
9720 PRINT@2,L+4;"**************************************"
9750 RETURN

10000 TEXT:PAPER0:INKEE(VI):PRINT
10020 PRINT" ************************************"
10030 FORI=1TOL:PRINT@2,I;"*":PRINT@38,I;"*":NEXTI
10040 T=INT((31-LEN(S$))/2)
10060 S$="< "+S$+" > ":GOSUB5650:PRINT@T,1;S$
10080 PRINT@2,I;"*************************************"
10100 RETURN

10800 L=19:PRINT@1,L;CHR$(145)"PERSONNAGES �  CASTE �   �PV �ET �CA"
10820 FORI=1TO6:L=L+1
10830 IFCP(I)=1THENEN=131
10835 IFCP(I)=2THENEN=135
10840 IFCP(I)=3THENEN=134
10850 IFCP(I)=4THENEN=133
10860 IFCP(I)=5THENEN=130
10870 IFCP(I)=6THENEN=132
10875 IFOK(I)=4THENEN=129
10880 IFOK(I)>1THENS$=OK$(OK(I))ELSES$=C$(CP(I))
10890 PRINT@1,L;CHR$(EN);I;N$(I);:PRINT@17,L;S$;
10900 PRINT@27,L;PV(I):PRINT@34-LEN(STR$(ET(I))),L;ET(I):PRINT@38-LEN(STR$(CA(I))),L;CA(I)
10910 NEXT
10920 EN=4
10950 RETURN

11000 CLS:L=20:S$=" # Labo d'Alchimie # ":EN=7:GOSUB10000
11010 S$=" MEMBRES ADMIS ":GOSUB5600:PLOT10,3,S$:J=1
11030 FORI=1TO6
11040 IFCP(I)<5THEN11060
11050 PRINT@11,4+J;J;N$(I);" ";C$(CP(I)):J=J+1
11060 NEXT
11065 IFJ=1THEN ZAP:PRINT @11,4+J;J;" DEHORS !":WAIT300:ZAP:GOTO4000
11070 IFVI<>9THENPRINT@10,5+J;" > Il n'y a personne ":GOTO11090
11080 PRINT@10,5+J;J;"Sorciere du Nord"
11090 IF PM=1THEN11170
11095 S$="Ingredients Potion du Nord"+STR$(NP):GOSUB5600:PRINT@3,7+J;S$
11100 FORI=1TO6:PRINT @5,9+J+I;"-> ";IG$(I)
11110 IFIG(I)=1THENPLOT24,9+J+I,"> OK"
11120 NEXT
11121 L=21:GOSUB30000
11125 IFNP<6ORVI<>9ORPM=1THEN11200
11130 FORI=1TO5:SHOOT:WAIT30:PAPER I:NEXTI:EXPLODE:PAPER0
11140 FORI=1TO9
11150 PRINT@3,9+I;CHR$(144)"                                  ":NEXT
11160 PM=1:S$="L'Athanor cuit la potion":GOSUB5650:L=12:GOSUB200
11165 FORI=1TO25:PRINT@7+I,14;">":WAIT20:NEXT
11170 L=12:S$="!! La potion est prete !! ":GOSUB5600:GOSUB200:PING:WAIT50
11180 S$="Direction Castleblack ":GOSUB5650:L=16:GOSUB200:ZAP:WAIT70
11190 L=21:GOSUB30000
11200 GOTO4000

22000 FOR P=1TO6' recharge sorts
22010 IFET(P)>0ANDET(P)<5THENET(P)=ET(P)+FNA(3)
22020 IFCP(P)<4THEN22070
22025 SS=NI(P):IFSS>8THENSS=8
22030  FORI=1TOSS
22040  SN(P,I)=FNA(3)+1
22045  IFI=5ORI=6THENSN(P,I)=FNA(2)+1
22046  IFI=7THENSN(P,I)=FNA(2)
22050 NEXTI
22060 SN(P,8)=1
22070 NEXTP
22100 RETURN

30000 S$="< ESPACE > ":GOSUB 5650:PRINT@13,L;S$:GETA$:IF A$<>" " THEN 30000
30001 RETURN

30100 IF KEY$="" THEN 30100
30101 RETURN

30200 GET A$:A=VAL(A$):IF A<1 OR A>6 THEN PING:GOTO 30200
30220 RETURN

40000 REM REINITIALISE TOUT
40010 FORI=1TO9
40020  FORJ=1TO4:CL(I,J)=0:NEXTJ'cl�s
40030  FORJ=1TO8:CF(I,J)=0:NEXTJ'coffres
40040 NEXTI
40050 FORI=1TO6:IG(I)=0:NEXTI:NP=0'ingredients potion
40060 FOR M=1TO5:TC(VIL,M)=0:NEXT M
40070 X=2:Y=2:S=2:VILLE=1
40080 PLOT23,16,"REINIT..OK":ZAP
40100 RETURN 

41000 REM BOOSTE TOUT
41010 FORI=1TO9
41020  FORJ=1TO4:CL(I,J)=1:NEXTJ'cl�s
41030  FORJ=1TO8:CF(I,J)=0:NEXTJ'coffres
41040 NEXTI
41050 FORI=1TO6:IG(I)=1'ingredients potion,
41055 NI(I)=15:XP(I)=0:RI(I)=10000:NEXTI:NP=6'persos
41060 FOR M=1TO5:TC(VIL,M)=0:NEXT M
41070 X=2:Y=2:S=2:VILLE=1:TL=9
41080 PLOT27,16,"BOOST..OK":ZAP
41100 RETURN 

48000 GOSUB49600
48005 LOAD"TEAM.BIN"
48010 O1=#A000
48011 O1=O1+1:VIL=PEEK(O1)
48012 PRINT"Version " VIL 
48013 O1=O1+1:X=PEEK(O1)
48014 O1=O1+1:Y=PEEK(O1)
48015 O1=O1+1:S=PEEK(O1)
48016 O1=O1+1:CA=PEEK(O1)
48017 O1=O1+1:VIL=PEEK(O1)
48018 PRINT"Ville " VIL "X " X "Y " Y "S " S "CA " CA
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
48130 O1=O1+1:PV(P)=PEEK(O1)
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
48297 O1=O1+1:DE=PEEK(O1)
48298 O1=O1+1:TL=PEEK(O1):PRINT "TL";TL:REM FR = FRE("")
48300 RETURN

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
49160 O1=O1+1:POKEO1,FM(P)
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
49370 O1=O1+1:POKEO1,TL:PRINT "TL";TL
49390 PING:SAVEU "TEAM.BIN",A#A000,EO1:REM FR = FRE("")
49395 REM SAVEU "TEAM2.BIN",A#A000,EO1
49400 RETURN

49600 CLS:PRINT@7,8;".. Chargement * Patientez .."
49610 S$=CHR$(148)+" "+CHR$(144):CU=1:GOTO49650
49620 PRINT@7,8;"++ Sauvegarde + Patientez ++"
49630 S$=CHR$(145)+" "+CHR$(144):CU=1
49650 CU=CU+2:PRINT@CU,9;S$:REM FR = FRE("")
49660 RETURN

50000 TI=20:HV=6:DF=0
50010 DIM IT$(55),PR%(55),IP$(10,2),TP$(2,15)
50020 GOSUB 50500
50060 FOR I=1TO4:READ TX$(I):NEXT I
50070 FOR I=1TO9:FOR J=1TO4:READ PS$(I,J):NEXT J,I
50080 FOR I=1TO4:READ OK$(I):NEXTI
50090 DEF FNA(X)=INT(RND(1)*X)+1
50100 FORI=1TO6:READ C$(I):NEXT
50110 FORI=1TO9:READ M$(I),CR$(I),EE(I):NEXT
50120 NS=4:NI=0:FOR I=1TO4:READ SH$(I),N(I),CO(I):NI=NI+N(I):NEXT
50130 FORI=1TO6:READ IG$(I):NEXT
50140 FORH=1TO3:FORI=1TO8:READ SP$(H,I):NEXTI,H
50150 REM FR = FRE("")
50400 RETURN

50499 REM Lecture TITEMS
50500 LOAD "TITEMS.BIN"
50510 O1=#A000
50520 LI=PEEK(O1)
50530 FOR I=1 TO LI
50540   O1=O1+1:LG=PEEK(O1)
50550   S$=""
50560   IF LG=0 THEN 50590
50570   FOR J=1 TO LG
50580     O1=O1+1:S$=S$+CHR$(PEEK(O1))
50590   NEXT
50600   ITEM$(I)=S$
50610 NEXT

50620 REM Lecture TPRIX
50630 LOAD "TPRIX.BIN"
50640 O1=#A000
50650 LP=PEEK(O1)
50660 FOR I=1 TO LP
50670   O1=O1+1:PR%(I)=DEEK(O1):O1=O1+1
50680 NEXT

50690 RETURN


51010 DATA "Ouille!","Le mur n'a rien senti","Tu as bu ?","Ou est la clef ?"

51021 DATA "Lord Starck","Master Luwin","PRISON","DONJON"
51022 DATA "Lord Brynden","Laboratory","PRISON","Cuisines"
51023 DATA "Lord Tyrion","Lord Tywin","PRISON","CHAPELLE"
51024 DATA "Petyr","Lady Sansa","SKY CELL","MOON DOOR"
51025 DATA "Asha","Theon Greyjoy","PRISON","CELLIER"
51026 DATA "Sir Loras","Lady MAERGERY","PRISON","COFFRES"
51027 DATA "Lord Stannis","Melisandre","PRISON","VIVARIUM"
51028 DATA "Prince Oberyn","ARMURERIE","PRISON","CELLIER"
51029 DATA "King Robert","Queen Cersei","PRISON","Conseil"
51030 DATA OK,"-Empoi- ","-Paral- ",">MORT< "

51050 DATA Chevalier,Paladin,Ranger,Sorcier,Mestre,Septon
51060 DATA AUCUNE,"KING'S LANDING",1, MARTELL,DORNE,5, BARATHEON,"STORM'S END",3, TYRELL,HIGHGARDEN,2
51070 DATA GREYJOY,PIKE,5, ARRYN,EYRIE,6, LANNISTER,CASTERLY ROC,1
51080 DATA TULLY,RIVERRUN,4, STARK,WINTERFELL,7

51100 DATA ARMURERIE,19,7, HERBORISTERIE,11,2, BAZAR,11,3, ANIMALERIE,7,5

52000 DATA "sangsue royale","huile du Roc","rose du Val","encre de poulpe","fleur de Lys","venin de vipere"

53000 DATA SOMMEIL, FEU, PIERRE, VENIN, SANG,  FOUDRE, LAVE, SEISME
53010 DATA EAU, SERUM, MUSCLE, BOUCLIER, ELIXIR, ECRAN, VIE, MORT
53020 DATA EPEE-FEU, FORCE, CHARME, VISION, GLACE, ILLUSION, VENT, DRAGONS



