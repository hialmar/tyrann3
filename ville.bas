10 REM {+ ORIC 2014-15 + TYRANN 3 + MAXIMUS +}
20 TEXT:LOAD "FONT.BIN":PAPER0:INK6
30 POKE 48035,0:POKE#26A,PEEK(#26A)AND254
40 DIM SN(6,9)
60 GOSUB 50000:GOSUB 48000:PING:CG=0
80 X=2:Y=2:S=2
110 'FORI=1TO9:FORJ=1TO4:CL(I,J)=1:NEXTJ,I'Toutes les cl�s
120 'FORI=1TO6:PV(I)=ET(I):NEXTI
135 'FORP=1TO6:FORI=1TO9:NI(I)=9:SN(P,I)=5:NEXTI,P'Tous les sorts
140 'FOR M=1TO5:TC(VIL,M)=0:NEXT M'Tous les coffres et combats actifs
145 'FORI=1TO6:IG(I)=0:NEXT:IG(3)=1:TL=9:VIL=9:NP=2
150 GOTO4000

200 REM Centre
210 T=INT((42-LEN(S$))/2):PRINT @T,L;S$
220 RETURN

299 REM LABY
300 CO = 0 : IF DE >= 128 THEN DE = 128 ELSE DE = 0 : GOSUB 49000 : LOAD "LABY"

4000 REM VILLAGE 
4002 X=2:Y=2:MENU=1:
4005 TEXT:CLS:PAPER 0:POKE48035,0:POKE#26A,PEEK(#26A) AND 254
4010 S$=" "+CR$(VI)+" ":L=17:GOSUB 10000
4020 PLOT 13,3,"YOUR CHOICE..."
4030 PLOT8,5,"1) TO THE SHOPS"
4035 PLOT8,6,"2) INSPECT A CHARACTER"
4040 PLOT8,7,"3) TEAM OVERVIEW"
4050 PLOT8,8,"4) MAESTER'S OFFICE"
4060 PRINT@8,9;"5) VISIT "+CR$(VILLE)
4070 PLOT8,10,"6) EXPLORE WESTEROS"
4075 IFVI>2THENPLOT8,11,"7) TO LABORATORY"
4080 PLOT8,13,"9) SAVING SCENARIO"
4090 PLOT8,15,"F)inish "
4100 GOSUB 10800:GOSUB22000

4200 GET A$
4205 IFA$<>"3"ANDA$<>"5"THEN CG=1
4210 IF A$="1" THEN 6000
4220 IF A$="2" THEN A=VAL(A$):ENC=6:GOSUB 4400:GOTO 4000
4230 IF A$="3" THEN GOSUB 5300:GOTO 4000
4240 IF A$="4" THEN5000
4250 IF A$="5" THEN X=2:Y=2:S=2:CA=50:GOTO 300
4260 IF A$="6" THEN5500
4270 IF A$="7" ANDVI>2THEN11000
4280 IF A$="9" THEN ZAP:GOSUB 49000:PING: GOTO 4000
4290 IFA$="F"THENPING:CLS:PLOT 3,10,"You are a coward, you know ?":END
4295 IFA$="M"THENS$=" >"+STR$(FRE(""))+" bytes":PLOT 18,15,S$
4296 IFA$="R"THEN GOSUB 40000
4297 IFA$="B"THEN GOSUB 41000
4300 GOTO 4200

