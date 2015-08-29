
#include "tyrann.h"

#define TMAX 800
char textes[TMAX];
int tmax = TMAX;

extern char * ptTextes;
extern char nbTextes;

char * textesItems[55];

extern char s; // direction (est)
extern unsigned char x; // coords
extern unsigned char y;

extern struct character characters[6];

extern unsigned char ingredients[6]; // ingrédients

extern unsigned char boussole;

extern unsigned char cles[9][4]; // trousseau de clefs (36 octets)

extern unsigned char ville; // ville courante

extern char ca; // case courante

extern unsigned char nb_combat;

extern unsigned char tl; // top level  villes visitables.
extern unsigned char np; // nombre d'ingredients de la potion

extern unsigned char boussole;
extern unsigned char filet;
extern unsigned char selle_dragon;

extern char io_needed;
extern char eencre[];

char *classe[] = { "Knight","Mercenary","Ranger","Wizard","Maester","Septon" };
char *etat[] = { "OK", "-Poison- ", "-Paral- ", ">DEAD< " };
char *maisons[] = { "MARTELL","BARATHEON","TYRELL","GREYJOY","ARRYN","LANNISTER","TULLY","STARK"};

char *sorts[] = { "SLEEP","FIRE","STONE","VENOM","BLOOD","LIGHTNING", "LAVA", "EARTHQUAKE",
				  "WATER", "SERUM", "MUSCLE", "SHIELD", "ELIXIR", "SCREEN", "LIFE", "DEATH",
				  "FIRE-SWORD", "FORCE", "CHARM", "VISION", "ICE", "ILLUSION", "WIND", 
				  "DRAGON" };
				  
char *nomIngredients[] = { "royal leech","lily flower","kraken ink","rose of the Vale","oil of the Rock","trout liver"};

char tentatives = 0; // pour les coffres

void loadTextesItems()
{
	char filename[16];
	char ret, a;
	char *ptr;
	memset(filename, 0, 16);
	sprintf(filename, "TITEMS.BIN", ville);
	//printf("Chargement de %s\n", filename);
    ret = DiscLoad(filename);        
    //printf("Retour %d\n", ret);
    if (ret==0) {
		ptr = (char*)0xa000;
		//printf("Nb NPC : %d\n", pmax);
		loadTexts(ptr, textesItems);
		#ifdef debug
		printf("Fin des textes, on utilise %d caracteres sur %d\n", 
			(ptTextes-textes), TMAX);
		puts("taper sur une touche pour continuer\n");
        a = (char)getchar();
        #endif
	}
}

void printTeam(void)
{
	char i,encre;
	attribAtXY(0,20,A_FWWHITE);
	attribAtXY(1,20,A_BGRED); // fond rouge
	printAtXY(2,20,"CHARACTERS     CAREER     HP  ST  AC"); 
	for(i=0;i<6;i++) {
		switch(characters[i].cp) {
			case 1:
				encre = A_FWYELLOW; // jaune
				break;
			case 2:
				encre = A_FWWHITE; // blanc
				break;
			case 3:
				encre = A_FWCYAN; // cyan
				break;
			case 4:
				encre = A_FWMAGENTA; // magenta
				break;
			case 5:
				encre = A_FWBLUE; // bleu
				break;
			default:
				encre = A_FWGREEN; // bleu		
		}
		if (characters[i].ok==4) encre = A_FWRED;
		// efface la ligne précédente
		printAtXY (2,21+i, "                                     ");
		attribAtXY(1,21+i,encre);
		printAtXY (2,21+i, itoa(i+1));
		printAtXY (4,21+i, characters[i].nom);		
		if (characters[i].ok==1) {
			printAtXY (17,21+i,classe[characters[i].cp-1]);
		} else {
			printAtXY (17,21+i,etat[characters[i].ok-1]);
		}
		printAtXY (27,21+i, itoa(characters[i].pv));
		printAtXY (32,21+i, itoa(characters[i].et));
		printAtXY (37,21+i, itoa(characters[i].ca));
	}
}

