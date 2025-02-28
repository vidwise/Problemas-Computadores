/*-----------------------------------------------------------------------
|   Description: Metronome for NDS (graphic version)
|------------------------------------------------------------------------
|	Author: Santiago Romani (DEIM, URV)
|	Date:   Nov/2020 Nov/2021
| -----------------------------------------------------------------------*/

//
// Solution author: Arey Ferrero Ramos.
// Merge with implementable problem by: Aleix Mariné-Tena
//

#include <nds.h>		// headers of libnds functions: swiWaitForVBlank()
#include <stdio.h>		// headers of libc input/output functions: printf()

#include "metronome.h"	// project definitions and function prototypes
#include "RSIs.h"

typedef struct 			// coordenadas de sprites
{
	short px;					// [-64..288]
	short py;					// [-32..224]
} t_pos;

t_pos ang_pos[360];		// vector con posiciones (px, py) para cada �ngulo

unsigned char bpm = 60;				// "beats" por minuto
unsigned char accent = 4;			// divisiones para generar el acento
unsigned char paused = !0;			// metr�nomo pausado? (!0: s�, 0: no)

unsigned int ang_actual = 0;		// �ngulo actual (en formato Q12)
unsigned int fraccion = ((60 / 4) / 10) << 12; 		// incremento del �ngulo en un VBL (Q12)


int main(void)
{
	inicializaciones();
	do
	{
		tareas_independientes();
		if (gestionar_botones())
		{ 							// actualizar fracci�n seg�n nuevos 
			fraccion = ((bpm / accent) / 10) << 12;			// valores de bpm i accent
		}
		swiWaitForVBlank();
		actualizar_pantallas();
		// activar_beat();			// ???
	} while (1);
	return(0);
}

