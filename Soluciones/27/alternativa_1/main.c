//
// Author: Arey Ferrero Ramos
//

#define MAX_CAPTURAS 10

unsigned char Vsegments[] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111};

unsigned char n_vals = 0;
float valores[MAX_CAPTURAS];

unsigned char Vdigits[4] = {0, 0};
unsigned char num_dent = 1;
unsigned char num_ddec = 1;

unsigned char capturar = 0;
unisgned char num_digit = 0;

int main()
{
    int i, segundo = 1;
    float acum, valor;

    inicializaciones();
    inicializar_timer0(40);
    do
    {
        if (capturar >= 4)
        {
            valores[n_vals++] = capturar_dato();
            capturar = 0;
        }
        if (n_vals == MAX_CAPTURAS)
        {
            n_vals = 0;
            acum = 0;
            for (i = 0; i < MAX_CAPTURAS; i++)
            {
                acum += valores[i];
            }
            valor = acum / MAX_CAPTURAS;
            convertir_numero(valor, Vdigits, &num_dent, &num_ddec);
            swiWaitForVBlank();
            printf("\t%i:\t", segundo++);
            for (i = 0; i < num_dent; i++)
            {
                printf("%i", Vdigits[i]);
            }
            printf(".");
            for (; i < num_dent + num_ddec; i++)
            {
                printf("%i", Vdigits[i]);
            }
            printf("\n");
        }
        else
        {
            swiWaitForVBlank();
        }
    } while (1);
}