void money(char p)
{
	char a,i,j;
	char titre[32];
	int somme;
	cls();
	printFrame(18);
	strcpy(titre, " < ");
	strcat(titre, characters[p].nom);
	strcat(titre, " GIVES > ");
	j = strlen(titre);
	a = (31-j)/2 + 4;
	printTitle(a,2, A_BGRED, titre, j);
	// affiche les persos
	for(i=0;i<6;i++) {
		printAtXY(5,4+i, itoa(i+1));
		printAtXY(7,4+i, characters[i].nom);
		printAtXY(19,4+i, itoa(characters[i].ri*10));
	}
	// affiche les richesses du héros sélectionné
	printAtXY(4,13, "Your Money :");
	printAtXY(18,13, itoa(characters[p].ri*10));
	printAtXY(26,13, "Silver Stags");
	// demande la somme
	printTitle(4,14, A_BGBLUE, "HOW MUCH ?", 17);
	somme = 0;
	while(1) {
		a = get();
		if (a == '\r' || a == '\n')
			break; // sort sur un retour chariot ou lf
		else if (a<'0' || a>'9')
			ping();
		else {
			// schéma de Horner
			somme = somme*10 + (a - '0');
			// si ça fait trop on repasse à 0 en pingant
			if (somme > characters[p].ri*10) {
				ping();
				somme = 0;
				// on efface aussi ce qu'il y avait
				printAtXY(27,14, "        ");
			}
			// on affiche la somme courante
			printAtXY(27,14, itoa(somme));
		}	
	}
	// si la somme n'est pas nulle on demande le destinataire
	if (somme != 0) {
		printTitle(4,16, A_BGBLUE, "TO WHOM ? (0:None)", 31);
		while(1) {
			a = get();
			if (a<'0' || a>'6')
				ping(); // ping si pas correct
			else
				break; // correct : on sort
		}
		i = a - '1';
		if ((i>=0) && (i!=p)) {
			// c'est correct on transfère
			characters[i].ri+=somme/10;
			characters[p].ri-=somme/10;
			ping();
		}
	}
}

void items(char p)
{
	char a,i,j, item,o;
	char titre[32];
	printTitle(4,25, A_BGBLUE, "What Item ? (0:None) ?", 24);
	while(1) {
		a = get();
		if (a<'0' || a>'6')
			ping(); // ping si pas correct
		else {
			o = a - '1';
			if(o==-1)
				return; // on arrête tout
			item = characters[p].sad[o];
			// IF(IT>21ANDIT<27)OR(IT>33ANDIT<44)THENL=24
			if ((item<=0)||(item>21 && item<27)||(item>33 && item<44)) {
				ping();
				printAtXY(6,25, "       !IMPOSSIBLE!       ");
				wait(250);
				return;
			} else
				break; // correct : on sort
		}
	}
	// ici on a un bon objet
	cls();
	printFrame(18);
	strcpy(titre, " < ");
	strcat(titre, characters[p].nom);
	strcat(titre, " GIVES > ");
	j = strlen(titre);
	a = (31-j)/2 + 4;
	printTitle(a,2, A_BGRED, titre, j);
	strcpy(titre, textesItems[item-1]);
	j = strlen(titre);
	printTitle(5,3, A_BGMAGENTA, titre, j);
	// affiche les persos
	for(i=0;i<6;i++) {
		printAtXY(10,7+i, itoa(i+1));
		printAtXY(12,7+i, characters[i].nom);
	}
	printTitle(4,16, A_BGBLUE, "TO WHOM ? (0:Aucun)", 24);
	while(1) {
		a = get();
		if (a<'0' || a>'6')
			ping(); // ping si pas correct
		else
			break; // correct : on sort
	}
	a = a - '1';
	if ((a>=0) && (a!=p)) {
		// sac à dos destination plein ?
		if (characters[a].sad[5]>0) {
			ping();
			printAtXY(6,25, "       !IMPOSSIBLE!       ");
			wait(250);
			return;
		}
		// c'est correct on transfère
		// on cherche la première place libre
		i=0; while(characters[a].sad[i]>0) i++;
		characters[a].sad[i] = characters[p].sad[o];
		characters[p].sad[o]=0;
		// compacte le sac à dos
		while(o<5) {
			characters[p].sad[o]=characters[p].sad[o+1];
			characters[p].sad[o+1]=0;
			o++;
		}
		ping();
	}
}

