//
// Created by aleixmt on 30/1/22.
//

#define MAX_FILAS 64
unsigned char num_filas = 0;  // máximo número de filas por hoja
unsigned int marcas[MAX_FILAS];  // número de filas actual


// vector de marcas capturadas
unsigned short num_hojas = 0;  // núm. hojas leídas correctamente




unsigned char num_bits_restantes;

unsigned char *REG_MARCAS = 0x2000 4567;






int main()
{
    char lectura_en_curso = 0;

    inicializaciones();
    do
    {
        tareas_independientes();
        if ((*REG_MARCAS) & 0x1 && !lectura_en_curso)
        {

            (*REG_MARCAS) = (*REG_MARCAS) | 0x80;
            lectura_en_curso = 1;
        }
        else if (lectura_en_curso && ! ((*REG_MARCAS) & 0x1))
        {
            num_hojas++;
            if (enviar_hoja(marcas, num_filas) == 1)
            {
                swiWaitForVBlank();
                printf("%d: OK\n", num_hojas);
            }
            else
            {
                swiWaitForVBlank();
                printf("%d: Error\n", num_hojas);
            }
            lectura_en_curso = 0;
            for (int i = 0; i < num_filas; i++)
            {
                marcas[i] = 0;
            }
            num_filas = 0;

        }

    } while (1);
}
