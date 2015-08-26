
#include <lib.h>

// ============================================================================
//
//                                                                      Externals
//
// ============================================================================

#include "params.h"

//#define debug 1

//
// ===== Display.s =====
//

extern unsigned char CurrentPixelX;             // Coordinate X of edited pixel/byte
extern unsigned char CurrentPixelY;             // Coordinate Y of edited pixel/byte

extern unsigned char OtherPixelX;               // Coordinate X of other edited pixel/byte
extern unsigned char OtherPixelY;               // Coordinate Y of other edited pixel/byte

/*
unsigned char CurrentPixelX;             // Coordinate X of edited pixel/byte
unsigned char CurrentPixelY;             // Coordinate Y of edited pixel/byte

unsigned char OtherPixelX;               // Coordinate X of other edited pixel/byte
unsigned char OtherPixelY;               // Coordinate Y of other edited pixel/byte
*/

//
// ===== line8.s =====
//
void DrawLine8();
/*
{
	curset(CurrentPixelX, CurrentPixelY, 1);
	draw(OtherPixelX-CurrentPixelX, OtherPixelY-CurrentPixelY, 1);
}

void GenerateTables();

{

}
*/
//
// ===== sedoric_io.s ======
//

extern unsigned char SPStorage;
extern void BackupSP();
extern char DiscSave(char * filename, char * pini, char * pend);
extern char DiscLoad(char * filename);
extern char Sedoric(char * command);
extern void SwitchToCommand(char * command);

// stdio.h

extern void puts(char *s);
extern void sprintf(char buf[], const char *format,...);

// string.h
extern void *memset(void *buffer, int c, int count);

// defines and structs

#define XMAX 36
#define YMAX 26

#define TIMER 20

#define A_FWBLACK	 0
#define A_FWRED 	 1
#define A_FWGREEN	 2
#define A_FWYELLOW	 3
#define A_FWBLUE	 4
#define A_FWMAGENTA	 5
#define A_FWCYAN	 6
#define A_FWWHITE	 7

struct character {
	char 		  nom[11]; // nom
	unsigned int  ri; // richesses (nom => 2 octets)
	unsigned char cp; // carrière perso
	unsigned char mp; // maison
	unsigned char cc; // capacité de combat
	unsigned char ct; // capacité de tir
	unsigned char fo; // force
	unsigned char ag; // agilité
	unsigned char in; // intelligence
	unsigned char fm; // force mentale
	unsigned char pv; // points de vie ou de blessures
	unsigned char et; // état des PV
	unsigned char ok; // santé
	unsigned char ni; // niveau (nom => 16 octets)
	unsigned int  xp; // expérience
	unsigned char wr; // arme droite (weapon right)
	unsigned char wl; // arme gauche
	unsigned char pt; // armure
	unsigned char ca; // classe d'armure
	unsigned char bt; // bête (nom => 23 octets)
	unsigned char sad[6]; // sac à dos
	unsigned char sp[8]; // sorts
};

// From common.c

// waits for some time 
void wait(unsigned int val);

// puts some text at the x,y coordinate of a TEXT screen
void printAtXY(int x, int y, char *texte);

// puts a specific attribute at the x,y coordinate of a TEXT screen
void attribAtXY(int x, int y, char attrib);

// backups page zero data
void backupPageZero();

// restore page zero data before switching to Basic/OS
void restorePageZero();

// prints a title with some background color
void printTitle(char x, char y, char color, char *text, char lgText);

// prints a frame
void printFrame(int size);

// loads texts from a bin file
char *loadTexts(char *ptr, char *tab[]);

// From team.c

// loads the team
void loadCharacters(void);

// saves the team
void saveCharacters(void);


