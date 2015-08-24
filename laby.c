
#include "tyrann.h"

#include "bit_ops.h"

// LABY

#define XMAX 36
#define YMAX 26

#define TIMER 20

char c[XMAX*YMAX];

char f[2]; // cases devant
char d[3]; // cases à droite
char g[3]; // cases à gauche

#define A_FWBLACK	 0
#define A_FWRED 	 1
#define A_FWGREEN	 2
#define A_FWYELLOW	 3
#define A_FWBLUE	 4
#define A_FWMAGENTA	 5
#define A_FWCYAN	 6
#define A_FWWHITE	 7

char *classe[] = { "Chevalier","Mercenaire","Ranger","Sorcier","Mestre","Septon" };
char *etat[] = { "OK", "-Empoi- ", "-Paral- ", ">MORT< " };
char *message[] = { "Ouille!","Le mur n'a rien senti","Tu as bu ?" };
char *portes[] = {"King Robert","Queen Cersei","Prison","Conseil",
	"Prince Oberyn","Laboratoire","Prison","Cellier",
	"Lord Stannis","Melisandre","Prison","Vivarium",
	"Sir Loras","Lady Margaery","Prison","Coffres",
	"Asha Greyjoy","Theon Greyjoy","Prison","Cellier",
	"Petyr","Lady Sansa","Sky Cell","Moon Door",
	"Lord Tyrion","Lord Tywin","Prison","Chapelle",
	"Lord Brynden","Porcherie","Prison","Cuisines",
	"Lord Starck","Master Luwin","Ranger","CastleBlack","- Sud -","- Nord -"};

char *maisons[] = { "MARTELL","BARATHEON","TYRELL","GREYJOY","ARRYN","LANNISTER","TULLY","STARK"};

extern char textes[];
extern char * ptTextes;

extern char s; // direction (est)
extern unsigned char x; // coords
extern unsigned char y;

char s_old = 1; // ancienne direction (est)
unsigned char x_old = 2; // anciennes coords
unsigned char y_old = 2;

extern struct character characters[6];

extern unsigned char boussole;

extern unsigned char cles[9][4]; // trousseau de clefs (36 octets)

extern unsigned char ville; // ville courante

extern unsigned char combats_coffres[9][5]; // combats et coffres sous forme de tableaux de bits

extern char ca; // case courante

extern unsigned char dedans;

extern unsigned char nb_combat;

extern unsigned char np; // nombre d'ingredients de la potion
extern unsigned char nf; // nombre de fuites
extern unsigned char pm; // potion faite


extern char io_needed;

extern char eencre[];

void loadLaby()
{	
	char *filename;
	char ret;
	switch(ville) {
		case 1:
			filename = "1KING.BIN";
			break;
		case 2:
			filename = "2DORNE.BIN";
			break;
		case 3:
			filename = "3STORM.BIN";
			break;
		case 4:
			filename = "4HIGHGAR.BIN";
			break;
		case 5:
			filename = "5PIKE.BIN";
			break;
		case 6:
			filename = "6EYRIE.BIN";
			break;
		case 7:
			filename = "7CASTER.BIN";
			break;
		case 8:
			filename = "8RIVER.BIN";
			break;
		case 9:
			filename = "9WINTER.BIN";
			break;
		default:
			return;
	}
	//printf("Chargement de %s\n", filename);
    ret = DiscLoad(filename);        
    //printf("Retour %d\n", ret);       
	if (ret==0) {
		memcpy(c, (char*)0xa000, XMAX*YMAX);
	}
}

void prep(void)
{
	char i;
	// 500 ON S GOTO 520,530,540,550
	switch(s) {
		case 0:
			// 520 F(1)=C(X,Y-1):F(2)=C(X,Y-2)
			f[0]=c[x+(y-1)*XMAX];
			f[1]=c[x+(y-2)*XMAX];
			// 522 FOR I=1TO3:G(I)=C(X-1,Y-I+1):D(I)=C(X+1,Y-I+1):NEXTI
			for (i=0;i<3;i++) {
				g[i]=c[x-1+(y-(i+1)+1)*XMAX];
				d[i]=c[x+1+(y-(i+1)+1)*XMAX];
			}
			break;
		case 1:
			// 530 F(1)=C(X+1,Y):F(2)=C(X+2,Y)
			f[0]=c[x+1+(y)*XMAX];
			f[1]=c[x+2+(y)*XMAX];
			// 532 FOR I=1TO3:G(I)=C(X+I-1,Y-1):D(I)=C(X+I-1,Y+1):NEXTI
			for (i=0;i<3;i++) {
				g[i]=c[x+i+1-1+(y-1)*XMAX];
				d[i]=c[x+i+1-1+(y+1)*XMAX];
			}
			break;
		case 2:
			// 540 F(1)=C(X,Y+1):F(2)=C(X,Y+2)
			f[0]=c[x+(y+1)*XMAX];
			f[1]=c[x+(y+2)*XMAX];
			// 542 FOR I=1TO3:G(I)=C(X+1,Y+I-1):D(I)=C(X-1,Y+I-1):NEXTI
			for (i=0;i<3;i++) {
				g[i]=c[x+1+(y+i+1-1)*XMAX];
				d[i]=c[x-1+(y+i+1-1)*XMAX];
			}
			break;
		case 3:
			// 550 F(1)=C(X-1,Y):F(2)=C(X-2,Y)
			f[0]=c[x-1+(y)*XMAX];
			f[1]=c[x-2+(y)*XMAX];
			// 552 FOR I=1TO3:G(I)=C(X-I+1,Y+1):D(I)=C(X-I+1,Y-1):NEXTI
			for (i=0;i<3;i++) {
				g[i]=c[x-(i+1)+1+(y+1)*XMAX];
				d[i]=c[x-(i+1)+1+(y-1)*XMAX];
			}
			break;
		default:
			printf("erreur prep %d\n", s);
	}
}

