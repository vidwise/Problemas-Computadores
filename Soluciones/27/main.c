//
// Author: Santiago Romaní Also
//

#define MAX_CAPTURAS 10 // máximo número de capturas (en un segundo)

// Vector de generación de los dígitos decimales en 7 segmentos
unsigned char Vsegments[] = {63, 6, 91, 79, 102, 109, 125, 7, 127, 111};

unsigned char n_vals = 0;  // Número de capturas actual
float valores[MAX_CAPTURAS];  // Vector de valores capturados
unsigned char Vdigits[4] = {0, 0};  // Vector de dígitos (inicial 0.0)
unsigned char num_dent = 1;  // Número de dígitos enteros
unsigned char num_ddec = 1;  // Número de dígitos decimales
unsigned char cont_tics = 0;  // Contador de tics (para la RSI)
unsigned char cont_pos = 0;  // Contador de posiciones
unsigned char nuevo_sec = 0;  // Booleano para nuevo segundo

int main()
{
    float promedio;
    int nsec = 0;

    inicializaciones();
    inicializar_timer0(40);  // F = 40 Hz (T = 25 ms)
    do
    {
        for (int i = 0; i < 5; i++)  // ralentizar bucle principal
        {
            swiWaitForVBlank();  // Alrededor de 0,1 segundos
        }

        valores[n_vals++] = capturar_dato();  // Tarea independiente

        if (nuevo_sec)  // Detectar si hay nuevo segundo
        {
            promedio = 0.0;
            for (int i = 0; i < n_vals; i++)
            {
                promedio += valores[i];  // Calcular valor promedio
            }
            promedio /= n_vals;
            n_vals = 0;  // Reiniciar contador de capturas

            convertir_numero(promedio, Vdigits, &num_dent, &num_ddec);

            swiWaitForVBlank();
            printf("\n\t%d:\t", ++nsec);
            for (int i = 0; i < num_dent + num_ddec; i++)
            {
                printf("%d", Vdigits[i]);
                if (i + 1 == num_dent)
                {
                    printf(".");
                }
            }
            nuevo_sec = 0;  // Desactiva señalización segundo
        }
    } while (1);
}