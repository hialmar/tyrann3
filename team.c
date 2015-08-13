
#include "tyrann.h"

unsigned char hi; // octet haut
unsigned char lo; // octet bas

// characters data

char s = 1; // direction (est)
unsigned char x = 2; // coords
unsigned char y = 2;

struct character characters[6];

unsigned char boussole;
unsigned char filet;
unsigned char selle_dragon;

unsigned char cles[9][4]; // trousseau de clefs (32 octets)

unsigned char ingredients[6]; // ingrédients

unsigned char ville=0; // ville courante

unsigned char combats_coffres[9][5]; // combats et coffres sous forme de tableaux de bits

unsigned char dedans; // tableau de bits pour gérer le côté des portes et le mur à la fin

unsigned char tl; // top level  villes visitables.
unsigned char np; // nombre d'ingredients de la potion
unsigned char nf; // nombre de fuites
unsigned char pm; // potion faite ?

char ca = 0; // case courante

char * teamfilename = "TEAM.BIN"; // fichier contenant l'équipe

char io_needed = 1;

extern char eencre[];

void loadCharacters(void)
{
	char namelen=0; // longueur d'un nom
	char perso; // numéro de perso
	char i; // compteur
	char j; // compteur
	char ret;
	char *ptr;
	unsigned char version;
	// 48000 PRINT SPC(9);"Veuillez Patienter..."
	puts("         Veuillez Patienter...\n");	
	// 48005 CLOAD"TEAM"
	if (io_needed) {
		//printf("Chargement de %s\n", teamfilename);
		ret = DiscLoad(teamfilename);        
		//printf("Retour %d\n", ret);
	} else {
		ret = 0;
	}
	if (ret==0) {
		// 48010 O1=#A000
		// 48015 O1=O1+1:VIL=PEEK(O1):PRINT SPC(9);"...";
		ptr = (char*)0xa001;
		//printf("debut : (%x) ou %d\n", (unsigned int) ptr, (int) ptr);
		version = *ptr; ptr++;
		x = *ptr; ptr++;
		y = *ptr; ptr++;
		s = *ptr; ptr++;
		ca = *ptr; ptr++;
		ville = *ptr; ptr++;
		printf("x=%d y=%d s=%d ca=%d ville=%d\n", x, y, s, ca, ville);
		// test
		if (x==0 || x > 100) {
			x = 2; y = 2; s = 1; ville = 4;
			//printf("x=%d y=%d s=%d ca=%d\n", x, y, s, ca);
		}
		ink(eencre[ville-1]);
		//printf("ville: %d\n", ville);
		puts("         ...\n");
		// 48020 FOR P=1TO6
		for(perso=0;perso<6;perso++) {
			// 48030 O1=O1+1:DD=PEEK(O1)
			namelen = *ptr; ptr++;
			// 48040 FORJ=1TODD:O1=O1+1:N$(P)=N$(P)+CHR$(PEEK(O1)):NEXTJ
			if (namelen > 10)
				namelen = 10;
			for(i=0;i<namelen;i++) {
				characters[perso].nom[i]=*ptr; ptr++;
			}
			characters[perso].nom[i]=0;
			memcpy((char*)&(characters[perso].ri), ptr, 21);
			ptr+=21;
#ifdef debug
			printf("...\n");
			printf("perso %d : longueur %d nom %s\n", perso, namelen, characters[perso].nom);
			printf("richesse %d0\n", characters[perso].ri);
			printf("classe %d\n", characters[perso].cp);
			printf("taper sur une touche pour continuer\n");
			printf("maison %d\n", characters[perso].mp);
			printf("CC %d\n", characters[perso].cc);
			printf("CT %d\n", characters[perso].ct);
			printf("FO %d\n", characters[perso].fo);
			printf("AG %d\n", characters[perso].ag);
			printf("IN %d\n", characters[perso].in);
			printf("FM %d\n", characters[perso].fm);
			a = (char)getchar();
			printf("PV %d\n", characters[perso].pv);
			printf("etat %d\n", characters[perso].et);
			printf("OK %d\n", characters[perso].ok);
			printf("NI %d\n", characters[perso].ni);
			printf("XP %d\n", characters[perso].xp);
			printf("WR %d\n", characters[perso].wr);
			printf("WL %d\n", characters[perso].wl);
			printf("Armure %d\n", characters[perso].pt);
			printf("CA %d\n", characters[perso].ca);
			printf("bete %d\n", characters[perso].bt);
			a = (char)getchar();
#endif
			// 48230 FORI=1TO6:O1=O1+1:SAD(P,I)=PEEK(O1):NEXTI
			memcpy((char*)&(characters[perso].sad), ptr, 6);
			ptr+=6;
#ifdef debug
			for(i=0;i<6;i++) {
				printf("SAD(%d) : %d\n", i, characters[perso].sad[i]);
			}
#endif
			//printf("taper sur une touche pour continuer\n");
        	//a = (char)getchar();
			// 48235 IF CP(P)>3 THEN FORI=1TO8:O1=O1+1:SN(P,I)=PEEK(O1):NEXT
			if (characters[perso].cp>3) {
				memcpy((char*)&(characters[perso].sp), ptr, 8);
				ptr+=8;
#ifdef debug
				for(i=0;i<8;i++) {
					printf("SP(%d) : %d\n", i, characters[perso].sp[i]);
				}
#endif
			}
			// 48240 PRINT "...";:NEXT P
		}

		// 48250 O1=O1+1:BS=PEEK(O1)
		boussole = *ptr; ptr++;
		//printf("Boussole %d\n", boussole);
		// 48260 O1=O1+1:FI=PEEK(O1)
		filet = *ptr; ptr++;
		//printf("filet %d\n", filet);
		selle_dragon = *ptr; ptr++;
		//printf("selle dragon %d\n", selle_dragon);
		// 48270 FOR L=1TO8:FOR C=1TO4:O1=O1+1:CLEF(L,C)=PEEK(O1):NEXT C,L
		memcpy((char*)cles, ptr, 36);
		ptr+=36;
#ifdef debug
		for(i=0;i<9;i++) {
			for (j=0;j<4;j++) {	
				printf("cle(%d,%d) = %d\n", i, j, cles[i][j]);
			}
		}
		puts("taper sur une touche pour continuer\n");
        a = (char)getchar();
#endif
		// 48290 FOR I=1TO6:O1=O1+1:INGREDIENT(I)=PEEK(O1):NEXT
		memcpy((char*)ingredients, ptr, 6);
		ptr+=6;
#ifdef debug
		for(i=0;i<6;i++) {
			printf("ingredients(%d) = %d\n", i, ingredients[i]);
		}
#endif
		memcpy((char*)combats_coffres, ptr, 45);
		ptr+=45;
		dedans=*ptr;
		ptr++;
		tl=*ptr;
		ptr++;
		printf("tl %d\n", tl);
		np=*ptr;
		ptr++;
		nf=*ptr;
		ptr++;
		pm=*ptr;
		ptr++;
		printf("longueur %d\n", (int) (ptr - 0xa000));
	} else {
		printf("Erreur lors du chargement de %s\n", "TEAM.BIN");
		exit(1);
	}
}

