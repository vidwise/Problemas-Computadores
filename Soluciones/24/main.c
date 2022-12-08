#define MAX_CAR 16
#define MAX_FON 50

char palabra[MAX_CAR+1];  // palabra a vocalizar
unsigned int fonemas[MAX_FON];  // fonemas a vocalizar
unsigned char fcs[MAX_FON];  // tiempo de cada fonema, en centésimas de segundo
unsigned char num_fon = 0;  // número de fonemas a vocalizar
char i_fon = -1;

int main()
{
    unsigned int* REG_MOUTH;

    inicializaciones();
    do {
       tareas_independientes();

       if (i_fon == -1)
       {
            if (siguiente_palabra(palabra) == 0)
            {
                continue;
            }

            num_fon = pal2fon(palabra, fonemas, fcs);
            i_fon = 0;

            swiWaitForVBlank();
            printf("%s", palabra);

            *REG_MOUTH = fonemas[0] | 0x40000000 ;
            activar_timer0(100);
       }
    } while(1);
}