void spells(char p)
{
	char i,a,j, max;
	char titre[32];
	
	// tests
	/*
	characters[0].ok=2;
	characters[0].et=2;
	characters[1].ok=3;
	characters[1].et=2;
	characters[2].ok=4;
	characters[2].et=2;
	characters[3].ok=3;
	characters[3].et=2;
	characters[4].ni=8;
	*/
	
	cls();
	printFrame(14);
	printTitle(11,2, A_BGRED, " < * SPELLS * > ", 15);
	max = characters[p].ni > 8 ? 8 : characters[p].ni; 
	for(i=0;i<max;i++) {
		printAtXY(11,4+i, itoa(i+1));
		printAtXY(14,4+i, sorts[(characters[p].cp-4)*8+i]);
		printAtXY(25,4+i, "(");
		printAtXY(27,4+i, itoa(characters[p].sp[i]));
		printAtXY(30,4+i, ")");
	}
	if (characters[p].cp!=5) {
		printTitle(14,14, A_BGRED, " <SPACE> ", 10);
		a = get();
	} else { // mestre
		a = 'y';
		while(a == 'y' || a == 'Y') {
			printTitle(7,14, A_BGRED, " Healing Spell (Y/N) ? ", 25);
			a = get();
			if (a!='y' && a!='Y')
				return;
			printAtXY(6,14, "                               ");
			// affichage équipe
			printTeam();
			printAtXY(8,12, "      WHICH ONE  ?      ");
			while(1) {
				a = get();
				if (a<'1' || a>'7' || a=='4' || a=='6') {
					zap(); // zap si pas correct
					printAtXY(6,12, "       !IMPOSSIBLE!       ");
					wait(250);
					printAtXY(8,12, "      WHICH ONE  ?      ");
				} else {
					i = a - '1';
					if(i>=characters[p].ni) {
						zap(); // pas du bon niveau
						printAtXY(6,12, "       !IMPOSSIBLE!       ");
						wait(250);
						printAtXY(8,12, "      WHICH ONE  ?      ");
					} else
						break; // correct : on sort
				}
			}		
			strcpy(titre, "Incantation of ");
			strcat(titre, sorts[(characters[p].cp-4)*8+i]);
			j = strlen(titre);
			a = (31-j)/2 + 4;
			printAtXY(a,12, titre);
			if(i==4) {
				// soigne tout le monde
				for(i=0;i<6;i++) {
					if (characters[i].ok!=4) {
						characters[i].et=characters[i].pv;
						characters[i].ok=1;
					}
				}
			} else {
				printAtXY(7,16, " Cure which ? (0:None) ");
				while(1) {
					a = get();
					if (a<'0' || a>'6')
						ping(); // ping si pas correct
					else
						break; // correct : on sort
				}
				a = a - '1';
				if (a>=0) {
					// soigne a
					// cas impossibles
					if((i==0 && characters[a].ok==4) || 
					   (i==1 && characters[a].ok!=2) ||
					   (i==2 && characters[a].ok!=3) ||
					   (i==6 && characters[a].ok!=4)) {
						zap();
						printAtXY(6,12, "       !IMPOSSIBLE!       ");
						wait(250);
						printAtXY(6,12, "                          ");
					} else {
						// ça marche
						characters[a].et=characters[a].pv;
						if(i!=0) characters[a].ok=1;
					}
				}
				printAtXY(7,16, "                         ");
			}
			printAtXY(7,12, "                         ");
			// affichage équipe
			printTeam();
			a='o';
		}
	}
}

