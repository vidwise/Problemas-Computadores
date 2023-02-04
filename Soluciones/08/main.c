//
// Author: Arey Ferrero Ramos.
//

#define MAX_ELEMENTS 32

unsigned char str1[MAX_ELEMENTS] = NULL;
unsigned char str2[MAX_ELEMENTS] = NULL;

unsigned char cont_visual = 16;
unsigned char desplazamiento = 1;

void main()
{
    int i;

    inicializaciones();
    do
    {
        tareas_independientes();
        if (wifiReciveText(str2))
        {
            insertar_strings(str1, str2);
            swiWaitForVBlank();
            for (i = 0; i < MAX_ELEMENTS; i++)
            {
                printf("%c", str2[i]);
            }
            printf("\n");
            strcpy(str1, str2);
        }
        else
        {
            swiWaitForVBlank();
        }
    } while(1);
}