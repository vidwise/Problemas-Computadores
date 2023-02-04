//
// Author: Arey Ferrero Ramos
//

typedef struct
{
    short freq;                      // Frecuencia de la nota (Hz).
    short time;                      // Tiempo de la nota (cs).
    short vol;                       // Volumen de la nota (0..127)
} info_note;

info_note musica[MAX_NOTAS];         // Vector de notas.

unsigned short pos_nota;             // Índice para acceder a la nota actual.
unsigned short tiempo_restante;      // Contador de tiempo restante hasta que deba dejar de sonar la nota actual.
unsigned char cambio_nota = 1;       // Booleano que indica si se ha cambiado de nota.

void main()
{
    inicializaciones();
    
    pos_nota = 0;
    tiempo_restante = musica[0].time;                  // Se carga el tiempo restante de la primera nota.
    activar_nota(0, musica[0].freq, musica[0].vol);    // Se activa la primera nota.
    
    do
    {
        tareas_independientes();
        swiWaitForVBlank();
        if (cambio_nota)
        {                                              // Si se ha cambiado de nota
            printf("Nota actual: %i\n", pos_nota);     // se imprime el número de la nueva nota por pantalla.
            cambio_nota = 0;
        }
    } while(1);
}