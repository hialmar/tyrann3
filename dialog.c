
#include "tyrann.h"

#include "bit_ops.h"

extern char textes[];
extern char * ptTextes;

char * textesPersos[2][15];
char * imagesPersos[10][2];

extern char s; // direction (est)
extern unsigned char x; // coords
extern unsigned char y;

extern struct character characters[6];

extern unsigned char boussole;

extern unsigned char cles[9][4]; // trousseau de clefs (32 octets)

extern unsigned char ville; // ville courante

extern char ca; // case courante

extern unsigned char dedans;

extern char io_needed;
extern char eencre[];

unsigned char coteTexte = 0; // 0 : droite ; 1 : gauche 

char *portes[] = {"King Robert","Queen Cersei","PRISON","Conseil",
	"Prince Oberyn","Laboratory","PRISON","CELLIER",
	"Lord Stannis","Melisandre","PRISON","VIVARIUM",
	"Sir Loras","Lady MAERGERY","PRISON","COFFRES",
	"Asha Greyjoy","Theon Greyjoy","PRISON","CELLIER",
	"Petyr","Lady Sansa","SKY CELL","MOON DOOR",
	"Lord Tyrion","Lord Tywin","PRISON","CHAPELLE",
	"Lord Brynden","ARMURERIE","PRISON","Cuisines",
	"Lord Starck","Master Luwin","RANGER","CASTLEBLACK","- SUD -","- NORD -"};

void loadTextesPersos()
{
	char filename[16];
	char p, pmax, ret, a;
	char *ptr;
	memset(filename, 0, 16);
	if (ca != 51) {
		sprintf(filename, "TXPERS%d.BIN", ville);
		ret = DiscLoad(filename);    
	} else {
		ret = DiscLoad("TXPERS10.BIN");
	}
	//printf("Chargement de %s\n", filename);
        
    //printf("Retour %d\n", ret);
    if (ret==0) {
		ptr = (char*)0xa000;
		pmax = *ptr; ptr++;
		//printf("Nb NPC : %d\n", pmax);
		for(p=0;p<pmax;p++) {
			ptr=loadTexts(ptr, textesPersos[p]);
		}
		#ifdef debug
		printf("Fin des textes, on utilise %d caracteres sur %d\n", 
			(ptTextes-textes), TMAX);
		puts("taper sur une touche pour continuer\n");
        a = (char)getchar();
        #endif
	}
}

void loadNomsImagesPersos()
{
	char v, vmax, ret, a;
	char *ptr;
    ret = DiscLoad("TIMGP.BIN");        
    //printf("Retour %d\n", ret);
    if (ret==0) {
		ptr = (char*)0xa000;
		vmax = *ptr; ptr++;
		printf("Nb Villes : %d\n", vmax);
		for(v=0;v<vmax;v++) {
			ptr=loadTexts(ptr, imagesPersos[v]);
		}
		//#ifdef debug
		printf("Fin des textes, on utilise %d caracteres sur %d\n", 
			(ptTextes-textes), TMAX);
		puts("taper sur une touche pour continuer\n");
        a = (char)getchar();
        //#endif
	}
}

void dialogue(char d)
{
	unsigned char i, j, k, x, xinit, y, t, lg;
	unsigned char *p, *q;
	char c;
	int deltaCote = 0;
	int maxCote = 103;

	// bande en haut et en bas
	do {
		if (coteTexte==0) {
			xinit=x=136;
			deltaCote = 18;
			maxCote = 236;
		} else {
			xinit=x=12;
			deltaCote = 0;
			maxCote = 120;
		}
		p = (unsigned char*)(0xa000+20*x);
		q = (unsigned char*)(0xbf18-30*x);
		for(j=0;j<10;j++) {
			memset(p+deltaCote,64,20);
			memset(q+deltaCote,64,20);
		}
		for(i=0;i<15;i++) {
			curset(x,20,3);
			hchar('=',0,1);
			curset(x,170,3);
			hchar('=',0,1);
			x+=6;
		}
		x=xinit;
		y=30;
		k=0;
		for(t=0;t<15;t++) {
			lg = strlen(textesPersos[d][t]);
			for(i=0;i<lg;i++) {
				curset(x,y,3);
				hchar(textesPersos[d][t][i],0,1);
				// printf("%c",textesPersos[1][t][i]);
				x+=6;
				if(x>maxCote) {
					x=xinit;
					y+=10;				
					if (y>160) {
						if(k==0) {
							puts("Appuyez sur une touche pour continuer\n");
							c=get();
							if(c=='f'||c=='F') return;
							puts("\n\n");
						}
						k=(k+1)%13;
						// scroll text
						// adresses des deux premières lignes
						p = (unsigned char*)(0xa000+40*30);
						q = p+400;
						// tant que q n'a pas dépassé la fin de la zone d'affichage
						while(q<(unsigned char*)(0xbf18 - 40*30+2)) {
							// on recopie les 20 octets de la ligne qui 
							// commence à q dans celle qui commence à p
							memcpy(p+deltaCote,q+deltaCote,20);
							// on passe aux deux lignes suivantes
							p += 40;
							q += 40;
						}
						y = 160;
						p = (unsigned char*)(0xbf18 - 40*40+2);
						for(j=0;j<10;j++) {
							memset(p+deltaCote,64,18);
							p += 40;
						}
						wait(1);
					}
				}
			}
		}
		/*
é - {
ù - |
è - }
ê - ~
à - @
^ - ô

		*/
		puts("Dois-je r{p{ter (O/N)?\n");
		c = get();
		// scrolling d'effacement
		x=xinit;
		p = (unsigned char*)(0xa000+40*x);
		q = (unsigned char*)(0xbf18-40*x);
		while(p+800<q) {
			memcpy(p+deltaCote+400,p+deltaCote,20);
			memcpy(q+deltaCote-400,q+deltaCote,20);
			memset(p+deltaCote+2,64,18);
			memset(q+deltaCote+2,64,18);
			p += 40;
			q -= 40;
			wait(1);
		}
		if(c=='o'||c=='O') {
			while(p<q) {
				memset(p+deltaCote+2,64,18);
				memset(q+deltaCote+2,64,18);
				p += 40;
				q -= 40;
			}
		}

	} while(c=='o'||c=='O');	
	puts("Appuyez sur une touche pour continuer\n");
	get();
}