void inspect(void)
{
	char a, i, j;
	char titre[32];
	
	printTitle(8,4, A_BGRED, "INSPECT WHICH HERO ? ", 23);
	while(1) {
		a = get();
		if (a<'1' || a>'6')
			ping(); // ping si pas correct
		else
			break; // correct : on sort
	}
	cls();
	printFrame(23);
	i = a - '1';
	// construction du nom/titre
	strcpy(titre, " < ");
	strcat(titre, characters[i].nom);
	if(characters[i].mp != 1) {
		strcat(titre, " ");
		strcat(titre, maisons[characters[i].mp-2]);
	}
	strcat(titre, " > ");
	j = strlen(titre);
	a = (31-j)/2 + 4;
	// affichage du titre
	printTitle(a,2, A_BGRED, titre, j);
	// affichage classe, niv, xp
	printAtXY(5,  4, "Carr:");
	printAtXY(11, 4, classe[characters[i].cp-1]);
	printAtXY(22, 4, "Lvl:");
	printAtXY(27, 4, itoa(characters[i].ni));
	printAtXY(29, 4, "XP:");
	printAtXY(33, 4, itoa(characters[i].xp));
	
	// affichage santé, pv
	printAtXY(5,  6, "Health:");
	printAtXY(11, 6, etat[characters[i].ok-1]);
	printAtXY(22, 6, "HP:");
	printAtXY(27, 6, itoa(characters[i].et));
	printAtXY(30, 6, "/");
	printAtXY(32, 6, itoa(characters[i].pv));
	// affichage bourse
	printAtXY(5,  8, "Money:");
	printAtXY(13, 8, itoa(characters[i].ri*10));
	printAtXY(21, 8, "Silver Stags");
	
	// affichage de l'équipement porté
	printAtXY(5,  10, "R Wpn:");
	if (characters[i].wr != 0)
		printAtXY(13, 10, textesItems[characters[i].wr-1]);

	printAtXY(5,  11, "L Wpn:");
	if (characters[i].wl != 0)
		printAtXY(13, 11, textesItems[characters[i].wl-1]);
	
	printAtXY(5,  12, "Animal:");
	if (characters[i].bt != 0)
		printAtXY(13, 12, textesItems[characters[i].bt-1]);

	printAtXY(5,  13, "Armor:");
	if (characters[i].pt != 0)
		printAtXY(13, 13, textesItems[characters[i].pt-1]);
	printAtXY(29, 13, "AC:");
	printAtXY(33, 13, itoa(characters[i].ca));
	
	// affiche les caracs
	printTitle(4,15, A_BGRED, "Ml  Rg  St  Dx  Ig  MS ", 23);
	printAtXY(7,16, itoa(characters[i].cc));
	printAtXY(11,16, itoa(characters[i].ct));
	printAtXY(15,16, itoa(characters[i].fo));
	printAtXY(19,16, itoa(characters[i].ag));
	printAtXY(23,16, itoa(characters[i].in));
	printAtXY(27,16, itoa(characters[i].fm));
	// affichage du sac à dos
	for(j=0;j<6;j++) {
		printAtXY(5,18+j, itoa(j+1));
		if (characters[i].sad[j]!=0) {
			if (characters[i].sad[j]-1<nbTextes)
			    printAtXY(8,18+j, textesItems[characters[i].sad[j]-1]);
			else
				printAtXY(8,18+j, "bogus item");
		} else {
			printAtXY(8,18+j, "..............");
		}
	}
	// les morts et les paralysés ne peuvent pas lancer de sorts!
	if (characters[i].cp>3 && characters[i].ok<3)
		printTitle(10,25, A_BGRED, " <SPACE> : SPELLS ", 18);
	else
		printTitle(10,25, A_BGRED, " <SPACE> : BACK", 18);
	printTitle(4,26, A_BGBLUE, " GIVE :  ", 11);
	printTitle(16,26, A_BGRED, " M)oney I)tem ? ", 17);
	while(1) {
		a = get();
		if (a=='M') {
			money(i);
			break;
		} else if (a=='I') {
			items(i);
			break;
		} else if (a==' ') {
			if (characters[i].cp>3 && characters[i].ok<3)
				spells(i);
			break;
		} else
			ping();
	}
}

