10 REM {++ ORIC 2014 + TYRANN 3 VO MAXIMUS +}
11 POKE 48035,0
12 PAPER0:INK6:POKE#26A,PEEK(#26A) AND 254
19 A=DEEK(#308):R= RND(-A)
20 GRAB : HIMEM 40959 : GOSUB 48000: GOSUB 42100 : POKE 48035,0
21 NO=CA-30 ' numero du combat
22 IF NO<13 THEN NC=1:GOTO 30 ' niveau du combat
23 IF NO<18 THEN NC=2:GOTO 30
24 NC=3

30 CLS:PAPER0:INK6:POKE#26A,PEEK(#26A) AND 254
40 PLOT 8,6,"! MONSTERS ATTACK !":PING

50 GOSUB 50000
110 GOTO 3000

200 PAPER0:INK ENC:PRINT
220 PRINT" ************************************"
230 FORI=1TOL:PRINT@2,I;"*":PRINT@38,I;"*":NEXTI
240 T=INT((33-LEN(S$))/2)
250 PRINT @ T,1;" ";CHR$(145);"< ";S$;" > ";CHR$(144)
260 PRINT@2,I;"*************************************"
290 RETURN

300 T=INT((42-LEN(S$))/2):PRINT @T,L;S$
320 RETURN

400 PRINT@14,L;" ";CHR$(145);"< SPACE > ";CHR$(144):GETA$:IFA$<>" "THEN400
420 RETURN

500 GET A$:A=VAL(A$):IFA<1ORA>6THENPING:GOTO500
510 RETURN

600 PING:PRINT @2,18;CHR$(148)" IMPOSSIBLE "CHR$(144)
610 WAITTI*3:GOSUB 8300
615 ZAP:PRINT @2,18;"              "
620 RETURN

700 FORII=1TO11:
720 PRINT@1,7+II;CHR$(144)"                                         ":NEXTII
730 RETURN

750 FOR J=1TO11
760 PRINT @3,10+J;"                                   ":NEXTJ
790 RETURN

800 GOSUB 700:PRINT @9,12;"Time (1-3) Now:";TI/5;:INPUT TI
820 IF TI<1 OR TI>3 THEN PING:GOTO 800
830 TI=5*TI
850 RETURN

3000 REM COMBATS
3010 T=15
3020 IF VIL > 2 THEN T=12
3025 IF VIL > 5 THEN T=7
3026 IF NC=2 THEN T=T-3
3027 IF NC=3 THEN T=T-5
3028 IF VIL > 7 THEN T=0
3030 NE=FNA(4)+1
3040 IF VIL<3 AND NE>3THEN NE=3
3045 EV=NE 
3050 FOR I=1 TO NE
3060  SS=FNA(NM-T):MO(I)=SS
3080  C1AGI(I)=CM(SS,1)+FNA(VIL)*2
3090  C2PV(I)= CM(SS,2)+FNA(VIL*2)+NC*4:DC=DC+C2(I) 
3100  C3CC(I)= CM(SS,3)+FNA(VIL)
3110  C4BF(I)= CM(SS,4)
3120  C5QI(I)= CM(SS,5)+FNA(VIL)
3140  C6OK(I)=1
3150 NEXT I
3160 DC=INT(DC/7)+FNA(VIL)

3200 REM INIT
3210 FU=0:ZO=0:HV=6:DR=0:DD=0:AMI=0:FF=0
3220 GOSUB 10500'Tri  
3230 FOR I=1TO6:BC(I)=CA(I):EF(I)=0:FC(I)=0:PRD(I)=0
3240  IF OK(I)=4 THEN HV=HV-1
3250 NEXT

4000 REPEAT
4010  TEXT:CLS:INK6:POKE#26A,PEEK(#26A) AND 254
4020  POKE 48035,0
4030   GOSUB 8100
4040   GOSUB 8300
4041  IF FF= 0 THEN GOSUB 8910
4042  IF BUG=1 THEN 6500
4050  FOR P=1TO6
4060   ACT(P)=3
4070   IF OK(P)<3 THEN GOSUB 8500 ELSE 4090
4080   GOSUB 8700
4090   GOSUB 700
4100  NEXT P
4110 PRINT @8,12;"CHANGE YOUR CHOICES (Y/N)?"
4115 PRINT @8,16;"CHANGE DISPLAY TIME: T"
4120 GETR$:IF R$="" THEN 4120
4130  IF R$="Y" OR R$="y" THEN 4010
4140  IF R$="N" OR R$="n" THEN 4200
4145  IF R$="T" OR R$="t" THEN GOSUB 800:GOTO 4110
4150 PING:GOTO 4120

4200 REM tour 
4210 IF DRAG>0 THEN DD=1:GOSUB 33850
4220 FOR P=1TO6+NE 
4230  ACT$=" attacks ":GOSUB 700
4240  PRINT@2,7;CHR$(145)"************** COMBAT ************** "CHR$(144)
4250  IF ESP(P)=0 AND EV>0 THEN GOTO 6000  
4300   REM HEROS
4310   IF OK(AO(P))>2 THEN 6300
4320   ON ACT(AO(P)) GOTO 4500,4600,5000,4800
4500   IF C2PV(TG(AO(P)))<=0 THEN 6300 
4510   GOSUB 11000
4520   L=10:S$=N$(AO(P))+ACT$:GOSUB 300:WAIT TI*5
4530   L=12:S$=MM$(MO(TG(AO(P)))):ZAP:GOSUB 300:WAIT TI*5
4540   IF C6OK(TG(AO(P)))>2 THEN DFF=DFF+30
4550   GOSUB 15000:DFF=FNA(VIL*3)
4555  'PRINT@6,6;"TST";TST;"SS";SS;"RT";RT;"  ":WAIT100
4560 IF ARM <4 THEN GOSUB 11200 ELSE GOSUB 11300

4590 GOTO 5000

4600 REM ACT 2
4610 GOSUB 9700
4620 GOTO 5000

4800 REM ACT 4
4810 IF EV=0 THEN 6300
4850 GOSUB 26000

5000 IF OK(AO(P))=2 THEN ET(AO(P))=ET(AO(P))-FNA(2)-FNA(VIL)
5010 IF ET(AO(P))<=0 THEN OK(AO(P))=4:ET(AO(P))=0:HV=HV-1
5050 GOTO 6300

6000 REM monstre
6010 IF C6OK(AO(P))>4 OR C6OK(AO(P))=0 THEN 6300 
6020 IF C6OK(AO(P))=4 AND EV>0 THEN GOSUB 36000:GOTO 6200
6030 IF C6OK(AO(P))=6 THEN GOSUB 16010:GOTO 6300 
6050  IF HV>0 THEN GOSUB 17000 ELSE 6300
6070  IF C6OK(AO(P))<2 OR C6OK(AO(P))>3 THEN 6200
6080   C2(AO(P))=C2(AO(P))-FNA(C6(AO(P))*4)-2
6100   IF C2(AO(P))> 0 THEN 6300
6110   IF C6OK(AO(P))=6 THEN FU=0
6120   C2(AO(P))=0:C6OK(AO(P))=0:EV=EV-1
6130   PRINT @15,16;MM$(MO(AO(P)));" dies ":EXPLODE:WAIT 5*TI
6200 WAIT 15*TIME
6300 NEXT P
6310 FOR I=1TO6:PRD(I)=0:NEXT
6320 GOSUB 10520
6500 UNTIL EV<1 OR HV<1
6501 IFBUG=1THENBUG=0:HIRES:ZAP:WAIT50:GOTO4000
6510 FORP=1TO6:BC(P)=CA(P):NEXTP
6520 IFPD=1THEN GOSUB23200:PD=0

6600 IF HV>0 THEN 20000 

7000 REM Defeat
7000 CLS:FORI=7TO0STEP-1:ZAP:WAIT10:PAPERI:NEXT:EXPLODE
7010 PRINT @6,8;" Your team is destroyed "
7020 PRINT @5,12;"1.Retry"
7030 PRINT @5,14;"2.Retreat"
7050 GOSUB 8300
7060 GETA$:IF A$<"1" OR A$>"2" THEN 7060
7070 IF A$="1" THEN RELEASE : LOAD "LABY"
7080 CLS:PRINT@15,5;"Coward !":ZAP:RELEASE:END 

8000 REM |SOUS PROGS  

8100 REM ENNEMIS
8110 FORI=1TO6:PRINT@1,I;"                               ":NEXT
8120 FORI=1TONE
8130  S$=STR$(I)+" "+MM$(MO(I)):C=3
8135 IF C6OK(I)=0 THEN S$=CHR$(149)+CHR$(128)+S$+" (DEAD) "+CHR$(144):C=1:GOTO 8250
8140  ON C6OK(I) GOTO 8220,8150,8160,8170,8180,8190
8150   C=2:S$=CHR$(130)+S$+" (Poison)"+STR$(C2(I)):GOTO 8250
8160   C=2:S$=CHR$(129)+S$+" (Bleed)"+STR$(C2(I)):GOTO 8250
8170   C=2:S$=CHR$(134)+S$+" (Friend)":GOTO 8220
8180   C=2:S$=CHR$(131)+S$+" (Asleep)":GOTO 8220
8190   C=2:S$=CHR$(132)+S$+" (-Net-)"
8220  IF ZO=1 THEN S$=S$+CHR$(130)+STR$(C2(I))
8250  PRINT@C,I;S$
8260 NEXTI
8290 RETURN

8300 REM EQUIPE
8310 L=19:PRINT@1,L;CHR$(145)"CHARACTERS     CAREER     HP  ST  AC "
8320 FOR I=1TO6:L=L+1
8330  IF CP(I)=1 THEN ENC=131
8335  IF CP(I)=2 THEN ENC=135
8340  IF CP(I)=3 THEN ENC=134
8350  IF CP(I)=4 THEN ENC=133
8360  IF CP(I)=5 THEN ENC=132
8370  IF CP(I)=6 THEN ENC=130
8380  IF OK(I)=4 THEN ENC=129
8390  IF OK(I)>1 THEN S$=OK$(OK(I)) ELSE S$=C$(CP(I))
8400 PRINT @ 1,L;CHR$(ENC);I;N$(I);:PRINT @ 17,L;S$;
8410 S$=STR$(BC(I)+PRD(I)):IF BC(I)+PRD(I)>9 THEN S$="MAX"
8415 IFBC(I)=50THEN S$="GOD"
8420 PRINT @ 27,L;PV(I):PRINT @ 34-LEN(STR$(ET(I))),L;ET(I):PRINT @ 36,L;S$
8430 NEXT I
8450 RETURN

8500 REM INVENTARY
8510 L=7:E1=132:E2=132
8520 PRINT@2,L;CHR$(145)"*********************************** "CHR$(144)
8530 S$=" "+N$(P)+" - "+C$(CP(P))+" "
8540 T=INT((41-LEN(S$))/2)
8550 PRINT @T,L;S$:L=L+2
8560 IF EF(P)=0 THEN 8600 ELSE IF EF(P)=1 THEN E1=129 ELSE E2=129
8600 PRINT @3,L;CHR$(E1);"1.R:";IT$(WR(P));CHR$(131):L=L+1
8610 PRINT @3,L;CHR$(E2);"2.L:";IT$(WL(P));CHR$(131):L=L+1
8620 PRINT @3,L;CHR$(132);"3.Anim:";:IF BT(P)>0 THEN PRINT IT$(BT(P));CHR$(131)
8630 OP(P)=0
8650 FORI=1TO6
8660 IF SAD(P,I)=0 THEN 8680
8670 PRINT @2,L+I;CHR$(134);I+3;ITEM$(SAD(P,I));CHR$(131):OP(P)=OP(P)+1
8680 NEXT I
8690 RETURN

8700 REM CHOIX
8720 PRINT@29,9;CHR$(145)"ACTION "CHR$(144)
8730 IF WR(P)=0 AND WL(P)=0 AND BT(P)=0 THEN ARM=0 ELSE ARM=1
8740 IF ARM=1 THEN PRINT@29,11;CHR$(131)"A)TTACK"
8750 IF OP(P)>0 THEN PRINT@29,12;CHR$(131)"U)SE ITEM"
8760 PRINT@29,13;CHR$(131)"P)ARRY"
8770 IF CP(P)>3 THEN PRINT@29,14;CHR$(131)"S)PELL"
8800 GET A$
8810 IF A$="A" AND ARM=1 THEN ACT(P)=1:GOTO 9000
8820 IF A$="U" AND OP(P)>0 THEN ACT(P)=2:GOSUB 9200:GOTO 8900 
8830 IF A$="P" THEN ACT(P)=3:PRD(P)=1+FNA(2):GOSUB 8300:GOTO 8900 
8840 IF A$="S" AND CP(P)>3 THEN ACT(P)=4:GOSUB 25000:IF CH=0 THEN 8700 ELSE 8900
8860 GOTO 8800
8900 RETURN

8910 REM FUITE
8915 FF=1:PRINT@15,12;CHR$(131)"FLEE Y/N"
8920 GETA$
8922 IF A$="B" THEN BUG=1:RETURN
8925 IF A$<>"Y" AND A$<>"N" THEN 8920
8930 IF A$="N" THEN 8980
8931 TEST=(VIL*2)+FNA(40)+10+NF
8935 IF TEST>AG(FNA(6)) THEN NF=0:GOTO 8970
8940 CLS:PRINT@13,8;CHR$(145)" YOU FLEE !!"CHR$(144)
8945 PRINT@13,10;"BACK TO MAZE":PRINT:NF=NF+20
8950 FORJ=1TO5:ZAP:WAIT5:NEXT:SHOOT:WAIT5
8960 GOSUB 49000 : FR=FRE("") : RELEASE : LOAD("LABY")
8970 PRINT@15,12;CHR$(131)"  FAIL  ":SHOOT:WAITTI*4
8980 PRINT@15,12;CHR$(131)"         "
8990 RETURN

9000 IF WL(P)=0 AND BT(P)=0 THEN A$="1":GOTO 9040
9015 IF WR(P)=0 THEN A$="3":GOTO 9060
9020  PRINT @4,8;"> Which one 1-3 ? "
9030  GET A$:IF A$<>"1"ANDA$<>"2"ANDA$<>"3" THEN 9030
9040 IF A$="1" THEN BF(P)=IMPACT(WR(P)-7):AU(P)=WR(P):GOTO 9070
9050 IF A$="2" THEN IF WL(P)>0 THEN BF(P)= IMPACT(WL(P)-7):AU(P)=WL(P) ELSE 9030
9060 IF A$="3" THEN IF BT(P)>0 THEN BF(P)= IA(BT(P)-36):AU(P)=BT(P) ELSE 9030
9070 IF AU(P)=18 AND FU=1 THEN PRINT@25,16;" NET in USE ":WAIT 5*TI:GOSUB 700:GOSUB 8500:GOTO 8700
9080 BF(P)=BF(P)+INT(FO(P)/10)+FC(P):GOSUB 9600
9090 WAIT 5*TI
9100 RETURN

9200 REM OBJET OC(P)
9210 PRINT@31,12;CHR$(145)"U)SE "CHR$(144)
9220 PRINT @29,16;"Which one?":PRINT @31,17;"0: None"
9230 GETA$:CH=VAL(A$):IF (CH>0 AND CH<4) OR CH>OP(P)+3  THEN 9230
9240 IF CH=0 THEN GOSUB 700:GOSUB 8500:GOTO 8700
9250 CH=CH-3:OC(P)=SAD(P,CH):CS(P)=CH
9260 PRINT@1,11+CH;CHR$(145):PRINT@27,11+CH;CHR$(144)
9270 IF OC(P)>19 AND OC(P)<25 THEN GOSUB 9500:GOTO 9350 
9290 IF (OC(P)>24 AND OC(P)<34) THEN PING:GOTO 9350
9310 GOSUB 600:GOSUB 700:GOSUB 8500:GOTO 8700
9320 WAIT 5*TI
9350 RETURN

9500 REM CIBLER PERSO
9510 PING:PRINT @2,19;CHR$(148)"  On Who ?  "CHR$(145)
9520 GOSUB 500
9530 TG(P)=VAL(A$)
9540 PRINT@1,19;CHR$(145)"CHARACTERS     CAREER     HP  ST  AC "
9550 RETURN

9600 REM CIBLER ENNEMI
9610 PRINT @3,6;CHR$(145)"* TARGET ? "CHR$(144)
9620 GET A$:IF VAL(A$)<1 OR VAL(A$)>NE THEN 9620
9630 IF C6OK(VAL(A$))=0 THEN 9620
9640 PRINT @3,6;CHR$(144)"           "
9650 TG(P)=VAL(A$)
9690 RETURN

9700 REM ITEMS

9710 REM UTIL OBJET
9720 IF OC(AO(P))=25 OR OC(AO(P))=26 OR OC(AO(P))>31 THEN 9770
9730 IF OC(AO(P))=20 OR OC(AO(P))=21 THEN GOSUB 22500:GOTO 9760
9740 IF OC(AO(P))=22 THEN GOSUB 23300:GOSUB 9950:GOTO 9760
9745 IF OC(AO(P))=23 THEN GOSUB 23400:GOTO 9760
9750 IF OC(AO(P))=24 THEN GOSUB 23000:GOTO 9760
9755 IF OC(AO(P))>26 AND OC(AO(P))<32 THEN GOSUB 10000
9760 WAIT 5*TI:GOSUB 8300:GOTO 9790
9770 IF OC(AO(P))=25 THEN PRINT @6,10;N$(AO(P))" use Warg vision ":ZO=1:GOTO 9790
9775 IF OC(AO(P))=26 THEN PRINT @6,10;N$(AO(P))" use freezing potion":GOSUB 33520:GOTO 9790
9780 IF OC(AO(P))=32 OR OC(AO(P))=33 THEN PRINT @6,10;N$(AO(P))" explode ";IT$(OC(AO(P))):GOSUB 10100:GOSUB 9850
9790 SAD(AO(P),CS(AO(P)))=0:WAITTI*5
9795 GOSUB 10700
9800 RETURN

9850 REM eveil
9855 IF REVEIL=O THEN 9880
9860 IF FNA(100)> C5(REVEIL) THEN 9880
9865 PING:PRINT@2,17;" > noise awakes "+MM$(MO(REVEIL)):WAITTI*8
9870 C6OK(REVEIL)=1:GOSUB 8100
9880 RETURN

9900 REM CURE
9905 IF OK(TG(AO(P)))=4 THEN 9930
9910 SS=FNA(4)+FNA(VIL)+3:IF OC(AO(P))=21 THEN SS=SS+4:OK(TG(AO(P)))=1
9920 ET(TG(AO(P)))=ET(TG(AO(P)))+SS:IF ET(TG(AO(P)))>PV(TG(AO(P))) THEN ET(TG(AO(P)))=PV(TG(AO(P)))
9930 RETURN

9950 REM LIFE
9955 IF OK(TG(AO(P)))<>4 THEN 9990
9960 OK(TG(AO(P)))=1: ET(TG(AO(P)))=INT(PV(TG(AO(P)))/2)
9970 HV=HV+1:GOSUB 8300
9990 RETURN

10000 REM FOOD
10010 IF OC(AO(P))=27 THEN M$=" drinks water ":P1=4:P2=2:GOTO 10060
10020 IF OC(AO(P))=28 THEN M$=" eats some bread ":P1=5:P2=3:GOTO 10060
10030 IF OC(AO(P))=29 THEN M$=" sips some ale ":P1=8:P2=3:GOTO 10060
10040 IF OC(AO(P))=30 THEN M$=" swallows fish ":P1=8:P2=4:GOTO 10060
10050 IF OC(AO(P))=31 THEN M$=" devours boar meat ":P1=10:P2=6
10060 SS=FNA(P1)+P2:S$=N$(AO(P))+M$:L=10:GOSUB 300
10070 ET(AO(P))=ET(AO(P))+SS:IF ET(AO(P))>PV(AO(P)) THEN ET(AO(P))=PV(AO(P))
10090 RETURN

10100 REM GREGEOIS & SORTS COLLECTIFS
10110 DG=6:IF OC(AO(P))=32 THEN DG=3
10120 FORJ=1TO5:SHOOT:WAIT15:PAPER J:NEXTJ:EXPLODE:PAPER0:GOSUB 700
10130 IF EV=0 THEN 10290
10140 LG=0:REVEIL=0
10150 FORI=1TO NE
10160 IF C6OK(I)<1 THEN 10200
10165 IF C6OK(I)=5 THEN REVEIL=I:PING
10170 LG=LG+1
10175 SS=FNA(DG)+DG:IF C6OK>4 THEN SS=SS*3
10180 S$=MM$(MO(I))+" looses "+STR$(SS)+" HP":GOSUB 10300
10190 PRINT @3,9+LG;S$:WAIT TI*5
10200 NEXT I
10210 DD=0
10250 IF EV<=0 THEN 10290
10260 GOSUB 8100:WAIT TI*5
10290 RETURN

10300 REM mort ?
10310 C2PV(I)=C2(I)-SS:IF C2(I)>0 THEN 10350
10320 S$=S$+CHR$(129)+" and dies":IF C6OK(I)=6 THEN FU=0 
10330 EV=EV-1:C6OK(I)=0:IF C6=4THENAMI=0
10340 IFDD=1THENMT(SD)=MT(SD)+1ELSEMT(AO(P))=MT(AO(P))+1
10350 RETURN

10499 REM + Tri persos 
10500 FOR P=1TO 6:JA=FNA(10):AO(P)=P:ESP(P)=1:VE(P)=AG(P)+JA:MT(P)=0:NEXTP
10510 FOR E=1TONE:JA=FNA(10):AO(E+6)=E:ESP(E+6)=0:VE(E+6)=C1AG(E)+JA:NEXTE
10520 REPEAT
10530  SS=0
10540  FOR J=1 TO 5+NE
10550   IF VE(J)>=VE(J+1) THEN 10600 
10560   TP=VE(J):VE(J)=VE(J+1):VE(J+1)=TP
10570   TP=ESP(J):ESP(J)=ESP(J+1):ESP(J+1)=TP
10580   TP=AO(J):AO(J)=AO(J+1):AO(J+1)=TP
10590   SS=1
10600  NEXTJ
10610 UNTIL SS=0
10650 RETURN

10700 REM  TRI SAC
10710 FOR I=1TO5
10720  IF SAD(AO(P),I)>0 THEN 10750
10730  IF SAD(AO(P),I+1)>0 THEN SAD(AO(P),I)=SAD(AO(P),I+1):SAD(AO(P),I+1)=0
10750 NEXT I
10790 RETURN

11000 REM ARMES
11010  IF AU(AO(P))>19 THEN ARM=3:TST=3:ACT$=" casts "+IT$(BT(AO(P)))+" on ":GOTO 11100
11020  IF AU(AO(P))>7  AND AU(AO(P))<15 OR AU(AO(P))=19 THEN TST=1:ARM=1:GOTO 11100
11030  IF AU(AO(P))>14 AND AU(AO(P))<18 THEN TST=2:ARM=2
11040   IF AU(AO(P))=15 THEN ACT$=" shoots a bolt on ":DFF=20:GOTO 11100 
11050   IF AU(AO(P))=16 THEN ACT$=" shoots an arrow on ":DFF=10:GOTO 11100 
11060   IF AU(AO(P))=17 THEN ACT$=" shoots a stone on ":DFF=-5:GOTO 11100 
11070  IF AU(AO(P))=18 THEN TST=3:DFF=15:ARM=4:ACT$=" throws the net on "  
11100 RETURN

11200 REM EFFET ARME
11210 IF C6OK(TG(AO(P)))>4 OR VE(AO(P))> 80 THEN RT=1
11215 IF RT=0 THEN PING:PRINT@15,14;" and fails ! ":GOTO 11280
11220 SS=VIL+FNA(5)+BF(AO(P))
11225 IF EF(AO(P))>0 THEN SS=SS+((1+FNA(2))*(BF(AO(P))))
11230 IF C6OK(TG(AO(P)))>4 THEN SS=SS+C2PV(TG(AO(P)))
11240 C2PV(TG(AO(P)))=C2PV(TG(AO(P)))-SS
11250 PRINT @12,14;"inflicts it "SS" damage"
11260 IF C2PV(TG(AO(P))) <= 0 THEN MT(AO(P))=MT(AO(P))+1:S$=MM$(MO(TG((AO(P))))):GOTO 40000
11280 WAIT 15*TI
11290 RETURN

11300 REM NET
11310 IF RT=1 THEN C6OK(TG(AO(P)))=6:S$=" ENEMY CAPTURED WITH THE NET !":FU=1 ELSE S$="net misses target"
11320 PRINT @8,14;S$:WAIT 10*TI:IF RT=1 THEN GOSUB 8100
11350 RETURN

15000 REM + TESTS > D100
15020 SS=FNA(100):RT=0
15030 ON TST GOTO 15100,15200,15300,15400,15500

15100 REM Combat
15110 IF ESP(AO(P))=0 THEN 15130
15120 IF SS < CC(AO(P))  +DFF THEN RT=1:GOTO 15150
15130 IF SS < C3CC(AO(P))+DFF THEN RT=1
15150 WAIT100:RETURN:'PRINT@6,6;"TST";TST;"SS";SS;"RT";RT;"  "

15200 REM Tir
15210 IF ESP(AO(P))=0 THEN 15230
15220 IF SS<CT(AO(P))  +DFF THEN RT=1:GOTO 15250
15230 IF SS<C3CC(AO(P))+DFF THEN RT=1
15250 WAIT100:RETURN:'PRINT@6,6;"TST";TST;"SS";SS;"RT";RT;"  "

15300 REM Agility
15310 IF ARM=3 THEN IF SS < AANIM(AO(P))+DFF THEN RT=1:GOTO 15350
15320 IF ESP(AO(P))=1 THEN IF SS<AGI(AO(P))+DFF THEN RT=1:GOTO 15350
15330 IF ESP(AO(P))=0 THEN IF SS<C1AG(AO(P))+DFF THEN RT=1
15350 WAIT100:RETURN:'PRINT@6,6;"TST";TST;"SS";SS;"RT";RT;"  "

15400 REM QI
15410 IF ESP(AO(P))=0 THEN 15430
15420 IF SS<IN(AO(P)) +DFF THEN RT=1:GOTO 15450
15430 IF SS<C5QI(AO(P))+DFF THEN RT=1
15450 WAIT100:RETURN:'PRINT@6,6;"TST";TST;"SS";SS;"RT";RT;"  "

15500 REM FM
15510 IF ESP(AO(P))=0 THEN 15530
15520 IF SS<FM(AO(P))+DFF THEN RT=1:GOTO 15550
15530 IF SS<C5QI(AO(P))+DFF THEN RT=1
15550 WAIT100:RETURN:'PRINT@6,6;"TST";TST;"SS";SS;"RT";RT;"  "

16000 REM ENEMY 
16010 REM net 
16010 S$=MM$(MO(AO(P)))
16020 PRINT @2,10;CHR$(129);S$;" tries to get free ":WAIT TI*5
16030 TST=3:DFF=-30:GOSUB 15000:WAIT 8*TI
16050 IF RT=0 THEN S$=S$+" stays captured " ELSE S$=S$+" frees from the net "
16060 PRINT @2,12;CHR$(129);S$:WAIT 8*TI
16070 IF RT=1 THEN FU=0:C6OK(AO(P))=1:ZAP:GOSUB 8100
16080 GOSUB 700
16090 RETURN

17000 REM Enemy attack
17010 TE=FNA(6):IF OK(TE)=4 THEN 17010
17015 TE$=N$(TE):SS$=" attacks ":TST=1
17020 IF MO(AO(P))>14 THEN IF FNA(10)>7 THEN SS$=" casts a spell on":TST=4:IF MO(AO(P))> 20 THEN TE$="the team"
17025 L=10:S$=CHR$(129)+MM$(MO(AO(P)))+SS$:GOSUB 300:ZAP
17030 L=12:S$=CHR$(129)+TE$:GOSUB 300:WAITTI*10
17040 DFF=(2*VIL)+FNA(10):GOSUB 15000:IF RT=0 THEN SS$="and fails": GOTO 17080
17050 IF TST=4 THEN GOTO 17150 
17055   SS=1+VIL+FNA(VIL)+CM(AO(P),4)-BC(TE)-PRD(TE)'FORMULA MONSTER ATTACK
17058 IF SS<=0 THEN SS$="the armor resists !":GOTO 17080
17060 SS$="inflicts him "+STR$(SS)+" damage"
17065 ET(TE)=ET(TE)-SS:ZAP:WAIT TI*5
17070 IF ET(TE)<=0 THEN ET(TE)=0:OK(TE)=4:HV=HV-1
17080 L=14:S$=SS$:GOSUB 300:WAITTI*5
17090 IF OK(TE)=4 THEN PRINT @15,16;"and s/he dies...":EXPLODE
17095 GOSUB 8300
17100 GOTO 18000

17150 REM week spells
17160 IF MO(AO(P)) > 20 THEN 17500
17200 IF FNA(10)>6 THEN SM=FNA(4)ELSE SM=1 
17210 ON SM GOTO 17250,17300,17350,17400
17250 FOR I=1TO13:PRINT@3+I,12;CHR$(129);"*":WAIT3:NEXT:SHOOT
17260 SS=6+FNA(VIL)-INT(FM(TE)/10):GOTO 17060
17290 GOTO 17450
17300 IF OK(TE)=1 THEN SS$="he poisons him":OK(TE)=2 ELSE 17200
17340 GOTO 17450
17350 IF OK(TE)=1 THEN SS$="his muscles doesn't respond":OK(TE)=3 ELSE 17200
17390 GOTO 17450
17400 SS$="his protection decreases":BC(TE)=BC(TE)-1-FNA(2)
17410 IF BC(TE)<0 THEN BC(TE)=0

17450 L=14:S$=SS$:GOSUB 300:WAITTI*12
17460 GOTO 18000

17500 REM strong spells
17510 SM=FNA(5)
17511 GOSUB 700
17512 L=9:S$=SM$(SM):GOSUB 300:ZAP:WAITTI*20:LL=10
17515 IF SM=4 THEN MALUS=MALUS+1+FNA(2):GOTO 18000
17516 IF SM=5 THEN GOSUB 18500:GOTO 18000
17530 FORJ=1TO6
17535 IF OK(J)=4 THEN 17990 ELSE LL=LL+1
17540 IF SM > 1 THEN 17600
17550   BC(J)=BC(J)-1-FNA(2)
17560   IF BC(J)<0 THEN BC(J)=0
17570   S$=" "+STR$(BC(J))+" "
17590   PRINT@35,19+J;S$:GOTO 17990
17600   SS=VIL+2+FNA(4)+CM(AO(P),4)
17605 IF CP(J)>3 THEN SS=SS-INT(QI(J)*2/10):IF SS<=0 THEN SS=1
17610   PRINT @5,LL;N$(J);" looses ";SS;" hp":ET(J)=ET(J)-SS
17620   IF ET(J)<=0 THEN ET(J)=0:OK(J)=4:HV=HV-1
17630   IF OK(J)=4 THEN PRINT @30,LL;"and dies!":EXPLODE
17900 WAITTI*5
17950 GOSUB 8300
17990 NEXTJ
18000 RETURN

18500 REM Cure
18505 L=11
18510 FOR J=1TONE
18515 S$=" is cured"
18520 IF C6(J)<2 OR C6(J)>3 THEN 18550
18530 C6(J)=1:C2=C2+5+FNA(8)
18540 S$=MM$(MO(J))+S$:GOSUB 300:WAIT TI*8:L=L+1
18550 NEXTJ
18555 GOSUB 8100
18560 RETURN

20000 REM RECOMPENSES
20010 TEXT:CLS:POKE#26A,PEEK(#26A) AND 254
20015 ENC=4:S$="RESULTS OF THE BATTLE":L=22:GOSUB 200
20020 PING:PRINT@14,4;"!  YOU WIN  !"
20040 PRINT@6,6;"Each survivor wins at least:"
20050 XP=DC*5:PO=DC*3:PRINT@6,8;"> Points:";XP
20060 PRINT@6,9;"> Money:";PO;" sd"
20070 FU=0
20150 FOR P=1TO6
20160 IF OK(P)>2 THEN 20170
20162 XP(P)=XP(P)+XP+(MT(P)*20)+FNA(10*VIL)
20164 RI(P)=RI(P)+PO+(MT(P)*25)+FNA(10*VIL)
20170 IF MT(P)< NE THEN 20220
20180 S$="Well done "+N$(P):L=11:GOSUB 300:WAITTI*8
20190 S$="who killed them all !":L=12:GOSUB 300:WAITTI*12
20195 PRIME=(NE*100)+FNA(DC*20)
20200 S$="A special bounty of"+STR$(PRI)+" ss":L=14:GOSUB 300:WAITTI*12
20201 RI(P)=RI(P)+PRI:XP(P)=XP(P)+XP+(MT(P)*20)+FNA(10*VIL)
20210 L=16:GOSUB 400:GOSUB 750
20220 IF XP(P)>1000+(VIL*150) AND NI(P)<21 AND OK(P)<>4 THEN GOSUB 21000 
20250 NEXT P
20260 L=18:S$="LET'S MOVE ON !":GOSUB 300
20270 L=21:GOSUB 400
20280 PING
20290 CA=0
20300 GOSUB 49000 : FR=FRE("") : RELEASE : LOAD("LABY")

21000 REM PROMOTION NEW
21010 NI(P)=NI(P)+1:XP(P)=0:FORJ=1TO5:PING:WAIT2*J:NEXT
21020 S$=CHR$(145)+C$(CP(P))+" "+N$(P)+" "+CHR$(144)+CHR$(132):L=11:GOSUB 300
21030 S$="rises to level :"+STR$(NI(P)):L=12:GOSUB 300
21040 S$="And earns some HP !":L=13:GOSUB 300:WAITTI*8
21045 S$=" 1   2   3   4   5   6"
21046 PLOT 7,15,S$
21050 S$="Ml  Rg  St  Dx  Ig  MS  "
21060 PRINT@6,16;CHR$(145)CHR$(135);S$;CHR$(144)CHR$(132)
21070 S$=STR$(CC(P))+" "+STR$(CT(P))+" "+STR$(FO(P))+" "+STR$(AG(P))+" "+STR$(IN(P))+" "+STR$(FM(P))
21080 PLOT 7,17,S$

21100 PRINT @5,19;"Raise which attribute (1-6) ?"
21110 GOSUB 500:PROMO=5+FNA(4)
21120 IF A=1 THEN CC(P)=CC(P)+PRO:IFCC(P)>99THENCC(P)=99:GOTO 21180 
21130 IF A=2 THEN CT(P)=CT(P)+PRO:IFCT(P)>99THENCT(P)=99:GOTO 21180 
21140 IF A=3 THEN FO(P)=FO(P)+PRO:IFFO(P)>99THENFO(P)=99:GOTO 21180 
21150 IF A=4 THEN AG(P)=AG(P)+PRO:IFAG(P)>99THENAG(P)=99:GOTO 21180 
21160 IF A=5 THEN IN(P)=IN(P)+PRO:IFIN(P)>99THENIN(P)=99:GOTO 21180 
21170 IF A=6 THEN FM(P)=FM(P)+PRO:IFFM(P)>99THENFM(P)=99
21180 S$=STR$(CC(P))+" "+STR$(CT(P))+" "+STR$(FO(P))+" "+STR$(AG(P))+" "+STR$(IN(P))+" "+STR$(FM(P))
21200 PLOT 7,18,S$
21210 PV(P)=PV(P)+FNA(3)+4:IFPV(P)>99THENPV(P)=99
21250 L=21:GOSUB 400:GOSUB 750
21300 RETURN 

22500 L=11:S$=CHR$(130)+N$(AO(P))+" Heals "+N$(TG((AO(P))))
22510 GOSUB 300:GOSUB 32130:WAITTI*5
22520 L=14:GOSUB300
22550 RETURN


23000 REM Potion divine
23020 L=10:S$=N$(AO(P))+" uses divine Potion ":GOSUB 300
23030 L=13:S$=N$(TG((AO(P))))+" gets a colossal strength":GOSUB 300
23033 FC(TG(AO(P)))=50+FNA(VIL*6):GOSUB24000
23035 PD=1:PP=1
23040 S$=N$(TG((AO(P)))):N$(TG((AO(P))))=LEFT$(S$,1)
23045 FORI=2TOLEN(S$)
23050 MJ=ASC(MID$(S$,I,1))
23055 IF MJ>96 AND MI<123 THEN MJ=MJ-32
23060 L$=CHR$(MJ)
23070 N$(TG((AO(P))))=N$(TG((AO(P))))+L$
23080 NEXT 
23100 RETURN

23200 REM lower letters
23205 FORP=1TO6
23210 S$=N$(P):N$(P)=LEFT$(S$,1)
23220  FORI=2TOLEN(S$)
23230    MI=ASC(MID$(S$,I,1))
23240    IF MI>64 AND MI<91 THEN MI=MI+32
23250    L$=CHR$(MI)
23260    N$(P)=N$(P)+L$
23270  NEXTI
23280 NEXTP 
23200 RETURN

23300 L=10:S$=N$(AO(P))+" uses Vital Essence ":GOSUB 300
23310 L=13:S$=N$(TG((AO(P))))+" revives":GOSUB 300
23350 RETURN

23400 L=10:S$=N$(AO(P))+" uses "+IT$(24):GOSUB 300
23410 L=13:S$=N$(TG((AO(P))))+" is Invincible !":GOSUB 300
23420 BC(TG(AO(P)))=50:ET(TG(AO(P)))=PV(TG(AO(P)))
23450 RETURN

24000 I=0' indice hero with potion ebony
24010 REPEAT
24020  I=I+1
24030 UNTIL AO(I)=TG(AO(P)) AND ESP(I)=1 ' OR I=6+NE
24040 VE(I)=90
24050 RETURN

24100 FORJ=1TONE'freezed enemies
24110 IF ESP(J)=1THEN 24130
24120 VE(J)=VE(J)-5
24130 NEXTJ
24150 GOSUB 10520 
24200 RETURN

25000 REM SPELLS 
25010 GOSUB 700:SS=NI(P):IFSS>8THENSS=8
25020 PRINT @14,8;CHR$(129);" < MAGIC > ";CHR$(144)
25030 FOR I=1TOSS:PRINT@12,I+9;I;"- ";SPELL$(CP(P)-3,I)
25040 S$="("+STR$(SN(P,I))+" )":PRINT @26,I+9;S$:NEXT
25050 PRINT @5,9;"None - 0":
25060 GETA$:CH=VAL(A$):IF CH>NI(P) THEN 25060
25070 IF CH=0 THEN GOSUB 700:GOSUB 8500:GOTO 25500
25080 IF SN(P,CH)=0 THEN PING:GOTO 25060
25090 SPELL(P)=CH
25100 ON CP(P)-3 GOTO 25200,25300,25400
25200 IF CH >6  THEN 25490
25210  GOSUB 9600:GOTO 25490 
25300 IF CH=5 OR CH=6 THEN 25490
25310 IF CH<>8 THEN GOSUB 9500 ELSE GOSUB 9600
25320  GOTO 25490
25400   IF CH>3 THEN 25490
25410   IF CH=3 AND AMI>0 THEN GOSUB 600:GOTO 25060
25411  RT=0
25412  FORJ=1TO6:IF WR(J)>14 OR WL(J)>14 THEN RT=1
25413  NEXTJ
25415 IF RT=0 THEN GOSUB 600:GOTO 25000
25420   IF CH<3 THEN GOSUB 9500 ELSE GOSUB 9600
25430   IF CH<>1 THEN 25490
25440    IF WR(TG(P))=0  THEN 25470
25450    IF WR(TG(P))>14 AND (WL(TG(P))=0 OR WL(TG(P))>14) THEN 25470
25460   GOTO 25480
25470   GOSUB 600:GOTO 25420
25480   GOSUB 25600
25490  GOSUB 8300
25500 RETURN

25600 GOSUB 700
25610 IF WL(TG(P))=0 THEN A=1:GOTO 25650 ELSE PRINT @4,10; "Enchant whose sword ?"
25620 PRINT @3,12;CHR$(132);"1.R:";IT$(WR(TG(P)));CHR$(131)
25630 PRINT @3,13;CHR$(132);"2.L:";IT$(WL(TG(P)));CHR$(131)
25640 GET A$:A=VAL(A$):IF A<>1 AND A<>2 THEN 25640
25650 EF(TG(P))=A:IF A=1 THEN EF=WR(TG(P)) ELSE EF=WL(TG(P))
25660 IF EF>14 THEN GOSUB 600:GOTO 25600
25690 RETURN

26000 REM SPELLS
26010 H=CP(AO(P))-3
26020 L=10:S$=CHR$(134)+N$(AO(P))+" Casts "+SPELL$(H,SP(AO(P))):GOSUB 300
26030 SN(AO(P),SP(AO(P)))=SN(AO(P),SP(AO(P)))-1

26050 ON H GOTO 26100,26200,26300

26100 IF SP(AO(P))<7 AND C6OK(TG(AO(P)))=0 THEN 27000
26105 IF SP(AO(P))<7 THEN S$=" on  "+MM$(MO(TG(AO(P)))) ELSE S$="on the enemies"
26110 L=12:GOSUB 300:WAIT TI*10:S$="fails his invocation"
26120  ON SPELL(AO(P)) GOSUB 31100,31200,31300,31400,31500,31600,31700,31800
26130 GOTO 27000

26200 IF SP(AO(P))<7 AND OK(TG(AO(P)))=4 THEN 27000
26205 IF SP(AO(P))<5 OR SP(AO(P))=7 THEN S$=" on  "+N$(TG(AO(P)))
26210 IF SP(AO(P))=5 OR SP(AO(P))=6 THEN S$=" on the team"
26220 IF SP(AO(P))=8 THEN IF C6OK(TG(AO(P)))<>0 THEN S$=" on "+ MM$(MO(TG(AO(P)))) ELSE 27000
26230  L=12:GOSUB 300:WAIT TI*10
26240  ON SPELL(AO(P)) GOSUB 32100,32200,32300,32400,32500,32600,32700,32800
26250  GOSUB 35000:GOSUB 8300:GOSUB 700
26290  GOTO 27000

26300 IF SP(AO(P))=2 THEN S$=" on "+ N$(TG((AO(P))))
26310 IF SP(AO(P))=3 THEN IF C6OK(TG(AO(P)))<>0 THEN S$=" on "+ MM$(MO(TG(AO(P)))) ELSE 27000
26320 IF SP(AO(P))=2 OR SP(AO(P))=3 THEN L=12:GOSUB 300:WAIT TI*10
26322 IF SP(AO(P))=8 AND SD<>AO(P) THEN S$=" you have no saddle! ":L=12:GOSUB 300:WAIT TI*10:GOTO27000
26325  S$="fails his invocation"
26330  ON SPELL(AO(P)) GOSUB 33100,33200,33300,33400,33500,33600,33700,33800
27000 RETURN

31000 REM SORCIER
31100 REM 1,1 
31120 TST=4:DFF=20:GOSUB 15000:IF RT=0 THEN 35000
31130 C6OK(TG(AO(P)))=5:S$="takes a good nap...ZZZzzz":GOSUB 35000
31190 RETURN

31200 REM 1,2 FEU 
31210 TST=4:DFF=25:GOSUB 15000:IF RT=0 THEN 35000
31220 ZAP:FORI=1TO5:PAPER1:WAIT10:PAPER3:WAIT15:NEXT:PAPER0:EXPLODE
31240 SS=FNA(5)+3:C2PV(TG(AO(P)))=C2PV(TG(AO(P)))-SS
31250 S$=MM$(MO(TG((AO(P)))))+" looses "+STR$(SS)+" HP":GOSUB 35000
31260 IF C2PV(TG(AO(P)))<=0 THEN MT(AO(P))=MT(AO(P))+1:S$=MM$(MO(TG((AO(P))))):GOTO 40000
31290 RETURN

31300 REM 1,3 
31320 TST=4:DFF=25:GOSUB 15000:IF RT=0 THEN 35000
31340 S$="turns into stone":GOSUB 35000
31390 S$=MM$(MO(TG((AO(P))))):GOTO 40000

31400 REM 1,4
31410 TST=5:DFF=40:GOSUB 15000:IF RT=0 THEN 35000
31420 C6OK(TG(AO(P)))=2:S$="poison will work"
31490 GOTO 35000

31500 REM 1,5 SANG
31520 TST=5:DFF=15:GOSUB 15000:IF RT=0 THEN 35000
31530 C6OK(TG(AO(P)))=3:S$="is bleeding"
31590 GOTO 35000

31600 REM 1,6 FOUDRE
31620 TST=4:DFF=30:GOSUB 15000:IF RT=0 THEN 35000
31630 S$="is reduced to ashes !":GOSUB 35000
31690 MT(AO(P))=MT(AO(P))+1:S$=MM$(MO(TG((AO(P))))):GOTO 40000

31700 REM 1,7 LAVE
31720 TST=5:DFF=35:GOSUB 15000:IF RT=0 THEN 35000
31730 S$="A lava rain!!!":GOSUB 35000:GOSUB 700
31790 DG=10:GOSUB 10120:RETURN

31800 REM 1,8 SEISME
31820 TST=5:DFF=40:GOSUB 15000:IF RT=0 THEN 35000
31830 EXPLODE:WAIT60:SHOOT
31840 S$="The ground opens and swallows them!":GOSUB 35000:GOSUB 700
31890 DG=20:GOSUB 10130:RETURN

32000 REM  MESTRE 
32100 REM 2,1 EAU 
32130 GOSUB 9900
32140 S$="S/he is a little better"
32190 RETURN

32200 REM 2,2 SERUM
32220 IF OK(TG(AO(P)))<>2 THEN S$="Nope ! read again your grimoire":GOTO 32290
32240 OK(TG(AO(P)))=1:S$="Poison is cured"
32290 RETURN

32300 REM 2,3 MUSCLE
32320 IF OK(TG(AO(P)))<>3 THEN S$="Nope ! read again your grimoire":GOTO 32390
32340 OK(TG(AO(P)))=1:S$="Back to full strength !"
32390 RETURN

32400 REM 2,4 BOUCLIER
32420 BC(TG(AO(P)))=BC(TG(AO(P)))+FNA(3)+2
32430 S$="A magical shield !"
32490 RETURN

32500 REM 2,5 ELIXIR
32520 FORI=1TO6
32522  IF OK(I)<>4 THEN ET(I)=PV(I)
32524 NEXT
32530 S$="A team healthy again !"
32590 RETURN

32600 REM 2,6 ECRAN
32620 FORI=1TO6:BC(I)=10:NEXT
32630 S$="Maximum Protection !"
32690 RETURN

32700 REM 2,7 VIE
32720 IF OK(TG(AO(P)))<>4 THEN  32790
32730 OK(TG(AO(P)))=1:ET(TG(AO(P)))=PV(TG(AO(P))):HV=HV+1
32740 S$="A rebirth !"
32790 RETURN

32800 REM 2,8 MORT
32805 IF C6OK(TG(AO(P)))=0 THEN 32890
32810 TST=5:DFF=50:GOSUB 15000:IF RT=0 THEN S$="fails his invocation":GOTO 32890
32820 GOSUB 40030
32840 S$="A nice Death !"
32890 RETURN

33000 REM SEPTON
33100 REM 3.1EPEE-FEU
33110 TST=4:DFF=25:GOSUB 15000:IF RT=0 THEN EF(TG((AO(P))))=0:GOTO 35000
33120 IF EF(TG((AO(P))))=1 THEN EF=WR(TG((AO(P)))) ELSE EF=WL(TG((AO(P))))
33140 WAIT TI*10:L=12:S$="on "+IT$(EF)+" of "+N$(TG((AO(P)))):GOSUB 300
33150 ZAP:PAPER1:WAIT TI*10:EXPLODE:PAPER0
33160 S$="...it inflames ...":GOSUB 35000:WAIT TI*8:GOSUB 700
33190 RETURN

33200 REM 3.2FORCE
33210 TST=4:DFF=20:GOSUB 15000:IF RT=0 THEN 35000
33215 IF OK(TG(AO(P)))=4 THEN 33290
33220 S$=" his strength grows ":PRINT @12,14;S$:WAIT TI*10
33230 FC(TG(AO(P)))=FC(TG(AO(P)))+FNA(VIL)+5
33290 RETURN

33300 REM 3.3CHARME
33310 TST=5:DFF=10:GOSUB 15000:IF RT=0 THEN 35000
33320 AMI=TG(AO(P)):C6OK(AMI)=4:EV=EV-1
33330 S$="A new friend  ;-)":PRINT @5,14;S$:WAIT TI*15
33390 RETURN

33400 REM 3.4VISION
33410 TST=4:DFF=50:GOSUB 15000:IF RT=0 THEN 35000
33420 PRINT @10,12;" uses Warg vision":ZO=1:GOSUB 8100:WAIT TI*12
33490 RETURN

33500 REM 3.5GLACE
33510 TST=4:DFF=25:GOSUB 15000:IF RT=0 THEN 35000
33520 ECHEC=0:L=13:PRINT @10,12;" The North's Blow  !! ":WAIT TI*10
33530 FORI=1TONE
33535   IF C6OK(I)<1 THEN 33575
33540   SS=FM(AO(P))-C5(I)+FNA(VIL):L=L+1
33550   IFSS<3THENEC=EC+1:S$=MM$(MO(I))+" is laughing":GOTO 33570
33555   C2(I)=C2(I)-SS:S$=MM$(MO(I))+" freezes: -"+STR$(SS)+"hp"
33560   GOSUB 10300:GOSUB 24100
33570   PRINT@3,L;S$:WAITTI*5
33575 NEXTI
33580 WAITTI*20:IFEC=EVTHENGOSUB 750:PRINT@3,15;"Ha Ha Ha a very small spirit !!"
33585 GOSUB 8100
33590 RETURN

33600 REM 3.6ILLUSION
33610 TST=5:DFF=30:GOSUB 15000:IF RT=0 THEN 35000
33620 L=12:PRINT @5,L;"Projects an imaginary monster ":WAIT TI*15
33630 WIN$=" sneers":LOST$=" flees"
33640 GOSUB 36200
33690 RETURN

33700 REM 3,7WIND
33710 PRINT @10,12;"the horde !":WAIT TI*8
33720 TST=5:DFF=35:GOSUB 15000:IF RT=0 THEN 35000
33730 EXPLODE:WAIT60:SHOOT
33740 S$="A tornado swipes the horde!":GOSUB 35000:GOSUB 700
33750 DG=6:GOSUB 10130
33790 RETURN

33800 REM 3,8DRAGOON
33810 DR=1
33820 S$="A Dragon is joining you":GOSUB 35000:GOSUB 700
33840 RETURN
33850 GOSUB 700:S$=CHR$(129)+"! the Dragon rages ! "
33870 T=INT((41-LEN(S$))/2):PRINT@T,10;S$:WAIT TI*15
33880 DG=20:GOSUB 10120
33900 RETURN

35000 L=14:GOSUB 300:WAIT TI*10
35010 GOSUB 8100
35050 RETURN

36000 REM CHARME
36010 GOSUB 700:S$=CHR$(134)+" YOUR FRIEND: "+MM$(MO(AMI)):T=INT((41-LEN(S$))/2)
36020 PRINT @T,7;S$:S$=CHR$(134)+MM$(MO(AMI))+" Attacks the horde "
36030 T=INT((41-LEN(S$))/2):PRINT@T,10;S$:WAIT TI*15
36040 TE=FNA(NE)
36045 IF C6OK(TE)<>0 AND C6OK(TE)<>4 THEN 36060
36050 IFTE<NETHENTE=TE+1ELSETE=1
36055 GOTO 36045 
36060 SS=FNA(6)+2+C4(AMI):IFC6OK(TE)>4THENSS=SS*2
36065 PRINT @4,12;MM$(MO(TE));" looses ";SS;" hp";:WAIT TI*15
36070 C2(TE)=C2(TE)-SS:IF C2(TE)<0 THEN C2(TE)=0:C6(TE)=0:GOTO 40050
36100 RETURN

36200 REM TEST Opposit 
36210 FORJ=1TONE
36220  IF C6OK(J)=4 OR C6OK(J)=0 OR C6OK(J)=6 THEN 36270
36230   L=L+1:SS=FNA(100):PRINT@4,8;"SS: ";SS;"QI: ";C5(J)
36240   IF SS<C5QI(J) THEN RT=1:SS$=MM$(MO(J))+WIN$:GOTO 36260
36250   SS$=MM$(MO(J))+LOST$:EV=EV-1:C6OK(J)=0:C2(J)=0:MT(AO(P))=MT(AO(P))+1
36260  PRINT @5,L;SS$:WAIT TI*15
36270 NEXTJ
36280 GOSUB 8100
36290 RETURN

40000 REM ENNEMI MORT
40010 PRINT @15,16;S$;" dies ":EXPLODE:WAIT 5*TI
40030 IF C6OK(TG(AO(P)))=6 THEN FU=0
40035 IF C6OK(TG(AO(P)))=4 THEN AMI=0
40040 C2PV(TG(AO(P)))=0:C6OK(TG(AO(P)))=0
40050 EV=EV-1
40060 GOSUB 8100' affichage monstres
40090 RETURN

42090 REM Lecture TITEMS.BIN
42100 CLS:PRINT @ 8,12;CHR$(145);CHR$(135);"++ PLEASE WAIT ++ ";CHR$(144):
42110 DIM ITEM$(55), CM(23,5)
42120 LOAD "TITEMS.BIN"
43110 O1=#A000
43120 LI=PEEK(O1)
43125 REM PRINT "LG IT:";LI
43130 FOR I=1 TO LI
43140   O1=O1+1:LG=PEEK(O1)
43150   S$=""
43160   IF LG=0 THEN 43200
43170   FOR J=1 TO LG
43180     O1=O1+1:S$=S$+CHR$(PEEK(O1))
43190   NEXT
43200   ITEM$(I)=S$
43205   REM PRINT "ITEM ";I;" = ";ITEM$(I)
43210 NEXT

43300 REM Lecture TMONST.BIN
43310 LOAD "TMONST.BIN"
43335 O1=#A000
43345 LI=PEEK(O1)
43346 O1=O1+1:LG=PEEK(O1)
43350 FOR I=1TOLI
43355  FOR J=1TO LG
43360   O1=O1+1:CM(I,J)=PEEK(O1)
43365  NEXTJ
43370 NEXTI

43400 RETURN


48000 GOSUB49600 ' chargement
48005 REM LOAD"TEAM.BIN"
48010 O1=#A000
48011 O1=O1+1:VIL=PEEK(O1)
48012 REM PRINT"version " VIL 
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
48130 O1=O1+1:PV(P)=PEEK(O1):GOSUB49650
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
48296 FOR V=1TO9:FORM=1TO5:O1=O1+1:TC(V,M)=PEEK(O1):NEXT M,V:REM PRINT "FIN";TC(VILLE,1);O1;(O1-#A000)
48297 O1=O1+1:DE=PEEK(O1):GOSUB49650
48298 O1=O1+1:TL=PEEK(O1):REM PRINT "TL";TL
48310 O1=O1+1:NP=PEEK(O1)
48320 O1=O1+1:NF=PEEK(O1)
48325 O1=O1+1:PM=PEEK(O1):GOSUB49650

48330 REM IF KEY$<> " " THEN 48297
48350 RETURN

49000 CLS:PRINT @ 8,12;CHR$(148);CHR$(131);"++ BACK TO MAZE ++ ";CHR$(144)
49010 O1=#A000:GOSUB49620
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
49100 O1=O1+1:POKEO1,CC(P)
49110 O1=O1+1:POKEO1,CT(P)
49120 O1=O1+1:POKEO1,FO(P)
49140 O1=O1+1:POKEO1,AG(P)
49150 O1=O1+1:POKEO1,IN(P)
49160 O1=O1+1:POKEO1,FM(P)
49180 O1=O1+1:POKEO1,PV(P)
49190 O1=O1+1:POKEO1,ET(P):GOSUB49650
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
49315 O1=O1+1:POKEO1,SD
49320 FOR V=1TO9:FOR C=1TO4:O1=O1+1:POKEO1,CL(V,C):NEXT C,V
49340 FORI=1TO6:O1=O1+1:POKEO1,IG(I):NEXT:GOSUB49650
49350 FOR V=1TO9:FORM=1TO5:O1=O1+1:POKEO1,TC(V,M):NEXT M,V:REM PRINT "COMBATS";CO;TC(VILLE,1);O1;(O1-#A000)
49360 O1=O1+1:POKEO1,DE:GOSUB49650
49370 O1=O1+1:POKEO1,TL
49380 O1=O1+1:POKEO1,NP
49385 O1=O1+1:POKEO1,NF
49386 O1=O1+1:POKEO1,PM:GOSUB49650
49390 PING:SAVEU "TEAM.BIN",A#A000,EO1
49395 CG=0
49400 RETURN

49600 CLS:PRINT@6,8;".. Loading * Please Wait .."
49610 S$=CHR$(148)+" "+CHR$(144):CU=1:GOTO49650
49620 CLS:PRINT@6,8;"++ Saving + Please Wait ++"
49630 S$=CHR$(145)+" "+CHR$(144):CU=1
49650 CU=CU+2:PRINT@CU,9;S$
49660 RETURN

50000 REM TABLEAUX
50030 TIME=10:DFF=0:ENC=6:GU$=CHR$(34)
50040 FOR I=1TO4:READ OK$(I):NEXTI
50050 DEF FNA(SS)=INT(RND(1)*SS)+1
50060 FORI=1TO6:READ C$(I):NEXTI:PRINT ".";
50070 FORI=1TO9:READ M$(I):NEXTI:PRINT ".";
50100 DIM IMPACT(19)
50120 FOR I=1TO 12:READ IMPACT(I):NEXTI
50140 FOR I=1TO6:READ AA(I),IA(I):NEXT I

50150 REM  Monstres
50200 READ NM:DIM MM$(NM)
50210 FORI=1TONM:READ MM$(I):NEXTI
50230 DIM AO(11),ESPECE(11),VE(11)
50240 FORH=1TO3:FORI=1TO8:READ SPELL$(H,I):NEXTI,H
50250 FORI=1TO5:READ SM$(I):NEXT

50290 RESTORE:RETURN

50300 DATA "OK","-Poison-","-Paral- ",">DEAD< "
50310 DATA Knight,Mercenary,Ranger,Wizard,Maester,Septon
50320 DATA None,MARTELL,BARATHEON,TYRELL
50330 DATA GREYJOY,ARRYN,LANNISTER,TULLY,STARK

50400 DATA 7,6,5,5,4,4,3,3,2,2,1,1

50410 DATA 75,8, 70,6, 50,5, 80,4, 95,3, 55,2

50500 DATA 23,Mutant rat, Wolf-dog, Jackal, Goblin, Cut-throat, Beggar, Prowler, Swordsman
50510 DATA Ogre, Dothrakhi, Giant, Wildling, Lion, Bear
50520 DATA Fire Warlock, Dark Priestess, Mad Monk
50530 DATA Demon-Druid, Black Spirit, White Septon
50540 DATA Grey Elf, Damned Knight, White Walker

51000 DATA SLEEP, FIRE, STONE, VENOM, BLOOD,  LIGHTNING, LAVA, EARTHQUAKE
51010 DATA WATER, SERUM, MUSCLE, SHIELD, ELIXIR, SCREEN, LIFE, DEATH
51020 DATA FIRESWORD, STRENGTH, CHARM, VISION, FREEZE, ILLUSION, WIND, DRAGON

52000 DATA "I reduce your armor !","** fireballs **","blades rain !","I destroy your weapons !","Healing friends"