/*
void loadRoutines()
{
	unsigned char ret;
    ret = DiscLoad("LZ77.COM");        
    // printf("Retour %d\n", ret);
    if (ret!=0) {
		return;
	}
    ret = DiscLoad("AFFIMAGE.COM");        
    // printf("Retour %d\n", ret);
    if (ret!=0) {
		return;
	}
}
*/
// from lz77.s
void lz77_unpack(void *ptr_dst, void *ptr_dst_end, void *ptr_src);
// from affimage.s
void affimage();

void loadImage(char *image)
{
	unsigned char ret, y;
	int ac;
    ret = DiscLoad(image);        
    // printf("Retour %d\n", ret);
    if (ret!=0) {
		return;
	}
	coteTexte = peek(0x7fff);
	if (coteTexte==0) {
		ink(peek(0x7ffd));
   		ac=0xa002;       
	} else {
		ink(peek(0x7ffe));
		ac=0xa014;
	}
	
	// decompresse image
	lz77_unpack((void*)0x7000, (void*)0x7fa0, (void*)0x8000);
	// adresse image decompressee  
    doke(0,0x7000);                     
    // adresse ecran               
   	doke(2,ac);
   	affimage();
/*
    // Decompresse Image           
    // adr debut table compressee  
    poke(0x6f61,0);
    poke(0x6f65,0x80);       
    // adr debut table decompressee
    poke(0x6f51,0);
    poke(0x6f55,0x70);       
    // adr fin table decompressee  
    poke(0x6f59,0xa0);
    poke(0x6f5D,0x7f);
    call(0x6f50);                       
    // Affiche image               
    // adresse table decompressee  
    doke(0,0x7000);                     
    // adresse ecran               
   	doke(2,ac);                        
   	call(0x6370);
*/

   	// remplissage couleur
	if (coteTexte==0) {
		for(y=0;y<200;y++) {
			poke(0xa014+40*y,peek(0x7ffe));
		}
	} else {
		for(y=0;y<200;y++) {
			poke(0xa014+40*y,peek(0x7ffd));
		}
	}
}


void main()
{		
		char j;
		unsigned int *seed;
		backupPageZero();
		io_needed=1;
        loadCharacters();
        loadTextesPersos();
        loadNomsImagesPersos();
        // DiscLoad("FONT.BIN");
		get();
		hires();
		//loadRoutines();
		if (ca == 7 || ca == 8) {
			printf("v: %d ca: %d, ca-7: %d\n", ville, ca, (ca-7));
			get();
			puts(imagesPersos[ville-1][ca-7]);
			get();
			loadImage(imagesPersos[ville-1][ca-7]);
			if(ville==2 && ca == 8)
				printf("Je suis la sorci}re\n");
			else
				printf("Je suis %s\n", portes[(ville-1)*4+(ca-7)]);
			dialogue(ca-7);
			//P=CA-6:CL(VI,P+1)=1:SS=VI
			// donne la clé suivante
			cles[ville-1][ca-6]=1;
		} else if (ca == 51) {
			// Jon
			loadImage(imagesPersos[9][0]);
			printf("Je suis Jon Snow\n");
			// test bit dedans
			if(TestBit(&dedans, 7)) {
				dialogue(1);
			} else {
				dialogue(0);
				SetBit(&dedans, 7);
			}
		}

		io_needed = 1;
		saveCharacters();
		restorePageZero();
		//SwitchToCommand("LABY");
		SwitchToCommand("!DIR");
}