void printTeamFull(void)
{
	char i, encre, a;
	cls();
	ink(eencre[ville-1]);
	// affichage des titres
	printTitle(8,2, A_BGRED, " * TYRANN 3 - TEAM * ", 23);
	printTitle(2,4, A_BGRED, "CHARACTERS  HOUSES CARREER LVL ", 35);
	printTitle(2,5, A_BGBLUE, " Money      Ml Rg St Dx Ig MS HP  ", 35);
	// affichage persos
	for(i=0;i<6;i++) {
		switch(characters[i].cp) {
			case 1:
				encre = A_FWYELLOW; // jaune
				break;
			case 2:
				encre = A_FWWHITE; // blanc
				break;
			case 3:
				encre = A_FWCYAN; // cyan
				break;
			case 4:
				encre = A_FWMAGENTA; // magenta
				break;
			case 5:
				encre = A_FWBLUE; // bleu
				break;
			default:
				encre = A_FWGREEN; // bleu		
		}
		attribAtXY(1,7+3*i,encre);
		printAtXY (3,7+3*i, itoa(i+1));
		printAtXY (5,7+3*i, characters[i].nom);		
		if (characters[i].mp != 1) printAtXY (17,7+3*i, maisons[characters[i].mp-2]);		
		printAtXY (27,7+3*i, classe[characters[i].cp-1]);
		printAtXY (37,7+3*i, itoa(characters[i].ni));
		printAtXY (6,7+3*i+1, itoa(characters[i].ri*10));
		printAtXY (13,7+3*i+1, "ss");
		printAtXY (18,7+3*i+1, itoa(characters[i].cc));
		printAtXY (21,7+3*i+1, itoa(characters[i].ct));
		printAtXY (24,7+3*i+1, itoa(characters[i].fo));
		printAtXY (27,7+3*i+1, itoa(characters[i].ag));
		printAtXY (30,7+3*i+1, itoa(characters[i].in));
		printAtXY (33,7+3*i+1, itoa(characters[i].fm));
		printAtXY (36,7+3*i+1, itoa(characters[i].pv));
	}
	printTitle(2,25, A_BGBLUE, " Money      Ml Rg St Dx Ig MS HP  ", 35);
	printTitle(2,26, A_BGRED, "            < SPACE >            ", 34);
	while(1) {
		a = get();
		if (a==' ') {
			break;
		} else
			ping();
	}
}