4400 S$="INSPECT WHICH HERO ?  ":GOSUB 5650:PRINT@6,3;S$
4410 GOSUB 30200:P=A
4420 S$=N$(P)+" ":IF MP(P)<>8 THEN S$=S$+M$(MP(P))
4430 L=23:CLS:GOSUB 10000
4440 PRINT@4,3;"Carr :";C$(CP(P)):PRINT@21,3;"Lev:"NI(P);"EXP:"XP(P)
4450 PRINT@4,5;"Health:";OK$(OK(P)):PRINT@22,5;"HP :";ET(P)"/"PV(P)
4460 PRINT@4,7;"Money:";RI(P)"Silver stags"
4470 PRINT@4,9;"R Weapon:";IT$(WR(P))
4480 PRINT@4,10;"L Weapon: ";IT$(WL(P))
4490 PRINT@4,11;"Animal: ";IT$(BT(P))
4500 PRINT@4,12;"Armor: ";IT$(PT(P));"  AC:";CA(P)
4510 S$="Ml  Rg  St  Dx  In  MS "
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
4585 PRINT@26,17;"Keys of"
4590 PRINT@26,18;"the city:":PRINT@34,18;STR$(NC)
4592 PRINT@28,20;"Potion:":PRINT@34,20;STR$(NP)
4593 PRINT@26,21;"Ingredients"
4600 S$="   GIVING:":GOSUB5600:PRINT@1,24;S$
4610 S$="M)oney S)tuff Q)uit ":GOSUB5650:PRINT@15,24;S$
4620 GETA$:IF A$<>"M" AND A$<>"S" AND A$<>"Q"THEN4620
4630 IFA$<>"Q"THEN4650
4640 IFCP(P)>3THEN4700ELSE4900
4650 IFA$="M"THEN5700ELSE5800
4700 CLS:S$=" * SPELLS * ":L=14:GOSUB10000
4705 SS=NI(P):IFSS>8THENSS=8
4710 FORI=1TOSS
4720 S$=STR$(I)+" - "+SPELL$(CP(P)-3,I):PRINT@11,I+3;S$
4730 S$="("+STR$(SN(P,I))+" )": PRINT@25,I+3;S$:NEXT
4735 IFCP(P)<>5OROK(P)>2THEN GOSUB30000:GOTO4900
4738 GOSUB10800
4740 S$="Healing Spells (Y/N)?":L=13:GOSUB200
4750 GETA$:IFA$="N"THEN 4900 ELSEIF A$<>"Y" THEN4750
4760 S$="       WHICH ONE  ?     ":L=13:GOSUB200
4770 GETA$:SP=VAL(A$):IFSP<1ORSP=4ORSP=6ORSP>NI(P)THENZAP:GOTO4770
4775 S$=" INCANTATION:"+SP$(2,SP)+" ":L=13:GOSUB200
4780 IFSP=5THEN4870
4790 S$="   WHICH HERO  ? None(0) ":L=17:GOSUB200
4800 GETA$:P=VAL(A$):IFP>6THEN4800ELSEIFP=0THEN4900
4805 S$="                           ":L=17:GOSUB200:PING
4810 IF (SP=1 AND OK(P)=4) OR (SP=2 AND OK(P)<>2) OR (SP=3 AND OK(P)<>3) OR (SP=7 AND OK(P)<>4) THEN ZAP:GOTO 4900
4840 ET(P)=PV(P):IF SP<>1 THEN OK(P)=1
4850 GOSUB 10800:GOTO 4740
4870 FOR I=1TO6:IF OK(I)<>4 THEN ET(I)=PV(I)
4880 NEXT
4900 ZAP:RETURN

5000 REM SOINS
5000 S$="CURING WHICH HERO ? ":GOSUB5650:PRINT@9,3;S$
5020 GETP$:P=VAL(P$):IFP<1ORP>6THENPING:GOTO5020
5040 ENC=2:S$="THE MESTER LUWIN":L=16:CLS:GOSUB10000
5050 PRINT@5,5;"Welcome ";N$(P)"
5060 PRINT@5,7;"Your condition is: ";OK$(OK(P))
5070 S$="State:"+STR$(ET(P))+" /"+STR$(PV(P)):PLOT 5,9,S$
5080 IFOK(P)=1AND ET(P)=PV(P)THEN M$="You're fine !":HO=0
5090 IFOK(P)=2OROK(P)=3THENHO=NI(P)*50
5100 IFOK(P)=4THENHO=NI(P)*100
5110 IFOK(P)=1ANDET(P)<PV(P)THENHO=NI(P)*25
5120 IFHO=0THENPLOT7,11,M$:PING:WAIT TI*8:GOTO4000
5130 PRINT@5,11;"FEES: ";HO;" ss"
5140 PLOT5,13,"DO I CURE YOU (Y/N) ?"
5150 GETA$
5160 IFA$="N"THEN4000
5170 IFA$="Y"THEN5190
5180 GOTO5150
5190 IFHO>RI(P)THENS$="Seven gods, you're too poor !":GOTO5210
5200 RI(P)=RI(P)-HO:OK(P)=1:ET(P)=PV(P):HO=0:S$="Thanks Gods, You're healed!"
5210 PING:GOSUB5650:PRINT@4,15;S$
5250 WAIT25*TI
5260 GOTO 4000