void drawLaby(void)
{
	char l=0,lg;
	char *ptr;
	// 1000 HIRES:INK EENC(VIL):POKE#26A,PEEK(#26A) AND 254
	hires();
	ink(eencre[ville-1]);
	ptr = (char*)0x26a; *ptr = *ptr & 254; // Vire le curseur 
	// 1020 CURSET40,30,3:DRAW160,0,1:DRAW0,150,1
    CurrentPixelX=40;
    CurrentPixelY=30;
	OtherPixelX=40+160;
    OtherPixelY=30;
    DrawLine8();
    CurrentPixelX=40+160;
    CurrentPixelY=30;
	OtherPixelX=40+160;
    OtherPixelY=30+150;
    DrawLine8();
	// 1030 DRAW-160,0,1:DRAW0,-150,1
    CurrentPixelX=40+160;
    CurrentPixelY=30+150;
	OtherPixelX=40;
    OtherPixelY=30+150;
    DrawLine8();
    CurrentPixelX=40;
    CurrentPixelY=30+150;
	OtherPixelX=40;
    OtherPixelY=30;
    DrawLine8();
	// 1035 IF BS=1 THEN GOSUB 2800
	// 1040 L=1
	for(l=0;l<3;l++) {
		// 1400 REM DESSINS DES BLOCS 

		// 1070 IF G(L)>0 AND G(L)<7 THEN ON L GOSUB 1500,1550,1600
		if(g[l]>0&&g[l]<7) {
			switch(l) {
				case 0:
					// 1500 CURSET 40,30,3:DRAW20,20,1:DRAW0,110,1:DRAW-20,20,1
					CurrentPixelX=40;
					CurrentPixelY=30;
					OtherPixelX=40+20;
					OtherPixelY=30+20;
					DrawLine8();
					CurrentPixelX=40+20;
					CurrentPixelY=30+20;
					OtherPixelX=40+20;
					OtherPixelY=30+20+110;
					DrawLine8();
					CurrentPixelX=40+20;
					CurrentPixelY=30+20+110;
					OtherPixelX=40;
					OtherPixelY=30+20+110+20;
					DrawLine8();
					break;
				case 1:
					// 1550 CURSET60,50,1:DRAW25,25,1:DRAW0,60,1:DRAW-25,25,1
					CurrentPixelX=60;
					CurrentPixelY=50;
					OtherPixelX=60+25;
					OtherPixelY=50+25;
					DrawLine8();
					CurrentPixelX=60+25;
					CurrentPixelY=50+25;
					OtherPixelX=60+25;
					OtherPixelY=50+25+60;
					DrawLine8();
					CurrentPixelX=60+25;
					CurrentPixelY=50+25+60;
					OtherPixelX=60;
					OtherPixelY=50+25+60+25;
					DrawLine8();
					// 1570 IF G(1)=0 OR G(1)>6 THEN CURSET 40,50,1:DRAW20,0,1:DRAW 0,110,1:DRAW -20,0,1
					if(g[0]==0 || g[0]>6) {
						CurrentPixelX=40;
						CurrentPixelY=50;
						OtherPixelX=40+20;
						OtherPixelY=50;
						DrawLine8();
						CurrentPixelX=40+20;
						CurrentPixelY=50;
						OtherPixelX=40+20;
						OtherPixelY=50+110;
						DrawLine8();
						CurrentPixelX=40+20;
						CurrentPixelY=50+110;
						OtherPixelX=40;
						OtherPixelY=50+110;
						DrawLine8();					
					}
					break;
				case 2:
					// 1600 CURSET85,75,1:DRAW10,10,1:DRAW0,40,1:DRAW-10,10,1
					CurrentPixelX=85;
					CurrentPixelY=75;
					OtherPixelX=85+10;
					OtherPixelY=75+10;
					DrawLine8();
					CurrentPixelX=85+10;
					CurrentPixelY=75+10;
					OtherPixelX=85+10;
					OtherPixelY=75+10+40;
					DrawLine8();
					CurrentPixelX=85+10;
					CurrentPixelY=75+10+40;
					OtherPixelX=85;
					OtherPixelY=75+10+40+10;
					DrawLine8();					
					// 1620 IF G(2)>0 AND G(2)<7  THEN GOTO 1650
					if(!(g[1]>0&&g[1]<7)) {
						char t;
						// 1630 IF G(1)=0 OR G(1)>6 THEN T=45 ELSE T=25
						if(g[0]==0 || g[0]>6) t=45;
						else t=25;
						// 1640 CURSET85,75,1:DRAW0,60,1:DRAW-T,0,1:CURSET85,75,1:DRAW-T,0,1
						CurrentPixelX=85;
						CurrentPixelY=75;
						OtherPixelX=85;
						OtherPixelY=75+60;
						DrawLine8();
						CurrentPixelX=85;
						CurrentPixelY=75+60;
						OtherPixelX=85-t;
						OtherPixelY=75+60;
						DrawLine8();
						CurrentPixelX=85;
						CurrentPixelY=75;
						OtherPixelX=85-t;
						OtherPixelY=75;
						DrawLine8();
					}
					break;
			}
			// 1650 IF G(L)<2 OR G(L)>6 THEN RETURN
			if (!(g[l]<2 || g[l]>6)) {
				// 1670 ON L GOSUB 1700,1750,1800
				switch(l) {
					case 0:
						// 1700 CURSET 48,172,1:DRAW0,-125,1:DRAW -7,-7,1:RETURN
						CurrentPixelX=48;
						CurrentPixelY=172;
						OtherPixelX=48;
						OtherPixelY=172-125;
						DrawLine8();
						CurrentPixelX=48;
						CurrentPixelY=172-125;
						OtherPixelX=48-7;
						OtherPixelY=172-125-7;
						DrawLine8();
						break;
					case 1:
						// 1750 CURSET65,155,1:DRAW0,-95,1:DRAW 15,15,1:DRAW0,65,1
						CurrentPixelX=65;
						CurrentPixelY=155;
						OtherPixelX=65;
						OtherPixelY=155-95;
						DrawLine8();
						CurrentPixelX=65;
						CurrentPixelY=155-95;
						OtherPixelX=65+15;
						OtherPixelY=155-95+15;
						DrawLine8();
						CurrentPixelX=65+15;
						CurrentPixelY=155-95+15;
						OtherPixelX=65+15;
						OtherPixelY=155-95+15+65;
						DrawLine8();
						// 1770 CURSET67,105,3:CIRCLE1,1:RETURN
						curset(67,105,3);
						circle(1,1);
						break;
					case 2:
						// 1800 CURSET 88,132,1:DRAW0,-49,1:DRAW5,5,1:DRAW0,38,1
						CurrentPixelX=88;
						CurrentPixelY=132;
						OtherPixelX=88;
						OtherPixelY=132-49;
						DrawLine8();
						CurrentPixelX=88;
						CurrentPixelY=132-49;
						OtherPixelX=88+5;
						OtherPixelY=132-49+5;
						DrawLine8();
						CurrentPixelX=88+5;
						CurrentPixelY=132-49+5;
						OtherPixelX=88+5;
						OtherPixelY=132-49+5+38;
						DrawLine8();
						// 1820 CURSET 89,105,1
						curset(89,105,1);
						break;
				}
			}
		}
		// 1080 IF D(L)>0 AND D(L)<7 THEN ON L GOSUB 1900,1950,2000
		if(d[l]>0&&d[l]<7) {
			switch(l) {
				case 0:
					// 1900 CURSET200,30,3:DRAW-20,20,1:DRAW0,110,1:DRAW20,20,1					
					CurrentPixelX=200;
					CurrentPixelY=30;
					OtherPixelX=200-20;
					OtherPixelY=30+20;
					DrawLine8();
					CurrentPixelX=200-20;
					CurrentPixelY=30+20;
					OtherPixelX=200-20;
					OtherPixelY=30+20+110;
					DrawLine8();
					CurrentPixelX=200-20;
					CurrentPixelY=30+20+110;
					OtherPixelX=200;
					OtherPixelY=30+20+110+20;
					DrawLine8();
					// 1920 GOTO 2050
					break;
				case 1:
					// 1950 CURSET180,50,3:DRAW-25,25,1:DRAW0,60,1:DRAW25,25,1
					CurrentPixelX=180;
					CurrentPixelY=50;
					OtherPixelX=180-25;
					OtherPixelY=50+25;
					DrawLine8();
					CurrentPixelX=180-25;
					CurrentPixelY=50+25;
					OtherPixelX=180-25;
					OtherPixelY=50+25+60;
					DrawLine8();
					CurrentPixelX=180-25;
					CurrentPixelY=50+25+60;
					OtherPixelX=180;
					OtherPixelY=50+25+60+25;
					DrawLine8();
					// 1970 IF D(1)=0 OR D(1)>6 THEN CURSET 200,50,1:DRAW-20,0,1:DRAW 0,110,1:DRAW20,0,1
					if(d[0]==0 || d[0]>6) {
						CurrentPixelX=200;
						CurrentPixelY=50;
						OtherPixelX=200-20;
						OtherPixelY=50;
						DrawLine8();
						CurrentPixelX=200-20;
						CurrentPixelY=50;
						OtherPixelX=200-20;
						OtherPixelY=50+110;
						DrawLine8();
						CurrentPixelX=200-20;
						CurrentPixelY=50+110;
						OtherPixelX=200;
						OtherPixelY=50+110;
						DrawLine8();
					}
					// 1980 GOTO 2050
					break;
				case 2:
					// 2000 CURSET155,75,1:DRAW-10,10,1:DRAW0,40,1:DRAW10,10,1
					CurrentPixelX=155;
					CurrentPixelY=75;
					OtherPixelX=155-10;
					OtherPixelY=75+10;
					DrawLine8();
					CurrentPixelX=155-10;
					CurrentPixelY=75+10;
					OtherPixelX=155-10;
					OtherPixelY=75+10+40;
					DrawLine8();
					CurrentPixelX=155-10;
					CurrentPixelY=75+10+40;
					OtherPixelX=155;
					OtherPixelY=75+10+40+10;
					DrawLine8();
					// 2020 IF D(2)>0 AND D(2)<7 THEN GOTO 2050
					if(!(d[1]>0 && d[1]<7)) {
						char t;
						// 2030 IF D(1)=0 OR D(1)>6 THEN T=45 ELSE T=25
						if(d[0]==0 || d[0]>6) t=45;
						else t=25;
						// 2040 CURSET155,75,1:DRAW0,60,1:DRAWT,0,1:CURSET 155,75,1:DRAWT,0,1
						CurrentPixelX=155;
						CurrentPixelY=75;
						OtherPixelX=155;
						OtherPixelY=75+60;
						DrawLine8();
						CurrentPixelX=155;
						CurrentPixelY=75+60;
						OtherPixelX=155+t;
						OtherPixelY=75+60;
						DrawLine8();
						CurrentPixelX=155;
						CurrentPixelY=75;
						OtherPixelX=155+t;
						OtherPixelY=75;
						DrawLine8();
					}
					break;
			}
			// 2050 IF D(L)<2 OR D(L)>6 THEN RETURN
			if(!(d[l]<2 || d[l]>6)) {
				// 2070 ON L GOSUB 2100,2150,2200
				switch(l) {
					case 0:
						// 2100 CURSET193,172,1:DRAW0,-125,1:DRAW 7,-7,1
						CurrentPixelX=193;
						CurrentPixelY=172;
						OtherPixelX=193;
						OtherPixelY=172-125;
						DrawLine8();
						CurrentPixelX=193;
						CurrentPixelY=172-125;
						OtherPixelX=193+7;
						OtherPixelY=172-125-7;
						DrawLine8();
						break;
					case 1:
						// 2150 CURSET175,155,1:DRAW0,-95,1:DRAW-15,15,1:DRAW0,65,1
						CurrentPixelX=175;
						CurrentPixelY=155;
						OtherPixelX=175;
						OtherPixelY=155-95;
						DrawLine8();
						CurrentPixelX=175;
						CurrentPixelY=155-95;
						OtherPixelX=175-15;
						OtherPixelY=155-95+15;
						DrawLine8();
						CurrentPixelX=175-15;
						CurrentPixelY=155-95+15;
						OtherPixelX=175-15;
						OtherPixelY=155-95+15+65;
						DrawLine8();
						// 2170 CURSET162,105,3:CIRCLE1,1:RETURN
						curset(162,105,3);
						circle(1,1);
						break;
					case 2:
						// 2200 CURSET 152,132,1:DRAW0,-49,1:DRAW-5,5,1:DRAW0,38,1
						CurrentPixelX=152;
						CurrentPixelY=132;
						OtherPixelX=152;
						OtherPixelY=132-49;
						DrawLine8();
						CurrentPixelX=152;
						CurrentPixelY=132-49;
						OtherPixelX=152-5;
						OtherPixelY=132-49+5;
						DrawLine8();
						CurrentPixelX=152-5;
						CurrentPixelY=132-49+5;
						OtherPixelX=152-5;
						OtherPixelY=132-49+5+38;
						DrawLine8();
						// 2220 CURSET 148,105,1
						curset(148,105,1);
						break;
				}
				// 2080 RETURN
			}
		}
		// 1090 IF F(L)>0 AND F(L)<7 THEN ON L GOSUB 2300,2400
		if(f[l]>0 && f[l]<7) {
			switch(l) {
				case 0:
					// 2300 CURSET 60,50,1:DRAW120,0,1:DRAW0,110,1:DRAW-120,0,1:DRAW0,-110,1
					CurrentPixelX=60;
					CurrentPixelY=50;
					OtherPixelX=60+120;
					OtherPixelY=50;
					DrawLine8();
					CurrentPixelX=60+120;
					CurrentPixelY=50;
					OtherPixelX=60+120;
					OtherPixelY=50+110;
					DrawLine8();
					CurrentPixelX=60+120;
					CurrentPixelY=50+110;
					OtherPixelX=60;
					OtherPixelY=50+110;
					DrawLine8();
					CurrentPixelX=60;
					CurrentPixelY=50+110;
					OtherPixelX=60;
					OtherPixelY=50;
					DrawLine8();
					// 2320 IF (G(1)=0 OR G(1)>6) AND (G(2)>0 AND G(2)<7) THEN 
					if((g[0]==0||g[0]>6)&&(g[1]>0&&g[1]<7)) {
						// DRAW-20,0,1:CURSET60,160,1:DRAW-20,0,1
						CurrentPixelX=60;
						CurrentPixelY=50;
						OtherPixelX=60-20;
						OtherPixelY=50;
						DrawLine8();
						CurrentPixelX=60;
						CurrentPixelY=160;
						OtherPixelX=60-20;
						OtherPixelY=160;
						DrawLine8();
					}
					// 2340 IF (D(1)=0 OR D(1)>6) AND (D(2)>0 AND D(2)<7) THEN 
					if((d[0]==0||d[0]>6)&&(d[1]>0&&d[1]<7)) {
						// CURSET180,50,3:DRAW 20,0,1:CURSET 180,160,1:DRAW20,0,1
						CurrentPixelX=180;
						CurrentPixelY=50;
						OtherPixelX=180+20;
						OtherPixelY=50;
						DrawLine8();
						CurrentPixelX=180;
						CurrentPixelY=160;
						OtherPixelX=180+20;
						OtherPixelY=160;
						DrawLine8();
					}
					// 2350 GOTO 2500
					break;
				case 1:
					// 2400 CURSET 85,75,1:DRAW 70,0,1:DRAW 0,60,1:DRAW-70,0,1:DRAW0,-60,1
					CurrentPixelX=85;
					CurrentPixelY=75;
					OtherPixelX=85+70;
					OtherPixelY=75;
					DrawLine8();
					CurrentPixelX=85+70;
					CurrentPixelY=75;
					OtherPixelX=85+70;
					OtherPixelY=75+60;
					DrawLine8();
					CurrentPixelX=85+70;
					CurrentPixelY=75+60;
					OtherPixelX=85;
					OtherPixelY=75+60;
					DrawLine8();
					CurrentPixelX=85;
					CurrentPixelY=75+60;
					OtherPixelX=85;
					OtherPixelY=75;
					DrawLine8();
					{
						char tg, td;
						// 2415 IF G(1)=0 OR G(1)>6 THEN TG=45 ELSE TG=25
						if(g[0]==0||g[0]>6) tg=45;
						else tg=25;
						// 2416 IF D(1)=0 OR D(1)>6 THEN TD=45 ELSE TD=25
						if(d[0]==0||d[0]>6) td=45;
						else td=25;
						// 2420 IF (G(2)=0 OR G(2)>6) AND (G(3)>0 AND G(3)<7) THEN 
						if((g[1]==0||g[1]>6)&&(g[2]>0&&g[2]<7)) {
							// DRAW-TG,0,1:CURSET85,135,1:DRAW-TG,0,1
							CurrentPixelX=85;
							CurrentPixelY=75;
							OtherPixelX=85-tg;
							OtherPixelY=75;
							DrawLine8();
							CurrentPixelX=85;
							CurrentPixelY=135;
							OtherPixelX=85-tg;
							OtherPixelY=135;
							DrawLine8();
						}
						// 2430 IF (D(2)=0 OR D(2)>6) AND (D(3)>0 AND D(3)<7) THEN 
						if((d[1]==0||d[1]>6)&&(d[2]>0&&d[2]<7)) {
							// CURSET155,75,3:DRAW TD,0,1:CURSET 155,135,1:DRAWTD,0,1
							CurrentPixelX=155;
							CurrentPixelY=75;
							OtherPixelX=155+td;
							OtherPixelY=75;
							DrawLine8();
							CurrentPixelX=155;
							CurrentPixelY=135;
							OtherPixelX=155+td;
							OtherPixelY=135;
							DrawLine8();
						}
					}
					break;
			}
			// 2500 IF F(L)>1 AND F(L)<7 THEN ON L GOSUB 2550,2580
			if(f[l]>1&&f[l]<7) {
				switch(l) {
					case 0:
						// 2550 CURSET 80,160,1:DRAW0,-100,1:DRAW85,0,1:DRAW0,100,1:CURSET 83,115,1:CIRCLE 2,1
						CurrentPixelX=80;
						CurrentPixelY=160;
						OtherPixelX=80;
						OtherPixelY=60;
						DrawLine8();
						CurrentPixelX=80;
						CurrentPixelY=60;
						OtherPixelX=80+85;
						OtherPixelY=60;
						DrawLine8();
						CurrentPixelX=80+85;
						CurrentPixelY=60;
						OtherPixelX=80+85;
						OtherPixelY=60+100;
						DrawLine8();
						curset(83,115,1);
						circle(2,1);
						// 2560 PS=F(L): IF PS>2 AND PS<7 THEN GOSUB 2650
						if(f[l]>2 && f[l]<7) {
							unsigned char p,i,t;
							char *texte;
							if(f[l]==5 || f[l]==6) {
								char g=105,nb=5,h=35,br=25;
								p=3;
								
								// Grille
								// New version Max DEBUG
								if(ville==9 && f[l]==6) {
									nb=7;g=96;br=75;h=53;
								}
								CurrentPixelX=g;
								CurrentPixelY=75;
								OtherPixelX=g+h;
								OtherPixelY=75;
								DrawLine8();
								CurrentPixelX=g+h;
								CurrentPixelY=75;
								OtherPixelX=g+h;
								OtherPixelY=75+br;
								DrawLine8();
								CurrentPixelX=g+h;
								CurrentPixelY=75+br;
								OtherPixelX=g;
								OtherPixelY=75+br;
								DrawLine8();
								CurrentPixelX=g;
								CurrentPixelY=75+br;
								OtherPixelX=g;
								OtherPixelY=75;
								DrawLine8();
								// 2720 FORI=1TO3:CURSETG,75,1:DRAW0,25,1:G=G+9:NEXTI
								for(i=0;i<nb;i++) {
									CurrentPixelX=g;
									CurrentPixelY=75;
									OtherPixelX=g;
									OtherPixelY=75+br;
									DrawLine8();
									g+=9;
								}
							}
							//printf("texte");
							// 2760 FORI=1TOLEN(S$):CURSET T,65,3:CHAR ASC(MID$(S$,I,1)),0,1:T=T+6:NEXTI
							t=(ville-1)*4+(f[l]-3);
							// pour la porte 6 de Winterfell
							if(ville==9 && f[l]==6) {
								// si on regarde vers le nord on écrit NORD
								if (s==1) t+=2;
								// si on regarde vers le sud ou l'ouest on écrit SUD
								else if(s==3 || s==4) t+=1;
								// sinon (on regarde vers l'est)
								// et si on est dedans on affiche pas
								else if(TestBit(&dedans,3)) break;
							} else {
								// si on est dedans on affiche pas
								if(f[l]-3<=3 && TestBit(&dedans,f[l]-3)) break;
							}
							texte = portes[t];
							lg = strlen(texte);
							t=124-lg*3;
							//printf("v:%d,f[l]:%d,i:%d,lg:%d,t:%d,de:%x\n",
							//	ville, f[l], (f[l]-3), lg, t, dedans);
							for(i=0;i<lg;i++) {
								curset(t,65,3);
								hchar(texte[i],0,1);
								//printf("%c",texte[i]);
								t+=6;
							}
							//printf("\n");
							// 2790 RETURN
						}
						// 2565 RETURN
						break;
					case 1:
						// 2580 CURSET95,135,1:DRAW0,-50,1:DRAW50,0,1:DRAW0,50,1:CURSET 96,115,1:RETURN
						CurrentPixelX=95;
						CurrentPixelY=135;
						OtherPixelX=95;
						OtherPixelY=135-50;
						DrawLine8();
						CurrentPixelX=95;
						CurrentPixelY=135-50;
						OtherPixelX=95+50;
						OtherPixelY=135-50;
						DrawLine8();
						CurrentPixelX=95+50;
						CurrentPixelY=135-50;
						OtherPixelX=95+50;
						OtherPixelY=135;
						DrawLine8();
						curset(96,115,1);
						break;
				}
			}
			// 2520 RETURN
			// 1095 IF F(L)>0 AND F(L)<7 THEN GOTO 1200
			// stop looping
			break;
		}
	}
	
	
	// boussole
	if(boussole){
		char dir;
		switch(s) {
			// 2800 IF S=1 THEN DIR=78
			case 0:
				dir=78;
				break;
			// 2820 IF S=2 THEN DIR=69
			case 1:
				dir=69;
				break;
			// 2830 IF S=3 THEN DIR=83
			case 2:
				dir=83;
				break;
			// 2840 IF S=4 THEN DIR=79
			case 3:
				dir=79;
				break;
		}
		// 2850 CURSET 220,10,1:CHAR DIR,0,1:CURMOV 2,8,1
		curset(220,10,0);hchar(dir,0,1);
		// 2860 DRAW 3,15,1:DRAW -3,15,1:DRAW -3,-15,1:DRAW 3,-15,1
		curset(222,18,1);
		CurrentPixelX=220+2;
		CurrentPixelY=10+8;
		OtherPixelX=220+2+3;
		OtherPixelY=10+8+15;
		DrawLine8();
		CurrentPixelX=220+2+3;
		CurrentPixelY=10+8+15;
		OtherPixelX=220+2;
		OtherPixelY=10+8+15+15;
		DrawLine8();
		CurrentPixelX=220+2;
		CurrentPixelY=10+8+15+15;
		OtherPixelX=220+2-3;
		OtherPixelY=10+8+15;
		DrawLine8();
		CurrentPixelX=220+2-3;
		CurrentPixelY=10+8+15;
		OtherPixelX=220+2;
		OtherPixelY=10+8;
		DrawLine8();
		// 2870 CURMOV2,12,1:DRAW 13,3,1:DRAW -13,3,1
		curset(224,30,1);
		CurrentPixelX=220+2+2;
		CurrentPixelY=10+8+12;
		OtherPixelX=220+2+2+13;
		OtherPixelY=10+8+12+3;
		DrawLine8();
		CurrentPixelX=220+2+2+13;
		CurrentPixelY=10+8+12+3;
		OtherPixelX=220+2+2;
		OtherPixelY=10+8+12+3+3;
		DrawLine8();
		// 2880 CURSET 220,30,1:DRAW -13,3,1:DRAW 13,3,1
		curset(220,30,1);
		CurrentPixelX=220;
		CurrentPixelY=30;
		OtherPixelX=220-13;
		OtherPixelY=30+3;
		DrawLine8();
		CurrentPixelX=220-13;
		CurrentPixelY=30+3;
		OtherPixelX=220;
		OtherPixelY=30+3+3;
		DrawLine8();
		// 2900 RETURN
	}
}