void chest(void)
{
	char a,i,dff,ss;
	char borne_sup, borne_inf;
	cls();
	printTitle(4,6, A_BGRED, "Here is a chest. Who opens it ? ", 31);
	printTeam();
	while(1) {
		a = get();
		if (a<'0' || a>'6')
			ping(); // ping si pas correct
		else
			break; // correct : on sort
	}
	a = a - '1';
	tentatives+=5;
	if (characters[a].cp!=3) {
		printAtXY(9,9, "He doesn't know how !");
		zap();
		wait(500);
		return;
	}
	for(i=0;i<6;i++) {
		if (characters[a].sad[i]==34) {
			dff=35;
			break;
		} else dff=-25;
	}
	ss = rand()%100+1;
	if(ss>characters[a].ag+dff+tentatives) {
		printAtXY(11,12, itoa(ss));
		printAtXY(14,12, " Failure!");
		zap();
		wait(500);
		return;
	}
	printAtXY(11,11, "Open ! Well done.");
	ping();
	printAtXY(6,12, "He finds ");
	if(ca==21) {
		cles[ville-1][0]=1;
		printAtXY(20,12, "An iron key"); // clé 1
		wait(500);
		ca=0;
		return;
	} else if(ca==26) {
		cles[ville-1][3]=1;
		printAtXY(20,12, "A golden key"); // clé 4 (prison)
		wait(500);
		ca=0;
		return;
	} else if(ca==27) {
		// 
		// 21700 IF IG(VI-2)=1THEN RETURN
		// 21708 NP=NP+1:IG(VI-2)=1:S$=IG$(VI-2)
		// 21710 PRINT@5,10;"IL TROUVE: ";S$
		// 21720 S$="Nb d'Ingredients Potion:"+STR$(NP):PRINT@5,12;S$
		// 21730 IF NP=6THENPRINT@5,14;"Direction le Labo pour la potion":GOTO21790
		// 21740 S$="Encore"+STR$(6-NP)+" a trouver":PRINT@5,14;S$
		// 21790 L=16:GOSUB 30000
		// 21800 RETURN
		if(ville<2 || ville >7) return; // bug
		if(ingredients[ville-2]) {
			printAtXY(20,12, "Nothing!");
			wait(150);
			return;
		}
		np++;
		ingredients[ville-2]=1;
		printAtXY(20,12, nomIngredients[ville-2]);
		printAtXY(6,13, "Potion ingredients number :");
		printAtXY(20,13, itoa(np));
		if(np==6) {
			printAtXY(6,15, "Let's go to the laboratory");
		} else {
			printAtXY(6,15, "Still ");
			printAtXY(13,15, itoa(6-np));
			printAtXY(17,15, "to find.");	
		}			
		ca=0;
		wait(500);
		return;
	} else if(ca==28) {
		// tresor 
		// 21900 SS=FNA(5000)+3000:RI(P)=RI(P)+SS
		// 21910 S$="un TRESOR de"+STR$(SS)+" ca"
		// 21920 TL=TL+1:UP=1
		// 21950 RETURN
		int prime = rand()%5000 + 3000;
		characters[a].ri += prime/10; // attention on stocke les ca / 10
		printAtXY(20,12, "a Treasure of");
		printAtXY(33,13, itoa(prime));
		printAtXY(38,13, "ss");
		tl++; // on peut aller a la ville suivante !
		printAtXY(4,15, "You find the directions for");
		printAtXY(4,16, "     a new village !");
		ca=0;
		wait(500);
		return;
	}
	
	// un objet
	// 21410 SS=FNA(100):IFSS<5ORSS>95THENSS=FNA(5)+43:GOTO21420
	// 21415 SS=FNA(22)+19:IFSS=40OR(SS>21ANDSS<29)OR(SS>36ANDSS<44)THEN21415
	// 21420 S$=IT$(SS)
	
	if(characters[a].sad[5]>0) {
		zap();
		printAtXY(19,12, "An item but...");
		printAtXY(6,14, "His backpack is full ! Too bad.");
		wait(500);
		return;
	}
		
	ss = rand()%100+1;
	if(ss<5||ss>95) {
		ss=rand()%5+43;
	} else {
		do {
			ss=rand()%22+19;
		} while(ss==40 || (ss>21 && ss<29) || (ss>36 && ss<44));
	}
	
	printAtXY(19,12, textesItems[ss-1]);
	
	if(ss == 36 || ss == 35) { // selle de dragon ou boussole
		// on essaie de les donner à quelqu'un qui pourra s'en servir
		char j;
		
		for(j=0;j<6;j++) {
			if(ss == 35 && characters[j].cp<5) // il ne peut pas utiliser la boussole
				continue;
			if(ss == 36 && characters[j].cp!=6) // il ne peut pas utiliser la selle
				continue;
			// on a trouvé quelqu'un qui pourra utiliser l'objet
			// peut on ranger l'objet
			for(i=0;i<6;i++) {
				if (characters[j].sad[i]==0) {
					// on a trouvé de la place
					characters[j].sad[i]=ss;
					printAtXY(11,14, "He gives the item to ");
					printAtXY(15,15, characters[j].nom);
					wait(500);
					// on positionne les booléens
					if (ss == 35) boussole = 1;
					else if (ss == 36) selle_dragon = 1;
					// le coffre est désormais vide
					ca=0;
					// on arrête tout
					return;
				}
			}
		}
	}
	
	// on range l'objet dans l'inventaire de celui qui l'a trouvé
	for(i=0;i<6;i++) {
		if (characters[a].sad[i]==0) {
			// il y a de la place ici
			characters[a].sad[i]=ss;
			// le coffre est désormais vide
			ca=0;
			// on arrête tout
			wait(500);
			return;
		}
	}
	wait(500);
}
		