5300 REM EQUIPE
5310 CLS:PRINT@8,1;CHR$(145)CHR$(128)" * TYRANN 3 - TEAM *  "CHR$(144)
5312 L=3:PRINT@3,L;CHR$(145)CHR$(128)"CHARACTERS  HOUSES   CARREERS  LEV "CHR$(144)
5315 PRINT@3,L+1;CHR$(148)CHR$(128)" Money      Ml Rg St Dx Ig MS HP   "CHR$(144):L=5:TE=0
5320 FOR I=1TO6
5330  IF CP(I)=1 THEN EN=131
5340  IF CP(I)=2 THEN EN=135
5350  IF CP(I)=3 THEN EN=134
5360  IF CP(I)=4 THEN EN=133
5370  IF CP(I)=5 THEN EN=132
5380  IF CP(I)=6 THEN EN=130
5390 PRINT@1,L;CHR$(ENC);I;N$(I);:PRINT@17,L;M$(MP(I)):PRINT@27,L;C$(CP(I))
5395 PRINT@37,L;NI(I)
5400 PRINT@4,L+1;STR$(RI(I));" ss"
5410 S$=STR$(CC(I))+STR$(CT(I))+STR$(FO(I))+STR$(AG(I))+STR$(IN(I))+STR$(FM(I))+STR$(ET(I))
5420 PRINT@16,L+1;S$:L=L+3:TE=TE+RI(I)
5430 NEXT I:PRINT@3,L-1;CHR$(148);CHR$(128)" Money      Ml Rg St Dx Ig MS HP  "CHR$(144):WAIT300
5435 PRINT@3,L;CHR$(145)CHR$(128)"            < SPACE >            "CHR$(144)
5436 PRINT@4,L;CHR$(128);STR$(TE);" ss"
5440 ENC=4
5450 GET A$:IF A$<>" " THEN 5450
5460 RETURN

5500 EN=3:S$="EXPLORE WESTEROS":L=18:CLS:GOSUB 10000:L=3:EN=128
5505 FORI=TLTO1STEP-1
5510 L=L+1:EN=128+EE(I)
5515 PRINT@3,L;CHR$(EN);
5516 SS$=". ":IF I=VILTHENSS$="->"
5520 PRINT@5,L;I;SS$;CR$(I);"..........."
5522 S$=M$(I):IF I=1THENS$=" THRONE"
5523 S$=S$++CHR$(128+EE(VI))
5525 PRINT@27,L;S$
5530 NEXTI
5545 S$="WHERE DO YOU WANT TO GO ?":GOSUB 5650:PRINT@7,L+3;S$
5550 GETP$:CR=VAL(P$)
5555 IFCR=VIORP$=" "ORCR>TLORCR<1THEN4000
5560 S$=" OK !! LET'S GO:  ":GOSUB 5650:PRINT@7,L+3;S$
5565 L=L+5:S$=CR$(CR):GOSUB 200
5570 IFCR<1ORCR>TLTHEN PING:GOTO5550
5572 FOR M=2TO5:TC(VIL,M)=0:NEXT M ' reinit combats mais pas coffres
5576 VI=CR:GOSUB49000:GOTO4000

5600 REM FOND BLEU 
5610 S$=" "+CHR$(148)+CHR$(128)+S$+CHR$(134)+CHR$(144)+" "
5620 RETURN

