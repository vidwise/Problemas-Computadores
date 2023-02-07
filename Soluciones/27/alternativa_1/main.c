//
// Author: Arey Ferrero Ramos
//

#define MAX_CAPTURAS 10                 // Máximo número de capturas (en un segundo).

unsigned char Vsegments[] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111};        // Vector de generación de los dígitos decimales en 7 segmentos. 

unsigned char n_vals = 0;               // Número de capturas actual.
float valores[MAX_CAPTURAS];            // Vector de valores capturado.

unsigned char Vdigits[4] = {0, 0};      // Vector de dígitos (inicial 0.0).
unsigned char num_dent = 1;             // Número de dígitos enteros.
unsigned char num_ddec = 1;             // Número de dígitos decimales.

unsigned char capturar = 0;             // Booleano para nueva captura.
unisgned char num_digit = 0;            // Contador de dígitos.

int main()
{
    int i, segundo = 1;
    float acum, valor;

    inicializaciones();
    inicializar_timer0(40);             // frecuencia = 40 Hz.
    do
    {
        if (capturar >= 4)
        {
            valores[n_vals++] = capturar_dato();         // Tarea independiente.
            capturar = 0;
        }
        if (n_vals == MAX_CAPTURAS)
        {
            n_vals = 0;
            acum = 0;
            for (i = 0; i < MAX_CAPTURAS; i++)           // Se calcula el promedio de todas las muestras tomadas.
            {
                acum += valores[i];
            }
            valor = acum / MAX_CAPTURAS;
            convertir_numero(valor, Vdigits, &num_dent, &num_ddec);          // Se convierte el valor decimal del promedio en un vector de dígitos.
            swiWaitForVBlank();
            printf("\t%i:\t", segundo++);
            for (i = 0; i < num_dent; i++)
            {                                            // Se imprimen los dígitos de la parte entera.
                printf("%i", Vdigits[i]);
            }
            printf(".");
            for (; i < num_dent + num_ddec; i++)
            {                                            // Se imprimen los dígitos de la parte decimal.
                printf("%i", Vdigits[i]);
            }
            printf("\n");
        }
        else
        {                                                // Se quiere reducir el consumo de la CPU cada vez que se obtenga una nueva muestra
            swiWaitForVBlank();                          // y no sólo cuando el promedio de todas ellas se imprima por pantalla.                         
        }
    } while (1);
}