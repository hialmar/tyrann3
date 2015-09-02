
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

200 DATA Valyrian Armor, Steel Armor, Iron Armor, Chainmail, Cuirass, leather armor, Linen Tunic
210 DATA Valyrian Sword, Winterfell's Axe, Morgenstern, Morning Star, Hammer, Longsword, Sword, Crossbow, Bow, Sling, Net, Dagger
220 DATA Unguent, Divine wood, Vital juice, Ebony Potion, Divine Potion, Zoman Potion, Freezing Potion
230 DATA Wineskin, Loaf of bread, Dornish ale, Dry fish, Boar leg
240 DATA Wildfire pot, Wildfire barrel, Crowbar, Compass, Dragoon saddle
250 DATA Direwolf, Panther, Mastiff, Eagle, Hawk, Wild dog, Wild Cat
260 DATA Crown, Jewel, Eyrie's Pearls, Heart of Diamonds, pouch of coins