5650 REM FOND ROUGE
5660 S$=" "+CHR$(145)+CHR$(135)+S$+CHR$(128+EE(VIL))+CHR$(144)
5670 RETURN

5699 REM DONNER Ag
5700 L=18:CLS:S$=N$(P)+" GIVE":GOSUB10000
5710 FORI=1TO6:PRINT@4,3+I;I;N$(I):PRINT@18,3+I;RI(I);" ss":NEXT
5715 PRINT@4,11;"Your money:";RI(P)"Silver Stags"
5720 PRINT@12,18;"0 to Quit"
5725 S$="How much ? ":GOSUB5650:PRINT@3,14;S$;
5730 INPUTDO:IFDO> RI(P)THEN PING:GOTO5700
5735 IFDO=0THEN5790
5740 S$="TO WHOM ?  0:None":GOSUB5650:PRINT@3,16;S$
5750 GETA$:A=VAL(A$):IFA>6 THENPING:GOTO 5750
5760 IFA=0THEN5920
5770 RI(A)=RI(A)+DO:RI(P)=RI(P)-DO:PING:GOTO5700
5790 IFX<>2THENRETURN
5795 IF MENU=1 THEN 4000 ELSE RETURN

5800 S$="Which Stuff ? 0:None ":GOSUB5600:PRINT@13,24;S$
5805 GETA$:O=VAL(A$):IF O>OP(P)THENPING:GOTO5805
5810 IFO=0THEN5985
5812 IT=SA(P,O)
5815 L=16:CLS:S$=N$(P)+" GIVE":GOSUB10000
5820 S$=IT$(SA(P,O)):GOSUB 5600:PRINT@8,3;S$
5825 FORI=1TO6:PRINT @8,4+I;I;N$(I):PRINT @22,4+I;C$(CP(I)):NEXT
5830 PING:PRINT@14,12;" TO WHOM ? ":PRINT@14,14;" 0 : Nobody "
5835 GET A$:A=VAL(A$):IF A>6 OR A=P THEN 5830
5836 IFA=0THEN ZAP:GOTO 5985
5840 IF IT=20 OR IT=21 OR (IT>26ANDIT<34) THEN 5960
5845   IFSA(A,6)>0 OR ((IT>21ANDIT<27)ANDCP(A)<4)THEN5900
5855   IF(IT=34ANDCP(A)<>3)OR(IT=35ANDCP(A)<5)OR(IT=36ANDCP(A)<>6)THEN5900
5865   IFIT>37ANDIT<44 THEN IFBT(A)>0THEN5900ELSE BT(A)=IT:GOTO5980
5870  GOTO 5960
5900  L=12:GOSUB5990:GOTO5830
5960 CLS:PING:PRINT@22,10;"OK !":WAIT100:I=0 
5965 REPEAT:I=I+1
5970 UNTILSA(A,I)=0
5975 SA(A,I)=SA(P,O)
5980 SA(P,O)=0:OO=O:GOSUB 8920
5981 IFIT=35THENBS=1
5982 IFIT=36THENSD=1
5985 IF MENU=1THEN4000ELSERETURN
5990 ZAP:PRINT @14,L;"  !IMPOSSIBLE!  ":WAIT150:RETURN

6000 S$=" GREAT MARKET ":MENU=0:N=6:ENC=EE(VIL):GOSUB9500
6010 AL$="ALREADY GOT ONE !"
6020 PLOT10,12,"Who wants to trade  ?"
6030 PLOT12,16,"G > Give money"
6035 PLOT12,18,"L > Leave shops"
6040 GETP$:P=VAL(P$)
6050 IFP$="L"THEN M$="":O$="":S$="":GOSUB49000:GOTO4000
6055 IFP$="G"THEN GOSUB 9100
6060 IFP<1ORP>6OROK(P)>2THENZAP:GOTO6040

