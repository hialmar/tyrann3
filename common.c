
#include "tyrann.h"


//char *save_zero = (char*)0xb800;
char save_zero[8];
char save_zero2[8];

char *saved = (char*)0xb400;

				// King    Dorne        Storm       Highgarden
char eencre[] = { A_FWRED, A_FWMAGENTA, A_FWYELLOW, A_FWGREEN, 
				// Pike      Eyrie     Casterly
				A_FWMAGENTA, A_FWCYAN, A_FWRED,
				// Riverrun  Winterfell
				A_FWBLUE,    A_FWWHITE };

extern char textes[]; // defini dans les fichiers contenant le main pour moduler la taille
extern int tmax;

char * ptTextes = (char*)textes;
char nbTextes = 0;
				  
extern unsigned char ville; // ville courante

void wait(unsigned int val)
{
	char i;
	while(val--) {
		i=100;
		while(i--);
	}
}

void printAtXY(int x, int y, char *texte)
{
	// adresse de l'emplacement (x,y) de l'écran
	char *ptr = (char*)0xbb80 + y * 40 + x;
	
	// tant qu'on n'a pas fini la chaine
	while(*texte!=0) {
		// on vérifie qu'on ne sorte pas de l'écran
		if (ptr>(char*)0xbfe0) return;
		// on écrit le caractère courant sur l'écran
		*ptr = *texte;
		// on avance sur l'écran et dans le texte
		ptr++; texte++;
	}
}

void attribAtXY(int x, int y, char attrib)
{
	// adresse de l'emplacement (x,y) de l'écran
	char *ptr = (char*)0xbb80 + y * 40 + x;
	if (ptr>(char*)0xbfe0) return;
	// on écrit l'attribut sur l'écran
	*ptr = attrib;
}

void backupPageZero()
{
	// backup the stack pointer
	BackupSP();
	// backup some page 0 important data
	memcpy(save_zero, (char*)0x84, 7);
	memcpy(save_zero2, (char*)0x00, 4);
	//printf("SP was %d\n", SPStorage);
}

void restorePageZero()
{
	memcpy((char*)0x84, save_zero, 7);
	memcpy((char*)0x00, save_zero2, 4);
	//poke(0x87,0);
	// call(0xc6f0); // Call Basic NEW
}


void printTitle(char x, char y, char couleur, char *texte, char lgTexte) 
{
	printAtXY ( x,y," ");
	attribAtXY(x+1,y, couleur); // fond rouge
	attribAtXY(x+2,y,A_FWWHITE); // encre blanche
	printAtXY (x+3,y,texte);
	attribAtXY(x+3+lgTexte,y,eencre[ville-1]);
	attribAtXY(x+3+lgTexte+1,y,A_BGBLACK); // fond noir
	printAtXY (x+3+lgTexte+2,y," ");
}

void printFrame(int taille)
{
	char i;
	ink(eencre[ville-1]);
	putchar('\n'); //1
	printf(" *************************************"); // haut
	for(i=0;i<taille;i++)
	printf(" *                                   *"); // milieu
	printf(" *************************************"); // bas
}

char *loadTexts(char *ptr, char *tab[])
{
	char t, max, longueur;
	max = *ptr; ptr++;
	//printf("ptTextes : %x\n", (unsigned int)ptTextes);
	nbTextes = max;
	//printf("Nb textes : %d\n", max);
	for (t=0; t<max; t++) {
		longueur = *ptr; ptr++;
		//printf("Longueur texte %d : %d\n", t, longueur);
		tab[t] = ptTextes;
		if (ptTextes+longueur+1-textes > tmax) {
			printf("Le tableau est trop petit, il faut au moins %d caracteres\n",
				ptTextes+longueur+1-textes);
			//restorePageZero();
			exit(1);
		}
		memcpy(tab[t], ptr, longueur);
		//tab[t][longueur]=' ';
		tab[t][longueur]=0;
		//printf("Texte %s \n", tab[t]);
		ptTextes+=longueur+1;
		ptr+=longueur;
	}
	return ptr;
}
