//
// Author: Santiago Romaní Also
//

#define FREQ_ENT0 33513982          // Posibles frecuencias de entrada de un timer (en Hz)
#define FREQ_ENT1 523656
#define FREQ_ENT2 130914
#define FREQ_ENT3 32728
#define MAX_LON 50                  // Longitud máxima del mensaje

unsigned int nbcode[59];            // Vector códigos (ya inicializado)
char inputstr[MAX_LON+1];           // Mensaje introducido por usuario
unsigned char transmsg[MAX_LON];    // Mensaje transformado
unsigned char lontr = 0;            // Longitud mensaje transformado
unsigned char curr_ind = 0,         // Índice de letra actual
unsigned char curr_bit;             // número de bit actual


void main()
{
    inicializaciones();
    do
    {
        leer_mensaje(inputstr, MAX_LON);
        while (curr_ind < lontr)    // Eperar el final de la reproducción del mensaje anterior (si la hay)
        {
            swiWaitForVBlank();
        }
        lontr = transformar_mensaje(inputstr, transmsg);
        if (lontr > 0)
        {
            curr_ind = 0;
            curr_bit = nbcode[transmsg[curr_ind]] >> 24;

            a = FREQ_ENT3;
            b = FREQ_ENT3 / 8;  // b = 4096

            activar_timer(0, a, b);
        }
    } while (1);
}