6070 S$=" WHICH SHOP ?":N=NS:ENC=EE(VIL):GOSUB9500:GOSUB9200
6080 PRINT@9,8;" 0 > Change customer ":FR=FRE(0)
6090 GETA$:SH=VAL(A$):IFSH>NSTHEN6090
6100 IFA$="C"THEN RI(P)=RI(P)+10000:GOTO6070
6110 IFA$="S"THENGOSUB8700:GOTO6070
6120 IFSH=0THEN6000

6130 REM CHOIX
6140 S$=SH$(SH):N=N(SH):EN=CO(SH):GOSUB 9500
6150 M$=" IMPOSSIBLE !":FD=145
6160 S$=CHR$(FD)+N$(P)+" "+C$(CP(P))+" "+STR$(RI(P))+" ss "+CHR$(144)
6165 L=2:GOSUB200
6170 PRINT@6,3;" Your choice ";:INPUTCH
6180 IFCH>NTHEN9000
6190 IFCH=0THEN6070
6195 IFSH=1THENSS=0
6200 IFSH=2THENSS=N(1)
6210 IFSH=3THENSS=N(1)+N(2)
6220 IFSH=4THENSS=N(1)+N(2)+N(3)
6230 IFPR%(CH+SS)>RI(P)THENM$=" TOO EXPENSIVE! ":GOTO9000
6240 IFOB(P,6)<>0THENM$=" BAG IS FULL! ":GOTO9000

6250 REM ARMES
6260 IFSH>1THEN6900
6270 IFCH>7THEN6500
6280 IFPT(P)>0THEN M$=AL$:GOTO9000
6290 IFCH>3THEN6400
6300 IFCP(P)>2THEN8990
6310 GOTO6460 
6400 IFCH>6THEN6450
6410 IFCP(P)>4THEN8990
6420 GOTO6460
6450 IFCP(P)<5THEN8990
6460 PT(P)=CH:CA(P)=8-CH
6470 M$=IT$(PT(P)):GOTO8960
6500 IFWR(P)>0ANDWL(P)>0THEN M$=AL$:GOTO9000
6520 IFCH>12THEN6550
6530 IFCP(P)>2THEN8990
6540 GOTO6800
6550 IFCH>14THEN6700
6570 IFCP(P)>4THEN 8990
6580 GOTO6800
6700 IFCH>17THEN6740
6710 IFCP(P)<3THEN8990
6720 IFCH=17AND(CP(P)<3ORCP(P)>3)THEN8990
6730 GOTO6800
6740 IFCH>18THEN6800
6760 IFCP(P)<>3THEN8990
6770 IFFI=1THEN M$=AL$:GOTO9000ELSEFI=1
6800 M$=IT$(CH)
6810 IFWR(P)=0THENWR(P)=CHELSEWL(P)=CH
6850 GOTO8960 
6900 IFSH>2THEN7000
6920 IFCP(P)=5ORCP(P)=6THEN6940
6930 IFCH>2ANDCP(P)<4THEN8990
6935 IFCP(P)=4ANDCH>7THEN8990
6940 M$=IT$(CH+SS):GOSUB7200
6950 GOTO8960

7000 IFSH=4THEN7100
7020 IFCH=9ANDCP(P)<5THEN8990
7030 IFCH=9THENIFBS=1THENM$=AL$:GOTO9000ELSEBS=1
7040 IFCH=10ANDCP(P)=6THENIFSD=1THEN M$=AL$:GOTO9000ELSESD=P
7050 IFCH=10ANDCP(P)<>6THEN8990
7080 M$=IT$(CH+SS):GOSUB7200
7090 GOTO8960

7100 REM ANIMAL
7100 IFCH=1ANDMP(P)<8THEN M$="Not for Southerners":GOTO9000
7130 IFBT(P)>0THEN M$=AL$:GOTO9000
7140 M$=IT$(CH+SS)
7150 BT(P)=CH+SS
7160 GOTO8960

7200 REM SAC
7210 IFSA(P,1)=0THENI=1:GOTO7260
7220 I=0:REPEAT 
7230 I=I+1
7240 UNTILSA(P,I)=0ORI=6
7250 IFSA(P,6)>0THEN M$="BAG IS FULL!":GOTO9000
7260 SA(P,I)=SS+CH
7270 RETURN