void saveCharacters(void)
{
	char namelen=0; // longueur d'un nom
	char perso; // numéro de perso
	char i; // compteur
	char j; // compteur
	char ret;
	char *ptr;
	
	// 49000 TEXT:CLS:PRINT @ 8,12;CHR$(145);CHR$(135);"++ PREPARE L EQUIPE ++ ";CHR$(144)
	text(); cls(); printf("\n\n\n\n\n\n\n\n\n\n\n\n        ++ PREPARE L'EQUIPE ++ \n");
	// 49010 O1=#A000
	ptr = (char*)0xa001;
	//printf("debut : (%x) ou %d\n", (unsigned int) ptr, (int) ptr);
	// nouvelle version
	*ptr = 1; ptr++; // version 1 : passage a 9 villes
	*ptr = x; ptr++;
	*ptr = y; ptr++;
	*ptr = s; ptr++;
	*ptr = ca; ptr++;
	// 49020 O1=O1+1:POKEO1,VIL
	*ptr = ville; ptr++;
	
	// 49030  FORP=1TO6
	for(perso=0;perso<6;perso++) {
		// 49040 O1=O1+1:POKEO1,LEN(N$(P))
		namelen = strlen(characters[perso].nom);
		*ptr = namelen;
		ptr++;
		// 49050 FORJ=1TOLEN(N$(P)):O1=O1+1:POKEO1,ASC(MID$(N$(P),J,1)):NEXT
		for (i=0; i<namelen; i++) {
			*ptr = characters[perso].nom[i];
			ptr++;
		}
		memcpy(ptr, (char*)&(characters[perso].ri), 21);
		ptr+=21;
		// 49270 FORI=1TO6:O1=O1+1:POKEO1,SAD(P,I):NEXTI
		memcpy(ptr, (char*)characters[perso].sad, 6);
		ptr+=6;
		// 49280 IFCP(P)>3 THENFORI=1TO8:O1=O1+1:POKEO1,SN(P,I):NEXT
		if (characters[perso].cp>3) {
			memcpy(ptr, (char*)characters[perso].sp, 8);
			ptr+=8;
		}
		// 49290  NEXTP
	}
	// 49300 O1=O1+1:POKEO1,BS
	*ptr = boussole;
	ptr++;
	// 49310 O1=O1+1:POKEO1,FI
	// filet = 0; // tempo
	*ptr = filet;
	ptr++;
	*ptr = selle_dragon;
	ptr++;
	// 49320 FORL=1TO8:FORC=1TO4:O1=O1+1:POKEO1,CLEF(L,C):NEXT C,L
	memcpy(ptr, (char*)cles, 36);
	ptr+=36;
	// 49340 FORI=1TO6:O1=O1+1:POKEO1,INGREDIENT(I):NEXT
	memcpy(ptr, (char*)ingredients, 6);
	ptr+=6;
	memcpy(ptr, (char*)combats_coffres, 45);
	ptr+=45;
	*ptr = dedans;
	ptr++;
	*ptr = tl;
	ptr++;
	printf("tl %d\n", tl);
	*ptr = np;
	ptr++;
	*ptr = nf;
	ptr++;
	*ptr = pm;
	ptr++;
	printf("fin (%x) longueur %d\n", (unsigned int) ptr, (int) (ptr - 0xa000));
	if (io_needed) {
		//restorePageZero();
		// 49390 PING:CSAVE "TEAM",A#A000,EO1
		DiscSave("TEAM.BIN",(char*)0xa000, ptr);
	}
}
