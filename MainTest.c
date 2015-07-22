
#include <lib.h>

// --------------------------------------
//   LineBench
// --------------------------------------
// (c) 2003-2008 Mickael Pointier.
// This code is provided as-is.
// I do not assume any responsability
// concerning the fact this is a bug-free
// software !!!
// Except that, you can use this example
// without any limitation !
// If you manage to do something with that
// please, contact me :)
// --------------------------------------
// --------------------------------------
// For more information, please contact me
// on internet:
// e-mail: mike@defence-force.org
// URL: http://www.defence-force.org
// --------------------------------------
// Note: This text was typed with a Win32
// editor. So perhaps the text will not be
// displayed correctly with other OS.


// ============================================================================
//
//                                                                      Externals
//
// ============================================================================

#include "params.h"

//
// ===== Display.s =====
//
extern unsigned char CurrentPixelX;             // Coordinate X of edited pixel/byte
extern unsigned char CurrentPixelY;             // Coordinate Y of edited pixel/byte

extern unsigned char OtherPixelX;               // Coordinate X of other edited pixel/byte
extern unsigned char OtherPixelY;               // Coordinate Y of other edited pixel/byte


//
// ===== line8.s =====
//
void DrawLine8();

void DrawLineROM()
{
	curset(CurrentPixelX, CurrentPixelY, 1);
	draw(OtherPixelX-CurrentPixelX, OtherPixelY-CurrentPixelY, 1);
}

//
// ===== sedoric_io.s ======
//

extern char DiscSave(char * filename, char * pini, char * pend);
extern char DiscLoad(char * filename);
extern char Sedoric(char * command);
extern void SwitchToCommand(char * command);

char * command1 = "COMBAT.COM"; // fichier contenant le combat (à changer)

void main()
{		
	GenerateTables();
	hires();

    CurrentPixelX=40;
    CurrentPixelY=30;
	OtherPixelX=40+160;
    OtherPixelY=30;
    DrawLine8();
    //DrawLineROM();
    
    text();
    // call(0xc6f0); // Call Basic NEW
    SwitchToCommand(command1);

}