8700 IFWR(P)=0ANDWL(P)=0ANDPT(P)=0ANDSA(P,1)=0ANDBT(P)=0THENS$=" ! EMPTY ! ":GOSUB5650:PRINT@20,17;S$:ZAP:WAIT80:RETURN
8720 PING:S$="WHICH ONE ? ":GOSUB5650:PRINT@5,23;S$
8730 GETA$:CH=VAL(A$):IFCH>9THENZAP:GOTO8730
8740 IFCH=0THENCH=10
8760 IFCH>6THEN8790
8770 IFSA(P,CH)=0THEN8720
8782 IFSA(P,CH)=35THENBS=0:GOTO8800
8785 IFSA(P,CH)=36THENSD=0:GOTO8800
8790 IF(CH=7ANDWR(P)=0)OR(CH=8ANDWL(P)=0)OR(CH=9ANDPT(P)=0)OR(CH=10ANDBT(P)=0)THEN8720
8800 IFCH<7THENPX=PR%(SA(P,CH)):GOSUB8900:SA(P,CH)=0:OO=CH:GOSUB8920:GOTO8850
8810 IFCH>7THEN 8820
8812   IFWR(P)=18THENFI=0
8815   PX=PR%(WR(P)):GOSUB8900:WR(P)=0
8818   IFWL(P)>0THEN WR(P)=WL(P):WL(P)=0
8820 IFCH>8THEN8830
8822   IFWL(P)=18THENFI=0
8825   PX=PR%(WL(P)):GOSUB8900:WL(P)=0
8830 IFCH=9THENPX=PR%(PT(P)):GOSUB8900:PT(P)=0:CA(P)=0
8840 IFCH=10THENPX=PR%(BT(P)):GOSUB8900:BT(P)=0
8850 RETURN
8900 REM OK
8910 RI(P)=RI(P)+INT(PX*2/3):ZAP:RETURN

8920 FORI=OOTO5
8930 IFSA(P,I+1)>0THENSA(P,I)=SA(P,I+1):SA(P,I+1)=0
8940 NEXTI 
8950 RETURN

8960 REM VALIDE
8970 RI(P)=RI(P)-PR%(CH+SS):FD=148:GOTO9000

8990 M$="Impossible for a "+C$(CP(P))

9000 T=INT((38-LEN(M$))/2)
9010 PING:CLS:PRINT:PRINT@T,5;CHR$(FD);" ";M$;" ";CHR$(144)
9020 WAIT150:SS=0:IFSH=4ANDBT(P)>0THEN6070ELSE6130

9100 PING:PLOT6,16,">> Who wants to give money ? <<"
9110 GETP$:P=VAL(P$)
9120 IFP<1ORP>6OROK(P)>2THENZAP:GOTO9110
9130 GOSUB5700:GOTO6000
9150 RETURN

9200 REM CLIENT
9200 S$=CHR$(135)+CHR$(145)+"INVENTORY: "+N$(P)+" "+CHR$(128+ENC)
9230 L=10:T=INT((42-LEN(S$))/2)
9240 PRINT@T,L;S$;CHR$(144)
9250 L=L+2
9260 FORI=1TO14:PRINT@2,I+9;"*":PRINT@39,I+9;"*":NEXTI
9270 PRINT@29,L;C$(CP(P))
9280 PRINT@28,L+1;RI(P)"ss"
9290 PRINT@29,L+8;"AC>";CA(P)
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
9430 PRINT@6,L;CHR$(135);CHR$(145);" S)ell ";CHR$(128+ENC);CHR$(144)
9450 RETURN

