
10 REM |=====================================================|
20 REM |=================||| OBJETS |||======================|
30 REM |=====================================================|

31 DIM ITEM$(48)
35 O1=#A000
36 POKEO1,48
40 FOR I=1 TO 48
60   READ ITEM$(I):
61   LG=LEN(ITEM$(I))
62   O1=O1+1:POKEO1,LG
63   IF LG=0 THEN 70
64   FOR J=1 TO LG
65     O1=O1+1:POKEO1,ASC(MID$(ITEM$(I),J,1))
66   NEXT
70 NEXT
80 PRINT"SAUVEGARDE DU TABLEAU"
90 REM STORE ITEM$,"T-ITEMS",S
95 SAVEO "TITEMS.BIN",A#A000,EO1
100 PRINT"OBJETS OK":PING:ZAP:END

200 DATA Armure valyrienne,Armure en acier,Armure de fer,Cotte de mailles,Cuirasse,Armure de cuir,Robe de bure:REM 1-7 
220 DATA Epee valyrienne,Hache de Winterfell,Morgenstern,Fleau d'armes,Marteau,Epee a 2 mains,Epee,Arbalete,Arc court,Fronde,Filet,Poignard:REM 8-19
250 DATA Onguent,Bois divin,Potion Ebene,Essence vitale,Potion Divine,Potion Zoman,Potion glaciale:REM 20-26
270 DATA Outre,Miche de pain,Cervoise,Poisson sec,Cuisse de sanglier:REM 27-31
280 DATA Pot Gregeois, Fut Gregeois, Pied de biche, Boussole, Selle de Dragon:REM 32-36
290 DATA DireWolf, Panthere, Molosse, Aigle, Faucon, Dogue, Chat sauvage:REM 37-43
300 DATA Couronne, Solitaire, Perles d'Eyrie, Coeur de diamants, Bourse:REM 44-48
