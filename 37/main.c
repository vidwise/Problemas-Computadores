//
// Created by aleixmt on 30/11/22.
//
#define FREQ_ENT0 33513982
#define FREQ_ENT1 523656
#define FREQ_ENT2 130914
#define FREQ_ENT3 32728
#define MAX_LON 50

unsigned int nbcode[59];
char inputstr[MAX_LON+1];
unsigned char transmsg[MAX_LON];
unsigned char lontr = 0;
unsigned char curr_ind = 0,
unsigned char curr_bit;


int main()
{
    inicializaciones();
    do
    {
        leer_mensaje(inputstr, MAX_LON);
        while (curr_ind < lontr)  // esperar el final de la reproducción del mensaje anterior (si la hay)
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
    return(0);
}