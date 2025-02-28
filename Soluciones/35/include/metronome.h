/*--------------------------------------------------------------------------
|   Definitions and prototypes of global functions and routines for the
|	Metronome project
| --------------------------------------------------------------------------*/

#ifndef METRONOME_H
#define METRONOME_H

#define MAX_BPM		180	// definition of constans for limiting
#define MIN_BPM		10	// the configuration parameters
#define MAX_ACCENT	8
#define MIN_ACCENT	1
#define INI_BPM		60	// definition of initial values
#define INI_ACCENT	4
#define INI_PAUSED	!0	// initially paused


/* Global C-language functions contained in mn_suport.c */
extern void inicializaciones();
extern void tareas_independientes();
extern unsigned char gestionar_botones();
extern void actualizar_pantallas();
extern void activar_beat();


#endif /* METRONOME_H */
