
#include "tyrann.h"

#include "bit_ops.h"

#define TMAX 1024
char textes[TMAX];
int tmax = TMAX;

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

char *persos[] = {"King Robert","Queen Cersei",
	"Prince Oberyn","La Sorci}re",
	"Lord Stannis","Melisandre",
	"Sir Loras","Lady Margaery",
	"Asha Greyjoy","Theon Greyjoy",
	"Petyr","Lady Sansa",
	"Lord Tyrion","Lord Tywin",
	"Lord Brynden","Jaime Lannister",
	"Lord Starck","Master Luwin"};

void loadTextesPersos()
{
	char filename[16];
	char p, pmax, ret, a;
	char *ptr;
	memset(filename, 0, 16);
	if (ca != 51 && ca != 52) {
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
		//printf("Nb Villes : %d\n", vmax);
		for(v=0;v<vmax;v++) {
			ptr=loadTexts(ptr, imagesPersos[v]);
		}
		#ifdef debug
		printf("Fin des textes, on utilise %d caracteres sur %d\n", 
			(ptTextes-textes), TMAX);
		puts("taper sur une touche pour continuer\n");
        a = (char)getchar();
        #endif
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
			xinit=x=132; // 120 = 20 octets (image) + 12 = 1 octet couleur texte + 1 de marge
			deltaCote = 20; 
			maxCote = 239; // max écran
		} else {
			xinit=x=12; // 1 octet paper, 1 octet ink
			deltaCote = 0;
			maxCote = 119; // demi écran
		}
		/*
		p = (unsigned char*)(0xa000+20);
		q = (unsigned char*)(0xbf18-30);
		for(j=0;j<10;j++) {
			memset(p+deltaCote,64,20);
			memset(q+deltaCote,64,20);
		}
		*/
		for(i=0;i<21;i++) {
			curset(x,20,3);
			hchar('=',0,1);
			curset(x,170,3);
			hchar('=',0,1);
			x+=5;
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
				x+=5;
			}
			x=xinit;
			y+=10;				
			if (y>160) {
				if(k==0) {
					puts("Appuyez sur une touche pour continuer");
					c=get();
					if(c=='f'||c=='F') return;
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
		/*
é - {
ù - |
è - }
ê - ~
à - @
ô - ^

		*/
		puts("Dois-je r{p{ter (O/N)?");
		c = get();
		// scrolling d'effacement
		x=20;
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
	puts("Appuyez sur une touche pour continuer");
	get();

}

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
		ac=0xa016;
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

#define NEW_VERSION 1
#ifdef NEW_VERSION
void main()
{		
		char i,j,a,c;
		unsigned int *seed;
		backupPageZero();
		io_needed=0;
        loadCharacters();
        loadTextesPersos();
        loadNomsImagesPersos();
        //DiscLoad("FONT.BIN");
        //printf("v: %d ca: %d, ca-7: %d\n", ville, ca, (ca-7));
		//get();
		hires();
		//loadRoutines();
		if (ca == 7 || ca == 8) {
			loadImage(imagesPersos[ville-1][ca-7]);
			printf("Je suis %s\n", persos[(ville-1)*2+(ca-7)]);
			// donne la clé suivante
			if (cles[ville-1][ca-6]!=1) {
				dialogue(ca-7);
				cles[ville-1][ca-6]=1;
			
				// cadeau Tyrion
				if(ville == 7 && ca == 7) {
					// on essaie de donner 2 grégeois
					char gift = 0;
					// on cherche un personnage
					for(a=0;a<6&&gift<2;a++) {
						// avec un slot de libre
						for(i=0;i<6&&gift<2;i++) {
							if (characters[a].sad[i]==0) {
								characters[a].sad[i]=33; // grégeois
								gift++;
							}
						}
					}
					if(gift<2) { // on a pas pu les donner, on donne 1500 ca à la place
						characters[2].ri += 150; // attention on stocke ca / 10
					}
				}
				
				// cadeau Jaime
				if(ville == 8 && ca == 8) {
					int prime;
					int perso;
					unsigned int *seed = (unsigned int *) 630; // timer
					srand(*seed);
					perso = rand()%6;
					prime = rand()%5000 + 5000;
					characters[perso].ri += prime/10; // attention on stocke les ca / 10
					printf("Jaime donne %d ca a %s.", prime, characters[perso].nom);
					wait(500);
				}
			} else {
				wait(200);
				puts("Dois-je r{p{ter (O/N)?");
				c = get();
				if(c=='o'||c=='O') {
					dialogue(ca-7);
				}
			}
		} else if (ville == 9 && ca == 51) {
			// Jon
			loadImage(imagesPersos[9][0]);
			printf("Je suis Jon Snow\n");
			// test bit wall
			if(!TestBit(&dedans, 7)) {
				dialogue(0);
				SetBit(&dedans, 7);
			} else {
				wait(200);
				puts("Dois-je r{p{ter (O/N)?");
				c = get();
				if(c=='o'||c=='O') {
					dialogue(0);
				}
			}
		} else if (ville == 9 && ca == 52) {
			// Jon
			loadImage(imagesPersos[9][0]);
			printf("Je suis Jon Snow\n");
			// test bit wall
			if(TestBit(&dedans, 7)) {
				dialogue(1);
				
				//printf("Generique\n");
				restorePageZero();
				SwitchToCommand("GENERIC");
			} else {
				printf("Je n'ai rien a vous dire.\n");
				wait(500);
			}
		}

		io_needed = 1;
		saveCharacters();
		restorePageZero();
		SwitchToCommand("LABY");
		//SwitchToCommand("!DIR");
}
#else
void main()
{		
		char j;
		unsigned int *seed;
		backupPageZero();
		io_needed=1;
        loadCharacters();
        loadTextesPersos();
        loadNomsImagesPersos();
        DiscLoad("FONT.BIN");

		hires();
		//loadRoutines();
		loadImage("PORTR01.DAT"); // margery
		dialogue(0);
		hires();
		loadImage("PORTR02.DAT"); // tyrion
		dialogue(0);
		hires();
		loadImage("PORTR03.DAT"); // jaime
		dialogue(0);
		hires();
		loadImage("PORTR04.DAT"); // jon
		dialogue(0);
		hires();
		loadImage("PORTR05.DAT"); // robert
		dialogue(0);
		hires();
		loadImage("PORTR06.DAT"); // luwin
		dialogue(1);
		hires();
		loadImage("PORTR07.DAT"); // LF
		dialogue(1);
		hires();
		loadImage("PORTR08.DAT"); // Tywin
		dialogue(1);
		hires();
		loadImage("PORTR09.DAT"); // Ned
		dialogue(1);
		hires();
		loadImage("PORTR10.DAT"); // Sansa
		dialogue(1);
		hires();
		loadImage("PORTR11.DAT"); // Sorciere
		dialogue(1);
		hires();
		loadImage("PORTR12.DAT"); // Theon
		dialogue(1);
		hires();
		loadImage("PORTR13.DAT"); // Asha
		dialogue(1);
		hires();
		loadImage("PORTR14.DAT"); // Loras
		dialogue(1);
		hires();
		loadImage("PORTR15.DAT"); // Blackfish
		dialogue(1);
		hires();
		loadImage("PORTR16.DAT"); // Melisandre
		dialogue(1);
		hires();
		loadImage("PORTR17.DAT"); // Stannis
		dialogue(1);
		hires();
		loadImage("PORTR18.DAT"); // Oberyn
		dialogue(1);
		hires();
		loadImage("PORTR19.DAT"); // Cersey
		dialogue(1);
		
		io_needed = 1;
		saveCharacters();
		restorePageZero();
		//SwitchToCommand("LABY");
		SwitchToCommand("!DIR");
}
#endif