9500 CLS:PRINT:INK(ENC):PRINTCHR$(17);
9510 POKE#26A,PEEK(#26A)AND254
9520 PRINT"**************************************"
9530 T=INT((33-LEN(S$))/2)
9540 S$="[ "+S$+" ] ":GOSUB5650:PRINT@T,1;S$;CHR$(128+EN)
9545 INK(EN):IFN<>6THENJ=N+4ELSEJ=N+2
9550 FORI=1TOJ:PRINT@2,I+1;"*":PRINT@39,I+1;"*":NEXTI
9570 FORI=1TON:L=I+2
9580   IFN<>6THEN9600
9585   T=34-LEN(STR$(RI(I)))
9586   IFOK(I)<3THENS$=C$(CP(I))ELSES$=OK$(OK(I))
9590   PRINT@4,L;I;N$(I);@18,L;S$;@T,L;RI(I);"ss":GOTO9700
9600   IFN<>NSTHEN9630
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
9710 IFN<>6ANDN<>NSTHENPRINT@12,L+3;" 0 to Leave"
9715 T=L+4:IFN=6THENT=L+2
9720 PRINT@2,T;"**************************************"
9750 RETURN

10000 TEXT:PAPER0:INKEE(VI):PRINT
10020 PRINT" ************************************"
10030 FORI=1TOL:PRINT@2,I;"*":PRINT@38,I;"*":NEXTI
10040 T=INT((31-LEN(S$))/2)
10060 S$="< "+S$+" > ":GOSUB5650:PRINT@T,1;S$
10080 PRINT@2,I;"*************************************"
10100 RETURN

10800 L=19:PRINT@1,L;CHR$(145)"CHARACTERS     CAREER     HP  ST  AC "
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

11000 CLS:L=20:S$=" # Alchemist Lab # ":EN=7:GOSUB10000
11010 S$=" AUTHORISED PEOPLE ":GOSUB5600:PLOT10,3,S$:J=1
11030 FORI=1TO6
11040 IFCP(I)<5THEN11060
11050 PRINT@11,4+J;J;N$(I);" ";C$(CP(I)):J=J+1
11060 NEXT
11065 IFJ=1THEN ZAP:PRINT @11,4+J;J;" GET OUT !":WAIT300:ZAP:GOTO4000
11070 IFVI<>9THENPRINT@10,5+J;" > There is nobody ":GOTO11090
11080 PRINT@10,5+J;J;"Northern Witch"
11090 IF PM=1THEN11170
11095 S$="Ingredients of Potion"+STR$(NP):GOSUB5600:PRINT@3,7+J;S$
11100 FORI=1TO6:PRINT @5,9+J+I;"-> ";IG$(I)
11110 IFIG(I)=1THENPLOT24,9+J+I,"> OK"
11120 NEXT
11121 L=21:GOSUB30000
11125 IFNP<6ORVI<>9ORPM=1THEN11200
11130 FORI=1TO5:SHOOT:WAIT30:PAPER I:NEXTI:EXPLODE:PAPER0
11140 FORI=1TO9
11150 PRINT@3,9+I;CHR$(144)"                                  ":NEXT
11160 PM=1:S$="The Athanor bakes the potion":GOSUB5650:L=12:GOSUB200
11165 FORI=1TO25:PRINT@7+I,14;">":WAIT20:NEXT
11170 L=12:S$="!! the potion is ready !! ":GOSUB5600:GOSUB200:PING:WAIT30
11180 S$="Let's go to Castleblack ":GOSUB5650:L=16:GOSUB200:ZAP:WAIT50
11190 L=21:GOSUB30000
11200 GOTO4000

22000 FOR P=1TO6' recharge sorts
22010 IFET(P)>0ANDET(P)<5THENET(P)=ET(P)+FNA(3)
22020 IFCP(P)<4THEN22070
22025 SS=NI(P):IFSS>8THENSS=8
22030 FORI=1TOSS
22035  IFI<5THENSN(P,I)=FNA(3)+1
22040  IFI=5ORI=6THENSN(P,I)=FNA(2)+1
22045  IFI=7THENSN(P,I)=FNA(2)
22050 NEXTI
22060 SN(P,8)=1
22070 NEXTP
22100 RETURN

30000 S$="< SPACE > ":GOSUB 5650:PRINT@13,L;S$:GETA$:IF A$<>" " THEN 30000
30001 RETURN