/*
unsigned char findCombatChestNumber() {
	unsigned char combatChestNumber = 0;
	int i;
	int fin = x+(y-1)*XMAX;
	for(i = 0; i <= fin; i++) {
		if(c[i]>=10 && c[i]<25) // combat ou coffre
			combatChestNumber++;
	}
	return combatChestNumber;
}
*/

void manageCell(void)
{
	char i, j, a, combat;
	char *ptr;
	//printf("ca = %d\n", ca);
	if (ca==7 || ca==8 || ca==51) {
		// personnage
		//printf("Voila un personnage, dialoguer (O/N) ?\n");
        //a = get();
        //if (a == 'o' || a == 'O') { 
			text();
			io_needed = 0;
			saveCharacters();
			restorePageZero();
			SwitchToCommand("DIALOG");
		//} else {
		//	puts("\n");
		//}
	} else if (ca==99) {
		printf("        Retour Village (O/N)?\n");
        a = get();
        if (a == 'o' || a == 'O') { 
        	text();
        	io_needed = 1;
        	// re-init de la position et orientation pour retour laby
        	x = y = s = 2;
			saveCharacters();
			restorePageZero();
        	SwitchToCommand("VILLE");
		} else {
			puts("\n");
		}
	} else if (ca >=30 && ca <= 50) {
		// combats_coffres[ville-1]
		// si le combat n'a pas été déjà fini
		unsigned char nb = ca - 30 + 8; // les 8 premiers bits stockent les coffres
		if(!TestBit(combats_coffres[ville-1], nb)) {
			printf("Combat !", ca);
			wait(300);
			//printf("Combat %d non fini!\n", nb);
			//printf("debug : C pour combat, autre evite.\n");
			//a = get();
			//if (a == 'c' || a == 'C') {
				DiscLoad("STARK.BIN");
				puts("            < ESPACE >");
				a = get();
				text();
				io_needed = 0;
				saveCharacters();
				restorePageZero();
				SwitchToCommand("COMBAT");
			//}
		}
	// coffres
	} else if (ca>=21 && ca<=28) {
		// si le coffre n'a pas été déjà ouvert
		unsigned char nb = ca - 21;
		if(!TestBit(combats_coffres[ville-1], nb)) {
			printf("Vous trouvez un coffre !", ca);
			wait(300);
			//printf("Coffre %d non fini!\n", nb);
			//printf("debug : C pour camp, autre evite.\n");
			//a = get();
			//if (a == 'c' || a == 'C') {
				text();
				io_needed = 1;
				saveCharacters();
				restorePageZero();
				SwitchToCommand("CAMP");
			//}
		}
	} else if (ca==52) {
		DiscLoad("ZWALL2.BIN");
		/* // A ADAPTER
		3101 IFPM=0THENPRINT"ET LA POTION ?":ZAP:WAIT50:GOTO3104
		3102 IF WALL=1THENPRINT"VERS LE NORD DU MUR":GOTO3110
		3104 PRINT"PORTE DU NORD CLOSE":WAITTI*10:GOTO3140
		3110 GETA$:IFA$=""THEN3110
		3120 GOSUB 30500:ZAP:TEXT:PRINT@10,10;"ZE END":END
		3130 FORI=1TO5:ZAP:WAIT30:NEXT:SHOOT
		3140 X=XO:Y=YO
		3150 RETURN
		*/
		if(pm==0) { // potion
			printf("      ET LA POTION ?\n");
			zap();
			wait(400);
		} else if(TestBit(&dedans, 7)) { // wall
			printf("      VERS LE NORD DU MUR\n");
			wait(250);
			text();
			io_needed = 0;
			saveCharacters();
			restorePageZero();
			SwitchToCommand("DIALOG");
		} else {
			printf("     PORTE DU NORD CLOSE\n");
			wait(400);
		}
	} else {
		// combats aléatoires ?
#ifdef RANDOM
		combat = (nb_combat < 20) ? rand()%10 == 1 : rand()%15 == 1;
		if(combat) {
			nb_combat++;
			printf("combat %d\n", ca);
			printf("debug : C pour combat, autre evite (nb combat : %d).\n", nb_combat);
			a = get();
			if (a == 'c' || a == 'C') {
				text();
				io_needed = 0;
				saveCharacters();
				restorePageZero();
				SwitchToCommand("COMBAT");
			}
		}
#endif
	}
	//prep();
	//drawLaby();
}