void sleep(void)
{
/*
21500 IF VIL>6 THEN ZAP:PRINT@8,9;" TROP DANGEREUX !":WAIT250:RETURN
21500 CLS:PRINT @10,8;" UNE PETITE SIESTE "
21510 GOSUB 22000:PRINT @7,10;" VOUS RECUPEREZ VOS SORTS ":WAIT TI*5
21580 PRINT @10,12;"  BON VOYAGE  ":WAIT TI*5
21590 RETURN

22000  FOR P=1TO6
22010  IF ET(P)>0 AND ET(P)<5 THEN ET(P)=ET(P)+FNA(3)
22020  IF CP(P)<4 THEN 22070
22030     FOR I=1TONI(P)
22040     SN(P,I)=FNA(2)+2
22050     NEXT I
22070 NEXT P
22100 RETURN
*/
	char p,i,max;
	
	if(ville>6) {
		printAtXY(9,10, "Too dangerous !");
		wait(250);
	} else {
		cls();
		printAtXY(11,3, "A little nap. ");
	
		for(p=0;p<6;p++) {
			if(characters[p].et>0 && characters[p].et<5)
				characters[p].et+=rand()%3+1;
			if(characters[p].cp>3) {
				max = characters[p].ni > 8 ? 8 : characters[p].ni; 
				for(i=0;i<max;i++)
					characters[p].sp[i]=rand()%2+3;
			}
		}	
		printAtXY(8,5, "You recover your spells ");
		wait(150);
	}
}	
			  
void camping(void)
{
	char i, encre, a;
	char *ptr;
	while(1) {
		text();cls();
		ptr = (char*)0x26a; *ptr = *ptr & 254; // Vire le curseur 
		ink(eencre[ville-1]);
		printFrame(15);
		printTitle(8,2, A_BGRED, "<  ++   CAMP   ++  >", 21);
		printAtXY(9,6, "1. Inspect a hero");
		printAtXY(9,8, "2. Team overview");
		if (ca>20 && ca<29)
			printAtXY(9,10, "3. Open the chest");
		printAtXY(9,12,"4. Rest");
		printAtXY(13,16,"5. Leave camp");
		// affichage équipe
		printTeam();
		a = get();
		switch(a) {
			case '1':
				inspect();
				break;
			case '2':
				printTeamFull();
				break;
			case '3':
				if (ca>20 && ca<29)
					chest();
				break;
			case '4':
				sleep();
				break;
			case '5':
				cls();
				printAtXY(8,10, "Fair travels !");
				wait(150);
				return;
				break;
			default:
				ping();
				break;	
		}
		//attribAtXY(3,0,a);
	}
	
}

void main()
{		
		char j;
		unsigned int *seed;
		backupPageZero();
		io_needed=0;
        loadCharacters();
        loadTextesItems();
		seed = (unsigned int *) 630; // timer
		srand(*seed);
		j = rand();
		camping();
		io_needed = 1;
		saveCharacters();
		restorePageZero();
		SwitchToCommand("LABY");
		//SwitchToCommand("!DIR");
}
