//
// Author: Santiago Romaní Also
//

typedef struct {
    short freq;         // frecuencia de la nota (Hz)
    short time;         // tiempo de la nota (centésimas de segundo)
    short vol;          // volumen de la nota (0..127)
} info_note;

info_note musica[MAX_NOTAS];

short nota_actual;      // índice de la nota actual
short tiempo_restante;  // cuenta el tiempo restante de la nota actual
short cambio_nota = 0;  // indica si ha habido cambio de nota

int main()
{
    inicializaciones();
    nota_actual = 0;
    tiempo_restante = musica[0].time;
    activar_nota(0, musica[0].freq, musica[0].vol);
    do
    {
        tareas_independientes();
        swiWaitForVBlank();
        if (cambio_nota == 1)
        {
            printf("Nota actual = %d\n", nota_actual);
            cambio_nota = 0;
        }
    } while (1);
}