void forward(void)
{
	char b;
	// 600 IF F(1)>0 AND F(1)<7 THEN GOTO 660
	if (f[0]>0 && f[0]<7) {
		// 660 B=INT(RND(1)*3+1)
		// 670 SHOOT:PRINT SPC(5) TX$(B) :WAIT8*TI:SHOOT:CLS
		// 672 IF B=2 THEN ZAP:SHOOT:ZAP
		shoot();
		printf("     ");
		b = rand()%3;
		printf(message[b]);
		wait(160);
		shoot();
		cls();
		if (b==1) {
			zap();shoot();zap();
		}
	} else {
		s_old = s;
		x_old = x;
		y_old = y;
		switch(s) {
			case 0:
				if(y>0)
					y--;
				break;
			case 1:
				if(x<XMAX)
					x++;
				break;
			case 2:
				if(y<XMAX)
					y++;
				break;
			case 3:
				if(x>0)
					x--;
				break;
			default:
				printf("erreur forward\n");
		}
	}
	// 330 CASE=C(X,Y)
	ca = c[x+y*XMAX];
	
	prep();
	drawLaby();
	manageCell();
}


void main()
{		
		char j, a;
		unsigned int *seed;
		backupPageZero();
        GenerateTables();
		DiscLoad("FONT.BIN");
        // testing
        
        //sedoric("!LOAD(\"TEAM.BIN\")");
       	//cls();
       	
       	#ifdef debug 
        printf("char : %d, short %d, int %d, long %d, float %d\n",
        	sizeof(char), sizeof(short), sizeof(int), sizeof(long), sizeof(float));
        	
       
        printf("taper sur une touche pour continuer\n");
        a = (char)getchar();
        #endif
        io_needed = 1;
        loadCharacters();
        
        #ifdef debug
        printf("taper sur une touche pour continuer\n");
        a = (char)getchar();
        #endif
        loadLaby();
        if (ca==0) {
        	if (c[x+y*XMAX] != 0) {
        		unsigned char nb = 255;
        		// un coffre ou un combat a été fini
        		char cas = c[x+y*XMAX];
        		if (cas>=21 && cas<=28) nb = cas - 21;
        		else if (cas >=30 && cas <= 50) nb = cas - 30 + 8; // les 8 premiers bits stockent les coffres
				if (nb < 40) {
					SetBit(combats_coffres[ville-1], nb);
					//printf("Coffre ou Combat %d fini!\n", nb);
					c[x+y*XMAX] = 0;
				}
        	}
        }
        
        #ifdef debug
        for (a=0; a<8; a++)
        	for (j=0; j<40; j++)
				if(TestBit(combats_coffres[a], j))
					printf("Bit %d is set\n", j);
        
        // testing
        // SetBit(combats_coffres[ville-1], 0);
        #endif
        
        printf("Taper sur une touche pour continuer\n");
        get();
		
		seed = (unsigned int *) 630; // timer
		srand(*seed);
		#ifdef debug
		printf("timer vaut %d\n", *seed);
		printf("alea vaut %d\n", rand());
				
		printf("taper sur une touche pour continuer\n");
        a = (char)getchar();
		#endif
		
        // Sedoric(command2);
      
		// 330 CASE=C(X,Y)
		prep();
		drawLaby();

		ca = c[x+y*XMAX];
		// manageCell();
		// 320 GOSUB 500:GOSUB 1000
		
		
		
		while(1) {
						
			// 380 GET A$
			//a = (char)getchar();
			//printf("x=%d, y=%d, s=%d ca=%d\n", x,y,s,ca);
			a = get();
			
			switch(a) {
				//#ifdef debug
				case 'F': // pour debug
				case 'f':
					// 390 IF A$="F" THEN END
					a = 'F';
					text();
					io_needed = 1;
					saveCharacters();
					restorePageZero();
					printf("sauvegarde ok\n");
					SwitchToCommand("!DIR"); // évite une erreur bizarre
					return;
					break;
				//#endif
				case ' ':
					// 400 IF A$=" "AND F(1)>1 AND F(1)<7 THEN GOSUB 3000:GOTO 330
					if(f[0]>1&&f[0]<7) {
						#ifdef debug
						for (j=0;j<4;j++) {	
							printf("cle(%d,%d) = %d ", 3, j, cles[3][j]);
						}
						#endif
						// 3000 REM ClÈ
						// 3010 IF F(1)=2 THEN 3030
						// 3020 IF CLEF(VIL,(F(1)-2))=0 THEN ZAP:PRINT TX$(4):GOTO 3050
						// 3030 F(1)=0:GOSUB 600:PING
						// 3050 RETURN
						if (f[0] == 2) {
							f[0]=0;
							forward();
							ping();
							// on avance deux fois
							prep();
							drawLaby();
							forward();
							printf("On entre dans la pi}ce\n");
						} else {
							////// MODIF Maximus *******
							if(cles[ville-1][f[0]-3]==0) {
								zap();
								printf("Ou est la cle ?\n");
							} else {
								#ifdef debug
								printf("Porte %d cle(%d,%d) %d  ", 
									f[0], ville-1, (f[0]-3), cles[ville-1][f[0]-3]);
								a = (char)getchar();
								#endif
								InvertBit(&dedans,f[0]-3);
								f[0]=0;
								forward();
								ping();
								// on avance deux fois
								prep();
								drawLaby();
								forward();
								printf("On entre dans la pi}ce\n");
							}
						}
					}
					break;
				case 'I':
				case 'i':
				case 'Z':
				case 'z':
					// 410 IF A$="I" OR A$="i" THEN GOSUB 600:GOTO 330
					forward();
					break;
				case 'J':
				case 'j':
				case 'Q':
				case 'q':
					// 420 IF A$="J" OR A$="j" THEN S=S-1:IF S=0 THEN S=4
					s--;
					if(s<0) s=3;
					prep(); drawLaby();
					break;
				case 'L':
				case 'l':
				case 'D':
				case 'd':
					// 430 IF A$="L" OR A$="l" THEN S=S+1:IF S=5 THEN S=1
					s++;
					if(s>3) s=0;
					prep(); drawLaby();
					break;
				case 'C':
				case 'c':
					// 435 IF A$="C" THEN GOTO 21000
					text();
					io_needed = 1;
					saveCharacters();
					restorePageZero();
					SwitchToCommand("CAMP");
					break;
				//#ifdef debug
				case 'A':
				case 'a':
					printf("alea vaut %d\n", rand());
					break;
				case 'K':
				case 'k':					
					for (j=0;j<4;j++) {	
						cles[ville-1][j] = !cles[ville-1][j];
					}
					break;
				case 'V':
				case 'v':
					text();
					io_needed = 1;
					saveCharacters();
					restorePageZero();
					SwitchToCommand("VILLE");
					break;
				//#endif
				default:
					;
			}
			// 450 GOTO 300
		}
}
