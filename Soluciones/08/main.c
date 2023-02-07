//
// Author: Arey Ferrero Ramos.
//

#define MAX_ELEMENTS 32

unsigned char str1[MAX_ELEMENTS] = NULL;         // String para almacenar los carácteres de la primera línea del display.
unsigned char str2[MAX_ELEMENTS] = NULL;         // String para almacenar los carácteres de la segunda línea del display.

unsigned char cont_visual = 16;                  // Contador que permite llevar a cabo la visualización cada 40 interrupciones del timer. Se debe tener en cuenta que, 
                                                 // cuando se arranca el programa, la RSI no requerirá los dos segundos necesarios para hacer el scroll de derecha a izquierda.
                                                 // Por ello, incializar el contador a 16 permite diseñar una RSI más sencilla.
unsigned char desplazamiento = 1;                // Booleano que indica el sentido del scroll horizontal.              

void main()
{
    int i;

    inicializaciones();
    do
    {
        tareas_independientes();
        if (wifiReciveText(str2))
        {                                        // El texto recibido por wifi se copia en el segundo string. 
            insertar_strings(str1, str2);        // Se llama a la rutina para imprimir los strings en el display.
            swiWaitForVBlank();
            for (i = 0; i < MAX_ELEMENTS; i++)
            {                                    // Se imprime el segundo string por la pantalla inferior de la NDS.
                printf("%c", str2[i]);
            }
            printf("\n");
            strcpy(str1, str2);                  // Se copia el contenido del segundo string en el primer string (scroll vertical).
        }
        else
        {                                        // Se quiere reducir el consum de la CPU en cada iteración del bucle principal
            swiWaitForVBlank();                  // y no sólo cuando se haya recibido un texto por wifi.
        }
    } while(1);
}