30100 IF KEY$="" THEN 30100
30101 RETURN

30200 GET A$:A=VAL(A$):IF A<1 OR A>6 THEN PING:GOTO 30200
30220 RETURN

40000 REM REINITIALISE TOUT
40010 FORI=1TO9
40020  FORJ=1TO4:CL(I,J)=0:NEXTJ'cles
40030  FORM=1TO5:TC(VIL,M)=0:NEXT M ' coffres et combats
40040 NEXTI
40050 FORI=1TO6:IG(I)=0:NEXTI:NP=0'ingredients potion
40070 X=2:Y=2:S=2:VILLE=1:TL=1
40080 PLOT23,16,"REINIT..OK":ZAP
40100 RETURN 

41000 REM BOOSTE TOUT
41010 FORI=1TO9
41020  FORJ=1TO4:CL(I,J)=1:NEXTJ'cles
41040 NEXTI
41050 FORI=1TO6:IG(I)=1'ingredients potion,
41055 NI(I)=15:XP(I)=0:RI(I)=10000:NEXTI:NP=6'persos
41070 X=2:Y=2:S=2:TL=9
41080 PLOT27,16,"BOOST..OK":ZAP
41100 RETURN 

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

50000 TI=20:HV=6:DF=0
50010 DIM IT$(55),PR%(55),IP$(10,2),TP$(2,15)
50020 GOSUB 50500
50060 FOR I=1TO4:READ TX$(I):NEXT I
50070 FOR I=1TO4:READ OK$(I):NEXTI
50080 FOR I=1TO9:FOR J=1TO4:READ PS$(I,J):NEXT J,I:READ PS$(9,5):READ PS$(9,6)
50090 DEF FNA(X)=INT(RND(1)*X)+1
50100 FORI=1TO6:READ C$(I):NEXTI
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


51010 DATA "Ouch!","Wall seems in good condition","Are you drunk ?","Where is the key ?"
51020 DATA "OK","-Poison- ","-Paral- ",">DEAD< "
51021 DATA "King Robert","Queen Cersei","JAIL","Council"
51022 DATA "Prince Oberyn","Laboratory","JAIL","CELLAR"
51023 DATA "Lord Stannis","Melisandre","JAIL","SOLAR"
51024 DATA "Sir Loras","Lady MAERGERY","JAIL","COFFERS"
51025 DATA "Asha Greyjoy","Theon Greyjoy","JAIL","CELLAR"
51026 DATA "Petyr","Lady Sansa","SKY CELL","MOON DOOR"
51027 DATA "Lord Tyrion","Lord Tywin","JAIL","CHAPEL"
51028 DATA "Lord Brynden","PIGPEN","JAIL","Kitchens"
51029 DATA "Lord Starck","Master Luwin","RANGER","CASTLEBLACK","-SOUTH-","- NORTH -"
51050 DATA Knight,Mercenary,Ranger,Wizard,Maester,Septon
51060 DATA None,"KING'S LANDING",1, MARTELL,DORNE,5, BARATHEON,"STORM'S END",3, TYRELL,HIGHGARDEN,2
51070 DATA GREYJOY,PIKE,5, ARRYN,EYRIE,6, LANNISTER,CASTERLY ROCK,1
51080 DATA TULLY,RIVERRUN,4, STARK,WINTERFELL,7
51100 DATA ARMORY,19,7, BOTANICS,7,2, BAZAAR,10,3, ANIMALS,7,5
52000 DATA "royal leech","lily flower","kraken ink","rose of the Vale","oil of the Rock","trout liver"
53000 DATA SLEEP, FIRE, STONE, VENOM, BLOOD,  LIGHTNING, LAVA, EARTHQUAKE
53010 DATA WATER, SERUM, MUSCLE, SHIELD, ELIXIR, SCREEN, LIFE, DEATH
53020 DATA FIRE-SWORD, STRENGTH, CHARM, VISION, FREEZE, ILLUSION, WIND, DRAGON
